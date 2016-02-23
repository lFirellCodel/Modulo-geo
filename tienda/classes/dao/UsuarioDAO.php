<?php

class UsuarioDAO {

    public static function validar($username, $password) {
        
        $query = "SELECT * FROM usuarios WHERE username=:username and password=:password";
        
        $con = Conexion::getConexion();
        $stmt = $con->prepare($query);
        $stmt->bindParam(':username', $username);
        $stmt->bindParam(':password', $password);
        $stmt->execute();

        if($fila = $stmt->fetchObject('Usuario')){
            return $fila;
        }
        return NULL;
    }
    
    public static function listar() {
        $lista = array();
        $query = "SELECT * FROM usuarios ORDER BY nombres";
        $con = Conexion::getConexion() ;
        $stmt = $con->prepare($query);
        $stmt->execute();

        while($fila = $stmt->fetchObject('Usuario')){
            $lista[] = $fila;
        }

        return $lista;
    }
    
    public static function registrar($usuario) {
        
        $query = "INSERT INTO usuarios (username, `password`, nombres, roles_id, email) "
                . "VALUES (:username, :password, :nombres, :roles_id, :email)";
        
        $con = Conexion::getConexion();
        $stmt = $con->prepare($query);
        
        $stmt->bindParam(':username', $usuario->username);
        $stmt->bindParam(':password', $usuario->password);
        $stmt->bindParam(':nombres', $usuario->nombres);
        $stmt->bindParam(':email', $usuario->email);
        $stmt->bindParam(':roles_id', $usuario->roles_id);
        
        $stmt->execute();
    }
    
    public static function eliminar($id) {
        
        $query = "DELETE FROM usuarios WHERE id=:id";
        
        $con = Conexion::getConexion();
        $stmt = $con->prepare($query);
        
        $stmt->bindParam(':id', $id);
        
        $stmt->execute();
    }
        
}

?>
