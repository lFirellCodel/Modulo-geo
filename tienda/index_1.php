<?php
require_once './config.php';
?>

<!DOCTYPE html>
<html lang="es">
<head>
  
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <title>UBICANOS</title>
    <script src="//code.jquery.com/jquery-1.12.0.min.js"></script>
    
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
     <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
    <style>
    body{
        font-family:arial;
        font-size:.8em;
    }
     
    input[type=text]{
        padding:0.5em;
        width:20em;
    }
     
    input[type=submit]{
        padding:0.4em;
    }
     
    #gmap_canvas{
        width:100%;
        height:30em;
    }
     
    #map-label,
    #address-examples{
        margin:1em 0;
    }
    
    
    #clientes-tabla{
          border: 1px solid cadetblue;
    }
        </style>
    </style>
    <script>
         $(function(){
             listar();
         });
        
        function listar(){
                $('#mapa-tabla').load('mapa-listar.php');
            }
        
        function registrar_mapa(){
                var lat = $("#mapita").attr("data-lat");
                var lng = $("#mapita").attr("data-lng");
                var direc = $("#mapita").attr("data-direc");
                var edif = $("#mapita").attr("data-edif");
           
//                  console.log(lat)
//                  console.log(lng)
//                console.log(nombres)
//                console.log(apellidos)

                $.post('mapa-registrar.php', {
                    'lat': lat,
                    'lng': lng,
                    'direc': direc,
                    'edif':edif
                    
                }, function(data){
                    console.log(data)
                    
                   if(data.type == 'error'){
                       $('#flash').addClass('error');
                   }else{
                       $('#flash').removeClass('error');
                   }
                    
                    $('#flash p').text(data.message);
                    $('#flash').fadeIn(); 
                    
                 
                    
                }, 'json');
                
                listar(); 
            } 
            
           
         
            function update_mapa(id) {
                var lat = $("#"+id).attr("data-lat");
                var lng = $("#"+id).attr("data-lng"); 
                var direc = $("#"+id).attr("data-direc");
                var edif = $("#"+id).attr("data-edif");
                
               
             $.post('mapa-editar.php', {
                    'id': id,
                    'lat': lat,
                    'lng': lng,
                    'direc': direc,
                    'edif':edif
                    
                }, function(data){
                    console.log(data)
                    
                   if(data.type == 'error'){
                       $('#flash').addClass('error');
                   }else{
                       $('#flash').removeClass('error');
                   }
                    
                    $('#flash p').text(data.message);
                    $('#flash').fadeIn(); 
                    
                }, 'json');
                
   
            } 
       
        
        function eliminar(id){
                
                if(confirm('¿Realmente desea eliminar?')){
                    $.post('mapa-eliminar.php', {'id': id}, function(data){
                        
                        if(data.type == 'error'){
                            $('#flash').addClass('error');
                        }else{
                            $('#flash').removeClass('error');
                        }

                         $('#flash p').text(data.message);
                         $('#flash').fadeIn(); 
                        
                        listar();
                        
                    }, 'json');
                }
                
            }
            
            function obtener(id){
                
                 var j = jQuery.noConflict();

                j('#myModal').modal('show');  
                
                 $.post('mapa-obtener.php',{
                     'id': id
                 }, function(data){
                    console.log(data)
                    
//                   if(data.type == 'error'){
//                       $('#flash').addClass('error');
//                   }else{
//                       $('#flash').removeClass('error');
//                   }
//                    
//                    $('#flash p').text(data.message);
//                    $('#flash').fadeIn(); 
                    
//                    listar();
                        $('#myModal').html(data);

                }, 'html');
            }
    
    </script>
</head>
<body>

<?php
if($_POST){
    $edificio = $_POST['nom_edif'];
    // get latitude, longitude and formatted address
    $data_arr = geocode($_POST['address']);
 
    // if able to geocode the address
    if($data_arr){
         
        $latitude = $data_arr[0];
        $longitude = $data_arr[1];
        $formatted_address = $data_arr[2];
    ?>
 
    <!-- google map will be shown here -->
    <div id="gmap_canvas">Loading map...</div>
    <div id="mapa-tabla">Cargando ...</div> 
    <div id='map-label'>Verifique su locacion</div>
 
    <!-- JavaScript to show google map -->
    <script type="text/javascript" src="http://maps.google.com/maps/api/js"></script>    
    <script type="text/javascript">
        
        function init_map() {
             
            var latlng = new google.maps.LatLng(<?php echo $latitude; ?>, <?php echo $longitude; ?>);
            var myOptions = {
                zoom: 14,
                center: latlng,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            map = new google.maps.Map(document.getElementById("gmap_canvas"), myOptions);
            
            marker = new google.maps.Marker({
                map: map,
                position: latlng ,              
                draggable:true,
            });
            google.maps.event.addListener(marker, 'dragend', function(marker){
                
            
                
            var latLng = marker.latLng;
            
            var lat = latLng.lat();
            var lng = latLng.lng();
            $("#mapita").attr('data-lat', lat);
            $("#mapita").attr('data-lng', lng);
	             
	    });
		
            infowindow = new google.maps.InfoWindow({
                content: "<?php echo $formatted_address; ?>"
            });
            google.maps.event.addListener(marker, "click", function () {
                infowindow.open(map, marker);
            });
            infowindow.open(map, marker);
        }
        google.maps.event.addDomListener(window, 'load', init_map);
        
      
       
    </script>
 
    <?php
 
    // if unable to geocode the address
    }else{
        echo "No map found.";
    }
}
?>
    
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"> 
      <!-- enter any address -->
<form id="form1" class="form-group" action="" method="post">
    <input type='text' name='address' class="form-control" placeholder='ingrese direccion' />
<!--    <input type="text" name="nom_edif" class="form-control" placeholder="ingrese edificio">-->
    <select name="nom_edif" id="nom_edif " class="form-control" >
          <option value="oficina">Oficina Principal</option>
          <option value="itaca">Itaca</option>
          <option value="mykonos">Mykonos</option>
          <option value="milos">Milos</option>
          <option value="ikaria">Ikaria</option>
          <option value="mythos">Mythos</option>
        </select>
    <input class="btn btn-primary" type='submit' value='enviar'/>
</form>
  <button id="mapita" type="submit" class="btn btn-danger" onclick="registrar_mapa()" data-lat="<?php echo $data_arr[0]; ?>" data-lng="<?php echo $data_arr[1]; ?>" data-direc="<?php echo $data_arr[2]; ?> " data-edif="<?php echo $edificio;?>" >Registrar</button>    
    </div>

<!-- enter any address -->
<form id="form1" class="form-group" action="" method="post">
    <input type='text' name='address' class="form-control" placeholder='ingrese direccion' />
<!--    <input type="text" name="nom_edif" class="form-control" placeholder="ingrese edificio">-->
    <select name="nom_edif" id="nom_edif " class="form-control" >
          <option value="oficina">Oficina Principal</option>
          <option value="itaca">Itaca</option>
          <option value="mykonos">Mykonos</option>
          <option value="milos">Milos</option>
          <option value="ikaria">Ikaria</option>
          <option value="mythos">Mythos</option>
        </select>
    <input class="btn btn-primary" type='submit' value='enviar'/>
</form>


<button id="mapita" type="submit" class="btn btn-danger" onclick="registrar_mapa()" data-lat="<?php echo $data_arr[0]; ?>" data-lng="<?php echo $data_arr[1]; ?>" data-direc="<?php echo $data_arr[2]; ?> " data-edif="<?php echo $edificio;?>" >Registrar</button>
<?php
// function to geocode address, it will return false if unable to geocode address


function geocode($address){
 
    // url encode the address
    $address = urlencode($address);
     
    // google map geocode api url
    $url = "http://maps.google.com/maps/api/geocode/json?address={$address}";
 
    // get the json response
    $resp_json = file_get_contents($url);
     
    // decode the json
    $resp = json_decode($resp_json, true);
   ;
    // response status will be 'OK', if able to geocode given address 
    if($resp['status']=='OK'){
 
        // get the important data
        $lati = $resp['results'][0]['geometry']['location']['lat'];
        $longi = $resp['results'][0]['geometry']['location']['lng'];
        $formatted_address = $resp['results'][0]['formatted_address'];
         
        // verify if data is complete
        if($lati && $longi && $formatted_address){
         
            // put the data in the array
            $data_arr = array();            
             
            array_push(
                $data_arr, 
                    $lati, 
                    $longi, 
                    $formatted_address
                );
             
            return $data_arr;
             
        }else{
            return false;
        }
         
    }else{
        return false;
    }
}

?>
 
</body>
 
</html>
