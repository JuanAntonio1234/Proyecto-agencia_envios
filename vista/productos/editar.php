<!DOCTYPE html>
<html>

<?php
include "../../componentes/head.php";
require "../../modelo/productos.php";
?>

<body>
    <div class="container-fluid">
        <div class="jumbotron">
            <h1>Editar Producto: </h1>
            <br>

            <?php

            if (isset($_GET['cod_producto']) && !empty($_GET['cod_producto'])) {
                $cod_producto = $_GET['cod_producto'];
                $productos = new productos();
                $productos->setCodigoProducto($cod_producto);
                $producto = $productos->obtenerProducto($cod_producto);             
            }

            if (
                isset($_POST['cod_producto'])
                && isset($_POST['estado'])
                && isset($_POST['proveedor'])
            ) {
                $cod_producto = $_POST['cod_producto'];
                $estado = $_POST['estado'];
                $proveedor = $_POST['proveedor'];


                $producto = new productos();
                
                $producto->setCodigoProducto($cod_producto);
                $producto->setEstado($estado);
                $producto->setProveedor($proveedor);


                echo $producto->actualizarProducto();
            }

            ?>
            <div class="container-fluid">
                <form id="editarProducto" action="editar.php" method="post">

                <div class="form-group">
                        <label>Código de producto</label>
                        <input type="text" class="form-control" name="cod_producto" value="<?php echo $producto['cod_producto']; ?>" readonly>
                    </div>

                     <div class="form-group">
                        <label>Proveedor</label>
                        <input type="text" class="form-control" name="proveedor" value="<?php echo $producto['proveedor']; ?>" readonly>
                    </div>
                    
                    <div class="form-group">
                        <label>Estado</label>
                        <input type="text" class="form-control" name="estado" value="<?php echo $producto['estado']; ?>" required>
                    </div>

                   



                    <button type="submit" class="btn btn-primary">Editar producto</button>
                </form>
                <br>
                <a href="../../indexProductos.php"><button>Volver al listado</button></a>
            </div>
        </div>
</body>

</html>