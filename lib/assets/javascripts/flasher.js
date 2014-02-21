$('<div id="flasher"></div>').prependTo 'body'

Flasher = ->

  // css_class =
  //   Notice: "alert-success"
  //   Warning: "alert-warning"
  //   Error: "alert-danger"

  // hideFlash = ($flash) ->
  //   $flash.slideUp 100, ->
  //     $flash.remove()
  //     return

  show: (request) ->
    console.log 'from flasher'
    // for type in ["Notice", "Warning", "Error"]
    // msg = request.getResponseHeader("X-Ajax-#{type}")
    // if msg?
    //   flash = $("<div class=\"flasher-wrapper\"><div class=\"#{css_class[type]}\">#{msg}</div></div>")

    //   $('#flash').append("<div class=\"#{css_class[type]}\">#{msg}</div>")
    //   $("#flash .alert").fadeTo("fast", 0.98).delay(600).fadeOut(1200, -> $(this).remove())
()


$(document).on 'ajaxComplete', (event, request) ->
  Flasher.show

