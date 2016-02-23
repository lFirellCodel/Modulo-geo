<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title></title>


        <meta name="viewport" content="width=device-width, initial-scale=1">
        
        <!--<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>-->
        <script src="js/jquery-1.11.3.min.js" type="text/javascript"></script>
        <!--        Seccion de grafica-->
        
        
        <script src="lib/Highcharts-4.1.5/js/highcharts.js"></script>
        <script src="lib/Highcharts-4.1.5/js/modules/exporting.js"></script>
        <!-- Bootstrap -->
        <link href="https://fontastic.s3.amazonaws.com/S4oB3JzJncdU5ZEY34cesU/icons.css" rel="stylesheet">
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
        
        <!-- My custom style -->
        <link rel="stylesheet" href="style.css">
        
        <script>
            
        </script>
        <style type="text/css">
            #clientes-tabla{
                border: 1px solid cadetblue;
            }
        </style>
    </head>
    <body>
     
      
        <div class="container-fluid">
            <form method="GET" action="map.php" >
                <fieldset>
                    <legend>Registro de eventos</legend>

                    <div class="row">
                        <div class="form-group col-md-12">
                            <label>Nombre</label>
                            <input type="text" name="address" class="form-control" placeholder="Ingrese Evento">
                        </div>  
                    </div>
                    <button type="submit" class="btn btn-default" >Registrar</button>
                    
                </fieldset>
            </form>
            
            <h3>Lista de Eventos</h3>
            <div id="clientes-tabla">Cargando ...</div>
            
        </div>
   
         <?php require_once './include/footer.php';?>
    </body>
</html>



