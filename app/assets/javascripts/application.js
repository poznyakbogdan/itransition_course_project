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
//= require instructions
//= require steps
//= require cloudinary
//= require cloudinary/processing 
//= require turbolinks
//= require_tree .

//       Configure Cloudinary jQuery plugin
$.cloudinary.config({"api_key":"686525632959915","cloud_name":"bntu"});


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

		$('#steps-save-link').on("click", function(e){
			e.preventDefault();
			saveStepsNumbers(e);
		});

		$('#instruction_edit_save_button').on("click", function(e){
			e.preventDefault();
			saveInstruction(e);
		});

		$('#instruction_edit_save_button1').on("click", function(e){
			if (!$(this).hasClass('act')) e.preventDefault();
				alert('34234');
				updateSteps();
				alert('34234');
			$(".edit_instruction").trigger('submit');
			
		});

		// $('.edit_instruction').submit( function(e){
		// 	alert('qwwqe');
		// 	saveStepsNumbers(e);
		// });
});

function updateSteps () {
	var data = getStepsData();
	for (var key in data){
		var stepId = key;
		$('#steps_params>input[value='+ stepId +']').prev().attr('value', data[key].number);
	}
	
}

function  setOrderToSteps() {
	 var steps = $('#sortable>.ui-state-default');
	 steps.each(function(i){
			$(this).find('span').html(i + 1);
			$(this).attr('data-pos', i + 1);	 	
	 })
}


function saveInstruction(e){
	console.log('12312312');
	// var actionUrl = e.target.getAttribute('href'); 
	var actionUrl = $('form.edit_instruction').attr('action');
	var msg = new Object();
	msg.message = getStepsData();
	msg.instruction = getInstructionData();
	console.log(msg.instruction);
	console.log(msg.message);
	$.ajax(actionUrl, { 
		method: "PATCH", 
		data: msg
	})
		.done(function(){
			console.log('done');
		});
}


function saveStepsNumbers(e){
	// console.log('12312312');
	var actionUrl = e.target.getAttribute('href'); 
	// var actionUrl = $('form.edit_instruction').attr('action');
	var msg = new Object();
	msg.message = getStepsData();
	// console.log(msg.instruction);
	// console.log(msg.message);
	$.ajax(actionUrl, { 
		method: "POST", 
		data: msg
	})
		.done(function(){
			console.log('done');
		});
}

function getStepsData(){
	var steps = $('.ui-state-default');
	var data = new Object();
	steps.each(function(){
		data[$(this).attr('data-id')] = {
			number: $(this).attr('data-pos')} 
	});
	return data;
}

function getInstructionData(){
	data = new Object();
	data.name = $("[name='instruction[name]']").val();
	data.video_url = $("[name='instruction[video_url]']").val();
	return data;
}

//////////////////////////////////////////////////////////////////////

