<?php

    require_once './config.php';

    ini_set('include_path', ini_get('include_path').';lib/phpexcel/');
    require_once 'PHPExcel.php';
    
    var_dump($_FILES);
    $archivo = $_FILES['documento']['tmp_name'];
    var_dump($archivo);
    die();

    $objReader = new PHPExcel_Reader_Excel2007();
    $objReader->setReadDataOnly(true);
    $objPHPExcel = $objReader->load($archivo);
    
    //Recuperamos la referencia a la hoja activada
    $objPHPExcel->setActiveSheetIndex(0);
    $objWorksheet = $objPHPExcel->getActiveSheet();

    $highestRow = $objWorksheet->getHighestRow(); // Ultima Fila 8 (desde indice 0)
    $highestColumn = $objWorksheet->getHighestColumn(); // Ultima columna D
    $highestColumnIndex = PHPExcel_Cell::columnIndexFromString($highestColumn);
    
    echo '<table border="1">';
    for ($row = 1; $row <= $highestRow; $row++) {
        echo '<tr>';
        for ($col = 0; $col < $highestColumnIndex; $col++) {

            $cell = $objWorksheet->getCellByColumnAndRow($col, $row);

            if ($cell->getDataType() == PHPExcel_Cell_DataType::TYPE_FORMULA)
                echo '<td>' . number_format($cell->getCalculatedValue(),2) . '</td>';
            else if ($cell->getDataType() == PHPExcel_Cell_DataType::TYPE_NUMERIC)
                echo '<td>' . number_format($cell->getValue(),2) . '</td>';
            else
                echo '<td>' . $cell->getValue() . '</td>';

        }
        echo '</tr>';
    }
    echo '</table>';
