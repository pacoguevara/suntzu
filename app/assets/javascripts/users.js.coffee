# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->	
	User = (->
		subenlaces = []
		enlaces = []
		coordinadores = []
		grupos = []
		complete =  4
		 
		init = ->
			bind_witho_load()
			getSubEnlaces()
			getEnlaces()
			getCoordinadores()
			getGrupos()
			bind()
			return
		bind_witho_load = ->
			$('#user_enabled').change ->
				if $(this).is(':checked')
					$('#user_password').removeClass 'hide'
					$('#user_password_confirmation').removeClass 'hide'
				else
					$('#user_password').addClass 'hide'
					$('#user_password_confirmation').addClass 'hide'
			return 
			#$('#role_select_form'). ->

		bind = ->
			$('#user_subenlace_id').change ->
				selectSubEnlace( @ )
			$('#user_enlace_id').change ->
				selectEnlace( @ )
			$('#user_coordinador_id').change ->
				selectCoordinador( @ )
			$('#user_group_id').change ->
				selectGrupo( @ )
			return
		searchInCoordinador = (id) ->
			grupo_id = 0
			$(coordinadores).each (i) ->
				if coordinadores[i].id is parseInt(id)
					grupo_id = coordinadores[i].group_id
					return false
			return grupo_id
		searchInSubenlaces = (id) ->
			enlace_id = 0
			coordinador_id = 0
			group_id = 0
			$(subenlaces).each (i) ->
				if subenlaces[i].id is parseInt(id)
					enlace_id = subenlaces[i].enlace_id
					coordinador_id = subenlaces[i].coordinador_id
					group_id = subenlaces[i].group_id
					return false
			return [enlace_id, coordinador_id, group_id]
		searchInEnlaces = (id) ->
			coordinador_id = 0
			group_id = 0
			$(enlaces).each (i) ->
				if enlaces[i].id is parseInt(id)
					coordinador_id = enlaces[i].coordinador_id
					group_id = enlaces[i].group_id
					return false
			return [coordinador_id,group_id]

		selectGrupo = (el)->
			$('#user_subenlace_id').val 0
			$('#user_enlace_id').val 0
			$('#user_coordinador_id').val 0
			return
		selectSubEnlace = (el)->
			enlace_id = searchInSubenlaces($(el).val())[0]
			coordinador_id = searchInSubenlaces($(el).val())[1]
			grupo_id = searchInSubenlaces($(el).val())[2]
			if !coordinador_id 
				coordinador_id = 0
			if !grupo_id 
				grupo_id = 0
			if !enlace_id 
				enlace_id = 0
			
			$('#user_enlace_id').val enlace_id
			$('#user_coordinador_id').val coordinador_id
			$('#user_group_id').val grupo_id
			return
		selectEnlace = (el)->
			coordinador_id = searchInEnlaces($(el).val())[0]
			grupo_id = searchInEnlaces($(el).val())[1]
			$('#user_group_id').val grupo_id
			$('#user_coordinador_id').val coordinador_id
			$('#user_subenlace_id').val('0')
			return
		selectCoordinador = (el)->
			grupo_id = searchInCoordinador $(el).val()
			$('#user_group_id').val grupo_id
			$('#user_subenlace_id').val('0')
			$('#user_enlace_id').val('0')
			return
		getGrupos = ->
			$.ajax
				url: '/api/groups/grupos'
				success: (data)->
					grupos = data
					complete = complete - 1
					if complete is 0
						bind()
			return
		getCoordinadores = ->
			$.ajax
				url: '/api/users/coordinadores'
				success: (data)->
					coordinadores = data
					complete = complete - 1
					if complete is 0
						bind()
			return
		getEnlaces = ->
			$.ajax
				url: '/api/users/enlaces'
				success: (data)->
					enlaces = data
					complete = complete - 1
					if complete is 0
						bind()
			return
		getSubEnlaces = ->
			$.ajax
				url: '/api/users/subenlaces'
				success: (data)->
					subenlaces = data
					complete = complete - 1
					if complete is 0
						bind()
			return
		
		init:init
	)()

	User.init()

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
				if data.results.length > 0
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
		# if role is 'coordinador'
		# 	show_groups()
		# else
		# 	hide_groups()
		#load_parents(role)
		if role is 'jugador'
			$('#select_subenlace').show()
			$('#select_enlace').show()
			$('#select_coordinador').show()
		if role is 'subenlace'
			$('#select_subenlace').hide()
			$('#select_enlace').show()
			$('#select_coordinador').show()
		if role is 'enlace'
			$('#select_subenlace').hide()
			$('#select_enlace').hide()
			$('#select_coordinador').show()
		if role is 'coordinador'
			$('#select_subenlace').hide()
			$('#select_enlace').hide()
			$('#select_coordinador').hide()

		
	$('.search3').keypress (e) ->
		key = e.which
		if key is 13
			filters = get_filters2()
			$.ajax 
				url:"/api/users/get_list_votation"
				data:
					filters.data
				success: (data) ->
					console.log "data"
					console.log data
					fill_table2("#detalle_table", data)
	$(document).on "change", ".filtro_role", ->	
		filters = get_filters_role()
		console.log "filters"
		console.log filters.data
		$.ajax 
				url:"/api/users/tabla_show"
				data:
					filters.data
				success: (data) ->
					console.log "succeess"
					console.log data
					fill_table_show('#users_table', data)
	$(document).on "change", ".filtro_dropdown", ->	
		filters = get_filters()
		$.ajax 
				url:"/api/users"
				data:
					filters.data
				success: (data) ->
					fill_table('#users_table', data)

	
	$('#head_municipality').change ->
		filters = get_lista_nominal_filters()

		$.ajax 
			url:"/api/users"
			data:
				filters.data
			success: (data) ->
				fill_table_nominal_list('#users_table', data)
			error: (xhr, ajaxOptions, thrownError) ->
		      alert xhr.status 
		      alert thrownError
		      return
		      
	$('.search2').keypress (e) ->
		key = e.which
		console.log key
		if key is 13
			filters = get_filters()
			$.ajax 
					url:"/api/users"
					data:
						filters.data
					success: (data) ->
						fill_table_nominal_list('#users_table', data)
					error: (xhr, ajaxOptions, thrownError) ->
				      alert xhr.status 
				      alert thrownError
				      return

	$('.search').keypress (e) ->
		key = e.which
		if key is 13
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
						municipality_id: params['municipality_id']
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
	get_lista_nominal_filters = ->
		$inputs = $('.search2')
		params = {}
		data = {}
		$inputs.each ->
			unless $(this).val() is ''
				params[this.name] = $(this).val()
		console.log params
		if params
			data:
				municipality_id: if params['municipality_id'] isnt '-1' then params['municipality_id']
				role: 'jugador'
				register_start: if $('#register_start_date').val() isnt '' then $('#register_start_date').val()
				register_end: if $('#register_end_date').val() isnt '' then $('#register_end_date').val()
				bird_start: if $('#bird_start_date').val() isnt '' then $('#bird_start_date').val()
				bird_end: if $('#bird_end_date').val() isnt '' then $('#bird_end_date').val()
	get_filters2 = ->
		$inputs = $('.search3')
		params = {}
		data = {}
		$inputs.each ->
			unless $(this).val() is ''
				params[this.name] = $(this).val()
		if params
			data:
				number: params['number']
				name: params['name']
				polling_id: $('.hidd')[0].value
				
	get_filters_role = ->
		$inputs = $('.search4')
		params = {}
		data = {}
		$inputs.each ->
			unless $(this).val() is ''
				params[this.name] = $(this).val()
		console.log "params"
		console.log params
		if params
			data:
				role: params['role_select']
				usuario_id: params['usuario_id']
				usuario_role: params['usuario_role']
	get_filters = ->
		$inputs = $('.search')
		params = {}
		data = {}
		$inputs.each ->
			unless $(this).val() is ''
				params[this.name] = $(this).val()
		console.log "params"
		console.log params
		if params
			data:
				role: if params['role'] isnt undefined then params['role'] else getURLParameter('role')
				register_date: params['register_date']
				municipality_id: if params['municipality_id'] isnt '-1' then params['municipality_id']
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
				register_start: params['register_start_date']
				register_end: params['register_end_date']
				bird_start: params['bird_start_date']
				bird_end: params['bird_end_date']
				sub_enlace_id: params['sub_enlace_id']
				enlace_id: params['enlace_id']
				coordinador_id: params['coordinador_id']
				group_id: params['group_id']
				role_select: params['role_select']
	selectchange = (id, user_id, tipo) ->
	  $.ajax
	    url: "/api/users/enlace"
	    dataType: "json"
	    data:
	      id1: id
	      id2: user_id
	      tipo: tipo

	    success: (json) ->

	    error: (xhr, ajaxOptions, thrownError) ->
	      alert xhr.status
	      alert thrownError
	      return

	  return
	changeselected = (esto,id, user_id, tipo) ->
		$.ajax
			url: "/api/users/get_parent"
			data:
				id1: id
				id2: user_id
				tipo: tipo
			success: (json) ->
				if json isnt false
					console.log "respuesta"
					console.log esto
					if tipo == 1
						if json["user_id"] != null
							$(esto).parent().parent().parent().find('#td-enlace').find('.enlace').val json["user_id"]
							$(esto).parent().parent().parent().find('#td-coordinador').find('.coordinador').val json["user_id2"]
					if tipo == 2
						$(esto).parent().parent().parent().find('#td-subenlace').find('.subenlace').val json["user_id"]
						if json["user_id2"] != null
							$(esto).parent().parent().parent().find('#td-coordinador').find('.coordinador').val json["user_id2"]
					if tipo == 3
						$(esto).parent().parent().parent().find('#td-subenlace').find('.subenlace').val json["user_id"]
						$(esto).parent().parent().parent().find('#td-enlace').find('.enlace').val json["user_id2"]
					$(esto).parent().parent().parent().find('#td-grupo').html(json["group_name"])	
			error: (xhr, ajaxOptions, thrownError) ->
				alert xhr.status 
				alert thrownError
		  return
		$.ajax
			url: "/api/users/update_hijos"
			data:
				id1: id
				id2: user_id
				tipo: tipo
			success: (json) ->
				console.log "se pudoooooo"
			error: (xhr, ajaxOptions, thrownError) ->
				alert xhr.status 
				alert thrownError
		  return

			
	$(document).on "change", ".select_class", ->
		selectchange $(this).val(),$(this).find(":selected").data("user_id"),$(this).find(":selected").data("tipo") 
		changeselected $(this),$(this).val(),$(this).find(":selected").data("user_id"),$(this).find(":selected").data("tipo") 
	$('.page_number').click (e) ->
		filters = get_filters()
		#console.log filters
		$('.page_number').removeClass 'active'
		$(this).addClass 'active'

		page_number=$(this).data('num')
		filters.data.page = page_number
		console.log page_number
		$.ajax 
			url:"/api/users"
			data: filters.data
			success: (data) ->
				console.log data
				fill_table('#users_table',data)
				$('html, body').animate(
					scrollTop : 0
				,800)
	fill_table2 = (table_id, data) ->
		$("tr:has(td)").remove();
		$.each data, (i, item) ->
			if data[i].check == true
				checkaux = '<input type="checkbox" name="temp_chek" class="check2" data-id="'+data[i].id+'" checked>Ya votó'
			else
				checkaux = '<input type="checkbox" name="temp_chek" class="check2" data-id="'+data[i].id+'">Ya votó'
			tds = '<td><p class="small"> ' + data[i].number + " </p></td> " +
			'<td><p class="small"> ' + data[i].name + " </p></td> " +
			'<td><p class="small"> ' + checkaux + " </p></td> "
			cleared_tds = ((tds.replace 'null', '').replace 'null', '').replace 'NaN', ''
			$('<tr>').html(cleared_tds).appendTo '#detalle_table'
	fill_table_show = (table_id, data) ->
		$("tr:has(td)").remove();
		$("#total_result").html(data.data.length)
		data = data.data
		$.each data, (i, item) ->
			tds = '<td><p class="small"> ' + data[i].name + " </p></td> " +
			'<td><p class="small"> ' + data[i].first_name + " </p></td> " +
			'<td><p class="small"> ' + data[i].last_name + " </p></td> " +
			'<td><p class="small"> ' + data[i].gender + " </p></td> " +
			'<td><p class="small"> ' + data[i].age + " </p></td> " +
			'<td><p class="small"> ' + parseInt(data[i].section)+ " </p></td> " +
			'<td><p class="small"> ' + data[i].city + " </p></td> " +
			'<td><p class="small"> ' + data[i].neighborhood + " </p></td> " +
			'<td><p class="small"> ' + data[i].role + " </p></td> "
			cleared_tds = ((tds.replace 'null', '').replace 'null', '').replace 'NaN', ''
			$('<tr>').html(cleared_tds).appendTo table_id

	fill_table = (table_id, data) ->
		count = data.total
		subenlaces = data.subenlaces
		enlaces = data.enlaces
		coordinadores = data.coordinadores
		$('#total_result').html(count)
		
		#console.log data
		stringsubenlace = '<select class="default select_class subenlace" style="width:100%">'+
			'<option value="vacio" ></option>'
		stringenlace = '<select class="default select_class enlace" style="width:100%">'+
			'<option value="vacio" ></option>'
		stringcoordinador = '<select class="default select_class coordinador" '+
			'style="width:100%"><option value="vacio" ></option>'
		i = 0

		while i < subenlaces.length
			full_name = subenlaces[i].name+" "+subenlaces[i].first_name+
				' '+subenlaces[i].last_name
	  	stringsubenlace = stringsubenlace + 
		  '<option value = "'+subenlaces[i].id+'">'+full_name
		  '</option>'
		  i++

		i = 0
		while i < enlaces.length
				full_name=enlaces[i].name+" "+enlaces[i].first_name+
				' '+enlaces[i].last_name
		  stringenlace = stringenlace + '<option value = "'+enlaces[i].id+
		  '">'+full_name+'</option>'
		  i++

		i = 0
		while i < coordinadores.length
				full_name=coordinadores[i].name+" "+coordinadores[i].first_name+
				' '+coordinadores[i].last_name
		  stringcoordinador = stringcoordinador + '<option value = "'+
		  coordinadores[i].id+'">'+full_name+'</option>'
		  i++

		stringenlace = stringenlace + '</select>'
		stringcoordinador = stringcoordinador + '</select>'
		stringsubenlace = stringsubenlace + "</select>"
		
		html = $.parseHTML(stringsubenlace)
		html2 = $.parseHTML(stringenlace)
		html3 = $.parseHTML(stringcoordinador)

		$("tr:has(td)").remove();
		data = data.data
		$.each data, (i, item) ->
			#change selected parents if user has one
			string_selects = ""
			#if data[i].subenlace_id?
			option = $(html).find("option[value='" + data[i].subenlace_id + "']")[0] 
			$(option).attr "selected", "selected"
			#if data[i].enlace_id?
			option = $(html2).find("option[value='" + data[i].enlace_id + "']")[0]
			$(option).attr "selected", "selected"
			
			#if data[i].coordinador_id?
			option = $(html3).find("option[value='" + data[i].coordinador_id + "']")[0]
			$(option).attr "selected", "selected"
			 


			$($(html).find("option")).attr "data-user_id", data[i].id
			$($(html).find("option")).attr "data-tipo", "1"

			$($(html2).find("option")).attr "data-user_id", data[i].id
			$($(html2).find("option")).attr "data-tipo", "2"

			$($(html3).find("option")).attr "data-user_id", data[i].id
			$($(html3).find("option")).attr "data-tipo", "3"

			stringsubenlace = $(html).prop "outerHTML"
			stringenlace = $(html2).prop "outerHTML"
			stringcoordinador = $(html3).prop "outerHTML"

			if getURLParameter('role') is 'jugador'
				if data[i].role == "subenlace"
					stringsubenlace = ""
				else if data[i].role == "enlace"
					stringsubenlace = ""
					stringenlace = ""
				else if data[i].role == "coordinador"
					stringsubenlace = ""
					stringenlace = ""
					stringcoordinador = ""

				string_selects = '<td id="td-subenlace"><p class="small"> ' + stringsubenlace + "</p></td> " + '<td id="td-enlace"><p class="small"> ' + stringenlace + "</p></td> " + '<td id="td-coordinador"><p class="small"> ' + stringcoordinador + "</p></td> "
				string_grupo = '<td id="td-grupo"><p class="small"> ' + data[i].group + "</p></td>"+'<td><p class="small"> ' + data[i].role + "</p></td>"
			else
				console.log "heyyy"
				console.log data[i].role
				if data[i].role == "jugador"
					string_selects = '<td id="td-subenlace"><p class="small"> ' + stringsubenlace + "</p></td> " + '<td id="td-enlace"><p class="small"> ' + stringenlace + "</p></td> " + '<td id="td-coordinador"><p class="small"> ' + stringcoordinador + "</p></td> "
					string_grupo = '<td id="td-grupo"><p class="small"> ' + data[i].group + "</p></td>"+'<td><p class="small"> ' + data[i].role + "</p></td>"
				else if data[i].role == "subenlace"
					string_selects = '<td id="td-enlace"><p class="small"> ' + stringenlace + "</p></td> " + '<td id="td-coordinador"><p class="small"> ' + stringcoordinador + "</p></td> "
					string_grupo = ""
				else if data[i].role == "enlace" 
					string_selects = '<td id="td-coordinador"><p class="small"> ' + stringcoordinador + "</p></td> "
					string_grupo = ""

			tds = '<td><p class="small"><a href="/users/'+data[i].id+'"> ' + data[i].name + " </a></p></td> " +
			'<td><p class="small"> <a href="/users/'+data[i].id+'"> ' + data[i].first_name + " </a> </p></td> " +
			'<td><p class="small"> <a href="/users/'+data[i].id+'"> ' + data[i].last_name + " </a> </p></td> " +
			'<td><p class="small"> ' + data[i].gender + " </p></td> " +
			'<td><p class="small"> ' + data[i].age + " </p></td> " +
			'<td><p class="small"> ' + parseInt(data[i].section)+ " </p></td> " +
			'<td><p class="small"> ' + data[i].city + " </p></td> " +
			'<td><p class="small"> ' + data[i].neighborhood + " </p></td> " + string_selects +
			string_grupo

			cleared_tds = ((tds.replace 'null', '').replace 'null', '').replace 'NaN', ''
			#console.log cleared_tds
			$('<tr>').html(cleared_tds).appendTo table_id
			if data[i].subenlace_id?
				$($(html).find("option[value='"+data[i].subenlace_id+"']")[0]).removeAttr "selected"
			$($(html).find("option[value='" + data[i].subenlace_id + "-"+data[i].id+"']")[0]).val(data[i].subenlace_id) 
			stringsubenlace = $(html).prop "outerHTML"

			if data[i].enlace_id?
				$($(html2).find("option[value='" + data[i].enlace_id + "']")[0]).removeAttr "selected"
			$($(html2).find("option[value='" + data[i].enlace_id + "-"+data[i].id+"']")[0]).val(data[i].enlace_id) 
			stringenlace = $(html2).prop "outerHTML"

			if data[i].coordinador_id?
				$($(html3).find("option[value='" + data[i].coordinador_id + "']")[0]).removeAttr "selected"
			$($(html3).find("option[value='" + data[i].coordinador_id + "-"+data[i].id+"']")[0]).val(data[i].coordinador_id) 
			stringcoordinador = $(html3).prop "outerHTML"
	
	fill_table_nominal_list = (table_id, data) ->
		count = data.total
		$('#total_result').html(count)
		data = data.data
		$("tr:has(td)").remove();
		$.each data, (i, item) ->
			#remove rows
			if data[i].temp_chek
				checkitem = '<input type="checkbox" name="temp_chek" class="check" '+
				'data-id="'+data[i].id+'" checked> Ya votó'
			else
				checkitem = '<input type="checkbox" name="temp_chek" class="check" '+
				'data-id="'+data[i].id+'" > Ya votó'

			tds = '<td><p class="small"> <a href="/users/'+data[i].id+'"> ' + data[i].name + " </a> </p></td> " +
			'<td><p class="small"> <a href="/users/'+data[i].id+'"> ' + data[i].first_name + " </a> </p></td> " +
			'<td><p class="small"> <a href="/users/'+data[i].id+'"> ' + data[i].last_name + " </a> </p></td> " +
			'<td><p class="small"> ' + data[i].age + " </p></td> " +
			'<td><p class="small"> ' + parseInt(data[i].section)+ " </p></td> " +
			'<td><p class="small"> ' + data[i].city + " </p></td> " +
			'<td><p class="small"> ' + data[i].subenlace  + " </p></td> " +
			'<td><p class="small"> ' + data[i].enlace + " </p></td> " +
			'<td><p class="small"> ' + data[i].coordinador + " </p></td> " +
			'<td><p class="small"> ' + data[i].group + " </p></td> " +
			'<td><p class="small"> ' + data[i].role + " </p></td> "

			cleared_tds = ((tds.replace 'null', '').replace 'null', '').replace 'NaN', ''
			#console.log cleared_tds
			$('<tr>').html(cleared_tds).appendTo table_id

	load_parents(getURLParameter('role'))
	if $('#show_user_id').val() != undefined
		load_user_in_map($('#show_user_id').val())

	$('.datepicker').datepicker(
			format: 'dd/mm/yyyy'
		).on 'changeDate', ->
		filters = get_lista_nominal_filters()
		$.ajax 
			url:"/api/users"
			data: filters.data
			success: (data) ->
				console.log data
				fill_table_nominal_list('#users_table',data)
				$('html, body').animate(
					scrollTop : 0
				,800)
	$(".select_search").change ->
	  $inputs = undefined
	  data = undefined
	  params = undefined
	  $inputs = undefined
	  data = undefined
	  params = undefined
	  $inputs = $(".search")
	  params = {}
	  data = {}
	  $inputs.each ->
	    params[@name] = $(this).val()  if $(this).val() isnt ""
	    return

	  if params
	    data =
	      role: getURLParameter('role')
	      register_date: params['register_date']
	      municipality_id: params["municipality_id"]
	      ife_key: params["ife_key"]
	      bird: params["bird"]
	      age: params["age"]
	      section: params["section"]
	      dto_fed: params["dto_fed"]
	      dto_loc: params["dto_loc"]
	      city: params["city"]
	      street_number: params["street_number"]
	      outside_number: params["outside_number"]
	      internal_number: params["internal_number"]
	      neighborhood: params["neighborhood"]
	      zipcode: params["zipcode"]
	      phone: params["phone"]
	      parent: params["parent"]
	      email: params["email"]
	      cellphone: params["cellphone"]
	      gender: params["gender"]
	      rnm: params["rnm"]
	      name: params["name"]
	      first_name: params["first_name"]
	      last_name: params["last_name"]
	      parent: params["parent"]
	      register_start: params["register_start_date"]
	      register_end: params["register_end_date"]
	      bird_start: params["bird_start_date"]
	      bird_end: params["bird_end_date"]
	    		coordinador_id: params['coordinador_id']
	    		subenlace_id: params['sub_enlace_id']
	    		enlace_id: params['enlace_id']
	    console.log data
	    $.ajax
	      url: "/api/users"
	      data: data
	      success: (data) ->
	        console.log data
	        fill_table "#users_table", data
	        $("html, body").animate
	          scrollTop: 0
	        , 800
	        return

	  return

	$(document).on "change", ".check", ->
		user_id = $(this).data('id')
		mje = (if @checked then " ha votado" else " ha cancelado su voto")
		$.ajax 
			type: "PUT"
			url:"/api/users/"+user_id
			data: 
				user:
					temp_chek: @checked
			success: (data) ->
			error: (xhr, ajaxOptions, thrownError) ->
				alert 'no se ha podido registrar el voto'

	$(document).on "change", ".check2", ->
		user_id = $(this).data('id')
		mje = (if @checked then " ha votado" else " ha cancelado su voto")
		$.ajax 
			type: "GET"
			url:"/api/users/list_check"
			data: 
				user:
					temp_chek: @checked
					votation_list_id: user_id
			success: (data) ->
			error: (xhr, ajaxOptions, thrownError) ->
				alert 'no se ha podido registrar el voto '

	$("#btn-enviar").click ->
		municipio = $('#head_municipality').find(":selected").val()
		polling = $('#select_polling').find(":selected").val()
		register_start_date = $('#register_start_date').val()
		register_end_date = $('#register_end_date').val()
		bird_start_date = $('#bird_start_date').val()
		bird_end_date = $('#bird_end_date').val()
		
		if municipio == "-1"
			alert "Selecciona un municipio."
		else if polling == "-1"
			alert "Selecciona un polling."
		else if register_start_date == ""
			alert "Selecciona una fecha de registro inicial."
		else if register_end_date == ""
			alert "Selecciona una fecha de registro final."
		else if bird_start_date == ""
			alert "Selecciona una fecha de nacimiento inicial."
		else if bird_end_date == ""
			alert "Selecciona una fecha de nacimiento final."
		else
			$.ajax 
				type: "GET"
				url:"/api/users/list_votation"
				data: 
					prueba:
						municipio: municipio
						polling: polling
						register_start_date: register_start_date
						register_end_date: register_end_date
						bird_start_date: bird_start_date
						bird_end_date: bird_end_date
				success: (data) ->
					location.reload()
				error: (xhr, ajaxOptions, thrownError) ->
					alert 'No se ha podido registrar la nueva votación ' + thrownError
		return false
return