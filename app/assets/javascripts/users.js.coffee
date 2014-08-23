# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	console.log 'jquery loaded'
	$(document).on "change", "#role-select", ->
	  window.location = "/users?role=" + $("option:selected", this).val()
	  return

	$(document).on "change", "#role_select_form", ->
		$.get "/api/users/parents?role="+$("option:selected", this).val(), (data) ->
			data.forEach (entry) ->
				$("#parent-select").empty()
				$("#parent-select").append "<option value=\"" + entry.id + "\">" + entry.name + " " + entry.last_name + "</option>"
				return
			return
		return

	$('.search').keyup (e) ->
		$inputs = $('.search')
		params = {}
		$inputs.each ->
			unless $(this).val() is ''
				console.log this.name
				params[this.name] = $(this).val()
		if params
			$.ajax 
				url:"/api/users/parents"
				data:
					role: params['role']
					email: params['email']
					cellphone: params['cellphone']
					rnm: params['rnm']
					name: params['name']
					parent: params['parent']
				success: (data) ->
					console.log data
		console.log $(this).val()