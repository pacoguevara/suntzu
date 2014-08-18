<a class="btn btn-orange pull-right" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#newSchModal">Crear Horario <span class="glyphicon glyphicon-plus-sign"></span></a>
<h2>Horarios</h2>
<hr />

<table class="table table-hover table-striped table-bordered">
	<tr>
		<th><span class="glyphicon glyphicon-time"></span> Inicio</th>
		<th><span class="glyphicon glyphicon-time"></span> Fin</th>
		<th>Descripción</th>
		<th>Recurrente</th>
		<th class="center">Activo</th>
		<th></th>
		<th></th>
	</tr>
	<?php foreach($schedules as $s):?>
	<tr>
		<td><?php echo $s->start;?></td>
		<td><?php echo $s->end;?></td>
		<td><?php echo $s->description;?></td>
		<td>Todos los días</td>
		<?php if($s->enabled == 1):?>
			<td class="center"><input type="checkbox" class="switch_active" checked="true"></td>
		<?php else:?>
			<td class="center"><input type="checkbox" class="switch_active"></td>
		<?php endif;?>
		<td class="center"><span class="glyphicon glyphicon-pencil editSche"></span></td>
		<td class="center"><span id="<?php echo $s->id?>" class="glyphicon glyphicon-remove removeSche"></span></td>
	<?php endforeach;?>
	</tr>
</table>

<!-- newSchModal -->
<div class="modal fade" id="newSchModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Nuevo Horario</h4>
      </div>
      <div class="modal-body">
      <form action="<?php echo base_url('index.php/schedule/insert');?>" method="post">
      	<div class="row">
	      	<div class="col-md-6 center">
	      		<h4>Hora de Inicio:</h4>
	      		<div class="bfh-timepicker" id="start"></div>
	      	</div>
	      	<div class="col-md-6 center">
	      		<h4>Hora de Finalización:</h4>
	      		<div class="bfh-timepicker" id="end"></div>
	      	</div>
      	</div>
      	<hr />
      	Descripción:
      	<input type="text" class="form-control" placeholder="(Ej. Vacaciones)" id="description">
      	<br />
      	Repetir:<br />
      	<input type="checkbox" name="concurrent[]"  value="0"/> L
      	<input type="checkbox" name="concurrent[]"  value="1"/> M
      	<input type="checkbox" name="concurrent[]" value="2"/> M
      	<input type="checkbox" name="concurrent[]"  value="3"/> J
      	<input type="checkbox" name="concurrent[]"  value="4"/> V
      	<input type="checkbox" name="concurrent[]"  value="5"/> S
      	<input type="checkbox" name="concurrent[]" value="6"/> D
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
        <input type="submit" class="btn btn-primary" data-dismiss="modal" id="saveSchedule" value="Guardar"/>
      </div>
      </form>
    </div>
  </div>
</div>


<!-- editSchModal -->
<div class="modal fade" id="editSchModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Editar Horario</h4>
      </div>
      <div class="modal-body">
      <form action="<?php echo base_url('index.php/schedule/insert');?>" method="post">
      	<div class="row">
	      	<div class="col-md-6 center">
	      		<h4>Hora de Inicio:</h4>
	      		<div class="bfh-timepicker" id="startE"></div>
	      	</div>
	      	<div class="col-md-6 center">
	      		<h4>Hora de Finalización:</h4>
	      		<div class="bfh-timepicker" id="endE"></div>
	      	</div>
      	</div>
      	<hr />
      	Descripción:
      	<input type="text" class="form-control" placeholder="(Ej. Vacaciones)" id="descriptionE">
      	<br />
      	Repetir:<br />
      	<input type="checkbox" name="concurrent[]"  value="0"/> L
      	<input type="checkbox" name="concurrent[]"  value="0"/> M
      	<input type="checkbox" name="concurrent[]" value="0"/> M
      	<input type="checkbox" name="concurrent[]"  value="0"/> J
      	<input type="checkbox" name="concurrent[]"  value="0"/> V
      	<input type="checkbox" name="concurrent[]"  value="0"/> S
      	<input type="checkbox" name="concurrent[]" value="0"/> D
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
        <input type="submit" class="btn btn-primary" data-dismiss="modal" id="saveSchedule" value="Guardar"/>
      </div>
      </form>
    </div>
  </div>
</div>






<script type="text/javascript" src="<?php echo base_url('assets/js/bootstrap-switch.js');?>"></script>
<script type="text/javascript" src="<?php echo base_url('assets/js/bootstrap-formhelpers.js');?>"></script>
<link rel="stylesheet" href="<?php echo base_url('assets/css/bootstrap-switch.css');?>" />
<link rel="stylesheet" href="<?php echo base_url('assets/css/bootstrap-formhelpers.css');?>" />
<script type="text/javascript">
	$(function(){
		$(".switch_active").bootstrapSwitch({size:'small'});
		
		$('#saveSchedule').click(function(){
			var startH = $('#start').val();
			var endH = $('#end').val();
			var description = $('#description').val();
			var concurrent = "";
			
			$.each($("input[name='concurrent[]']:checked"), function() {
			  concurrent += $(this).val()+',';
			});
			if(concurrent == ""){
				concurrent = "0,1,2,3,4,5,6,";
			}
			concurrent = concurrent.slice(0, -1);
			
			$.post('<?php echo base_url('index.php/schedule/insert');?>', {start: startH, end: endH, description: description, concurrent: concurrent}).success(function(){
				location.reload();
			});
		});
		$(document).on('click', '.removeSche', function(){
			var id = $(this).attr('id');
			$.post("<?php echo base_url('index.php/schedule/remove');?>", {id: id});
			$(this).closest('tr').hide('slow');
		});
		$(document).on('click', '.editSche', function(){
			$('#editSchModal').modal('show');
		});
	});
</script>