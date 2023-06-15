<!DOCTYPE html>
<html>

<?php
include "../../componentes/head.php";
require "../../modelo/productos.php";
?>

<body>
    <div class="container-fluid">
        <div class="jumbotron">
            <h1>Crear Producto </h1>
            <br>

            <?php
            if (isset($_GET['cod_proveedor']) && !empty($_GET['cod_proveedor'])) {
                $cod_proveedor = $_GET['cod_proveedor'];
                require_once "../../modelo/proveedores.php";

                $cod_proveedor = $_GET['cod_proveedor'];
                $proveedores = new proveedores();
                $proveedor = $proveedores->obtenerProveedor($cod_proveedor);             
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

                echo $producto->insertarProducto();
            }


            ?>

           <form action="insertar.php" method="post">
                    
                <div class="form-group">
                    <label>Proveedor</label>
                    <input type="text" class="form-control" name="proveedor" value="<?php echo $proveedor['cod_proveedor']; ?>" readonly>
                </div>

                <div class="form-group">
                    <label>Estado</label>
                    <input type="text" class="form-control" name="estado" required>
                </div>

                <div class="form-group">
                    <label>Código producto</label>
                    <input type="text" class="form-control" name="cod_producto" required>
                </div>

                <button type="submit" class="btn btn-primary">Crear Producto</button>

            </form>
                <br>
                <a href="../../indexProveedores.php"><button>Volver al listado</button></a>
            </div>
        </div>
</body>

</html>