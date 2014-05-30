# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	line_cfg = 
		chart:
	  type: "line"
	 title:
	  text: "Grupo 1 vs Grupo 2"
	 xAxis:
	  categories: [
	   "Jan"
	   "Feb"
	   "Mar"
	   "Apr"
	   "May"
	   "Jun"
	   "Jul"
	   "Aug"
	   "Sep"
	   "Oct"
	   "Nov"
	   "Dec"
	   ]
	 yAxis:
	  title:
	   text: "Temperature (°C)"
	 plotOptions:
	  line:
	   dataLabels:
	    enabled: true
	   enableMouseTracking: false
	 series: [
	  {
	   name: "Tokyo"
	   data: [
	    7.0
	    6.9
	    9.5
	    14.5
	    18.4
	  		21.5
	    25.2
	    26.5
	    23.3
	    18.3
	    13.9
	    9.6
	   ]
	  }
	  {
	   name: "London"
	   data: [
	    3.9
	    4.2
		   5.7
	    8.5
	    11.9
	    15.2
	    17.0
	    16.6
	    14.2
	    10.3
	    6.6
	    4.8
	    ]
	   }
	 ]
 bar_cfg = 
		chart:
	  type: "column"
	 title:
	  text: "Adquisición de Nuevos Militantes por Grupo"
	 xAxis:
	  categories: [
	   "Jan"
	   "Feb"
	   "Mar"
	   "Apr"
	   "May"
	   "Jun"
	   "Jul"
	   "Aug"
	   "Sep"
	   "Oct"
	   "Nov"
	   "Dec"
	   ]
	 yAxis:
	  title:
	   text: "Temperature (°C)"
	 plotOptions:
	  column:
	   pointPadding: 0.2
	   borderWidth: 0
	 series: [
	  {
	   name: "Vicente Fox"
	   data: [
	    49.9
	    71.5
	    106.4
	    129.2
	    144.0
	    176.0
	    135.6
	    148.5
	    216.4
	    194.1
	    95.6
	    54.4
	   ]
	  }
	  {
	   name: "Felipe Calderon"
	   data: [
	    83.6, 78.8, 98.5, 93.4, 106.0, 84.5, 105.0, 104.3, 91.2, 83.5, 106.6, 92.3
	   ]
	   }
	 ]

	pie_cfg = 
		chart:
			type: "pie"
	  plotBackgroundColor:null
	  plotBorderWidth: null
	  plotShadow: false
	 title:
	  text: "Participacion de Candidados (Militantes)"
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
	   data: [
	    ['Felipe Calderón',   55.0]
     ['Vicente Fox',       45.0]
	   ]
	  }
	 ]

	typed_cfg = 
		chart:
			renderTo: 'container'
			type: "column"
			margin: 75
	  options3d:
	  	enabled:true
	  	alpha:15
	  	beta:15
	  	depth:50
	  	viewDistance:25
	 title:
	  text: "Militantes por Grupo"
	 plotOptions:
	  column:
	  	depth:25
	 series: [
	 	{
	 		name: 'Felipe Calderon'
	   data: [29.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4]
	  }
	  {
	 		name: 'Vicente Fox'
	   data: [39.9, 81.5, 206.4, 159.2, 244.0, 136.0, 13.6, 80.5, 216.4, 124.1, 65.6, 154.4]
	  }
	 ]

	$container1=$('#container1')
	$container2=$('#container2')
	$container3=$('#container3')
	$container4=$('#container4')

	$container1.highcharts typed_cfg
	$container2.highcharts line_cfg
	$container3.highcharts bar_cfg
	$container4.highcharts pie_cfg

	handler = Gmaps.build('Google')
	handler.buildMap
  provider: {}
  zoom: 8
  internal:
    id: "map"
  ->
  	markers = handler.addMarkers([
  		{
	  		lat: 25.723
	  		lng: -100.312
	  		picture:
	    	width: 36
	    	height: 36
	  		infowindow: "hello!"
  		}
  		{
	  		lat: 25.670
	  		lng: -100.289
	  		picture:
	    	width: 36
	    	height: 36
	  		infowindow: "hello!"
  		}
  		{
	  		lat: 25.37
	  		lng: -100.06
	  		picture:
	    	width: 36
	    	height: 36
	  		infowindow: "hello!"
  		}
  		{
	  		lat: 25.582
	  		lng: -100.423
	  		picture:
	    	width: 36
	    	height: 36
	  		infowindow: "hello!"
  		}
			])
			handler.bounds.extendWith markers
			handler.fitMapToBounds()
			handler.getMap().setZoom(7)
