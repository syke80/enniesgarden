<script type="text/javascript">
function edit_success() {
	$("#page_list").conscendoTable('load');
}
</script>

<% form form_id='edit' itemtype='form' action=$siteconfig[site_url].'/page/' method='put' %>
  <% form itemtype='hidden' name='id_page' value=$page[id_page] %>
  <% form itemtype='text'   name='permalink' label='Permalink' default=$page[permalink] %>
  <% form itemtype='select' name='is_public' label='Public'    default=$page[is_public] %>
	<% form itemtype='option' value='y' label='Yes' %>
	<% form itemtype='option' value='n' label='No' %>

  
	<% form itemtype='select'   name='id_category'       label='Category' default=$page[id_category] %>
		<% form itemtype='option' value='' label='' %>
		<% foreach from=$categorylist item=category %>
			<% form itemtype='option' value=$category[id_category] label=$category[name] %>
		<% /foreach %>
	<% form itemtype='text' name='new_category' label='Add new category' %>

	<% foreach from=$regionlist item=region %>
		<% assign name='region_content' value='' %>
		<% foreach from=$contentlist item=content %>
			<% if $content[id_region]==$region[id_region] %>
				<% assign name='region_content' value=$content[content] %>
			<% /if %>
		<% /foreach %>
		<% form itemtype='textarea' name='content_'.$region[id_region] label=$region[name] default=$region_content extraclass='item_textarea type_'.$region[type] %>
	<% /foreach %>

	<% form itemtype='submit' name='ok' label='OK' %>
<% form cmd='render_form' %>
<% form cmd='render_javascript' function_success='edit_success();' msg_success='The changes has been successfully saved' resetform=false %>

<script>
	<% foreach from=$regionlist item=region %>
		<% if $region[type]=='wysiwyg' %>
			if (CKEDITOR.instances.edit_content_<% $region[id_region] %>) CKEDITOR.instances.edit_content_<% $region[id_region] %>.destroy(true);
		<% /if %>
	<% /foreach %>
	$('#form_edit .type_wysiwyg textarea').ckeditor({
		toolbar: 	[
			<% if $user[access_value]>=$siteconfig[access][root] %>
			{ name: 'document', items : [ 'Source' ] },
			<% /if %>
			{ name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
			{ name: 'editing', items : [ 'Find','Replace','-','SelectAll' ] },
			'/',
			{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
			{ name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','CreateDiv', '-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] },
			{ name: 'links', items : [ 'Link','Unlink','Anchor' ] },
			{ name: 'insert', items : [ 'Image', 'Table','HorizontalRule','SpecialChar' ] },
			{ name: 'styles', items : [ 'Format' ] },
			{ name: 'tools', items : [ 'ShowBlocks' ] }
			],
		//filebrowserBrowseUrl : '<% $siteconfig[site_url] %>/content/javascript/jasfinder/index.html',
		filebrowserBrowseUrl : '<% $siteconfig[site_url] %>/content/javascript//kcfinder/browse.php?type=files',
		filebrowserImageBrowseUrl : '<% $siteconfig[site_url] %>/content/javascript/kcfinder/browse.php?type=images&dir=content/files/page',
		//filebrowserFlashBrowseUrl : '<% $siteconfig[site_url] %>/content/javascript//kcfinder/browse.php?type=flash',
		filebrowserUploadUrl : '<% $siteconfig[site_url] %>/content/javascript//kcfinder/upload.php?type=files',
		filebrowserImageUploadUrl : '<% $siteconfig[site_url] %>/content/javascript/kcfinder/upload.php?type=images&dir=content/files/page',
		//filebrowserFlashUploadUrl : '<% $siteconfig[site_url] %>/content/javascript//kcfinder/upload.php?type=flash',
		width: 700,
		height: 300,
		indentOffset: 20,
		entities: false,
		bodyClass: 'page',
		contentsCss: "<% mtimelink file='www/css/page.css' %>",
		colorButton_enableMore: false,
		colorButton_colors: '58585A,88952B,555555'
//		forcePasteAsPlainText: true
	});
</script>

<script>
$("#edit_new_category").keydown( function() {
	$("#edit_id_category").val("");
	$("#item_edit_id_category .select_styled").html( $("#edit_id_category option[value="+$("#edit_id_category").val()+"]").html() );
});
</script>
