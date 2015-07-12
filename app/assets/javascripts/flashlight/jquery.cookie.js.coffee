#!
# * jQuery Cookie Plugin v1.4.0
# * https://github.com/carhartl/jquery-cookie
# *
# * Copyright 2013 Klaus Hartl
# * Released under the MIT license
#
((factory) ->
  if typeof define is "function" and define.amd

    # AMD
    define ["jquery"], factory
  else if typeof exports is "object"

    # CommonJS
    factory require("jquery")
  else

    # Browser globals
    factory jQuery
  return
) ($) ->
  encode = (s) ->
    (if config.raw then s else encodeURIComponent(s))
  decode = (s) ->
    (if config.raw then s else decodeURIComponent(s))
  stringifyCookieValue = (value) ->
    encode (if config.json then JSON.stringify(value) else String(value))
  parseCookieValue = (s) ->

    # This is a quoted cookie as according to RFC2068, unescape...
    s = s.slice(1, -1).replace(/\\"/g, "\"").replace(/\\\\/g, "\\")  if s.indexOf("\"") is 0
    try

      # Replace server-side written pluses with spaces.
      # If we can't decode the cookie, ignore it, it's unusable.
      # If we can't parse the cookie, ignore it, it's unusable.
      s = decodeURIComponent(s.replace(pluses, " "))
      return (if config.json then JSON.parse(s) else s)
    return
  read = (s, converter) ->
    value = (if config.raw then s else parseCookieValue(s))
    (if $.isFunction(converter) then converter(value) else value)
  pluses = /\+/g
  config = $.cookie = (key, value, options) ->

    # Write
    if value isnt `undefined` and not $.isFunction(value)
      options = $.extend({}, config.defaults, options)
      if typeof options.expires is "number"
        days = options.expires
        t = options.expires = new Date()
        t.setTime +t + days * 864e+5
      # use expires attribute, max-age is not supported by IE
      return (document.cookie = [
        encode(key)
        "="
        stringifyCookieValue(value)
        (if options.expires then "; expires=" + options.expires.toUTCString() else "")
        (if options.path then "; path=" + options.path else "")
        (if options.domain then "; domain=" + options.domain else "")
        (if options.secure then "; secure" else "")
      ].join(""))

    # Read
    result = (if key then `undefined` else {})

    # To prevent the for loop in the first place assign an empty array
    # in case there are no cookies at all. Also prevents odd result when
    # calling $.cookie().
    cookies = (if document.cookie then document.cookie.split("; ") else [])
    i = 0
    l = cookies.length

    while i < l
      parts = cookies[i].split("=")
      name = decode(parts.shift())
      cookie = parts.join("=")
      if key and key is name

        # If second argument (value) is a function it's a converter...
        result = read(cookie, value)
        break

      # Prevent storing a cookie that we couldn't decode.
      result[name] = cookie  if not key and (cookie = read(cookie)) isnt `undefined`
      i++
    result

  config.defaults = {}
  $.removeCookie = (key, options) ->
    return false  if $.cookie(key) is `undefined`

    # Must not alter options, thus extending a fresh object...
    $.cookie key, "", $.extend({}, options,
      expires: -1
    )
    not $.cookie(key)

  return
