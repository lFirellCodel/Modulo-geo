<?php 
require_once './config.php';

$roles = RolDAO::listar();
$usuarios = UsuarioDAO::listar();

?>
<!DOCTYPE html>
<html>
    <head>
        <?php require_once 'include/head.php';?>
        <title></title>
        
    </head>
    <body>
        
        <?php require_once './include/header.php';?>
        <?php require_once './include/menubar.php';?>
        <div id="content">
            
            <form method="post" action="usuarios-registrar.php">
                <fieldset>
                    <legend>Registro de usuario</legend>

                    <div class="row">
                        <div class="form-group col-md-6">
                            <label>Usuario</label>
                            <input type="text" name="username" class="form-control" placeholder="Ingrese usuario">
                        </div>
                        <div class="form-group col-md-6">
                            <label>Rol</label>
                            <select name="roles_id" class="form-control">
                                <?php foreach($roles as $rol) {?>
                                <option value="<?php echo $rol->id?>"><?php echo $rol->nombre?></option>
                                <?php } ?>
                            </select>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="form-group col-md-6">
                            <label>Password</label>
                            <input type="password" name="password" class="form-control" placeholder="Ingrese password">
                        </div>
                        <div class="form-group col-md-6">
                            <label>Repetir password</label>
                            <input type="password" name="password2" class="form-control" placeholder="Ingrese password nuevamente">
                        </div>
                    </div>

                    <div class="row">
                        <div class="form-group col-md-6">
                            <label>Nombres</label>
                            <input type="text" name="nombres" class="form-control" placeholder="Ingrese nombres">
                        </div>
                        <div class="form-group col-md-6">
                            <label>Email</label>
                            <input type="text" name="email" class="form-control" placeholder="Ingrese email">
                        </div>
                    </div>

                    <button type="submit" class="btn btn-default">Registrar</button>
                </fieldset>
            </form>
            
            <hr/>
            
            <div class="table-responsive">
            <table border="1" class="table table-striped table-bordered table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>USUARIO</th>
                        <th>NOMBRES</th>
                        <th>EMAIL</th>
                        <th>&nbsp;</th>
                    </tr>
                </thead>
                <tbody>
                  <?php
                    foreach($usuarios as $usuario){
                  ?>
                    <tr>
                        <td><?php echo $usuario->id ?></td>
                        <td><?php echo $usuario->username ?></td>
                        <td><?php echo $usuario->nombres ?></td>
                        <td><?php echo $usuario->email ?></td>
                        <td><a href="usuarios-eliminar.php?id=<?php echo $usuario->id ?>">Eliminar</a></td>
                    </tr>
                  <?php
                    }
                  ?>
                </tbody>
            </table>
            </div>
            
            <a href="usuarios-exportar-excel.php" class="btn btn-default" role="button">Descargar Excel</a>
    
            <hr/>
            
            <form method="post" action="usuarios-importar-excel.php" enctype="multipart/form-data">
                <fieldset>
                    <legend>Importar excel</legend>
                    <div class="row">
                        <div class="form-group col-md-6">
                            <input type="file" name="documento" class="form-control">
                        </div>
                        <div class="form-group col-md-6">
                            <button type="submit" class="btn btn-default">Importar</button>
                        </div>
                    </div>
                </fieldset>
            </form>
            
        </div>
       <?php require_once './include/footer.php';?>
        
    </body>
</html>
