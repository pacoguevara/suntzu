<div class="stepContainer">
	<div class="row">
		<div class="col-md-9">
			<h2>Presione el botón "Network" en sus dispositivos.</h2>
			<hr />
			<p class="importantInfo">De esta manera estaremos agregando todos los elementos a la red. En la parte inferior, se estarán desplegando conforme los vaya agregando.</p>
			<p class="importantInfo">Cuando estén listos, presione <b>"Continuar"</b>.</p>
		</div>
		<div class="col-md-3">
			<img src="<?php echo base_url('assets/img/icons/add.png');?>" class="img-responsive"/>
		</div>
	</div>
	
	<hr />
	
	<table class="table table-striped table-hover table-bordered" id="tableDevice">
		<tr>
			<th>Número de Serie</th>
			<th class="center">Estatus</th>
			<th class="center">Tipo</th>
			<th class="center">Nombrar</th>
		</tr>
	</table>
	
	<a  id="next" class="btn btn-orange btn-lg pull-right"><b>Continuar</b> <span class="glyphicon glyphicon-chevron-right"></span></a>
	
</div>
<script type="text/javascript">
	initialCommandN = 0;
	flag = 0;
	flag2 = 0;
	countDevices = 0;
	countDevices2 = 0;
	nombres = [];
	flagName = 0;
	setInterval(function(){
		timestamp = new Date().getTime();;
		$.getJSON( "<?php echo base_url('assets/bash/serialF.json');?>?timestamp="+timestamp, function( data ) {
			allCommands = data.content.split("##");
			initialCommandN = allCommands.length;
			if(flag == 0){
				currentN = initialCommandN -1;
				flag = 1;
			}
			//console.log(currentN+' '+initialCommandN);
				if(currentN < initialCommandN){
					currentN++;
					
					var currentDevice = allCommands[initialCommandN - 2];
					currentDevice = currentDevice.match(/(\d{3,})/)[0];
					console.log(allCommands);
					if(currentDevice == '702495400'){
						countDevices= countDevices+2;
						currentDevice = '702495402';
						$('#tableDevice').append('<tr> \
								<td>702495401</td> \
								<td class="center">Detectado <span class="glyphicon glyphicon-ok-sign"></span></td> \
								<td><select class="form-control type"> \
									<option value="" selected>Seleccione el Tipo</option> \
									<?php foreach($device_types as $t):?>
										<option value="<?php echo $t->id;?>"><?php echo $t->description;?></option> \
									<?php endforeach;?>
								</select></td> \
								<td class="center"><input type="text" id="702495401" placeholder="Ingresar Nombre" class="deviceName"> <span class="glyphicon glyphicon-ok ok" serial="702495401"></span></td> \
							</tr>');
							$('#tableDevice').append('<tr> \
									<td>702495402</td> \
									<td class="center">Detectado <span class="glyphicon glyphicon-ok-sign"></span></td> \
									<td><select class="form-control type"> \
										<option value="0" selected>Seleccione el Tipo</option> \
										<?php foreach($device_types as $t):?>
											<option value="<?php echo $t->id;?>"><?php echo $t->description;?></option> \
										<?php endforeach;?>
									</select></td> \
									<td class="center"><input type="text" id="702495402" placeholder="Ingresar Nombre" class="deviceName"> <span class="glyphicon glyphicon-ok ok" serial="702495402"></span></td> \
							</tr>');
					}
					if(flag2 == 0){
						flag2 = 1;
					}else{
						countDevices++;
						$('#tableDevice').append('<tr> \
								<td>'+currentDevice+'</td> \
								<td class="center">Detectado <span class="glyphicon glyphicon-ok-sign"></span></td> \
								<td><select class="form-control type"> \
									<option value="0" selected>Seleccione el Tipo</option> \
									<?php foreach($device_types as $t):?>
										<option value="<?php echo $t->id;?>"><?php echo $t->description;?></option> \
									<?php endforeach;?>
								</select></td> \
								<td class="center"><input type="text" id="'+currentDevice+'" placeholder="Ingresar Nombre" class="deviceName"> <span class="glyphicon glyphicon-ok ok" serial="'+currentDevice+'"></span></td> \
							</tr>');
					}
				}
		});
	}, 2000);
	
	$(function(){
			$.post('<?php echo base_url('index.php/device/nameDevice');?>')
			.done(function(data){
				data = JSON.parse(data);
				for (var i = data.length - 1; i >= 0; i--) {
					nombres.push(data[i].name);
				};
			});
			$(document).on('click', '.ok', function(){
				flagName = 0;
				var serial = $(this).attr('serial').trim();
				var name = $(this).prev('.deviceName').val();
				var type = $(this).closest('td').prev('td').children('select').val();
				
				for (var i = nombres.length - 1; i >= 0; i--) {
					if (name == nombres[i]) {
						console.log(nombres[i]);
						flagName++;
					}
				};
				if (serial=="" || serial==null) {
					alert("Favor de agregar de nuevo este dispositivo");
				}else if (name=="") {
					alert("Ingresar un nombre");
				}else if(flagName>0){
					alert("Ya existe un dispositivo con este nombre");
				}else if (type==0) {
					alert("Selecciona una opcion de la lista de tipo");
				}else{
					countDevices2++;
					nombres.push(name);
					$(this).prev('.deviceName').prop('disabled', true);
					$(this).hide('slow');
					$.post('<?php echo base_url('index.php/setup/insertDevice');?>', {serial: serial, name: name, type:type});
				}
				
			});
			$(document).on('click','#next',function(){			
				if (countDevices2 != countDevices) {
					alert("Faltan "+parseInt(countDevices-countDevices2)+" dispositivos por agregar");
				}else{
					location.href=location.hostname+'<?php echo base_url('index.php/setup/done');?>';
				}
			});
	});
</script>