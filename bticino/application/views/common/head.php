<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<script type="text/javascript" src="<?php echo base_url('assets/js/jquery.js');?>"></script>
		<script type="text/javascript" src="<?php echo base_url('assets/js/bootstrap.js');?>"></script>
		<script type="text/javascript" src="<?php echo base_url('assets/js/bootstrap-switch.js');?>"></script>
		<link rel="stylesheet" href="<?php echo base_url('assets/css/bootstrap.css');?>" />
		<link rel="stylesheet" href="<?php echo base_url('assets/css/bootstrap-switch.css');?>" />
		<link rel="stylesheet" href="<?php echo base_url('assets/css/style.css');?>" />
		<title>Bticino Domótica</title>
	</head>
	<body>
                <div class="container">
                    <div class="pull-right">
                        <?php echo $this->session->userdata('name') . ' ' . $this->session->userdata('last_name'); ?> | <a href="<?php echo base_url('index.php/session/logout');?>">Salir</a>
                    </div>
                </div>
		<nav class="navbar navbar-default" role="navigation">
		  <div class="container-fluid">
		    <!-- Brand and toggle get grouped for better mobile display -->
		    <div class="navbar-header">
		      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		      </button>
		    </div>
		
		    <!-- Collect the nav links, forms, and other content for toggling -->
		    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		    	<div class="container">
			      <ul class="nav navbar-nav">
			      	<li><a href="<?php echo base_url();?>"><img src="<?php echo base_url('assets/img/logo.png');?>" id="mainLogo" /></a></li>
			      	<?php if($this->session->userdata('rol') != 1):?>
			      	<li class="dropdown">
			     		<a href="#" class="dropdown-toggle" data-toggle="dropdown">Red Bticino<b class="caret"></b></a>
			     		<ul class="dropdown-menu">
			     			<li><a href="<?php echo base_url('index.php/setup/create');?>">Crear Nueva Red</a></li>
			     			<li><a href="<?php echo base_url('index.php/setup/join');?>">Unirse a Red</a></li>
			     			<li><a id="leaveNet">Dejar esta Red</a></li>
			     		</ul>
			     	</li>
			     	<?php endif;?>
			     	<li class="dropdown">
			     		<a href="#" class="dropdown-toggle" data-toggle="dropdown">Control del Hogar<b class="caret"></b></a>
			     		<ul class="dropdown-menu">
			     		<?php if(sizeof($floors) > 0):?>
					     	<?php foreach($floors as $f):?>
				     			<li><a href="<?php echo base_url('index.php/floor/show/'.$f->id);?>"><?php echo $f->name;?></a></li>
				     		<?php endforeach;?>
				     		<li class="divider"></li>
			     		<?php endif;?>
			     			<li><a href="<?php echo base_url('index.php/device/all');?>">Dispositivos</a></li>
			     			<li><a href="<?php echo base_url('index.php/scene/home');?>">Escenarios</a></li>
			     			<li><a href="<?php echo base_url('index.php/schedule');?>">Horarios</a></li>
			     		</ul>
			     	</li>
			      </ul>
			      <ul class="nav navbar-nav navbar-right">
			      	<li class="dropdown">
			     		<a href="#" class="dropdown-toggle iconNav" data-toggle="dropdown"><span class="glyphicon glyphicon-cog"></span></a>
			     		<ul class="dropdown-menu">
				     		<li><a href="<?php echo base_url('index.php/settings/hour');?>">Configuración Horaria</a></li>
				     		<li><a href="<?php echo base_url('index.php/settings/network');?>">Configuración de Red</a></li>
				     		<li class="divider"></li>
				     		<?php if($this->session->userdata('rol') == 3):?>
				     		<li><a href="<?php echo base_url('index.php/admin/users');?>">Gestionar Usuarios</a></li>
                            <?php endif;?>
			     		</ul>
			     	</li>
			      	
			      	<li class="iconNav"><a href="<?php echo base_url('index.php/welcome/help');?>"><span class="glyphicon glyphicon-question-sign"></span></a></li>
			      </ul>
		    	</div>
		    </div><!-- /.navbar-collapse -->
		    
		  </div><!-- /.container-fluid -->
		</nav>
		
		
		
		<div class="container" id="mainContainer">
		
		<script type="text/javascript">
			$(function(){
				$('#leaveNet').click(function(){
					$.post('<?php echo base_url('index.php/setup/leave');?>');
				});
			});
		</script>
