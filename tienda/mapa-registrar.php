<?php
 require_once './config.php';
 
$lat = $_POST['lat'];
$lng = $_POST['lng'];
$direc = $_POST['direc'];
$edif  = $_POST['edif'];

var_dump($lat);
var_dump($lng);

$mapa = new Mapa();

$mapa->lat = $lat;
$mapa->lng = $lng;
$mapa->direc = $direc;
$mapa->edif = $edif;
try{
    
    MapaDAO::registrar($mapa);
    
    $mensaje = array('type' => 'success', 'message' => 'Registro satisfactorio');
    echo json_encode($mensaje);
    
} catch (Exception $e){
    $mensaje = array('type' => 'error', 'message' => $e->getMessage());
    echo json_encode($mensaje);
}

?>
 