<!DOCTYPE html>
<html>
<?php
    include "../../componentes/head.php";
    require "../../modelo/proveedores.php";
?>

<body>
    <h1>Borrar Proveedor: </h1>
    <br>

    <?php

    if (isset($_GET['cod_proveedor']) && !empty($_GET['cod_proveedor'])) {
        $codProveedor = $_GET['cod_proveedor'];
        $proveedor = new proveedores();
        echo $proveedor->eliminarProveedor($codProveedor);
    }

    ?>
    <br>
    <a href="../../indexProveedores.php"><button button class="btn btn-primary">Volver</button></a>

</body>

</html>