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
		# if role is 'coordinador'
		# 	show_groups()
		# else
		# 	hide_groups()
		load_parents(role)
		
	$('.search3').keypress (e) ->
		key = e.which
		if key is 13
			filters = get_filters2()
			$.ajax 
				url:"/api/users/get_list_votation"
				data:
					filters.data
				success: (data) ->
					console.log data
					console.log "pudo entrar"
					fill_table2("#detalle_table", data)
	$(document).on "change", ".municipality", ->	
		filters = get_filters()
		console.log filters
		$.ajax 
				url:"/api/users"
				data:
					filters.data
				success: (data) ->
					console.log "pos si"
					fill_table_nominal_list('#users_table', data)				
	$('.search2').keypress (e) ->
		key = e.which
		if key is 13
			filters = get_filters()
			$.ajax 
					url:"/api/users"
					data:
						filters.data
					success: (data) ->
						fill_table_nominal_list('#users_table', data)
					error: (xhr, ajaxOptions, thrownError) ->
				      alert xhr.status + " " + url_root
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
				

	get_filters = ->
		$inputs = $('.search2')
		params = {}
		data = {}
		$inputs.each ->
			unless $(this).val() is ''
				params[this.name] = $(this).val()
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
	      alert xhr.status + " " + url_root
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
					console.log json
					if tipo == 1
						row = $($(esto).parent().parent().parent().find('.enlace')[0]).remove()
						select = '<p class="small"><select class="select_class enlace"  style="width:100%" data-catid="2"><option value="vacio"></option><option value="'+json["user_id"]+'" selected>'+json["name"]+'</option></select></p>'
						$(esto).parent().parent().parent().find('#td-enlace').append select
						if json["user_id2"] isnt "0"
							row = $($(esto).parent().parent().parent().find('.coordinador')[0]).remove()
							select = '<p class="small"><select class="select_class coordinador"  style="width:100%" data-catid="3"><option value="vacio"></option><option value="'+json["user_id2"]+'" selected>'+json["name2"]+'</option></select></p>'
							$(esto).parent().parent().parent().find('#td-coordinador').append select
							
					if tipo == 2
						row = $($(esto).parent().parent().parent().find('.coordinador')[0]).remove()
						select = '<p class="small"><select class="select_class enlace"  style="width:100%" data-catid="2"><option value="vacio"></option><option value="'+json["user_id"]+'" selected>'+json["name"]+'</option></select></p>'
						$(esto).parent().parent().parent().find('#td-coordinador').append select
					
						

					option = $(esto).find("option[value='" + json["user_id"] + "']")[0] 
					$(option).attr "selected", "selected"
					
					console.log "si se pudo?"
			error: (xhr, ajaxOptions, thrownError) ->
				alert xhr.status + " " + url_root
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
		console.log data
		console.log table_id
		$("tr:has(td)").remove();
		$.each data, (i, item) ->
			if data[i].check == true
				checkaux = '<input type="checkbox" name="temp_chek" class="check2" data-id="'+data[i].id+'" checked>Ya votó'
			else
				checkaux = '<input type="checkbox" name="temp_chek" class="check2" data-id="'+data[i].id+'">Ya votó'
			tds = '<td><p class="small"> ' + data[i].number + " </p></td> " +
			'<td><p class="small"> ' + data[i].name + " </p></td> " +
			'<td><p class="small"> ' + checkaux + " </p></td> " +
			console.log "ejey"
			console.log tds
			cleared_tds = ((tds.replace 'null', '').replace 'null', '').replace 'NaN', ''
			$('<tr>').html(cleared_tds).appendTo '#detalle_table'

	fill_table = (table_id, data) ->
		count = data.total
		subenlaces = data.subenlaces
		enlaces = data.enlaces
		coordinadores = data.coordinadores
		$('#total_result').html(count)
		
		#console.log data
		stringsubenlace = '<select class="default select_class" style="width:100%">'+
			'<option value="0" ></option>'
		stringenlace = '<select class="default select_class" style="width:100%">'+
			'<option value="0" ></option>'
		stringcoordinador = '<select class="default select_class" '+
			'style="width:100%"><option value="0" ></option>'
		i = 0

		while i < subenlaces.length
				full_name=subenlaces[i].name+" "+subenlaces[i].first_name+
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
			if data[i].subenlace_id?
				option = $(html).find("option[value='" + data[i].subenlace_id + "']")[0] 
				$(option).attr "selected", "selected"
			if data[i].enlace_id?
				option = $(html2).find("option[value='" + data[i].enlace_id + "']")[0]
				$(option).attr "selected", "selected"
			if data[i].coordinador_id?
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
			tds = '<td><p class="small"> ' + data[i].name + " </p></td> " +
			'<td><p class="small"> ' + data[i].first_name + " </p></td> " +
			'<td><p class="small"> ' + data[i].last_name + " </p></td> " +
			'<td><p class="small"> ' + data[i].gender + " </p></td> " +
			'<td><p class="small"> ' + data[i].age + " </p></td> " +
			'<td><p class="small"> ' + parseInt(data[i].section)+ " </p></td> " +
			'<td><p class="small"> ' + data[i].city + " </p></td> " +
			'<td><p class="small"> ' + data[i].neighborhood + " </p></td> " +
			'<td><p class="small"> ' + stringsubenlace + "</p></td> " +
			'<td><p class="small"> ' + stringenlace + "</p></td> " +
			'<td><p class="small"> ' + stringcoordinador + "</p></td> " +
			'<td ><a href="/users/'+data[i].id+'?role='+data[i].role+'">'+
				'<span class="glyphicon glyphicon-eye-open"></span></a></td>'+
			'<td ><a class="table-action" '+
				'data-confirm="¿Está seguro que desea eliminar?" data-method="delete"'+
				' href="/users/'+data[i].id+'" rel="nofollow">'+
			'<span class="glyphicon glyphicon-remove"></span></a></td>'

			cleared_tds = ((tds.replace 'null', '').replace 'null', '').replace 'NaN', ''
			#console.log cleared_tds
			$('<tr>').html(cleared_tds).appendTo table_id
			if data[i].subenlace_id?
				$($(html).find("option[value='" + data[i].subenlace_id + "-"+data[i].id+"']")[0]).removeAttr "selected"
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

	fill_table_nominal_list2 = (table_id, data) ->
		alert "ey"
	
	fill_table_nominal_list = (table_id, data) ->
		count = data.total
		$('#total_result').html(count)
		data = data.data
		console.log data
		$("tr:has(td)").remove();
		$.each data, (i, item) ->
			#remove rows
			if data[i].temp_chek
				checkitem = '<input type="checkbox" name="temp_chek" class="check" '+
				'data-id="'+data[i].id+'" checked> Ya votó'
			else
				checkitem = '<input type="checkbox" name="temp_chek" class="check" '+
				'data-id="'+data[i].id+'" > Ya votó'

			tds = '<td><p class="small"> ' + data[i].name + " </p></td> " +
			'<td><p class="small"> ' + data[i].first_name + " </p></td> " +
			'<td><p class="small"> ' + data[i].last_name + " </p></td> " +
			'<td><p class="small"> ' + data[i].age + " </p></td> " +
			'<td><p class="small"> ' + parseInt(data[i].section)+ " </p></td> " +
			'<td><p class="small"> ' + data[i].city + " </p></td> " +
			'<td><p class="small"> ' + data[i].parent + " </p></td> " +
			'<td><p class="small"> ' + data[i].parent + " </p></td> "+
			'<td><p class="small"> ' + data[i].parent + " </p></td> "+
			'<td><p class="small"> ' + data[i].parent + " </p></td> "+
			'<td><p class="small"> ' + checkitem + " </p></td> "

			cleared_tds = ((tds.replace 'null', '').replace 'null', '').replace 'NaN', ''
			#console.log cleared_tds
			$('<tr>').html(cleared_tds).appendTo table_id

	load_parents(getURLParameter('role'))
	if $('#show_user_id').val() != undefined
		load_user_in_map($('#show_user_id').val())

	$('.datepicker').datepicker(
			format: 'dd/mm/yyyy'
		).on 'changeDate', ->
		filters = get_filters()
		$.ajax 
			url:"/api/users"
			data: filters.data
			success: (data) ->
				console.log data
				fill_table_nominal_list('#users_table',data)
				$('html, body').animate(
					scrollTop : 0
				,800)
	$('#select_municipality').change ->
		filters = get_filters()
		console.log filters
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
				alert 'no se ha podido registrar el votoSDD '+thrownError

	$(document).on "click", ".btn-enviar", ->
		municipio = $('#select_municipality').find(":selected").val()
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
					alert 'no se ha podido registrar el votoSDD '+thrownError

return