<!DOCTYPE html>
<html lang="es">

    <?php
    include "componentes/head.php";
    require "modelo/productos.php";
    ?>

    <body>
        <div class="container-fluid">
            <div class="jumbotron">
                <h1>Listado de Productos: </h1>
                <br>
                <table class='table table-striped'>
                    <thead>
                        <tr>
                            <th>Código de producto</th>
                            <th>Estado</th>
                            <th>Proveedor</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php

                        $productos = new productos();
                        $listadoProductos = $productos->obtenerListadoProductos();

                        foreach ($listadoProductos as $producto) {
                            echo "<tr>
                    <th>" . $producto->getCodigoProducto() . "</th>
                    <th>" . $producto->getEstado() . "</th>
                    <th>" . $producto->getProveedor() . "</th>
                    <th>
                        <a href=vista/productos/borrar.php?cod_producto=" . urlencode($producto->getCodigoProducto()) . "><button>Borrar</button></a>
                        <a href=vista/productos/editar.php?cod_producto=" . urlencode($producto->getCodigoProducto()) . "><button>Editar</button></a>
                    </th>
                </tr>";
                        }

                        ?>
                    </tbody>
                </table>

                <br>
                <a href="indexProveedores.php"><button class="btn btn-primary">Proveedores</button></a>
            </div>
        </div>
    </body>

</html>