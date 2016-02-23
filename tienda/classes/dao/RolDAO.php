<?php

class RolDAO {
    
    public static function listar() {
        $lista = array();
        $query = "SELECT * FROM roles ORDER BY nombre";
        $con = Conexion::getConexion() ;
        $stmt = $con->prepare($query);
        $stmt->execute();

        while($fila = $stmt->fetchObject('Rol')){
            $lista[] = $fila;
        }

        return $lista;
    }
        
}

?>
