<h2><?php echo $floor->name;?></h2>
<hr />
<table class="table table-bordered table-hover table-striped">
	<tr>
		<th>Nombre</th>
		<th>Inicio</th>
		<th>Fin</th>
		<th></th>
		<th></th>
	</tr>
	<?php foreach($scenes as $s):?>
		<tr>
			<td><?php echo $s->name;?></td>
			<?php if($s->start == "00:00 XX"):?>
			<td>N/A</td>
			<td>N/A</td>
			<?php else:?>
			<td><span class="glyphicon glyphicon-time"></span> <?php echo $s->start;?></td>
			<td><span class="glyphicon glyphicon-time"></span> <?php echo $s->end;?></td>
			<?php endif;?>
			<td class="center"><a class="btn btn-xs btn-orange toggle-scene" id="<?php echo $s->id;?>" enabled="0">Activar</a></td>
			<td class="center"><span class="glyphicon glyphicon-remove remove" id="<?php echo $s->id;?>"></span></td>
		</tr>
	<?php endforeach;?>
</table>

<script type="text/javascript">
	$(function(){
		$(document).on('click', '.toggle-scene', function(){
			var pressed = $(this);
			scene = pressed.attr('id');
			if(pressed.attr('enabled') == 0){
				pressed.attr('class', 'btn btn-default btn-xs toggle-scene');
				pressed.attr('enabled', 1);
				pressed.text('Desactivar');
				$.post('<?php echo base_url('index.php/scene/start');?>', {scene: scene});
			}else{
				pressed.attr('class', 'btn btn-orange btn-xs toggle-scene');
				pressed.attr('enabled', 0);
				pressed.text('Activar');
				console.log(scene);
				$.post('<?php echo base_url('index.php/scene/end');?>', {scene: scene});
			}
		});
		$('.remove').click(function(){
			id = $(this).attr('id');
			$.post('<?php echo base_url('index.php/floor/removeScene');?>', {id: id});
			$(this).closest('tr').hide('fast');
		});
	});
</script>