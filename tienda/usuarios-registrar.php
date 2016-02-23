<?php
require_once './config.php';

$username = $_POST['username']; //filter_input(INPUT_POST, 'username');
$password = $_POST['password'];
$nombres = $_POST['nombres'];
$email = $_POST['email'];
$roles_id = $_POST['roles_id'];

$usuario = new Usuario();
$usuario->username = $username;
$usuario->password = $password;
$usuario->nombres = $nombres;
$usuario->email = $email;
$usuario->roles_id = $roles_id;

UsuarioDAO::registrar($usuario);

Flash::set('Registro guardado satisfactoriamente.');

header('location: usuarios-listar.php');