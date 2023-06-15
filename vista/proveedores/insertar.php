<!DOCTYPE html>
<html>

<?php
include "../../componentes/head.php";
require "../../modelo/proveedores.php";
?>

<body>
    <div class="container-fluid">
        <div class="jumbotron">
            <h1>Nuevo Proveedor: </h1>
            <br>

            <?php

            if (
                //añadir el cod_proveedor si no funciona. En principio no hace falta porque es autoincrement.
                isset($_POST['nombre_proveedor'])
                && isset($_POST['direccion'])
                && isset($_POST['ciudad'])
                && isset($_POST['estado'])
                && isset($_POST['pais'])
                && isset($_POST['codigo_postal'])
                && isset($_POST['telefono'])
            ) {
                $nombre_proveedor = $_POST['nombre_proveedor'];
                $direccion = $_POST['direccion'];
                $ciudad = $_POST['ciudad'];
                $estado = $_POST['estado'];
                $pais = $_POST['pais'];
                $codigo_postal = $_POST['codigo_postal'];
                $telefono = $_POST['telefono'];

                $proveedor = new proveedores();

                $proveedor->setNombreProveedor($nombre_proveedor);
                $proveedor->setDireccion($direccion);
                $proveedor->setCiudad($ciudad);
                $proveedor->setEstado($estado);
                $proveedor->setPais($pais);
                $proveedor->setCodigoPostal($codigo_postal);
                $proveedor->setTelefono($telefono);
                
                echo $proveedor->insertarProveedor();
            }

            ?>
            <form action="insertar.php" method="post">
                <div class="form-group">
                    <label>Nombre proveedor</label>
                    <input type="text" class="form-control" name="nombre_proveedor" required>
                </div>

                <div class="form-group">
                    <label>Direccion</label>
                    <input type="text" class="form-control" name="direccion" required>
                </div>

                <div class="form-group">
                    <label>Pais</label>
                    <input type="text" class="form-control" name="pais" required>
                </div>

                <div class="form-group">
                    <label>Ciudad</label>
                    <input type="text" class="form-control" name="ciudad" required>
                </div>

                <div class="form-group">
                    <label>Estado</label>
                    <input type="text" class="form-control" name="estado" required>
                </div>

                <div class="form-group">
                    <label>Código postal</label>
                    <input type="text" class="form-control" name="codigo_postal" required>
                </div>

                <div class="form-group">
                    <label>Telefono</label>
                    <input type="text" class="form-control" name="telefono" required>
                </div>

                <button type="submit" class="btn btn-primary">Crear Proveedor</button>
            </form>
            <br>
            <a href="../../indexProveedores.php"><button>Volver al listado</button></a>
        </div>
    </div>
</body>

</html>