(function () {
    'use strict';
    var states=new Map();
    document.querySelectorAll('form[id^="edit-item-"],form[id^="pantry-"]').forEach(function (form) {
        var button=document.querySelector('button[form="'+form.id+'"]');
        if (!button) return;
        var status=document.createElement('span'); status.className='row-save-status'; status.setAttribute('role','status'); status.setAttribute('aria-live','polite'); status.textContent='Up to date';
        button.hidden=true; button.parentElement.appendChild(status);
        states.set(form,{form:form,status:status,dirty:false,pending:false,version:0,timer:null});
        form.addEventListener('submit',function (event) {event.preventDefault(); var state=states.get(form); state.dirty=true; state.version++; save(state);});
    });
    function mark(state,text,error) { state.status.textContent=text; state.status.classList.toggle('theme-error',!!error); state.status.classList.toggle('theme-success',text==='Saved'); }
    function save(state) {
        clearTimeout(state.timer);
        if (!state.dirty || state.pending) return;
        var invalid=Array.from(state.form.elements).find(function (input) {return input.willValidate && !input.checkValidity();});
        if (invalid) {mark(state,'Not saved: '+(invalid.getAttribute('aria-label') || invalid.name)+' — '+invalid.validationMessage,true); return;}
        state.pending=true; var version=state.version;
        mark(state,'Saving…');
        fetch(state.form.action,{method:'POST',body:new FormData(state.form),credentials:'same-origin',headers:{Accept:'application/json'}})
            .then(async function (response) {var data;try {data=await response.json();}catch(e){throw new Error('Could not confirm the save. Reload to check the stored value.');}if(!response.ok || !data.ok)throw new Error(data.error || 'Could not save this row.');return data;})
            .then(function () {if(state.version===version){state.dirty=false;mark(state,'Saved');}})
            .catch(function (error) {if(state.version===version)mark(state,'Not saved: '+error.message,true);})
            .finally(function () {state.pending=false;if(state.version!==version)save(state);});
    }
    document.addEventListener('input',function (event) {
        var state=states.get(event.target.form);if(!state)return;
        state.dirty=true;state.version++;mark(state,'Unsaved');clearTimeout(state.timer);state.timer=setTimeout(function () {save(state);},900);
    });
    document.addEventListener('focusout',function (event) {var state=states.get(event.target.form);if(state)save(state);});
    document.addEventListener('keydown',function (event) {var state=states.get(event.target.form);if(state && event.key==='Enter'){event.preventDefault();save(state);}});
    window.addEventListener('beforeunload',function (event) {if(Array.from(states.values()).some(function (s){return s.dirty || s.pending;})){event.preventDefault();event.returnValue='';}});
}());
