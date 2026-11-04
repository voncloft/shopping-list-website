// Run with Node.js 22.13+ (uses its built-in SQLite module).
// This checks import data semantics; it is not a MariaDB/MySQL server test.
import { DatabaseSync } from 'node:sqlite';
import { readFileSync, existsSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { resolve, dirname } from 'node:path';
import assert from 'node:assert/strict';
const root = resolve(dirname(fileURLToPath(import.meta.url)), '..');
const read = p => readFileSync(resolve(root, p), 'utf8');
const migration = read('upgrades/import_12_instant_pot_recipes.sql');
const recipes = [
 ['Creamy_Cajun_Chicken', 10], ['Tuscan_Chicken', 12],
 ['Buffalo_Chicken_Mac_and_Cheese', 11], ['Mississippi_Pot_Roast', 7],
 ['Beef_Birria', 17], ['Hungarian_Beef_Goulash', 15],
 ['Korean_Spicy_Pulled_Pork', 12], ['Filipino_Pork_Adobo', 8],
 ['Smoky_BBQ_Pulled_Pork', 11], ['Chicken_Tikka_Masala', 17],
 ['White_Chicken_Chili', 14], ['Cajun_Jambalaya', 14],
].map(([name,count]) => [name + '_recipe_table', count]);
assert.equal(recipes.reduce((n, r) => n+r[1],0), 148);

function forSQLite(sql) {
  const strings=[];
  // Protect quoted SQL values while changing only MySQL schema/control syntax.
  sql=sql.replace(/'(?:\\.|''|[^'\\])*'/gs, s=> {
    const value=s.slice(1,-1).replace(/''/g,"'").replace(/\\(.)/gs,(_,c)=>({n:'\n',r:'\r',t:'\t',0:'\0',Z:'\x1a'}[c]??c));
    strings.push("'"+value.replace(/'/g,"''")+"'");
    return `__SQL_VALUE_${strings.length-1}__`;
  });
  sql=sql.replace(/\/\*[\s\S]*?\*\//g,'').replace(/^\s*--.*$/gm,'');
  const statements=[];
  for (let stmt of sql.split(';').map(s=>s.trim()).filter(Boolean)) {
    if (/^(USE|SET|LOCK TABLES|UNLOCK TABLES|CREATE DATABASE)\b/i.test(stmt)) continue;
    stmt=stmt.replace(/^START TRANSACTION$/i,'BEGIN TRANSACTION');
    if (/^CREATE TABLE/i.test(stmt)) {
      stmt=stmt.replace(/\) ENGINE=[\s\S]*$/i,')')
        .replace(/`(id)` int\(11\) NOT NULL AUTO_INCREMENT/gi,'`$1` INTEGER PRIMARY KEY AUTOINCREMENT')
        .replace(/,\s*PRIMARY KEY \(`id`\)/gi,'')
        .replace(/UNIQUE KEY `[^`]+` (\(`[^`]+`\))(?: USING HASH)?/gi,'UNIQUE $1');
    }
    statements.push(stmt.replace(/__SQL_VALUE_(\d+)__/g,(_,i)=>strings[+i])+';');
  }
  return statements.join('\n');
}
const translated=forSQLite(migration);
const rows = (db,table)=>db.prepare(`SELECT * FROM \`${table}\` ORDER BY rowid`).all();
const snapshot=db=>Object.fromEntries(db.prepare("SELECT name FROM sqlite_master WHERE type='table' AND name <> 'sqlite_sequence' ORDER BY name").all().map(({name})=>[name,rows(db,name)]));
function verify(db) {
  for (const [table,count] of recipes) {
    assert.equal(rows(db,table).length,count,table);
    assert.equal(db.prepare('SELECT count(*) AS n FROM recipe_lists WHERE recipe_name=?').get(table).n,1);
    assert.equal(db.prepare(`SELECT count(*) AS n FROM \`${table}\` r LEFT JOIN items i ON r.ingredient_name=i.ID WHERE i.ID IS NULL`).get().n,0);
    assert.equal(db.prepare(`SELECT count(*) AS n FROM \`${table}\` WHERE used_servings IS NULL OR used_servings<0 OR qty<0`).get().n,0);
    assert.equal(db.prepare(`SELECT count(DISTINCT ingredient_name) AS n FROM \`${table}\``).get().n,count);
    const ingredients=read(`recipes/ingredients/${table}_ingredients.html`);
    const steps=read(`recipes/steps/${table}_steps.html`);
    assert.match(ingredients,/Makes 7 servings/);
    assert.match(steps,/165°F/);
    assert.match(steps,/pressure pin drops/);
    assert.match(steps,/freeze the other 4/);
    assert.equal(ingredients.split('\n').slice(2).findIndex(line=>line.startsWith('Allergens:')), count, table+' ingredient lines');
    const numbers=[...steps.matchAll(/<b>(\d+)\)\.<\/b>/g)].map(m=>+m[1]);
    assert.deepEqual(numbers,Array.from({length:numbers.length},(_,i)=>i+1));
  }
  const lookup=(table,name)=>db.prepare(`SELECT r.* FROM \`${table}_recipe_table\` r JOIN items i ON r.ingredient_name=i.ID WHERE lower(trim(i.grocery_item))=lower(?)`).get(name);
  assert.equal(lookup('Creamy_Cajun_Chicken','Frozen Onion').used_servings,1.5);
  assert.equal(lookup('Buffalo_Chicken_Mac_and_Cheese','Elbow Macaroni 16 oz').used_servings,8);
  assert.equal(lookup('Buffalo_Chicken_Mac_and_Cheese','Cheddar Cheese block').qty,2);
  assert.equal(lookup('Cajun_Jambalaya','Fully Cooked Andouille Sausage 12 oz').qty,2);
  assert.equal(lookup('Cajun_Jambalaya','Long Grain Rice').used_servings,8);
  assert.equal(lookup('White_Chicken_Chili','Cannellini Beans 15 oz').qty,3);
  assert.equal(lookup('Filipino_Pork_Adobo','Water From Sink').qty,0);

}

const db=new DatabaseSync(':memory:');
db.exec(forSQLite(read('database_setup')));
const before=snapshot(db);
db.exec(translated); verify(db);
assert.equal(rows(db,'items').length,before.items.length+18);
assert.equal(rows(db,'recipe_lists').length,before.recipe_lists.length+12);
for(const [table,oldRows] of Object.entries(before)) {
  const current=rows(db,table);
  assert.deepEqual(current.slice(0,oldRows.length),oldRows,'preserve '+table);
}
for(const food of rows(db,'items').slice(before.items.length)) {
  for(const key of ['price','protein','fat','carbs','calories','fiber']) assert.equal(food[key],null);
  assert.equal(food.servings,1);
}
const first=snapshot(db); db.exec(translated); assert.deepEqual(snapshot(db),first,'repeat import');
db.exec("UPDATE items SET price=123.45 WHERE grocery_item='Elbow Macaroni 16 oz'; UPDATE Buffalo_Chicken_Mac_and_Cheese_recipe_table SET qty=4 WHERE id=1;");
const customized=snapshot(db); db.exec(translated); assert.deepEqual(snapshot(db),customized,'preserve later edits');

// Different IDs, casing and surrounding spaces; no dependence on the dump's IDs.
const fresh=new DatabaseSync(':memory:');
fresh.exec('CREATE TABLE items (ID INTEGER PRIMARY KEY AUTOINCREMENT,grocery_item TEXT UNIQUE,price,department,pantryqty,servings,protein,fat,carbs,calories,fiber,url); CREATE TABLE recipe_lists (id INTEGER PRIMARY KEY AUTOINCREMENT,recipe_name TEXT UNIQUE,url);');
fresh.exec("INSERT INTO items VALUES (9001,'  bOnElEsS sKiNlEsS cHiCkEn ThIgHs  ',17.23,'custom','9',999,21,8,0,164,0,'https://example.invalid/kept');");
const original=rows(fresh,'items')[0];fresh.exec(translated);verify(fresh);
assert.equal(rows(fresh,'items').length,63);
assert.deepEqual(rows(fresh,'items')[0],original);
assert.equal(fresh.prepare("SELECT ingredient_name FROM Creamy_Cajun_Chicken_recipe_table WHERE used_servings=12").get().ingredient_name,'9001');
const again=snapshot(fresh);fresh.exec(translated);assert.deepEqual(snapshot(fresh),again);
console.log('PASS: 12 recipes, 148 rows, 18 missing foods, full-dump preservation, changed IDs, repeat imports, user edits, HTML filenames, seven servings, and key purchase/serving amounts.');
