# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->	
	load_user_in_map = (user_id) ->
		console.log "/api/users/"+user_id+"?cols=zipcode,id,lat,lng"
		$.ajax 
			url:"/api/users/"+user_id+"?cols=zipcode,id,neighborhood,name,lat,lng,city"
			success:(data) ->
				console.log data
				draw_user_in_map data
			error:(info) ->
	draw_user_in_map = (user_data) ->
		console.log user_data[0].lat
		if user_data[0].lat == undefined || user_data[0].lat == null
			url = "https://maps.googleapis.com/maps/api/geocode/json?address="+user_data[0].zipcode+", "+user_data[0].neighborhood+", "+user_data[0].city+", NL, Mexico"
			console.log url
			$.get(url).success (data) ->
				initCenter = new google.maps.LatLng(data.results[0].geometry.location.lat,data.results[0].geometry.location.lng)
				mapOptions =
					zoom: 17
					center: initCenter
				map = new google.maps.Map(document.getElementById('containerMapas'), mapOptions)
				marker = new google.maps.Marker
					position: initCenter
					map: map
					draggable: true
					center: initCenter
					title: "Casa de "+user_data[0].name
				google.maps.event.addListener(marker, 'dragend', ->
					if confirm '¿Está seguro que desea cambiar la ubicación del jugador?'
						$.ajax
							url:"/api/users/"+user_data[0].id
							type: "PUT"						
							data:
								user: 
									lat: marker.getPosition().lat()
									lng: marker.getPosition().lng()
							dataType: "json"
							success: (data, textStatus, jqXHR) ->
								console.log data
					else
								
						)
		else
			initCenter = new google.maps.LatLng(user_data[0].lat,user_data[0].lng)
			mapOptions =
					zoom: 17
					center: initCenter
			map = new google.maps.Map(document.getElementById('containerMapas'), mapOptions)
			marker = new google.maps.Marker
				position: initCenter
				map: map
				draggable: true
				center: initCenter
				title: "Casa de "+user_data[0].name
				
			google.maps.event.addListener(marker, 'dragend', ->
					if confirm '¿Está seguro que desea cambiar la ubicación del jugador?'
						$.ajax
							url:"/api/users/"+user_data[0].id
							type: "PUT"						
							data:
								user: 
									lat: marker.getPosition().lat()
									lng: marker.getPosition().lng()
							dataType: "json"
							success: (data, textStatus, jqXHR) ->
								console.log data
					else
								
						)
			
	load_parents = (role)->
		$.get "/api/users/parents?role="+role, (data) ->
			$("#parent-select").empty()
			data.forEach (entry) ->
				option = "<option value=\"" + entry.id + "\">" + entry.name + " " + entry.last_name + "</option>"
				$("#parent-select").append option
	show_groups = ->
		#$('#group').hide()
		$('#user_group_id').attr('disabled',false)
	hide_groups = ->
		$('#group').hide()
	$(document).on "change", "#role-select", ->
	  window.location = "/users?role=" + $("option:selected", this).val()
	  return
	
	$(document).on "change", "#role_select_form", ->
		role=$("option:selected", this).val()
		if role is 'coordinador'
			show_groups()
		else
			hide_groups()
		load_parents(role)
		

	$('.search').keyup (e) ->
		$inputs = $('.search')
		params = {}
		$inputs.each ->
			unless $(this).val() is ''
			
				params[this.name] = $(this).val()
		if params
			$.ajax 
				url:"/api/users"
				data:
					role: if params['role'] isnt undefined then params['role'] else getURLParameter('role')
					register_date: params['register_date']
					ife_key: params['ife_key']
					bird: params['bird']
					age: params['age']
					section: params['section']
					dto_fed: params['dto_fed']
					dto_loc: params['dto_loc']
					city: params['city']
					street_number: params['street_number']
					outside_number: params['outside_number']
					internal_number: params['internal_number']
					neighborhood: params['neighborhood']
					zipcode: params['zipcode']
					phone: params['phone']
					parent: params['parent']
					email: params['email']
					cellphone: params['cellphone']
					gender: params['gender']
					rnm: params['rnm']
					name: params['name']
					first_name: params['first_name']
					last_name: params['last_name']
					parent: params['parent']
				success: (data) ->
					console.log data
					fill_table('#users_table', data)

	$('.page_number').click (e) ->
		$('.page_number').removeClass 'active'
		$(this).addClass 'active'
		page_number=$(this).data('num')
		console.log page_number
		$.ajax 
			url:"/api/users"
			data:
				role: if getURLParameter('role') != 'jugador' then getURLParameter('role') else ''
				page: page_number
			success: (data) ->
				console.log data
				fill_table('#users_table',data)
				$('html, body').animate(
					scrollTop : 0
				,800)

	fill_table = (table_id, data) ->
		$("tr:has(td)").remove();
		$.each data, (i, item) ->
			#remove rows
			tds = '<td><p class="small"> ' + data[i].name + " </p></td> " +
			'<td><p class="small"> ' + data[i].first_name + " </p></td> " +
			'<td><p class="small"> ' + data[i].last_name + " </p></td> " +
			'<td><p class="small"> ' + data[i].gender + " </p></td> " +
			'<td><p class="small"> ' + data[i].age + " </p></td> " +
			'<td><p class="small"> ' + parseInt(data[i].section)+ " </p></td> " +
			'<td><p class="small"> ' + data[i].city + " </p></td> " +
			'<td><p class="small"> ' + data[i].neighborhood + " </p></td> " +
			'<td ><a href="/users/'+data[i].id+'"><span class="glyphicon glyphicon-eye-open"></span></a></td>'+
			'<td ><a class="table-action" data-confirm="¿Está seguro que desea eliminar?" data-method="delete" href="/users/'+data[i].id+'" rel="nofollow">'+
			'<span class="glyphicon glyphicon-remove"></span></a></td>'

			cleared_tds = ((tds.replace 'null', '').replace 'null', '').replace 'NaN', ''
			#console.log cleared_tds
			$('<tr>').html(cleared_tds).appendTo table_id

	load_parents(getURLParameter('role'))
	if $('#show_user_id').val() != undefined
		load_user_in_map($('#show_user_id').val())
	console.log $('#show_user_id').val() != undefined
