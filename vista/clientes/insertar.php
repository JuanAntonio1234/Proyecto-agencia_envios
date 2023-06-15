<!DOCTYPE html>
<html>

<?php
include "../../componentes/head.php";
require "../../modelo/cliente.php";
?>

<body>
    <div class="container-fluid">
        <div class="jumbotron">
            <h1>Nuevo cliente: </h1>
            <br>

            <?php

            if (
                isset($_POST['dirección'])
                && isset($_POST['correo'])
                && isset($_POST['nombre'])
                && isset($_POST['apellidos'])
            ) {
                $dirección = $_POST['dirección'];
                $correo = $_POST['correo'];
                $nombre = $_POST['nombre'];
                $apellidos = $_POST['apellidos'];

                $cliente = new cliente();

                $cliente->setDirección($dirección);
                $cliente->setCorreo($correo);
                $cliente->setNombre($nombre);
                $cliente->setApellidos($apellidos);


                echo $cliente->insertarCliente();
            }

            ?>
            <form action="insertar.php" method="post">
                <div class="form-group">
                    <label>Dirección</label>
                    <input type="text" class="form-control" name="dirección" required>
                </div>

                <div class="form-group">
                    <label>Correo</label>
                    <input type="text" class="form-control" name="correo" required>
                </div>

                <div class="form-group">
                    <label>Nombre</label>
                    <input type="text" class="form-control" name="nombre" required>
                </div>

                <div class="form-group">
                    <label>Apellidos</label>
                    <input type="text" class="form-control" name="apellidos" required>
                </div>

                <button type="submit" class="btn btn-primary">Crear Cliente</button>
            </form>
            <br>
            <a href="../../index.php"><button>Volver al listado</button></a>
        </div>
    </div>
</body>

</html>