<!DOCTYPE html>
<html>
<?php
    include "../../componentes/head.php";
    require "../../modelo/productos.php";
?>

<body>
    <h1>Borrar Producto: </h1>
    <br>

    <?php

    if (isset($_GET['cod_producto']) && !empty($_GET['cod_producto'])) {
        $cod_producto = $_GET['cod_producto'];
        $producto = new productos();
        $producto->setCodigoProducto($cod_producto);
        echo $producto->eliminarProducto($cod_producto);
    }

    ?>
    <br>
    <a href="../../indexProductos.php"><button button class="btn btn-primary">Volver</button></a>

</body>