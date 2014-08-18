<div class="row">
<div class="col-md-8">
	<h1>Escenarios</h1>
	<p class="importantInfo">Aquí podrá crear escenarios para su hogar de una manera muy sencilla. Solo siga estos pasos:
		<ul>
			<li>De click en <b>Agregar Escenario</b> y nómbrelo</li>
			<li>De la lista de dispositivos, arrastre los necesarios a su nuevo escenario</li>
			<li>Siga las instrucciones que se le proporcionarán para guardar el comportamiento de su dispositivo</li>
		</ul>
	</p>
</div>
<div class="col-md-4">
	<img src="<?php echo base_url('assets/img/icons/createscene.png');?>" class="img-responsive"/>
</div>
</div>
<hr />

<div class="row">
	
	<div class="col-md-8" id="floorsContainer">
		<a href="#addFloorModal" data-toggle="modal" data-target="#addFloorModal" class="btn btn-orange">Agregar Planta</a>
		<br /><br />
		<?php foreach($floors as $f):?>
		<div class="floor">
			<a href="#addSceneModal" data-toggle="modal" data-target="#addSceneModal" class="btn btn-default pull-right addSceneG" id="<?php echo $f->id;?>">
				Agregar Escenario <span class="glyphicon glyphicon-plus-sign"></span>
			</a>
			<h2><?php echo $f->name;?></h2>
			<div class="sceneDeviceContainer" id="<?php echo $f->id;?>"></div>
		</div>
		<?php endforeach;?>
	</div>
	
	
	<div class="col-md-4">
	
		<div class="well">
			<h3>Dispositivos</h3>
			<hr />
			<?php foreach($devices as $d):?>
				<div class="col-md-6">
				<div class="draggableDevice" description="<?php echo $d->name;?>" id="<?php echo $d->id;?>" serial="<?php echo $d->serial;?>">
					<span class="glyphicon glyphicon-flash"></span> <?php echo $d->name;?>
				</div>
				</div>
			<?php endforeach;?>
			<br class="clear" />
		</div>
		
		<div class="well">
			<h3>Horarios</h3>
			<hr />
			<?php foreach($schedules as $s):?>
				<div class="scheduleContainer" id="<?php echo $s->id;?>" description="<?php echo $s->description;?>">
					<h4><?php echo $s->description;?></h4>
					<div class="hours">
						<div class="col-md-6 hour"><span class="glyphicon glyphicon-time"></span> <?php echo $s->start;?></div>
						<div class="col-md-6 hour"><span class="glyphicon glyphicon-time"></span> <?php echo $s->end;?></div>
					</div>
				</div>
			<?php endforeach;?>
			<br class="clear" />
		</div>
		
	</div>
	
</div>


<!-- Modal -->
<div class="modal fade" id="addSceneModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Agregar Escenario</h4>
      </div>
      <div class="modal-body">
      	Nombre: <input type="text" class="form-control" placeholder="Ej.: Comedor" id="sceneName"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
        <button type="button" class="btn btn-primary" data-dismiss="modal" id="saveScene">Guardar</button>
      </div>
    </div>
  </div>
</div>

<!-- Modal -->
<div class="modal fade" id="addFloorModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Agregar Planta</h4>
      </div>
      <div class="modal-body">
      	Nombre: <input type="text" class="form-control" placeholder="Ej.: Segundo Piso" id="floorName"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
        <button type="button" class="btn btn-primary" data-dismiss="modal" id="saveFloor">Guardar</button>
      </div>
    </div>
  </div>
</div>

<!-- Modal -->
<div class="modal fade" id="learnModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Atención!</h4>
      </div>
      <div class="modal-body">
      	Por favor siga los siguientes pasos:
      	<ol>
      		<li>Localice el dispositivo que desea agregar</li>
      		<li>Colóquelo en una posición que le permita <i>regresar</i> a la deseada (Si lo quiere agregar encendido, apáguelo)</li>
      		<li>Presione el botón <b>"Learn"</b> de su dispositivo</li>
      		<li>Realice la acción en el dispositivo que quiera grabar</li>
      		<li>Presione el botón Guardar de esta ventana</li>
      	</ol>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
        <button type="button" class="btn btn-primary" data-dismiss="modal" id="saveFloor">Guardar</button>
      </div>
    </div>
  </div>
</div>


<div class="modal fade" id="newSwitch">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">Configurar Apagador</h4>
      </div>
      <div class="modal-body">
        <p>Por favor indique el estado del apagador al activarse esta escena: </p>
        <input type="checkbox" id="switchCheck" />
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" id="saveSwitchDevice" data-dismiss="modal">Guardar</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div class="modal fade" id="newDimmer">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">Configurar Apagador</h4>
      </div>
      <div class="modal-body">
        <p>Por favor indique el nivel de intensidad del dimmer para esta escena: </p>
        <div class='slider' id="dimSlider"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" id="saveDimmerDevice" data-dismiss="modal">Guardar</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->



<script type="text/javascript" src="<?php echo base_url('assets/js/jquery-ui.js');?>"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script type="text/javascript">
	$(function(){
		$("#switchCheck, #dimmerCheck").bootstrapSwitch();
		$(".slider").slider({min: 0,max: 10,range: "min"});
		
		var floorCounter = 1;
		currentScene = -1;
		var selectedFloor = 0;
		$(".draggableDevice, .scheduleContainer").draggable({ revert: "invalid" });
		
		$('#saveScene').click(function(){
			selector = '#'+currentScene+'.sceneDeviceContainer';
			sceneName = $('#sceneName').val();
			$.post("<?php echo base_url('index.php/scene/saveScene');?>", {floor: selectedFloor, name: sceneName}).done(function(response){
				insertedScene = response;
				$(selector).append('<div class="col-md-6"><div class="scene" id="'+insertedScene+'"><h4 class="center">'+sceneName+'</h4><ul></ul></div></div>');
				$(".scene").droppable({drop: function(event, ui){
						if($(ui.draggable).attr('class').indexOf("scheduleContainer") > -1){
							var idSce = $(this).attr('id');
							var idSch = $(ui.draggable).attr('id');
							var descriptionSch = $(ui.draggable).attr('description');
							$.post('<?php echo base_url('index.php/scene/updateSchedule');?>', {scene: idSce, schedule: idSch});
							$(ui.draggable).hide('fast');
							
							$(this).append('<div class="scheneSche"><span class="glyphicon glyphicon-time"></span> '+descriptionSch+' <a class="btn btn-inverse btn-xs saveCronJob" id="'+idSce+'">Guardar</a></div>');
						}else{
							var idSce = $(this).attr('id');
							var idDvc = $(ui.draggable).attr('id');
							var serial = $(ui.draggable).attr('serial');
							var descriptionDvc = $(ui.draggable).attr('description');
							$(this).children("ul").append('<li>'+descriptionDvc+'</li>');
							$(ui.draggable).hide('fast');
							if(serial == '702442500'){
								$('#newDimmer').modal('show');
								$('#saveDimmerDevice').attr('scene', idSce);
								$('#saveDimmerDevice').attr('device', idDvc);
								$('#saveDimmerDevice').attr('serial', serial);
							}else{
								$('#newSwitch').modal('show');
								$('#saveSwitchDevice').attr('scene', idSce);
								$('#saveSwitchDevice').attr('device', idDvc);
								$('#saveSwitchDevice').attr('serial', serial);
							}
						}
					}
				});
				$('#sceneName').val('');
			});
		});
		
		$('#saveSwitchDevice').click(function(){
			var idSce = $(this).attr('scene');
			var idDvc = $(this).attr('device');
			var serial = $(this).attr('serial');
			var state = ($('#switchCheck').bootstrapSwitch('state')) ? 1 : 0;
			$.post('<?php echo base_url('index.php/scene/addDevice');?>', {scene: idSce, device: idDvc, serial: serial, state: state, type: "s"});
		});
		$('#saveDimmerDevice').click(function(){
			var idSce = $(this).attr('scene');
			var idDvc = $(this).attr('device');
			var serial = $(this).attr('serial');
			var state = $('#dimSlider').slider('value');
			$.post('<?php echo base_url('index.php/scene/addDevice');?>', {scene: idSce, device: idDvc, serial: serial, state: state, type: "d"});
		});
		
		$('#saveFloor').click(function(){
			$.post('<?php echo base_url('index.php/floor/saveFloor');?>', {name: $('#floorName').val()});
			floorCounter++;
			$('#floorsContainer').append('<div class="floor"> \
				<a href="#videoModal" data-toggle="modal" data-target="#addSceneModal" class="btn btn-default pull-right addSceneG" id="'+floorCounter+'"> \
					Agregar Escenario <span class="glyphicon glyphicon-plus-sign"></span> \
				</a> \
				<h2>'+$('#floorName').val()+'</h2> \
				<div class="sceneDeviceContainer" id="'+floorCounter+'"></div> \
			</div>');
			$('#floorName').val('')
		});
		$(document).on('click', '.addSceneG', function(){
			currentScene = $(this).attr('id');
			selectedFloor = $(this).attr('id');
		});
		$(document).on('click', '.saveCronJob', function(){
			scene = $(this).attr('id');
			$.post("<?php echo base_url('index.php/scene/saveConcurrent');?>", {sceneP: scene}).done(function(){
				alert("El horario para esta escena ha sido guardado!");
			});
		});
	});
</script>