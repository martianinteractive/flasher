jQuery ->
  $('<div id="flasher-messages"></div>').prependTo 'body'
  Flasher.showFlashFromCookies()

Flasher = (->
  hideFlash = (flash) ->
    flash.slideUp 100, ->
      flash.remove()

  showFlashMessage = (message, options) ->
    options = $.extend(type: "notice", timeout: 5000, options)

    flash = $("<div class='#{message['type']}'><div>#{message['message']}</div></div>")
    console.log $("#flasher-messages").prepend flash
    flash.hide().delay(300).slideDown 100
    flash.click ->
      hideFlash flash

    if options.timeout > 0
      setTimeout (->
        hideFlash flash
      ), options.timeout

  extractFlashFromCookies = (request) ->
    if flash = Cookies.get('flash')
      decoded = decodeURIComponent(flash.replace(/\+/g,'%20'))
      data = $.parseJSON(decoded);
      Cookies.remove('flash')
      data

  showFlashFromCookies: ->
    flashMessages = extractFlashFromCookies() || []
    $.each flashMessages, (_, flashMessage) ->
      showFlashMessage(type: flashMessage[0], message: flashMessage[1])

)()

$(document).on 'ajaxComplete', (event, request) ->
  Flasher.showFlashFromCookies()
