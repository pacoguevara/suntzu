# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->	
	load_user_in_map = (user_id) ->
		console.log "/api/users/"+user_id+"?cols=zipcode,id"
		$.ajax 
			url:"/api/users/"+user_id+"?cols=zipcode,id,neighborhood, name"
			success:(data) ->
				console.log data
				draw_user_in_map data
			error:(info) ->
	draw_user_in_map = (data) ->
		address = data[0].neighborhood + ',' +data[0].zipcode + " Escobedo, NL, Mexico"
		console.log address
		initCenter = new google.maps.LatLng(25.673252,-100.30892)
		geocoder = new google.maps.Geocoder()
		map = new google.maps.Map(document.getElementById('containerMapas'), 
    	zoom: 17
    	center: initCenter
    	mapTypeId: google.maps.MapTypeId.ROADMAP
    )

		geocoder.geocode {address: address}, (results, status) ->
			if status == google.maps.GeocoderStatus.OK
				lat = results[0].geometry.location.lat();
				lng = results[0].geometry.location.lng();
				console.log lat + ',' + lng
				myLatlng = new google.maps.LatLng lat, lng
				
				marker = new google.maps.Marker
					position: myLatlng
					map: map
					center: myLatlng
					title: "Casa de "+data[0].name
				map.setCenter myLatlng
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

	fill_table = (table_id, data) ->
		$("tr:has(td)").remove();
		$.each data, (i, item) ->
			#remove rows
			tds = '<td><p class="small"> ' + data[i].register_date + " </p></td> " +
			'<td><p class="small"> ' + data[i].ife_key + " </p></td> " +
			'<td><p class="small"> ' + data[i].bird + " </p></td> " +
			'<td><p class="small"> ' + data[i].name + " </p></td> " +
			'<td><p class="small"> ' + data[i].first_name + " </p></td> " +
			'<td><p class="small"> ' + data[i].last_name + " </p></td> " +
			'<td><p class="small"> ' + data[i].gender + " </p></td> " +
			'<td><p class="small"> ' + data[i].age + " </p></td> " +
			'<td><p class="small"> ' + parseInt(data[i].section)+ " </p></td> " +
			'<td><p class="small"> ' + parseInt(data[i].dto_fed) + " </p></td> " +
			'<td><p class="small"> ' + parseInt(data[i].dto_loc) + " </p></td> " +
			'<td><p class="small"> ' + data[i].city + " </p></td> " +
			'<td><p class="small"> ' + data[i].street_number + " </p></td> " +
			'<td><p class="small"> ' + parseInt(data[i].outside_number) + " </p></td> " +
			'<td><p class="small"> ' + parseInt(data[i].internal_number) + " </p></td> " +
			'<td><p class="small"> ' + data[i].neighborhood + " </p></td> " +
			'<td><p class="small"> ' + parseInt(data[i].zipcode) + " </p></td> " +
			'<td><p class="small"> ' + parseInt(data[i].phone) + " </p></td> " +
			'<td><p class="small"> ' + parseInt(data[i].cellphone) + " </p></td> " +
			'<td colspan="2">' + data[i].email + " </p></td> " +
			'<td><p class="small"> ' + data[i].role + " </p></td> " +
			'<td><p class="small"> ' + data[i].parent + " </p></td> " +
			'<td ><a href="/users/'+data[i].id+'"><span class="glyphicon glyphicon-eye-open"></span></a></td>'+
			'<td ><a class="table-action" data-confirm="¿Está seguro que desea eliminar?" data-method="delete" href="/users/'+data[i].id+'" rel="nofollow">'+
			'<span class="glyphicon glyphicon-remove"></span></a></td>'
			cleared_tds = ((tds.replace 'null', '').replace 'null', '').replace 'NaN', ''
			#console.log cleared_tds
			$('<tr>').html(cleared_tds).appendTo table_id

	load_parents(getURLParameter('role'))
	load_user_in_map(window.uid)
	console.log window.uid
