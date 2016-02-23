<?php

    require_once './config.php';

   
    //var_dump($usuarios);

    ini_set('include_path', ini_get('include_path').';lib/phpexcel/');
    require_once 'PHPExcel.php';
    require_once 'PHPExcel/Writer/Excel2007.php';

    $objPHPExcel = new PHPExcel();
    //var_dump($objPHPExcel);

    //Activamos y seleccionamos la Hoja1
    $objPHPExcel->setActiveSheetIndex(0);
    $objWorksheet = $objPHPExcel->getActiveSheet();
    
    $objWorksheet->setTitle('Usuarios');
    
    //Insertar logo
    $objDrawing = new PHPExcel_Worksheet_Drawing();
    $objDrawing->setName('Logo Tecsup');
    $objDrawing->setPath('logo.png');
    $objDrawing->setCoordinates('A1');
    $objDrawing->setWorksheet($objWorksheet);
    
    //Introducimos encabezados
    $objWorksheet->SetCellValue('A5', 'ID');
    $objWorksheet->SetCellValue('B5', 'Usuario');
    $objWorksheet->SetCellValue('C5', 'Nombre');
    $objWorksheet->SetCellValue('D5', 'Email');
    
    // Inseratr la data
    $row = 0;
    foreach ($usuarios as $i => $usuario){
        $objWorksheet->getCellByColumnAndRow(0, $i + 6)->setValue($usuario->id);
        $objWorksheet->getCellByColumnAndRow(1, $i + 6)->setValue($usuario->username);
        $objWorksheet->getCellByColumnAndRow(2, $i + 6)->setValue($usuario->nombres);
        $objWorksheet->getCellByColumnAndRow(3, $i + 6)->setValue($usuario->email);
        $row = $i + 6;
    }
    var_dump($usuario);
    //Definimos el ancho de las columnas
    $objWorksheet->getColumnDimension('A')->setAutoSize(true);
    $objWorksheet->getColumnDimension('B')->setAutoSize(true);
    $objWorksheet->getColumnDimension('C')->setAutoSize(true);
    $objWorksheet->getColumnDimension('D')->setAutoSize(true);
    
    //Definimos un estilo para el fondo del logo
    $logoStyle = $objWorksheet->getStyle('A1:D4');
    //Definimos el relleno
    $logoStyle->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID)->getStartColor()->setARGB(PHPExcel_Style_Color::COLOR_DARKBLUE);
    
    //Definimos un estilo para el encabezado
    $headStyle = $objWorksheet->getStyle('A5:D5');
    //Definimos el relleno
    $headStyle->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID)->getStartColor()->setARGB(PHPExcel_Style_Color::COLOR_BLACK);
    //Definimos la fuente
    $headStyle->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_WHITE);
    //Definimos el alineamiento
    $headStyle->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
    
    //Definimos un estilo para la data
    $dataStyle = $objWorksheet->getStyle('A6:D'.$row);
    $dataStyle->getBorders()->getAllBorders()->setBorderStyle(PHPExcel_Style_Border::BORDER_THIN);
    
    
    //Definimos el Writer
    $objWriter = new PHPExcel_Writer_Excel2007($objPHPExcel);
    $objWriter->save('usuarios.xlsx');
    header("Location: usuarios.xlsx");