
$(document).ready( function() {
    $( "#sortable" ).sortable({
    	update: setOrderToSteps,
    });
    $( "#sortable" ).disableSelection();

});

function  setOrderToSteps() {
	 var steps = $('#sortable>.ui-state-default');
	 var i = 0;
	 steps.each(function(){
			i++;
			$(this).html(i);	 	
	 })
}
