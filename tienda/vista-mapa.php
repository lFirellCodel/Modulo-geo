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

<!-- JavaScript to show google map -->
<script type="text/javascript" src="http://maps.google.com/maps/api/js"></script> 

<script type="text/javascript">
    
    function init_map($latitude,$longitude,$formatted_address) {
             
        var latlng = new google.maps.LatLng($latitude,$longitude);
        var myOptions = {
                zoom: 14,
                center: latlng,
                mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        
        map = new google.maps.Map(document.getElementById("gmap_canvas"), myOptions);
            
        marker = new google.maps.Marker({
            map      : map,
            position : latlng ,              
            draggable:true,
        });

        var infowindow = new google.maps.InfoWindow({
            content: $formatted_address
        });

        infowindow.open(map, marker);

        //
        google.maps.event.addListener(marker, 'dragend', function(marker){

            var latLng = marker.latLng;
            
            var lat = latLng.lat();
            var lng = latLng.lng();

            // get geoposition
            var geocoder = new google.maps.Geocoder();

            geocoder.geocode({
                latLng:  latLng 
            }, function(responses) {
                var address = (responses[0].formatted_address);

                infowindow.setContent(address);

                j("#edit_address").val('');
                j("#edit_address").val(address);

                //cambiar id de boton de actualizar
                j('#btn_update-map')
                    .attr('data-lat',lat)
                    .attr('data-lng',lng)
                    .attr('data-direccion',address);
            });
        });
    }

</script>


<!-- Todas las funciones CRUD -->
<script type="text/javascript"> 

    function listar(){
        $('#mapa-tabla').load('mapa-listar.php');
    }

    function registrar_mapa(){
        var lat = $("#mapita2").attr("data-lat");
        var lng = $("#mapita2").attr("data-lng");
        var direc = $("#mapita2").attr("data-direc");
        var edif = $("#mapita2").attr("data-edif");

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


    function update_mapa(){

        var j = jQuery.noConflict();    

        var id   = j('#btn_update-map').attr("data-id");
        var lat   = j('#btn_update-map').attr("data-lat");
        var lng   = j('#btn_update-map').attr("data-lng");
        var direc = j('#btn_update-map').attr("data-direccion");
        var edif  = j('#btn_update-map').attr("data-edificio");

        console.log(lat,id,lng,direc,edif);

        j.post('mapa-editar.php', {
            'id'   : id,
            'lat'  : lat,
            'lng'  : lng,
            'direc': direc,
            'edif' : edif

        }, function(data){

            console.log(data);

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

    //funcion obtener datos a partir de id
    function obtener(id){
        var j = jQuery.noConflict();

        j('.js-editForm').slideUp();

        j.post('mapa-obtener.php',{
            'id': id
        }, function(data){

            var contenido = data['content'][0];
            var lat       = contenido['lat'];
            var lng       = contenido['lng'];
            var direccion = contenido['direc'];
            var edificio  = contenido['edif'];

            console.log(direccion + " " + edificio );

            //introducir las variables en el formulario
            j('#edit_address').val(direccion);
            j('#edit_edif').val(edificio);
            j('#edit_edif').change(edificio);


            //mostrar formulario
            j('.js-editForm').slideDown();

            //cambiar mapa
            init_map(lat,lng,direccion);

            //cambiar id de boton de actualizar
            j('#btn_update-map')
                .attr('data-id',contenido['id'])
                .attr('data-lat',lat)
                .attr('data-lng',lng)
                .attr('data-direccion',direccion)
                .attr('data-edificio',edificio);

        }, 'json' );
    }

    //llamar a la funcion listar 
    //listar();

</script>


<script>
    var j = jQuery.noConflict();

    j(document).on('change', '#edit_edif', function () {

        var edificio = j('#edit_edif').val();

       j('#btn_update-map').attr('data-edificio',edificio);

    });

    

</script>

</head>

<body>

<?php

if($_POST){

    $edificio = !empty( $_POST['nom_edif'] ) ? $_POST['nom_edif'] : '' ;
    // get latitude, longitude and formatted address
    $address = !empty($_POST['address'] ) ? $_POST['address'] : '' ;

    $data_arr = geocode($address);
 
    // if able to geocode the address
    if($data_arr){

         
        $latitude          = $data_arr[0];
        $longitude         = $data_arr[1];
        $formatted_address = $data_arr[2];
    ?>
 
    <!-- google map will be shown here -->
    <div id="gmap_canvas" style="width: 100%; height: 200px">Loading map...</div>
    <!--div id="mapa-tabla">Cargando ...</div> 
    <div id='map-label'>Verifique su locacion</div-->
 
       
    <script type="text/javascript">


        google.maps.event.addDomListener(window, 'load', init_map(<?= $latitude ?>,<?= $longitude ?>,<?= "'".$formatted_address."'" ?>) );
       
    </script>


 
    <?php
 
    // if unable to geocode the address
    }else{
        echo "No map found.";
    }
}

    //incluir archivo listar 
    include_once 'mapa-listar.php';
?>


<div id="update"></div>


<!-- Este es el formulario para editar cualquier mapa por id de registro  -->
<section class="js-editForm col-xs-4" style="display: none;">
    <h2 class="text-capitalize text-warning text-medium">Editar Mapa</h2>

    <form action="" method="post">
        <div class="form-group">
            <label for="direction">Editar Direccion:</label>
            <input type="text" id="edit_address" class="form-control" required placeholder="Ingresar direccion" />
        </div>
        <div class="form-group">
            <label for="edit_edif">Editar Oficina:</label>
            <select name="edit_edif" id="edit_edif" class="form-control">
                <option value="oficina">Oficina Principal</option>
                <option value="itaca">Itaca</option>
                <option value="mykonos">Mykonos</option>
                <option value="milos">Milos</option>
                <option value="ikaria">Ikaria</option>
                <option value="mythos">Mythos</option>
            </select>  
        </div>
    </form>

    <button id="btn_update-map" data-id="" data-lat="" data-lng="" data-direccion="" data-edificio="" class="btn btn-success" onclick="update_mapa()" >ActualizarbyJeremy</button>

</section>



<!-- ESTE ES EL FORMULARIO PARA INGRESAR LA DIRECCION POR PRIMERA VEZ -->
<div id="mp" class="col-xs-4">
     <h2 class="text-capitalize text-info text-medium">Nuevo Mapa</h2>

    <!-- enter any address -->
    <form id="form1" class="form-group" action="" method="post">

        <input  type='text' name='address' class="form-control" placeholder='ingrese direccion' required />

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

    <button id="btn-update" type="submit" class="btn btn-danger" onclick="registrar_mapa()" data-lat="<?php echo $data_arr[0]; ?>" data-lng="<?php echo $data_arr[1]; ?>" data-direc="<?php echo $data_arr[2]; ?> " data-edif="<?php echo $edificio;?>" >Registrar</button>

     
</div> <!-- /end mp -->




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
