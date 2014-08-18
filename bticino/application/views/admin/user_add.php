<?php if(isset($user)):?>
	<form action="<?php echo base_url('index.php/admin/updateUser');?>" method="post">
	<input type="hidden" name="id" value="<?php echo $user->id;?>"/>
<?php else:?>
	<form action="<?php echo base_url('index.php/admin/addUser');?>" method="post">
<?php endif;?>
<div class="row">
	<div class="col-md-6">
		<div class="col-md-3">
			<b>Rol: </b>
		</div>
		<div class="col-md-9">
			<select name="rol" class="form-control">
				<?php foreach($rols as $r):?>
					<option value="<?php echo $r->id;?>"><?php echo $r->description;?></option>
				<?php endforeach;?>
			</select>
		</div>
		<br /><br />
		<div class="col-md-3">
			<b>Nombre: </b>
		</div>
		<div class="col-md-9">
			<input type="text" name="name" class="form-control" value="<?php if(isset($user->name))echo $user->name;?>"/>
		</div>
		<br /><br />
		<div class="col-md-3">
			<b>Apellido: </b>
		</div>
		<div class="col-md-9">
			<input type="text" name="last_name" class="form-control" value="<?php if(isset($user->last_name))echo $user->last_name;?>"/>
		</div>
		<br /><br />
		<div class="col-md-3">
			<b>Email: </b>
		</div>
		<div class="col-md-9">
			<input type="email" name="email" class="form-control" value="<?php if(isset($user->email))echo $user->email;?>" />
		</div>
	</div>
	<div class="col-md-6">
		<div class="col-md-3">
			<b>Usuario: </b>
		</div>
		<div class="col-md-9">
			<input type="text" name="username" class="form-control" value="<?php if(isset($user->username))echo $user->username;?>"/>
		</div>
		<br /><br />
		<div class="col-md-3">
			<b>Contraseña: </b>
		</div>
		<div class="col-md-9">
			<input type="password" name="password" class="form-control" />
		</div>
		<br /><br />
		<div class="col-md-3">
			<b>Repetir Contraseña: </b>
		</div>
		<div class="col-md-9">
			<input type="password" name="password_confirm" class="form-control" />
		</div>
	</div>
</div>
<hr />
<div class="pull-right">
	<a class="btn btn-default" href="<?php echo base_url('index.php/admin/users');?>">Cancelar</a>
	<input class="btn btn-orange" value="Guardar" type="submit">
</div>
</form>