<?php
require_once './config.php';

$id = $_POST['id'];

try{
    
    MapaDAO::eliminar($id);

    $mensaje = array('type' => 'success', 'message' => 'Registro eliminado satisfactoriamente');
    echo json_encode($mensaje);

} catch (Exception $e){
    $mensaje = array('type' => 'error', 'message' => $e->getMessage());
    echo json_encode($mensaje);
}