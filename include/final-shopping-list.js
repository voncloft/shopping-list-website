(function () {
    'use strict';
    function init() {
        var table = document.getElementById('shopping-items');
        if (!table) return;
        var body = table.tBodies[0];
        var status = document.getElementById('shopping-status');
        var clearButton = document.getElementById('clear-got-it');
        var openButton = document.getElementById('open-all-links');
        var coveredButton = document.getElementById('toggle-covered-items');
        var hideCovered = coveredButton.getAttribute('aria-pressed') === 'true';
        var coveredSaveBusy = false;
        var coveredRequest = 0;
        var confirmed = JSON.parse(document.getElementById('shopping-state').textContent);
        var busy = false;
        var sort = null;
        var linkQueue = null;
        var sortKey = 'shopping-list-sort-v1:' + location.pathname;
        var money = new Intl.NumberFormat('en-US', {style: 'currency', currency: 'USD'});
        function rows() { return Array.from(body.rows); }
        function updateCoveredVisibility() {
            var hiddenCount = 0;
            rows().forEach(function (row) {
                row.hidden = hideCovered && row.dataset.pantryCovered === '1';
                if (row.hidden) hiddenCount++;
            });
            coveredButton.setAttribute('aria-pressed', String(hideCovered));
            coveredButton.textContent = hideCovered ? 'Show grey items (' + hiddenCount + ' hidden)' : 'Hide grey items';
            document.getElementById('all-items-covered').hidden = hiddenCount === 0 || hiddenCount !== rows().length;
        }
        coveredButton.hidden = false;
        coveredButton.addEventListener('click', async function () {
            if (coveredSaveBusy) return;
            var previous = hideCovered;
            coveredRequest++;
            coveredSaveBusy = true;
            coveredButton.disabled = true;
            hideCovered = !hideCovered;
            updateCoveredVisibility();
            message('');
            try {
                var data = await post('../ajax/display_settings.php', {hide_covered: hideCovered ? '1' : '0'}, true);
                if (typeof data.hideCovered !== 'boolean') throw new Error('Unexpected display setting.');
                hideCovered = data.hideCovered;
            } catch (error) {
                hideCovered = previous;
                message(error.message || 'Could not save the display setting. Previous view restored.', true);
            } finally {
                updateCoveredVisibility();
                coveredSaveBusy = false;
                coveredButton.disabled = false;
            }
        });
        async function refreshCoveredSetting() {
            if (coveredSaveBusy || document.hidden) return;
            var request = ++coveredRequest;
            var controller = new AbortController();
            var timer = setTimeout(function () { controller.abort(); }, 10000);
            try {
                var response = await fetch('../ajax/display_settings.php', {
                    credentials: 'same-origin', cache: 'no-store', signal: controller.signal
                });
                var data = await response.json();
                if (response.ok && data.ok === true && typeof data.hideCovered === 'boolean' &&
                    request === coveredRequest && !coveredSaveBusy) {
                    hideCovered = data.hideCovered;
                    updateCoveredVisibility();
                }
            } catch (ignored) {
                // Keep the last confirmed view when a returning tab is offline.
            } finally { clearTimeout(timer); }
        }
        window.addEventListener('focus', refreshCoveredSetting);
        window.addEventListener('pageshow', function (event) { if (event.persisted) refreshCoveredSetting(); });
        document.addEventListener('visibilitychange', refreshCoveredSetting);
        updateCoveredVisibility();

        // Fit the original table and its price box across a phone screen. This
        // leaves wide-screen layout and the user's normal pinch zoom untouched.
        var shoppingLayout = document.querySelector('.shopping-layout');
        var shoppingViewport = document.querySelector('.shopping-layout-viewport');
        var phoneView = window.matchMedia('(max-width:600px), (max-width:1000px) and (pointer:coarse)');
        var fitFrame = null;
        function fitPhoneTable() {
            fitFrame = null;
            if (!phoneView.matches) {
                shoppingLayout.style.removeProperty('--shopping-mobile-scale');
                return;
            }
            var naturalWidth = Math.max(shoppingLayout.offsetWidth, shoppingLayout.scrollWidth);
            var scale = naturalWidth ? Math.min(1, shoppingViewport.clientWidth / naturalWidth) : 1;
            shoppingLayout.style.setProperty('--shopping-mobile-scale', String(Math.floor(scale * 10000) / 10000));
        }
        function schedulePhoneFit() {
            if (fitFrame === null) fitFrame = requestAnimationFrame(fitPhoneTable);
        }
        if (window.ResizeObserver) {
            var shoppingResize = new ResizeObserver(schedulePhoneFit);
            shoppingResize.observe(shoppingLayout);
            shoppingResize.observe(shoppingViewport);
        }
        window.addEventListener('resize', schedulePhoneFit);
        if (phoneView.addEventListener) phoneView.addEventListener('change', schedulePhoneFit);
        else phoneView.addListener(schedulePhoneFit);
        if (document.fonts) document.fonts.ready.then(schedulePhoneFit);
        fitPhoneTable();
        function message(text, error) {
            status.textContent = text;
            status.classList.toggle('error', !!error);
        }
        function render(summary) {
            document.getElementById('estimated-bill').textContent = money.format(summary.fullSubtotalCents / 100);
            document.getElementById('estimated-tax').textContent = money.format(summary.fullTaxCents / 100);
            document.getElementById('remaining-total').textContent = money.format(summary.totalCents / 100);
            document.getElementById('full-list-total').textContent = money.format(summary.fullTotalCents / 100);
            document.getElementById('missing-prices').hidden = summary.missingPrices === 0;
        }
        function restoreChecks(summary) {
            var checked = new Set(summary.checkedIds.map(String));
            rows().forEach(function (row) {
                // Ignore is a one-shot action, never a saved checkbox state.
                row.querySelector('.ignoreIt').checked = false;
                row.querySelector('.checkIt').checked = checked.has(row.dataset.itemId);
            });
        }
        function optimisticSummary() {
            var subtotal = 0, missing = 0;
            rows().forEach(function (row) {
                if (row.dataset.missingPrice === '1') missing++;
                if (!row.querySelector('.checkIt').checked) {
                    subtotal += Number(row.dataset.priceCents);
                }
            });
            var tax = Math.round(subtotal * 0.06);
            return Object.assign({}, confirmed, {
                subtotalCents: subtotal, taxCents: tax,
                totalCents: subtotal + tax, missingPrices: missing
            });
        }
        function setBusy(value) {
            busy = value;
            document.querySelectorAll('.checkIt, .ignoreIt, #portions, #shopping-form input[type="submit"]').forEach(function (input) {
                input.disabled = value;
            });
            document.querySelectorAll('.pantry-qty').forEach(function (cell) {
                cell.contentEditable = value ? 'false' : 'true';
            });
            clearButton.disabled = value || confirmed.checkedIds.length === 0;
        }
        async function post(url, values, json) {
            var controller = new AbortController();
            var timer = setTimeout(function () { controller.abort(); }, 15000);
            try {
                var response = await fetch(url, {
                    method: 'POST', credentials: 'same-origin', signal: controller.signal,
                    headers: {'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8'},
                    body: new URLSearchParams(values).toString()
                });
                var data = json ? await response.json() : await response.text();
                if (!response.ok || (json && (!data || data.ok !== true))) {
                    throw new Error(json && data && data.error ? data.error : 'The server could not save this change.');
                }
                return data;
            } finally { clearTimeout(timer); }
        }
        async function saveChecks(values) {
            setBusy(true);
            render(optimisticSummary());
            message('');
            try {
                var data = await post('../ajax/checkbox.php', values, true);
                if (!data.summary || !Array.isArray(data.summary.checkedIds) ||
                    !Number.isInteger(data.summary.totalCents)) throw new Error('Unexpected server response.');
                confirmed = data.summary;
                restoreChecks(confirmed);
                render(confirmed);
                if (sort) applySort(sort.column, sort.direction);
            } catch (error) {
                restoreChecks(confirmed);
                render(confirmed);
                message('Could not confirm the change. Previous checkmarks restored; reload to check the saved state.', true);
            } finally { setBusy(false); }
        }
        table.addEventListener('change', function (event) {
            var checkbox = event.target;
            if (checkbox.matches('.checkIt')) {
                if (busy) { restoreChecks(confirmed); return; }
                saveChecks({action: 'set', id: checkbox.value, checked: checkbox.checked ? 'true' : 'false'});
            } else if (checkbox.matches('.ignoreIt') && checkbox.checked) {
                if (busy) { checkbox.checked = false; return; }
                setBusy(true);
                message('Ignoring item…');
                post('../ajax/ignore.php', {id: checkbox.value}, false).then(function () {
                    checkbox.checked = false;
                    location.reload();
                }).catch(function () {
                    checkbox.checked = false;
                    setBusy(false);
                    message('Could not confirm that the item was ignored. Reload to check the saved list.', true);
                });
            }
        });
        clearButton.addEventListener('click', function () {
            if (busy) return;
            rows().forEach(function (row) { row.querySelector('.checkIt').checked = false; });
            saveChecks({action: 'clear_all'});
        });

        // Sort only the nine top-level cells. Expanded nutrition never becomes a row or sort key.
        function applySort(column, direction) {
            var header = table.tHead.rows[0].cells[column];
            if (!header) return;
            var type = header.dataset.sortType;
            function key(row) {
                if (type === 'checked') return row.querySelector('.checkIt').checked ? 1 : 0;
                var cell = row.cells[column];
                var text = cell.dataset.sortValue !== undefined ? cell.dataset.sortValue : cell.textContent.trim();
                return type === 'number' ? Number(text) || 0 : text;
            }
            rows().sort(function (a, b) {
                var pantryOrder = Number(a.dataset.pantryCovered) - Number(b.dataset.pantryCovered);
                if (pantryOrder) return pantryOrder;
                var ka = key(a), kb = key(b);
                var comparison = type === 'number' || type === 'checked' ? ka - kb :
                    String(ka).localeCompare(String(kb), undefined, {numeric: true, sensitivity: 'base'});
                return direction === 'asc' ? comparison : -comparison;
            }).forEach(function (row) { body.appendChild(row); });
            sort = {column: column, direction: direction};
            Array.from(table.tHead.rows[0].cells).forEach(function (cell, index) {
                cell.setAttribute('aria-sort', index === column ? (direction === 'asc' ? 'ascending' : 'descending') : 'none');
            });
            try { localStorage.setItem(sortKey, JSON.stringify(sort)); } catch (ignored) {}
        }
        table.addEventListener('click', function (event) {
            var toggle = event.target.closest('.macro-toggle');
            if (toggle && table.contains(toggle)) {
                var details = document.getElementById(toggle.getAttribute('aria-controls'));
                var expanded = toggle.getAttribute('aria-expanded') !== 'true';
                toggle.setAttribute('aria-expanded', String(expanded));
                toggle.textContent = expanded ? '−' : '+';
                toggle.setAttribute('aria-label', (expanded ? 'Hide' : 'Show') + ' nutrition for ' +
                    toggle.closest('.description-cell').dataset.sortValue);
                details.hidden = !expanded;
                return;
            }
            var heading = event.target.closest('.sort-heading');
            if (heading && table.contains(heading)) {
                var column = Number(heading.dataset.column);
                applySort(column, sort && sort.column === column && sort.direction === 'asc' ? 'desc' : 'asc');
            }
        });
        // Browsers can restore form state by position after a row disappears.
        // Use saved item IDs before sorting and again after browser restoration.
        restoreChecks(confirmed);
        window.addEventListener('pageshow', function () {
            if (busy) return;
            restoreChecks(confirmed);
            if (sort) applySort(sort.column, sort.direction);
            setBusy(false);
        });
        try {
            var saved = JSON.parse(localStorage.getItem(sortKey));
            if (saved && Number.isInteger(saved.column) && saved.column >= 0 && saved.column < 9 &&
                ['asc', 'desc'].includes(saved.direction)) applySort(saved.column, saved.direction);
        } catch (ignored) {}
        // Pantry-covered rows are always last, even before the user chooses a sort.
        if (!sort) applySort(6, 'asc');

        openButton.addEventListener('click', function () {
            // Pantry coverage, not whether a row is currently hidden, decides eligibility.
            var eligibleLinks = Array.from(new Set(Array.from(table.querySelectorAll('tbody > tr[data-pantry-covered="0"] .shopping-item-link')).map(function (link) {
                return link.href;
            }))).filter(function (href) {
                try { return ['http:', 'https:'].includes(new URL(href).protocol); } catch (ignored) { return false; }
            });
            // A popup retry must also skip any rows that are now pantry-covered.
            linkQueue = linkQueue === null ? eligibleLinks : linkQueue.filter(function (href) { return eligibleLinks.includes(href); });
            if (!linkQueue.length) {
                linkQueue = null;
                openButton.textContent = 'Open all Walmart links';
                message('There are no saved links on non-grey rows.');
                return;
            }
            var opened = 0;
            // Keep these calls in the click handler; timers lose the browser's user-gesture permission.
            while (linkQueue.length) {
                // Firefox remembers this URL when it blocks a popup. Opening about:blank
                // first loses the later navigation when the user allows that blocked popup.
                var tab = window.open(linkQueue[0], '_blank');
                if (!tab) break;
                try {
                    tab.opener = null;
                } catch (error) {
                    tab.close();
                    break;
                }
                linkQueue.shift();
                opened++;
            }
            if (linkQueue.length) {
                openButton.textContent = 'Open remaining links (' + linkQueue.length + ')';
                message('Opened ' + opened + ' links. Your browser blocked the rest. Allow pop-ups for this shopping-list site, then click Open remaining links.');
            } else {
                openButton.textContent = 'Open all Walmart links';
                message('Opened ' + opened + ' item links.');
                linkQueue = null;
            }
        });
        document.getElementById('portions').addEventListener('change', function (event) {
            if (busy) return;
            setBusy(true);
            post('../ajax/portions.php', {id: event.target.value}, false).then(function () {
                location.reload();
            }).catch(function () {
                setBusy(false);
                message('Could not confirm the portion change. Reload to check the saved value.', true);
            });
        });
        table.addEventListener('keydown', function (event) {
            if (event.target.matches('.pantry-qty') && event.key === 'Enter') {
                event.preventDefault();
                if (!busy) event.target.blur();
            }
        });
        table.addEventListener('focusout', function (event) {
            var cell = event.target;
            if (!cell.matches('.pantry-qty') || busy) return;
            var value = cell.textContent.trim();
            if (value === cell.dataset.original) return;
            if (!/^\d+(\.\d+)?$/.test(value) || !Number.isFinite(Number(value))) {
                cell.textContent = cell.dataset.original;
                message('Pantry quantity must be zero or a positive number.', true);
                return;
            }
            setBusy(true);
            // The existing pantry endpoint expects a price parameter; the reloaded page recalculates it.
            post('../ajax/edit_pantry.php', {
                id: cell.dataset.itemId, updated_value: value, price: (confirmed.fullTotalCents / 100).toFixed(2)
            }, false).then(function () { location.reload(); }).catch(function () {
                cell.textContent = cell.dataset.original;
                setBusy(false);
                message('Could not confirm the pantry change. Reload to check the saved quantity.', true);
            });
        });
        if (window.Plotly && document.getElementById('myDiv0')) {
            var sizeChart = function () {
                window.Plotly.relayout('myDiv0', {width: Math.min(400, document.documentElement.clientWidth - 32)});
            };
            sizeChart();
            window.addEventListener('resize', sizeChart);
        }
        render(confirmed);
        setBusy(false);
    }
    if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', init);
    else init();
}());
