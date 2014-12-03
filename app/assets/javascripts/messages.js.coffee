# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

message = 
	url: "/api/messages"
	send: (msg, table_items)->
		console.log table_items
		$.ajax
		 	type: 'POST'
		 	url:"/api/messages"
		 	data:
		 		message: msg
		 	success:(data)->
		 		alert 'Se ha enviado el mensaje'
		 		console.log data
		 		msg_id = data.id
		 		console.log msg_id
	 			table_items.each ->
	 				cell = $(this).find('td > p.cellphone').html()
	 				user = $(this).find('td > p.cellphone').attr('id')
	 				console.log cell
	 				console.log user
						$.ajax
							type: 'POST'
						 url:"/api/messages/"+data.id+"/user"
						 data:
					 		user_id: user
					 		cellphone: cell
					 		message: msg
					 		message_id: msg_id
				 		success:(data)->
				 			console.log data

			
$ ->
	$('#send_twilio').click ->

		table_items = $('#militants_table > tbody > tr')
		#console.log table_items
		#table_items.each -> 
		#	console.log $(@)[0].id
		#	cellphone = $(this).find('td > p.cellphone').html()
		#	console.log cellphone
		message.send($('#message_message').val(), table_items)
		false


	#Trying to create the filters
	$('.search_m').keypress (e) ->
			key = e.which
			if key is 13
				$inputs = $('.search_m')
				params = {}
				$inputs.each ->
					unless $(this).val() is ''
						params[this.name] = $(this).val()
				if params
					$.ajax 
						url:"/api/users"
						data:
							role: 'jugador'
							municipality_id: params['municipality_id']
							age: params['age']
							section: params['section']
							city: params['city']
							zipcode: params['zipcode']
							phone: params['phone']
							parent: params['parent']
							email: params['email']
							cellphone: params['cellphone']
							gender: params['gender']
							name: params['name']
							first_name: params['first_name']
							last_name: params['last_name']
							parent: params['parent']
							sub_enlace_id: params['sub_enlace_id']
							enlace_id: params['enlace_id']
							coordinador_id: params['coordinador_id']
						success: (data) ->
							fill_table('#militants_table', data)

	$('.select_search_m').change ->
		filters = get_filters()
		$.ajax 
				url:"/api/users"
				data:
					filters.data
				success: (data) ->
					console.log data
					fill_table('#militants_table', data)

	get_filters = ->
		$inputs = $('.search_m')
		params = {}
		data = {}
		$inputs.each ->
			unless $(this).val() is ''
				params[this.name] = $(this).val()
		if params
			data:
				role: 'jugador'
				register_date: params['register_date']
				municipality_id: if params['municipality_id'] isnt '-1' then params['municipality_id']
				age: params['age']
				city: params['city']
				email: params['email']
				cellphone: params['cellphone']
				gender: params['gender']
				name: params['name']
				first_name: params['first_name']
				last_name: params['last_name']
				sub_enlace_id: params['sub_enlace_id']
				enlace_id: params['enlace_id']
				coordinador_id: params['coordinador_id']
						

	fill_table = (table_id, data) ->
			count = data.total
			subenlaces = data.subenlaces
			enlaces = data.enlaces
			coordinadores = data.coordinadores
			
			$('#total_result').html(count)
			
			$("tr:has(td)").remove();
			console.log data.data
			data = data.data
			$.each data, (i, item) ->
				#change selected parents if user has one
				stringsubenlace = '<td><p class="small"> '
				$.each subenlaces, (j, item)->
					if subenlaces[j].id == data[i].subenlace_id
						stringsubenlace = stringsubenlace + subenlaces[j].name + " " + subenlaces[j].first_name 
						+ " " +subenlaces[j].last_name + '</p></td>'

				stringenlace = '<td><p class="small"> '
				$.each enlaces, (j, item)->
					if enlaces[j].id == data[i].enlace_id
						stringenlace = stringenlace + enlaces[j].name + " " + enlaces[j].first_name 
						+ " " +enlaces[j].last_name + '</p></td>'

				stringcoordinador = '<td><p class="small"> '
				$.each coordinadores, (j, item)->
					if coordinadores[j].id == data[i].coordinador_id
						stringcoordinador = stringcoordinador + coordinadores[j].name + " " + coordinadores[j].first_name 
						+ " " +coordinadores[j].last_name + '</p></td>'

					
					
				tds = '<td><p class="small"><a href="/users/'+data[i].id+'"> ' + data[i].name + " </a></p></td> " +
				'<td><p class="small"> <a href="/users/'+data[i].id+'"> ' + data[i].first_name + " </a> </p></td> " +
				'<td><p class="small"> <a href="/users/'+data[i].id+'"> ' + data[i].last_name + " </a> </p></td> " +
				'<td><p class="small cellphone" id="'+data[i].id+'"> ' + data[i].cellphone + " </p></td> " +
				'<td><p class="small"> ' + data[i].email + " </p></td> " +
				'<td><p class="small"> ' + data[i].gender + " </p></td> " +
				'<td><p class="small"> ' + data[i].age + " </p></td> " +
				'<td><p class="small"> ' + data[i].city + " </p></td> " +
				'<td><p class="small"> ' + "#" + " </p></td> "  + stringsubenlace + stringenlace + stringcoordinador +
				'<td><p class="small"> ' + "#" + " </p></td> " 

				cleared_tds = ((tds.replace 'null', '').replace 'null', '').replace 'NaN', ''
				#console.log cleared_tds
				$('<tr>').html(cleared_tds).appendTo table_id
				
