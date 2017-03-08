CKEDITOR.editorConfig = function( config ) {

	config.toolbarGroups = [
		{ name: 'editing',     groups: [ 'spellchecker' ] },
		{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
		{ name: 'paragraph',   groups: [ 'list', 'indent', 'align'] },
		{ name: 'links' },
		{ name: 'styles' },
		{ name: 'colors' }
	];

	config.removeButtons = 'Cut,Copy,Paste,Undo,Redo,Anchor,Underline,Strike,Subscript,Superscript';

	config.removeDialogTabs = 'link:advanced';
};