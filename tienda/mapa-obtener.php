<?php

require_once './config.php';

$id = $_POST['id'];


//$event = new Evento();

//$event->dato= $dato;
    


try{
    
    MapaDAO::obtener($id);
   $l = MapaDAO::obtener($id);
   
   
    $mensaje = array('type' => 'success', 'message' => 'Registro satisfactorio');
    echo json_encode($mensaje);
    
} catch (Exception $e){
    $mensaje = array('type' => 'error', 'message' => $e->getMessage());
    echo json_encode($mensaje);
}
?>
 
 
      <!-- enter any address -->
      <form id="form1" class="form-group" action="" method="post" onsubmit="update_mapa();">
   <?php foreach ($l as $map){
 ?>
   
    <input id="direction" type='text' name='address' class="form-control" placeholder='ingrese direccion'  value="<?php echo $map->direc ?>" />
<!--    <input type="text" name="nom_edif" class="form-control" placeholder="ingrese edificio">-->
    <input id="lat" value="<?php echo $map->lat ?>">
    <input id="lng" value="<?php echo $map->lng ?>">
    <select name="nom_edif" id="nom_edifio" class="form-control" value="<?php echo $map->edif ?>">
          <option value="oficina" <?= $map->edif == 'oficina' ? 'selected' : '' ?> > Oficina Principal</option>
          <option value="itaca" <?= $map->edif == 'itaca' ? 'selected' : '' ?> >Itaca</option>
          <option value="mykonos"<?= $map->edif == 'mykonos' ? 'selected' : '' ?> >Mykonos</option>
          <option value="milos" <?= $map->edif == 'milos' ? 'selected' : '' ?> >Milos</option>
          <option value="ikaria" <?= $map->edif == 'ikaria' ? 'selected' : '' ?> >Ikaria</option>
          <option value="mythos" <?= $map->edif == 'mythos' ? 'selected' : '' ?> >Mythos</option>
        </select>
    
     <button id="update" type="submit" class="btn btn-susses" >ActualizarXD</button>
    
    <?php        }?>
    
</form>
  
