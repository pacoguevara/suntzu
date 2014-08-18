<div class="col-md-12">
	<div class="alert alert-success" role="alert" style="display:none;" id="msgAlert"><b>Cambios Guardados!</b> Navega a esta nueva dirección para continuar: <a id="newUrl" href=""></a></b></div>
</div>
<div class="col-md-6">
	<div class="panel panel-default">
	    <div class="panel-heading"><h4>Configuración de Red</h4></div>
	    <div class="panel-body">
	    	Dirección IP:<br />
	    	<div class="row">
	    		<div class="col-md-2"><input class="form-control" id="ip1"/></div>
	    		<div class="col-md-1">.</div>
	    		<div class="col-md-2"><input class="form-control" id="ip2"/></div>
	    		<div class="col-md-1">.</div>
	    		<div class="col-md-2"><input class="form-control" id="ip3"/></div>
	    		<div class="col-md-1">.</div>
	    		<div class="col-md-2"><input class="form-control" id="ip4"/></div>
	    	</div>
	    	<br />
	    	Máscara de Red:<br />
	    	<div class="row">
	    		<div class="col-md-2"><input class="form-control" id="mask1"/></div>
	    		<div class="col-md-1">.</div>
	    		<div class="col-md-2"><input class="form-control" id="mask2"/></div>
	    		<div class="col-md-1">.</div>
	    		<div class="col-md-2"><input class="form-control" id="mask3"/></div>
	    		<div class="col-md-1">.</div>
	    		<div class="col-md-2"><input class="form-control" id="mask4"/></div>
	    	</div>
	    	<br />
	    	Puerta de Enlace:<br />
	    	<div class="row">
	    		<div class="col-md-2"><input class="form-control" id="gate1"/></div>
	    		<div class="col-md-1">.</div>
	    		<div class="col-md-2"><input class="form-control" id="gate2"/></div>
	    		<div class="col-md-1">.</div>
	    		<div class="col-md-2"><input class="form-control" id="gate3"/></div>
	    		<div class="col-md-1">.</div>
	    		<div class="col-md-2"><input class="form-control" id="gate4"/></div>
	    	</div>
	    	<br />
	    </div>
	</div>
</div>
<div class="col-md-6">
	<div class="well overhid">
		<a id="saveSettings" class="btn btn-block btn-orange">Guardar</a>
		<hr />
		<p class="justify">
			Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu.
			<br /><br />
			Para mayor información de la configuración:
			<br />
			<a class="btn btn-default pull-right">Ayuda</a>
		</p>
	</div>
</div>

<script type="text/javascript">
	$(function(){
		$('#saveSettings').click(function(){
			var ip = $('#ip1').val()+'.'+$('#ip2').val()+'.'+$('#ip3').val()+'.'+$('#ip4').val();
			var mask = $('#mask1').val()+'.'+$('#mask2').val()+'.'+$('#mask3').val()+'.'+$('#mask4').val();
			var gateway = $('#gate1').val()+'.'+$('#gate2').val()+'.'+$('#gate3').val()+'.'+$('#gate4').val();
			var new_url = "http://"+ip+"/index.php/settings/network";
			$('#newUrl').attr("href", new_url);
			$('#newUrl').text(new_url);
			$("#msgAlert").show('slow');
			$.post('<?php echo base_url('index.php/settings/setNetworkOptions');?>', {ip:ip, mask:mask, gateway:gateway});
		});
	});
</script>