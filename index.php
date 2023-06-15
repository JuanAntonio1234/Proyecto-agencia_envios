<!DOCTYPE html>
<html lang="es">

    <?php
    include "componentes/head.php";
    require "modelo/cliente.php";
    ?>

    <body>
        <div class="container-fluid">
            <div class="jumbotron">
                <h1>Listado de Clientes: </h1>
                <br>
                <table class='table table-striped'>
                    <thead>
                        <tr>
                            <th>Dirección</th>
                            <th>Correo</th>
                            <th>Nombre</th>
                            <th>Apellidos</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php

                        $clientes = new cliente();
                        $listadoClientes = $clientes->obtenerListadoClientes();

                        foreach ($listadoClientes as $cliente) {
                            echo "<tr>
                        <th>" . $cliente->getDireccion() . "</th>
                        <th>" . $cliente->getCorreo() . "</th>
                        <th>" . $cliente->getNombre() . "</th>
                        <th>" . $cliente->getApellidos() . "</th>
                        <th>
                        <a href=vista/envios/insertar.php?direccion=" . urlencode($cliente->getDireccion()) . "><button>Añadir envío</button></a>
                        <a href=vista/clientes/borrar.php?direccion=" . urlencode($cliente->getDireccion()) . "><button>Borrar</button></a>
                        <a href=vista/clientes/editar.php?direccion=" . urlencode($cliente->getDireccion()) . "><button>Editar</button></a>
                    </th>
                </tr>";
                        }
                        ?>
                    </tbody>
                </table>

                <br>
                <a href="vista/clientes/insertar.php"><button class="btn btn-primary">Nuevo Cliente</button></a>
                <a href="indexEnvios.php"><button class="btn btn-primary">Envios</button></a>
                <a href="indexProveedores.php"><button class="btn btn-primary">Proveedores</button></a>
            </div>
        </div>
    </body>

</html>