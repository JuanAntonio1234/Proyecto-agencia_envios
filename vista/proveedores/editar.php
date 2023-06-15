<!DOCTYPE html>
<html>

<?php
include "../../componentes/head.php";
require "../../modelo/proveedores.php";
?>

<body>
    <div class="container-fluid">
        <div class="jumbotron">
            <h1>Editar Proveedor: </h1>
            <br>

            <?php

            if (isset($_GET['cod_proveedor']) && !empty($_GET['cod_proveedor'])) {
                $cod_proveedor = $_GET['cod_proveedor'];
                $proveedores = new proveedores();
                $proveedor = $proveedores->obtenerProveedor($cod_proveedor);             
            }


            if (
                isset($_POST['nombre_proveedor'])
                && isset($_POST['codigo_proveedor'])
                && isset($_POST['direccion'])
                && isset($_POST['ciudad'])
                && isset($_POST['estado'])
                && isset($_POST['pais'])
                && isset($_POST['codigo_postal'])
                && isset($_POST['telefono'])
            ) {
                
                $codigo_proveedor = $_POST['codigo_proveedor'];
                $nombre_proveedor = $_POST['nombre_proveedor'];
                $direccion = $_POST['direccion'];
                $ciudad = $_POST['ciudad'];
                $estado = $_POST['estado'];
                $pais = $_POST['pais'];
                $codigo_postal = $_POST['codigo_postal'];
                $telefono = $_POST['telefono'];


                $proveedor = new proveedores();
                
                $proveedor->setCodigoProveedor($codigo_proveedor);
                $proveedor->setNombreProveedor($nombre_proveedor);
                $proveedor->setDireccion($direccion);
                $proveedor->setCiudad($ciudad);
                $proveedor->setEstado($estado);
                $proveedor->setPais($pais);
                $proveedor->setCodigoPostal($codigo_postal);
                $proveedor->setTelefono($telefono);


                echo $proveedor->actualizarProveedor();
            }

            ?>
            <div class="container-fluid">
                <form id="editarProveedor" action="editar.php" method="post">

                <div class="form-group">
                        <label>Código de proveedor</label>
                        <input type="text" class="form-control" name="codigo_proveedor" value="<?php echo $proveedor['cod_proveedor']; ?>" readonly>
                    </div>    

                    <div class="form-group">
                        <label>Nombre de proveedor</label>
                        <input type="text" class="form-control" name="nombre_proveedor" value="<?php echo $proveedor['nombre_proveedor']; ?>" required>
                    </div>

                    <div class="form-group">
                        <label>Dirección</label>
                        <input type="text" class="form-control" name="direccion" value="<?php echo $proveedor['direccion']; ?>" required>
                    </div>

                    <div class="form-group">
                        <label>País</label>
                        <input type="text" class="form-control" name="pais" value="<?php echo $proveedor['pais']; ?>" required>
                    </div>

                    <div class="form-group">
                        <label>Estado</label>
                        <input type="text" class="form-control" name="estado" value="<?php echo $proveedor['estado']; ?>" required>
                    </div>

                    <div class="form-group">
                        <label>Ciudad</label>
                        <input type="text" class="form-control" name="ciudad" value="<?php echo $proveedor['ciudad']; ?>" required>
                    </div>

                    <div class="form-group">
                        <label>Código postal</label>
                        <input type="text" class="form-control" name="codigo_postal" value="<?php echo $proveedor['codigo_postal']; ?>" required>
                    </div>

                    <div class="form-group">
                        <label>Teléfono</label>
                        <input type="text" class="form-control" name="telefono" value="<?php echo $proveedor['telefono']; ?>" required>
                    </div>


                    <button type="submit" class="btn btn-primary">Editar Proveedor</button>
                </form>
                <br>
                <a href="../../indexProveedores.php"><button>Volver al listado</button></a>
            </div>
        </div>
</body>

</html>