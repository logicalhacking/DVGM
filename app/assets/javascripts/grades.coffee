# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Parse GET parameters into urlParams object
match = undefined
pl     = /\+/g  # Regex for replacing addition symbol with a space
search = /([^&=]+)=?([^&]*)/g
decode = (s) -> decodeURIComponent(s.replace(pl, " "))
query  = window.location.search.substring(1)

window.urlParams = {}
while (match = search.exec(query))
   urlParams[decode(match[1])] = decode(match[2])


(exports ? this).validate_file = (file) ->
  if $(file).data("max-file-size") < file.files[0].size
    alert("File exceeded maximum file size!")
    $(file).val('')
  else if not file.files[0].name.endsWith("." + $(file).data("allowed-extension"))
    alert("File has forbidden extension!")
    $(file).val('')


$ ->
  if window.urlParams.hasOwnProperty('lecturer')
    $("p[data-search-info]").html("Showing grades from lecturer " + window.urlParams["lecturer"])
