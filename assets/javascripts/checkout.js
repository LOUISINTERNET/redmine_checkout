$(document).ready(function(){
  /* update the checkout URL if clicked on a protocol */
  $('#checkout_box #checkout_protocols a').each(function(i) {
    $(this).bind('click', function(event) {
      $('input#checkout_url').val(checkout_commands[$(this).attr('id')]);
      $('#checkout_box #checkout_protocols a').removeClass("selected");
      $(this).addClass("selected")

      var access = $('span#checkout_access');
      if (access.size() > 0) {
        var value = window.checkout_access[$(this).attr('id')];
        access.html(value);
      }

      event.preventDefault();
    });
  });
  /* select the text field contents if activated */
  $('input#checkout_url').bind('click', function(event) {
    $(this).focus();
  });

  if (typeof('ZeroClipboard') != 'undefined') {
    $('div#clipboard_container').show();
    clipboard = new ZeroClipboard.Client();
    clipboard.setHandCursor( true );
    clipboard.glue('clipboard_button', 'clipboard_container');

    clipboard.addEventListener('mouseOver', function (client) {
      clipboard.setText( $('#checkout_url').val() );
    });
  }
});
