<?php
class MapaDAO {
    
    public static function listar() {
        
        $lista = array();
        
        $con = Conexion::getConexion();
        
        $query = "SELECT * FROM gmap";
        
        $stmt = $con->prepare($query);
        $stmt->execute();
        
        while ($objeto = $stmt->fetchObject('Mapa')){
            $lista[] = $objeto;
        }
        return $lista;
    }
    
    
    public static function registrar($mapa) {
        
        $query = "INSERT INTO gmap (lat, lng, direc, edif)"
                . "VALUES (:lat, :lng, :direc, :edif);";
        
        $con = Conexion::getConexion();
        $stmt = $con->prepare($query);  
        $stmt->bindParam(':lat', $mapa->lat);
        $stmt->bindParam(':lng', $mapa->lng);
        $stmt->bindParam(':direc', $mapa->direc);
        $stmt->bindParam(':edif', $mapa->edif);
        $stmt->execute();
    }
     
    public static function update($mapa){

        $query = "UPDATE gmap SET lat = $mapa->lat , lng = $mapa->lng , direc= '$mapa->direc' , edif='$mapa->edif' WHERE id= $mapa->id";
        
        $con = Conexion::getConexion();
        $stmt = $con->prepare($query); 


        /*$stmt->bindParam(':lat', $mapa->lat);
        $stmt->bindParam(':lng', $mapa->lng);
        $stmt->bindParam(':direc', $mapa->direc);
        $stmt->bindParam(':edif', $mapa->edif);
        $stmt->bindParam(':id', $mapa->id);*/
        
        $result = $stmt->execute();

        return $result;

    }
    public static function eliminar($id) {
        
        $query = "DELETE FROM gmap WHERE id=:id";
        
        $con = Conexion::getConexion();
        $stmt = $con->prepare($query);
        
        $stmt->bindParam(':id', $id);
        
        $stmt->execute();
    }
    
  public static function obtener($id) {
        $lista = array();
         
        $sql = "SELECT * FROM gmap WHERE id=:id";
        
        $con = Conexion::getConexion();
        $stmt = $con->prepare($sql);
        $stmt->bindParam(':id', $id);
        $stmt->execute();
        
        while($objeto = $stmt->fetchObject('Mapa')){
             $lista[] = $objeto;
        }
        
        return $lista;
    }
    
    
}


