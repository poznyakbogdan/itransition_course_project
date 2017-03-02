// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require jquery-ui
//= require turbolinks
//= require_tree .


$(document).on('turbolinks:load', function() {
    $( "#sortable" ).sortable({
    	update: setOrderToSteps,
    });
    $( "#sortable" ).disableSelection();

    $('body').delegate( ".close-button","click", function(){
    	$('.form-shadov').remove();
		});
		
		$(document).on('submit','form#new_step',function(){
   		$('.form-shadov').remove();
		});

		$('#steps-save-link, #instruction_edit_save_button').on("click", function(e){
			saveStepsNumbers(e);
		});

});

function  setOrderToSteps() {
	 var steps = $('#sortable>.ui-state-default');
	 steps.each(function(i){
			$(this).find('span').html(i + 1);
			$(this).attr('data-pos', i + 1);	 	
	 })
}

function saveStepsNumbers(e){
	var actionUrl = e.target.getAttribute('href'); 
	var steps = $('.ui-state-default');
	var msg = new Object();
	msg.message = new Object();
	steps.each(function(){
		msg.message[$(this).attr('data-id')] = {
			number: $(this).attr('data-pos')} 
	});
	$.ajax(actionUrl, { 
		method: "POST", 
		data: msg
	})
		.done(function(){
			console.log('done');
		});
}

