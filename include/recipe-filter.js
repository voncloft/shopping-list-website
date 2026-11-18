(function () {
    'use strict';
    var filters = document.getElementById('recipe-filters');
    if (!filters) return;
    var cards = Array.from(document.querySelectorAll('.recipe-card'));
    var search = document.getElementById('recipe-search');
    var ranges = Array.from(filters.querySelectorAll('[data-metric]'));
    function refresh() {
        var words = search.value.trim().toLocaleLowerCase().split(/\s+/).filter(Boolean);
        var limits = ranges.filter(function (input) { return input.value !== ''; });
        var invalid = ranges.some(function (input) { return input.validity.badInput; });
        var bounds = {};
        limits.forEach(function (input) { (bounds[input.dataset.metric] ||= {})[input.dataset.bound] = Number(input.value); });
        Object.values(bounds).forEach(function (bound) { if (bound.min !== undefined && bound.max !== undefined && bound.min > bound.max) invalid = true; });
        var visible = 0, selected = 0, hiddenSelected = 0;
        cards.forEach(function (card) {
            var matches = !invalid && words.every(function (word) { return card.dataset.recipeName.toLocaleLowerCase().includes(word); });
            matches = matches && limits.every(function (input) {
                var raw = card.getAttribute('data-' + input.dataset.metric);
                if (raw === null || raw === '') return false;
                return input.dataset.bound === 'min' ? Number(raw) >= Number(input.value) : Number(raw) <= Number(input.value);
            });
            card.hidden = !matches;
            if (matches) visible++;
            if (card.querySelector('input[name="recipes[]"]').checked) { selected++; if (!matches) hiddenSelected++; }
        });
        document.getElementById('recipe-filter-count').textContent = visible + ' of ' + cards.length + ' recipes shown';
        document.getElementById('recipe-selection-count').textContent = selected + ' selected' + (hiddenSelected ? ' (' + hiddenSelected + ' hidden by filters — still selected)' : '');
        document.getElementById('recipe-no-matches').hidden = visible !== 0;
        var error = document.getElementById('recipe-filter-error');
        error.hidden = !invalid;
        error.textContent = invalid ? 'Check your ranges: each minimum must be no greater than its maximum, and values must be numbers.' : '';
    }
    filters.addEventListener('input', refresh);
    document.getElementById('recipe-selection-form').addEventListener('change', refresh);
    document.getElementById('clear-recipe-filters').addEventListener('click', function () { search.value = ''; ranges.forEach(function (input) { input.value = ''; }); refresh(); search.focus(); });
    refresh();
}());
