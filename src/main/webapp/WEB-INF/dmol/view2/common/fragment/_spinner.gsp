<div id="spinner" class="spinner" style="display:none;">
	<img src="${r.resource(dir:'images',file:'spinner.gif')}" alt="${message(code:'spinner.alt',default:'しばらくお待ちください')}" />
	しばらくお待ちください
</div>
<g:javascript><!--
function pleaseWait() {
	$('#spinner').modal({position:['10%',], containerCss:{width:'240px', height:'70px'}, close:false});
	return true;
}
function closeWait() {
	$.modal.close();
	return true;
}
//--></g:javascript>