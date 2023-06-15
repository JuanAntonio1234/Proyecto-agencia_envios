<!DOCTYPE html>
<html lang="es">

    <?php
    include "componentes/head.php";
    require "modelo/proveedores.php";
    ?>

    <body>
        <div class="container-fluid">
            <div class="jumbotron">
                <h1>Listado de Proveedores: </h1>
                <br>
                <table class='table table-striped'>
                    <thead>

                        <tr>
                            <th>Código de proveedor</th>
                            <th>Nombre de proveedor</th>
                            <th>Dirección</th>
                            <th>País</th>
                            <th>Estado</th>
                            <th>Ciudad</th>
                            <th>Código postal</th>
                            <th>Teléfono</th>
                        </tr>

                    </thead>
                    <tbody>
                        <?php

                        $proveedores = new proveedores();
                        $listadoProveedores = $proveedores->obtenerListadoProveedores();

                        foreach ($listadoProveedores as $proveedor) {
                            echo "<tr>
                    <th>" . $proveedor->getCodigoProveedor() . "</th>
                    <th>" . $proveedor->getNombreProveedor() . "</th>
                    <th>" . $proveedor->getDireccion() . "</th>
                    <th>" . $proveedor->getCiudad() . "</th>
                    <th>" . $proveedor->getEstado() . "</th>
                    <th>" . $proveedor->getPais() . "</th>
                    <th>" . $proveedor->getCodigoPostal() . "</th>
                    <th>" . $proveedor->getTelefono() . "</th>
                    <th>
                        <a href=vista/productos/insertar.php?cod_proveedor=" . urlencode($proveedor->getCodigoProveedor()) . "><button>Añadir producto</button></a>
                        <a href=vista/proveedores/borrar.php?cod_proveedor=" . urlencode($proveedor->getCodigoProveedor()) . "><button>Borrar</button></a>
                        <a href=vista/proveedores/editar.php?cod_proveedor=" . urlencode($proveedor->getCodigoProveedor()) . "><button>Editar</button></a>
                    </th>
                </tr>";
                        }
                        ?>
                    </tbody>
                </table>

                <br>
                <a href="vista/proveedores/insertar.php"><button class="btn btn-primary">Nuevo Proveedor</button></a>
                <a href="index.php"><button class="btn btn-primary">Clientes</button></a>
                <a href="indexProductos.php"><button class="btn btn-primary">Productos</button></a>
            </div>
        </div>
    </body>

</html>