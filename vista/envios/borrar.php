<!DOCTYPE html>
<html>
<?php
    include "../../componentes/head.php";
    require "../../modelo/envios.php";
?>

<body>
    <h1>Borrar Envío: </h1>
    <br>

    <?php

    if (isset($_GET['cod_envio']) && !empty($_GET['cod_envio'])) {
        $codEnvio = $_GET['cod_envio'];
        $envio = new envios();
        echo $envio->eliminarEnvio($codEnvio);
    }


    ?>
    <br>
    <a href="../../indexEnvios.php"><button button class="btn btn-primary">Volver</button></a>

</body>

</html>