<a class="btn btn-default" id="create">Crear Red</a>
<a class="btn btn-default" id="join">Unirse a Red</a>
<a class="btn btn-default" id="open">Abrir Red</a>
<a class="btn btn-default" id="close">Cerrar Red</a>
<a class="btn btn-default" id="leave">Salir de la Red</a>
<a class="btn btn-default" id="scan">Escanear Red</a>

<script type="text/javascript">
	$(function(){
		$('#create').click(function(){
			$.post('<?php echo base_url('index.php/commands/create_net');?>');
		});
		$('#join').click(function(){
			$.post('<?php echo base_url('index.php/commands/join_net');?>');
		});
		$('#open').click(function(){
			$.post('<?php echo base_url('index.php/commands/open_net');?>');
		});
		$('#close').click(function(){
			$.post('<?php echo base_url('index.php/commands/close_net');?>');
		});
		$('#leave').click(function(){
			$.post('<?php echo base_url('index.php/commands/leave_net');?>');
		});
		$('#scan').click(function(){
			$.post('<?php echo base_url('index.php/commands/scan_net');?>');
		});
	});
</script>