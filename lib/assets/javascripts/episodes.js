$(function(){

  //defaults
  $.fn.editable.defaults.url = '/episodes';

  //enable / disable
  $('#enable').click(function() {
    $('#user .editable').editable('toggleDisabled');
  });

  //editables
  $('#title').editable();
  $('#summary').editable({showbuttons: 'bottom'});
  $('#author').editable();
  $('#subtitle').editable();

  $('#user .editable').on('hidden', function(e, reason){
    if(reason === 'save' || reason === 'nochange') {
      var $next = $(this).closest('tr').next().find('.editable');
      if($('#autoopen').is(':checked')) {
        setTimeout(function() {
          $next.editable('show');
        }, 300);
      } else {
        $next.focus();
      }
    }
  });

});
