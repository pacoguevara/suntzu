<a href="<?php echo base_url('index.php/admin/user_add');?>" class="btn btn-default pull-right"><span class="glyphicon glyphicon-plus-sign"></span> Nuevo</a>
<h2>Gestión de Usuarios</h2>
<hr />
<table class="table table-bordered table-striped table-hover">
	<tr>
		<th>Usuario</th>
		<th>Nombre</th>
		<th>Email</th>
		<th>Descripción</th>
		<th>Alta</th>
		<th></th>
		<th></th>
	</tr>
	<?php foreach($users as $u):?>
	<tr>
		<td><?php echo $u->username;?></td>
		<td><?php echo $u->name.' '.$u->last_name;?></td>
		<td><?php echo $u->email;?></td>
		<td><?php echo $u->description;?></td>
		<td><?php echo $u->when;?></td>
		<td class="center"><a href="<?php echo base_url('index.php/admin/user_edit/'.$u->id);?>"><span class="glyphicon glyphicon-pencil"></span></a></td>
		<td class="center"><a id="<?php echo $u->id;?>" class="remove"><span class="glyphicon glyphicon-remove"></span></a></td>
	</tr>
	<?php endforeach;?>
</table>

<script type="text/javascript">
	$(function(){
		$('.remove').click(function(){
			$.post('<?php echo base_url('index.php/admin/removeUser');?>', {id: $(this).attr('id')});
			$(this).closest('tr').hide('fast');
		});
	});
</script>