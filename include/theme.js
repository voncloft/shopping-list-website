(function () {
    'use strict';
    function value(key) { return getComputedStyle(document.documentElement).getPropertyValue('--' + key).trim(); }
    function chartOptions(labels) {
        return {
            colors: labels.map(function (label) { return value('macro-' + String(label).toLowerCase()); }),
            hole: Number(value('chart-hole')) || 0,
            background: value('chart-bg'), text: value('chart-text'), label: value('chart-label'), border: value('chart-border'),
            font: value('font-family'), size: parseFloat(value('font-size')) || 16
        };
    }
    function refreshCharts() {
        if (!window.Plotly) return;
        document.querySelectorAll('.js-plotly-plot').forEach(function (chart) {
            if (!chart.data || chart._shoppingThemeBusy) return;
            var options = chartOptions(['Fat','Protein','Carbs','Fiber']);
            var signature = JSON.stringify(options);
            if (chart._shoppingThemeSignature === signature) return;
            chart._shoppingThemeBusy = true;
            var updates = chart.data.map(function (trace, index) {
                if (trace.type !== 'pie') return Promise.resolve();
                var o = chartOptions(trace.labels || []);
                return window.Plotly.restyle(chart, {'marker.colors':[o.colors], 'marker.line.color':o.border, 'marker.line.width':1,
                    hole:o.hole, 'textfont.color':o.label, 'hoverlabel.bgcolor':o.background, 'hoverlabel.font.color':o.text}, [index]);
            });
            Promise.all(updates).then(function () {
                return window.Plotly.relayout(chart, {paper_bgcolor:options.background, plot_bgcolor:options.background,
                    'font.color':options.text, 'font.family':options.font, 'font.size':options.size});
            }).then(function () { chart._shoppingThemeSignature = signature; }).catch(function () {}).finally(function () { chart._shoppingThemeBusy = false; });
        });
    }
    window.ShoppingTheme = {refreshCharts:refreshCharts, chartOptions:chartOptions};
    document.addEventListener('DOMContentLoaded', function () {
        document.querySelectorAll('table:not(.macro-chart)').forEach(function (table) {
            if (Array.from(table.rows).some(function (row) { return Array.from(row.cells).some(function (cell) { return cell.tagName === 'TH'; }); })) table.classList.add('theme-data-table');
        });
    });
    document.addEventListener('shopping-chart-ready', refreshCharts);
    document.addEventListener('DOMContentLoaded', refreshCharts);
    window.addEventListener('load', refreshCharts);
    var media = window.matchMedia('(prefers-color-scheme: dark)');
    if (media.addEventListener) media.addEventListener('change', function () { requestAnimationFrame(refreshCharts); });
    else media.addListener(refreshCharts);
}());
