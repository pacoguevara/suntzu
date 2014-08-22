# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "change", "#role-select", ->
  window.location = "/users?role=" + $("option:selected", this).val()
  return