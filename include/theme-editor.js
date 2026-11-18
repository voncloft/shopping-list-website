(function () {
    'use strict';
    var form = document.getElementById('theme-editor');
    var preview = document.getElementById('theme-preview');
    if (!form || !preview) return;
    function update() {
        form.querySelectorAll('[data-option]').forEach(function (input) {
            if (!input.checkValidity()) return;
            var key = input.dataset.option, value = input.value;
            if (key === 'font_family') value = {sans:'system-ui, sans-serif',serif:'Georgia, serif',mono:'ui-monospace, monospace'}[value];
            if (['font_size','cell_padding','border_width','radius'].indexOf(key) !== -1) value += 'px';
            preview.style.setProperty('--' + key.replaceAll('_','-'), value);
            var hex = form.querySelector('[data-color-for="' + input.id + '"]');
            if (hex && document.activeElement !== hex) hex.value = input.value;
        });
        preview.style.background = 'var(--page-bg)'; preview.style.color = 'var(--text)';
        preview.style.fontFamily = 'var(--font-family)'; preview.style.fontSize = 'var(--font-size)';
        var hole = Number(form.querySelector('[data-option=chart_hole]').value) || 0;
        preview.querySelector('.theme-preview-chart').style.maskImage = hole ? 'radial-gradient(circle, transparent '+(hole*50)+'%, black '+(hole*50+.5)+'%)' : 'none';
    }
    form.addEventListener('input', function (event) {
        if (event.target.dataset.colorFor && /^#[a-f0-9]{6}$/i.test(event.target.value)) document.getElementById(event.target.dataset.colorFor).value = event.target.value;
        update();
    });
    document.getElementById('preview-reset').addEventListener('click', function () { form.reset(); update(); });
    var deletion = document.getElementById('delete-theme-form');
    if (deletion) deletion.addEventListener('submit', function (event) { if (!window.confirm('Delete this custom theme?')) event.preventDefault(); });
    update();
}());
