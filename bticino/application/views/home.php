<div class="row">
	<div class="col-md-8">
		<div id="manualControl">
			<div class="bulbContainer">
				<div class="col-md-3"><div class="bulb">
					<h4>Apagador 1</h4>
					<img src="<?php echo base_url('assets/img/bulb_off.jpg');?>" class="img-responsive" id="bulbImg"/>
					<a id="lightsOn" class="btn btn-default">On</a>
					<a id="lightsOff" class="btn btn-default">Off</a>
					</div>
				</div>
			</div>
	
			
			<div class="bulbContainer">
				<div class="col-md-3"><div class="bulb">
					<h4>Apagador 2</h4>
					<img src="<?php echo base_url('assets/img/bulb_on.jpg');?>" class="img-responsive" />
					<a class="btn btn-default">Apagar</a>
				</div>
				</div>
			</div>
			
			<div class="bulbContainer">
				<div class="col-md-3"><div class="bulb">
					<h4>Dimmer 1</h4>
					<img src="<?php echo base_url('assets/img/bulb_off.jpg');?>" class="img-responsive" />
					Intensidad: 
					<input type="range" name="points" min="1" max="10">
				</div>
				</div>
			</div>
			
			<div class="bulbContainer">
				<div class="col-md-3"><div class="bulb">
					<h4>Apagador 3</h4>
					<img src="<?php echo base_url('assets/img/bulb_off.jpg');?>" class="img-responsive" />
					<a class="btn btn-default">Encender</a>
				</div>
				</div>
			</div>
		</div>
		<hr />
	</div>
	
	<div class="col-md-4">
	<div class="panel panel-warning">
	  <div class="panel-heading overhid">
	  	<a class="btn btn-default btn-xs pull-right" href="<?php echo base_url('index.php/scene/home');?>">Nuevo <span class="glyphicon glyphicon-plus-sign"></span></a>
	    <h3 class="panel-title">Escenarios</h3>
	  </div>
	  <div class="panel-body">
	    
		    <div class="input-group homeScene">
		      <span class="input-group-addon">
		        <input type="checkbox">
		      </span>
		      <input type="text" class="form-control" disabled value="Función de Cine"/>
		    </div><!-- /input-group -->
		    
		    <div class="input-group homeScene">
		      <span class="input-group-addon">
		        <input type="checkbox">
		      </span>
		      <input type="text" class="form-control" disabled value="Hora de Dormir"/>
		    </div><!-- /input-group -->
		    
		    <div class="input-group homeScene">
		      <span class="input-group-addon">
		        <input type="checkbox">
		      </span>
		      <input type="text" class="form-control" disabled value="Tenemos Visita"/>
		    </div><!-- /input-group -->
		    
		    <div class="input-group homeScene">
		      <span class="input-group-addon">
		        <input type="checkbox">
		      </span>
		      <input type="text" class="form-control" disabled value="Estamos de Vacaciones"/>
		    </div><!-- /input-group -->
		    
	  </div>
	</div>
</div>

</div>
<script type="text/javascript">
	function test(){
		$.getJSON( "<?php echo base_url('assets/bash/serialF.json');?>", function( data ) {
			console.log(data.content.split("##"));
		});
	}
	$(function(){
		$('#lightsOn').click(function(){
			$.post('<?php echo base_url('index.php/scene/on');?>');
			$('#bulbImg').attr('src', "<?php echo base_url('assets/img/bulb_on.jpg');?>");
		});
		$('#lightsOff').click(function(){
			$.post('<?php echo base_url('index.php/scene/off');?>');
			$('#bulbImg').attr('src', "<?php echo base_url('assets/img/bulb_off.jpg');?>");
		});
	})
</script>