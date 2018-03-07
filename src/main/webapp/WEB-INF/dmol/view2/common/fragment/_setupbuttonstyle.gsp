<r:script>
;jQuery(function(){
$("a.button, div.paginateButtons a").addClass('ui-state-default ui-corner-all').hover(
	function() {
		if (!$(this).hasClass('ui-state-disabled')) {
			$(this).addClass('ui-state-hover');
		}
	},
	function() {
		if ($(this).hasClass('ui-state-hover')) {
			$(this).removeClass('ui-state-hover');
		}
	}
);
});</r:script>
