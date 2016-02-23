<?php
//http://php.net/manual/es/intro.pdo.php
require_once 'Producto.php';
try{
    
    //***CONEXION
    
    $con = new PDO('mysql:host=localhost;dbname=catalogo', 'root', '');
    
    $con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    //PDO::ERRMODE_SILENT
    //PDO::ERRMODE_WARNING
    //PDO::ERRMODE_EXCEPTION
    
    //***SELECT (SIN SENTENCIA)
    $modelo = $con->quote('%desktop%'); //Parámetro seguro
    $stmt = $con->query("SELECT * FROM producto WHERE modelo LIKE $modelo");
//    var_dump($stmt->fetchAll());
    
    //***SELECT (CON SENTENCIA)
    
    $stmt = $con->prepare('SELECT * FROM producto WHERE modelo LIKE :modelo');
//    $params = array(
//        'modelo' => '%desktop%'
//    );
//    $stmt->execute($params);
    $stmt->bindParam(':modelo', $modelo = '%desktop%');
    $stmt->execute();

    echo 'Total: '.$stmt->rowCount(); 
    
    
    //***FETCH
    
//    $resultado = $stmt->fetchAll();
//    var_dump($resultado);
    
    //setFetchMode: PDO::FETCH_ASSOC, PDO::FETCH_NUM, PDO::FETCH_OBJ, PDO::FETCH_CLASS, ...
    
    $lista = array();
    
    $stmt->setFetchMode(PDO::FETCH_ASSOC); 
    while($fila = $stmt->fetch()) {  
        $producto = new Producto();
        $producto->codigo = $fila['codigo'];
        $producto->modelo = $fila['modelo'];
        $producto->precio = $fila['precio'];
        $producto->stock = $fila['stock'];
        $lista[] = $producto;
    }  
    var_dump($lista);
    
    echo '<hr>';
    
    // FETCH_OBJ
    
    $stmt->execute(); //fetch ya recorrio todas las filas
    
    $lista = array();
    
    $stmt->setFetchMode(PDO::FETCH_OBJ); 
    while($objeto = $stmt->fetch()) { 
        echo $objeto->modelo;
        $lista[] = $objeto;
    }  
    var_dump($lista);
    
    echo '<hr>';
    
    // FETCH CLASS
    
    $stmt->execute(); //fetch ya recorrio todas las filas
    
    $lista = array();
    
    $stmt->setFetchMode(PDO::FETCH_CLASS | PDO::FETCH_PROPS_LATE, 'Producto'); 
    while($producto = $stmt->fetch()) { 
        $lista[] = $producto;
    }  
    var_dump($lista);
    
    echo '<hr>';
    
    
    //***INSERT, UPDATE, DELETE
    
    $stmt = $con->prepare('INSERT INTO USUARIO(usuario, clave, nombres, apellidos) 
        VALUES(:usuario, :clave, :nombres, :apellidos)');
//    $params = array(
//        'usuario'   => 'ebenites',
//        'clave'     => 'tecsup',
//        'nombres'   => 'Erick',
//        'apellidos' => 'Benites'
//    );
//    $stmt->execute($params);
    
//    $stmt->bindParam(':usuario', $usuario = 'mgalvez');
//    $stmt->bindParam(':clave', $clave = 'tecsup');
//    $stmt->bindParam(':nombres', $nombres = 'Mauricio');
//    $stmt->bindParam(':apellidos', $apellidos = 'Galvez');
//    $stmt->execute();
//    
//    echo $con->lastInsertId(); 
    
    
    //***INSERT, UPDATE, DELETE (por Objeto)
    
    $producto = new Producto(NULL, 'Modelo PDO', 2000, 10);
    
    $stmt = $con->prepare('INSERT INTO PRODUCTO(codmarca, codcategoria, modelo, precio, stock, fecha) 
        VALUES(:codmarca, :codcategoria, :modelo, :precio, :stock, :fecha)');
    
    $stmt->execute((array)$producto);
    
    echo $con->lastInsertId(); 

}catch(PDOException $e){
    echo "ERROR: " . $e->getMessage();
}



?>
