<?php
require_once __DIR__.'/../functions/form_checks.php';site_post();
require_once __DIR__.'/../include/passwords.php';
site_transaction($conn,function () use ($conn) { $conn->query('DELETE FROM final_list'); $conn->query('DELETE FROM current_week_recipes'); $conn->query("UPDATE variables SET weekly_total='0.00'"); });
site_success('The shopping list has been cleared. Your saved recipes and pantry are unchanged.');
