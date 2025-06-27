document.addEventListener('DOMContentLoaded', function() {
    // Get all tables with class 'sortable'
    const tables = document.getElementsByClassName('sortable');

    for (let table of tables) {
        // Ensure thead exists, create if missing
        let thead = table.querySelector('thead');
        if (!thead) {
            thead = document.createElement('thead');
            const headerRow = table.querySelector('tr');
            if (headerRow) {
                thead.appendChild(headerRow);
                table.insertBefore(thead, table.firstChild);
            }
        }

        // Ensure tbody exists, create if missing
        let tbody = table.querySelector('tbody');
        if (!tbody) {
            tbody = document.createElement('tbody');
            const rows = table.querySelectorAll('tr:not(:first-child)');
            rows.forEach(row => tbody.appendChild(row));
            table.appendChild(tbody);
        }

        const headers = thead.querySelectorAll('th');
        headers.forEach((header, index) => {
            header.addEventListener('click', () => {
                sortTable(table, index);
            });
        });
    }

    function sortTable(table, colIndex) {
        const tbody = table.querySelector('tbody');
        const rows = Array.from(tbody.querySelectorAll('tr'));
        const isAscending = table.dataset.sortCol !== colIndex.toString() || table.dataset.sortDir !== 'asc';
        table.dataset.sortCol = colIndex;
        table.dataset.sortDir = isAscending ? 'asc' : 'desc';

        // Determine if the column contains numbers (for Qty, Price, Pantry Qty, etc.)
        const isNumeric = rows.every(row => {
            const cell = row.cells[colIndex];
            const text = cell.textContent.trim();
            return !isNaN(parseFloat(text)) && isFinite(text);
        });

        rows.sort((rowA, rowB) => {
            let cellA = rowA.cells[colIndex].textContent.trim();
            let cellB = rowB.cells[colIndex].textContent.trim();

            if (isNumeric) {
                cellA = parseFloat(cellA.replace(/[^0-9.-]+/g, '')) || 0;
                cellB = parseFloat(cellB.replace(/[^0-9.-]+/g, '')) || 0;
                return isAscending ? cellA - cellB : cellB - cellA;
            } else {
                // For text, including links in the Description column
                cellA = cellA.toLowerCase();
                cellB = cellB.toLowerCase();
                return isAscending ? cellA.localeCompare(cellB) : cellB.localeCompare(cellB);
            }
        });

        // Re-append rows in sorted order to tbody
        rows.forEach(row => tbody.appendChild(row));

        // Update visual indicator
        const headers = table.querySelector('thead').querySelectorAll('th');
        headers.forEach(header => header.classList.remove('sort-asc', 'sort-desc'));
        headers[colIndex].classList.add(isAscending ? 'sort-asc' : 'sort-desc');
    }
});
