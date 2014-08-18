<h2>Dispositivos</h2>
<hr />
<?php foreach($devices as $d):?>
	<div class="col-md-3">
		<?php if($this->session->userdata('rol') != 1):?>
		<span class="glyphicon glyphicon-remove remove remove-device pull-right" id="<?php echo $d->id?>"></span>
		<?php endif;?>
		<div class="device">
			<h4><?php echo $d->name;?></h4>
			<hr />
			<div class="row">
				<?php if($d->type == 1):?>
					<div class="col-md-6"><a class="turnDevice btn btn-block btn-orange" serial="<?php echo $d->serial;?>" operation="1">ON</a></div>
					<div class="col-md-6"><a class="turnDevice btn btn-block btn-default" serial="<?php echo $d->serial;?>" operation="0">OFF</a></div>
				<?php endif;?>
				<?php if($d->type == 2):?>
					<div class="col-md-12">
						<div class='slider' id="<?php echo $d->serial?>"></div>
					</div>
				<?php endif;?>
				<?php if($d->type == 3):?>
					<div class="col-md-6"><a class="turnDevice btn btn-block btn-orange" serial="<?php echo $d->serial;?>" operation="1">ON</a></div>
					<div class="col-md-6"><a class="turnDevice btn btn-block btn-default" serial="<?php echo $d->serial;?>" operation="0">OFF</a></div>
				<?php endif;?>
			</div>
		</div>
	</div>
<?php endforeach;?>
<link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script type="text/javascript" src="<?php echo base_url('assets/js/jquery-ui.js');?>"></script>
<script type="text/javascript">
	$(function(){
		$('.turnDevice').click(function(){
			$.post('<?php echo base_url('index.php/device/turnDevice');?>', {operation: $(this).attr('operation'), device: $(this).attr('serial')})
		});
		$(".slider").slider({min: 0,max: 10,range: "min", slide: function( event, ui ) {
			$.post("<?php echo base_url('index.php/commands/dimDevice');?>", {level: ui.value, device: $(this).attr('id')});
	    }});
	    $('.remove').click(function(){
		    id = $(this).attr('id');
		    $(this).parent().hide('slow');
		    $.post('<?php echo base_url('index.php/device/remove');?>', {id:id});
	    });
	});
</script>