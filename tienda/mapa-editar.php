

<?php

require_once './config.php';

$id = $_POST['id'];

$lat = $_POST['lat'];
$lng = $_POST['lng'];
$direc = $_POST['direc'];
$edif  = $_POST['edif'];


$mapa = new Mapa();

$mapa->lat = $lat;
$mapa->lng = $lng;
$mapa->direc = $direc;
$mapa->edif = $edif;
$mapa->id = $id;
try{
    
    MapaDAO::update($mapa);
   
    $mensaje = array('type' => 'success', 'message' => 'Registro satisfactorio');
    echo json_encode($mensaje);
    
} catch (Exception $e){
    $mensaje = array('type' => 'error', 'message' => $e->getMessage());
    echo json_encode($mensaje);
}



