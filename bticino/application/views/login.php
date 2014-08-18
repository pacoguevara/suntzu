<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title></title>
        <link rel="stylesheet" href="<?php echo base_url('assets/css/bootstrap.css');?>" />
        <link rel="stylesheet" href="<?php echo base_url('assets/css/style.css');?>" />
    </head>
    <body>
        <div class="container">
            <div class="col-md-4 col-md-offset-4">
                <div id="loginBox">
                    <div class="row">
                    <div class="col-md-10 col-md-offset-1">
                            <img src="<?php echo base_url('assets/img/logo.png');?>" class="img-responsive"/>
                    </div>
                    </div>
                    <hr />
                    <form action="<?php echo base_url('index.php/session/login');?>" method="post">
                    	<input type="text" placeholder="Usuario" class="form-control" name="username" /><br />
                    	<div class="row">
                            <div class="col-md-9">
                                    <input type="password" placeholder="Contraseña" class="form-control" name="password" /><br />	
                            </div>
                            <div class="col-md-3">
                                    <input type="submit" class="btn btn-orange btn-block" value="Ok!" />
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>