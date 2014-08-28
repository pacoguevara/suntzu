# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	
	load_parents = (role)->
		console.log 'from function'
		$.get "/api/users/parents?role="+role, (data) ->
			$("#parent-select").empty()
			data.forEach (entry) ->
				option = "<option value=\"" + entry.id + "\">" + entry.name + " " + entry.last_name + "</option>"
				$("#parent-select").append option
	show_groups = ->
		$('#group').hide()
		$('#group').show()
	hide_groups = ->
		$('#group').hide()
	$(document).on "change", "#role-select", ->
	  window.location = "/users?role=" + $("option:selected", this).val()
	  return
	$('#group').hide()
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
			tds = "<td>" + data[i].rnm + "</td>" +
			"<td>" + data[i].name + "</td>" +
			"<td>" + data[i].first_name + "</td>" +
			"<td>" + data[i].last_name + "</td>" +
			"<td>" + data[i].cellphone+ "</td>"+
			'<td colspan="2">'+ data[i].email + "</td>"+
			"<td>" + data[i].age + "</td>"+
			"<td>" + data[i].gender + "</td>"+
			"<td>" + data[i].role + "</td>"+
			"<td>" + data[i].parent + "</td>"+
			"<td>" + data[i].section + "</td>"+
			'<td ><a href="/users/'+data[i].id+'"><span class="glyphicon glyphicon-eye-open"></span></a></td>'+
			'<td ><a class="table-action" data-confirm="¿Está seguro que desea eliminar?" data-method="delete" href="/users/'+data[i].id+'" rel="nofollow">'+
			'<span class="glyphicon glyphicon-remove"></span></a></td>'
			console.log $('<tr>').html(tds)
			$('<tr>').html(tds).appendTo table_id
	load_parents(getURLParameter('role'))
	$("#table-responsive").doubleScroll()
