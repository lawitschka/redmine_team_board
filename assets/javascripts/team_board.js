$(function() {
  $('select#version_id').change(function() {
    var _id = $(this).find('option:selected').attr('value');
    var _url = $(this).data('url').replace('VERSION', _id);
    window.location = _url;
  });
});