<h3>Unirse a una red</h3>

<hr />

<div class="col-md-9">
	<h4>Dispositivos agregados:</h4>
	<br />
	<table class="table table-striped table-hover table-bordered" id="tableDevice">
		<tr>
			<th>Número de Serie</th>
			<th class="center">Estatus</th>
			<th class="center">Tipo</th>
			<th class="center">Nombrar</th>
		</tr>
	</table>
	
</div>
<div class="col-md-3">
	<a class="btn btn-block btn-default" id="scanNet"><span class="glyphicon glyphicon-screenshot"></span> Escanear red</a>
	<a class="btn btn-block btn-orange"><span class="glyphicon glyphicon-import"></span> Unirse a esta red</a>
	<hr />
	<img src="<?php echo base_url('assets/img/icons/joinnet.png');?>" class="img-responsive"/>
	<br />
	<p class="justify"><b>Nota: </b>Información detallada y capacidad de operación de los componentes de la red, estarán disponibles hasta que se una a esta red.</p>
</div>

<script type="text/javascript">
	$(function(){
		$('#scanNet').click(function(){
			$.post('<?php echo base_url('index.php/setup/scan');?>');
			var initialCommandN = 0;
			var initialDevices= 0;
			flag = 0;
			flag2 = 0;
			response ="";
			flagResponse = 0;
			var refreshIntervalId = setInterval(function(){
				timestamp = new Date().getTime();
				$.getJSON( "<?php echo base_url('assets/bash/serialF.json');?>?timestamp="+timestamp, function( data ) {
					allCommands = data.content.split("##");
					initialCommandN = allCommands.length;
					if(flag == 0){
						initialDevices = allCommands.filter(function(item){return /(\d{3,})/.test(item);}).length;
						currentN = initialCommandN;
						flag = 1;
					}
					currentDevices = allCommands.filter(function(item){return /(\d{3,})/.test(item);});
					currentDevicesN = currentDevices.length;
					
					if(currentDevicesN > initialDevices){
						newDevices = (currentDevicesN - initialDevices);
						for(i = 0; i<newDevices; i++){
							console.log(currentDevices[initialDevices+i].match(/(\d{3,})/)[0]);
						}
						clearInterval(refreshIntervalId);
					}
					
					console.log(currentN+' '+initialCommandN);
					if(currentN < initialCommandN){
						currentN++;
						var currentDevice = allCommands[initialCommandN - 3];
						
						if(currentDevice.indexOf("67") != -1){
							response = currentDevice.substring(9, 10);	
						}
						if (flagResponse == 0) {
							for (var i = 0; i <= response; i++) {
								$.post('<?php echo base_url('index.php/commands/executeGottenCommandPost');?>', {command: '*#13**66*'+i+'##'});
							};
							flagResponse = 1;
						}
						//$('#tableDevice').append('<tr><td>'+currentDevice+'</td><td class="center">Agregado <span class="glyphicon glyphicon-ok-sign"></span></td></tr>');
					}
				});
			}, 1500);
		});
	});
</script>