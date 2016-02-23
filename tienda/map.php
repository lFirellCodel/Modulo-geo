<?php
require_once './config.php';



if( isset($_GET['address']) ){
    $city = $_GET['address'];

}


function lookup($string){
 
   $string = str_replace (" ", "+", $string);
   $details_url = "http://maps.googleapis.com/maps/api/geocode/json?address=".$string."&sensor=false";
 
   $ch = curl_init();
   curl_setopt($ch, CURLOPT_URL, $details_url);
   curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
   $response = json_decode(curl_exec($ch), true);
 
   // If Status Code is ZERO_RESULTS, OVER_QUERY_LIMIT, REQUEST_DENIED or INVALID_REQUEST
   if ($response['status'] != 'OK') {
    return null;
   }
 
   //print_r($response);
   $geometry = $response['results'][0]['geometry'];
 
    $longitude = $geometry['location']['lat'];
    $latitude = $geometry['location']['lng'];
        
    $array = array(
        'lat' => $geometry['location']['lat'],
        'lng' => $geometry['location']['lng'],
        
        
    );
 
    return $array;
 
}
 

echo '<br/>';
echo '<br/>';

$array = lookup($city);
var_dump($array["lat"]);
var_dump($array["lng"]);


$lat = $array["lat"];
$lng = $array["lng"];


$mapa = new Mapa();

$mapa->lat = $lat;
$mapa->lng = $lng;

try{
    
    MapaDAO::registrar($mapa);
    
    $mensaje = array('type' => 'success', 'message' => 'Registro satisfactorio');
    echo json_encode($mensaje);
    
} catch (Exception $e){
    $mensaje = array('type' => 'error', 'message' => $e->getMessage());
    echo json_encode($mensaje);
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
        <style type="text/css">
        html, body { height: 100%; margin: 0; padding: 0; }
        #map { height: 100%; }
      </style>
	<script type="text/javascript">
            
        

	</script>
</head>
<body>
 
<section class="hola">	
 instrucciones: escribe en el cuadro de busqueda
 y asi obtendras tu beca !!! acuñalover      !!             
</section> 
   

    
    
<div id="map"></div>  

      
<!--<form action="map.php" method="GET">

 <input type="text" name="address" />
 <input type="submit" value="enviar" />

</form>-->


    <script type="text/javascript">
        
        <?php $array = lookup($city); 
              $lat   = $array['lat'];
              $lng   = $array['lng'];
        ?>

var map;
function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: { lat: <?php echo $lat; ?> , lng : <?php echo $lng; ?> },
    zoom: 8
  });
}

    </script>
    <script async defer
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCNOZ7J-A291CKxSnio8FC8yBWi574ko7A&callback=initMap">
    </script>   
    
</body>
</html>
