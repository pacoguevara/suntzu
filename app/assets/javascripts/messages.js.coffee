# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

message = 
	url: "/api/messages"
	send: (cell, msg)->
		console.log 'sending'
		$.ajax
		 	type: 'POST'
		 	url:"/api/messages"
		 	data:
		 		cellphone:cell
		 		message: msg
$ ->
	$('#send_twilio').click ->
		table_items = $('#militants_table > tbody > tr')
		table_items.each -> 
			console.log 
			cellphone = $(this).find('td.cellphone').html()
			message.send(cellphone, $('#message_message').val())
		false
