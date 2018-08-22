# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

match = undefined
pl     = /\+/g  # Regex for replacing addition symbol with a space
search = /([^&=]+)=?([^&]*)/g
decode = (s) -> decodeURIComponent(s.replace(pl, " "))
query  = window.location.search.substring(1)

window.urlParams = {}
while (match = search.exec(query))
   urlParams[decode(match[1])] = decode(match[2])
$ -> $("p[data-search-info]").html("You searched for lecturer: " + window.urlParams["lecturer"])
