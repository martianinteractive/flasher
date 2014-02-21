jQuery ->
  $('<div id="flasher-message"></div>').prependTo 'body'

Flasher = (->

  css_class =
    Notice: "success"
    Warning: "warning"
    Error: "error"

  options = $.extend({timeout: 5000}, options);

  hideFlash = (flash) ->
    flash.slideUp 100, ->
      flash.remove()
      return

  show: (request) ->
    for type in ["Notice", "Warning", "Error"]
      msg = request.getResponseHeader("X-RailsFlash-#{type}")
      console.log msg
      if msg?
        flash = $("<div class=\"flasher-wrapper\"><div class=\"#{css_class[type]}\">#{msg}</div></div>")

    $("#flasher-message").prepend flash
    flash.hide().delay(300).slideDown 100
    flash.click ->
      hideFlash flash
      return

    if options.timeout > 0
      setTimeout (->
        hideFlash flash
        return
      ), options.timeout
)()

$(document).on 'ajaxComplete', (event, request) ->
  Flasher.show(request)
