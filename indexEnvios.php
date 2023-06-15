<!DOCTYPE html>
<html lang="es">

    <?php
    include "componentes/head.php";
    require "modelo/envios.php";
    ?>

    <body>
        <div class="container-fluid">
            <div class="jumbotron">
                <h1>Listado de Envíos: </h1>
                <br>
                <table class='table table-striped'>
                    <thead>
                        <tr>
                            <th>Código de envío</th>
                            <th>Dirección</th>
                            <th>Estado</th>
                            <th>Operaciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php

                        $envios = new envios();
                        $listadoEnvios = $envios->obtenerListadoEnvios();
                        
                        foreach ($listadoEnvios as $envio) {
                            echo "<tr>
                    <th>" . $envio->getCodEnvio() . "</th>
                    <th>" . $envio->getDireccion() . "</th>
                    <th>" . $envio->getEstado() . "</th>
                    <th>
                        <a href=vista/envios/borrar.php?cod_envio=" . urlencode($envio->getCodEnvio()) . "><button>Borrar</button></a>
                        <a href=vista/envios/editar.php?cod_envio=" . urlencode($envio->getCodEnvio()) . "><button>Editar</button></a>
                    </th>
                </tr>";
                        }
                        ?>
                    </tbody>
                </table>

                <br>
                <a href="index.php"><button class="btn btn-primary">Clientes</button></a>
            </div>
        </div>
    </body>

</html>