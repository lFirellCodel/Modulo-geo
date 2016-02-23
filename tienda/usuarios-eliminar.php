<?php
require_once './config.php';

$id = (int)$_GET['id']; //filter_input(INPUT_GET, 'id');

UsuarioDAO::eliminar($id);

Flash::set('Registro eliminado satisfactoriamente.');

header('location: usuarios-listar.php');