<div class="row">
	<div class="col-md-4"><img src="<?php echo base_url('assets/img/icons/ok.png');?>" class="img-responsive"/></div>
	<div class="col-md-8">
		<h2 class="done">Dispositivos agregados con éxito!</h2>
		<p class="justify">
		<span class="importantInfo">
			Los dispositivos listados en la parte inferior han sido agregados con éxito para ser posteriormente usados en la red.
		</span>
		</p>
		
		<hr />
		
		<h3>Dispositivos agregados:</h3>
		<br />
		<div class="row">
		<?php foreach($devices as $d):?>
			<div class="col-md-6">
				<div class="device">
					<h4><?php echo $d->name;?>
					<?php if($d->type == 1):?>
						<a id="<?php echo $d->serial?>" class="btn btn-orange btn-sm btn-sm on">On</a>
						<a id="<?php echo $d->serial?>" class="btn btn-default btn-sm off">Off</a>
					<?php elseif($d->type ==2):?>
						<br /><br />
						<div class='slider' id="<?php echo $d->serial?>"></div>
					<?php elseif($d->type ==3):?>
						<a id="<?php echo $d->serial?>" class="btn btn-orange btn-sm on">Subir</a>
						<a id="<?php echo $d->serial?>" class="btn btn-default btn-sm off">Bajar</a>
					<?php endif;?>
				</div>
			</div>
		<?php endforeach;?>
		</div>
	</div>
</div>
<link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script type="text/javascript" src="<?php echo base_url('assets/js/jquery-ui.js');?>"></script>
<script type="text/javascript">
	$(function(){
		$('.on').click(function(){
			$.post("<?php echo base_url('index.php/commands/turnDevice');?>", {operation: 1, device: $(this).attr('id')});
		});
		$('.off').click(function(){
			$.post("<?php echo base_url('index.php/commands/turnDevice');?>", {operation: 0, device: $(this).attr('id')});
		});
		
		$(".slider").slider({min: 0,max: 10,range: "min", slide: function( event, ui ) {
			$.post("<?php echo base_url('index.php/commands/dimDevice');?>", {level: ui.value, device: $(this).attr('id')});
	    }});
	});
</script>