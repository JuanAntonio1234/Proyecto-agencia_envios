<!DOCTYPE html>
<html>
<?php
    include "../../componentes/head.php";
    require "../../modelo/cliente.php";
?>

<body>
    <h1>Borrar Cliente: </h1>
    <br>

    <?php

    if (isset($_GET['direccion']) && !empty($_GET['direccion'])) {
        $dirección = $_GET['direccion'];
        $cliente = new cliente();
        echo $cliente->eliminarCliente($dirección);
    }

    ?>
    <br>
    <a href="../../index.php"><button button class="btn btn-primary">Volver al Listado</button></a>

</body>

</html>