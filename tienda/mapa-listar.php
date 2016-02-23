<?php
    require_once './config.php';
    $lista = MapaDAO::listar();
 
?>
    
    <html>
    <head>
       <link href="https://fontastic.s3.amazonaws.com/S4oB3JzJncdU5ZEY34cesU/icons.css" rel="stylesheet">
       <link rel="stylesheet" href="style.css">
       
        <script src="//code.jquery.com/jquery-1.12.0.min.js"></script>
        
        
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
     <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
    </head>
    <body>
<table border="1" class="table table-striped table-bordered table-hover">
    <thead>
        <tr class="success text-center">
            
            <td>LATITUD</td>
            <td>LONGITUD</td>
            <td>DIRECCION</td>
            <td>EDIFICIO</td>
            <td colspan="2">ACCIONES</td>
        </tr>
    </thead>
    <tbody>
        <?php foreach ($lista as $mapa){?>
        <tr class="item-map" id="<?= $mapa->id ?>" data-lat="<?php echo $mapa->lat?>" data-lng="<?php echo $mapa->lng?>"  data-direc="<?php echo $mapa->direc?>" data-edif="<?php echo $mapa->edif?>">
            <td><?php echo $mapa->lat?></td>
            <td><?php echo $mapa->lng?></td>
            <td><?php echo $mapa->direc?></td>
            <td><?php echo $mapa->edif?></td>
<!--            <th width="150">Fecha Registro</th>-->
            <td align="center"><button class="btn btn-activity" onclick="eliminar('<?php echo $mapa->id?>')">eliminar</button></td>
            <td align="center"><button  id="id" class="btn btn-activity" onclick="obtener('<?php echo $mapa->id?>');">editar</button></td>
        </tr>
        <?php } ?>
        
     
    </tbody>
</table>  
 </body>

 </html>
 