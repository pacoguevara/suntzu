# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	$container4=$('#container4')
	$container5=$('#container5')
	$container6=$('#container6')
	$container7=$('#container7')

	VotationPanel = (->
		options_groups = 
			chart:
				renderTo: 'container7'
				defaultSeriesType: 'spline'
			series: []
			title:
		    text: "Votaciones por Coordinadores"
		    x: -20 #center

		  subtitle:
		    text: "Selecciona un grupo"
		    x: -20
		  xAxis:
		    categories: [
		      "8 hrs"
		      "9 hrs"
		      "10 hrs"
		      "11 hrs"
		      "12 hrs"
		      "13 hrs"
		      "14 hrs"
		      "15 hrs"
		      "16 hrs"
		      "17 hrs"
		      "18 hrs"
		      "19 hrs"
		    ]

		  yAxis:
		    title:
		      text: "Temperature (°C)"

		    plotLines: [
		      value: 0
		      width: 1
		      color: "#808080"
		    ]

		  tooltip:
		    valueSuffix: "Votos"

		options_pollings = 
			chart:
				renderTo: 'container6'
				defaultSeriesType: 'spline'
			series: []
			xAxis:
		    categories: [
		      "8 hrs"
		      "9 hrs"
		      "10 hrs"
		      "11 hrs"
		      "12 hrs"
		      "13 hrs"
		      "14 hrs"
		      "15 hrs"
		      "16 hrs"
		      "17 hrs"
		      "18 hrs"
		      "19 hrs"
		    ]

		  yAxis:
		    title:
		      text: "Temperature (°C)"

		    plotLines: [
		      value: 0
		      width: 1
		      color: "#808080"
		    ]
		  title:
		    text: "Votaciones por Grupos"
		    x: -20 #center

		  subtitle:
		    text: "Selecciona una votación"
		    x: -20
		  tooltip:
		    valueSuffix: "Votos"

		  legend:
		    layout: "vertical"
		    align: "right"
		    verticalAlign: "middle"
		    borderWidth: 0
		init = ->
			bind()
			return
		bind = ->
			$('#votation_groups').change ->
				selectGroups(@)
				return
			$('#votation_pollings').change ->
				selectPollings(@)
				return
			return
		selectGroups = (el)->
			if $('#votation_pollings').val() is '0'
				alert 'Seleccione una Lista Nominal'
			pollings_url = 'api/pollings/'+$('#votation_pollings').val()
			groups_url = pollings_url+'/groups/'+$(el).val()
			
			$.ajax
				url: groups_url
				success: (data) ->
					options_groups.series = data
					chart = new Highcharts.Chart(options_groups)
			return
		selectPollings = (el) ->
			pollings_url = '/api/pollings'+'/'+$(el).val()

			$.ajax
				url: pollings_url+'/groups'
				success: (data)->
					console.log data
					options_pollings.series = data
					chart = new Highcharts.Chart(options_pollings)
			return
		init:init
		)()
	VotationPanel.init()

	if $container5?
		$.ajax
	    url: "/api/users/municipality"
	    dataType: "json"
	    success: (json) ->
	    	
	    	console.log json
	    	tabla = "<table class='table table-bordered table-striped table-hover'>"+
	    		"<tr><th>Municipio</th><th>Numero de jugadores</th></tr>"
	    	$.each json, (i, item) ->
	    		tabla = tabla + "<tr><td>" + i+"</td><td>"+item+"</td>"
	    	tabla = tabla + "</table>"
	    	$container5.append tabla
	    error: (xhr, ajaxOptions, thrownError) ->
	      console.log xhr.status + " " + url_root
	      console.log thrownError
	      return
	if $container4?
		$.get('/api/users/groups').success (data) ->
			$container4.highcharts 
				chart:
					type: "pie"
			  plotBackgroundColor:null
			  plotBorderWidth: null
			  plotShadow: false
			 title:
			  text: "Jugadores por grupo"
			 plotOptions:
			  pie:
			   allowPointSelect: true
			   cursor: 'pointer'
			   dataLabels:
			   	enabled: false
			   showInLegend: true
			 series: [
			  {
			   name: "Pie"
			   data: data
			  }
			 ]		
		return