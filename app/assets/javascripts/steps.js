
// $(document).ready( function() {
//     $( "#sortable" ).sortable({
//     	update: setOrderToSteps,
//     });
//     $( "#sortable" ).disableSelection();

//     $('body').delegate( ".close-button","click", function(){
//     	$('.form-shadov').remove();
// 		});
		
// 		$(document).on('submit','form#new_step',function(){
//    		$('.form-shadov').remove();
// 		});

// 		$('#steps-save-link').on("click", function(e){
// 			saveStepsNumbers(e);
// 		});

// });

// function  setOrderToSteps() {
// 	 var steps = $('#sortable>.ui-state-default');
// 	 steps.each(function(i){
// 			$(this).find('span').html(i + 1);
// 			$(this).attr('data-pos', i + 1);	 	
// 	 })
// }

// function saveStepsNumbers(e){
// 	var actionUrl = e.target.getAttribute('href'); 
// 	var steps = $('.ui-state-default');
// 	var msg = new Object();
// 	msg.message = new Object();
// 	steps.each(function(){
// 		msg.message[$(this).attr('data-id')] = {
// 			number: $(this).attr('data-pos')} 
// 	});
// 	$.ajax(actionUrl, { 
// 		method: "POST", 
// 		data: msg
// 	})
// 		.done(function(){
// 			console.log('done');
// 		});
// }
$(document).on('turbolinks:load', function() {
	$('body').on('click', '.change-step-image-btn', function(){
		$('.step--edit-image-container').css("display", "none");
		$('.edit-image-upload').css("display", "block");
	})
});