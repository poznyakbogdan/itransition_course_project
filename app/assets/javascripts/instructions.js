$(document).on('turbolinks:load', function() {
	$( "#instruction_category_id" ).selectmenu();

	$('#instruction_tag_list').tagsInput({
    'onAddTag': addTagsToInput, 
    'onRemoveTag': addTagsToInput, 
  });
	
	
	function addTagsToInput(e) {
		var tags = $('#instruction_tag_list_tagsinput>span.tag>span');
		console.log(tags);''
		var tagsText = [];
		$(tags).each(function () {
	  	tagsText.push($(this).text().replace(/..$/,''));
		});
		$('#instruction_tag_list').attr('value', tagsText.join(','));
	}

	$('.steps-carousel').slick({

	});


});