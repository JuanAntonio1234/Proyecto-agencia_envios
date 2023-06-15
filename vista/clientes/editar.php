<!DOCTYPE html>
<html>

<?php
include "../../componentes/head.php";
require "../../modelo/cliente.php";
?>

<body>
    <div class="container-fluid">
        <div class="jumbotron">
            <h1>Editar Cliente: </h1>
            <br>

            <?php

            if (isset($_GET['direccion']) && !empty($_GET['direccion'])) {
                $direccionCliente = $_GET['direccion'];
                $clientes = new cliente();
                $cliente = $clientes->obtenerCliente($direccionCliente);             
            }

            if (
                isset($_POST['dirección'])
                && isset($_POST['correo'])
                && isset($_POST['nombre'])
                && isset($_POST['apellidos'])
            ) {
                $direccion = $_POST['dirección'];
                $correo = $_POST['correo'];
                $nombre = $_POST['nombre'];
                $apellidos = $_POST['apellidos'];

                $cliente = new cliente();
            
                $cliente->setDirección($direccion);
                $cliente->setCorreo($correo);
                $cliente->setNombre($nombre);
                $cliente->setApellidos($apellidos);

                echo $cliente->actualizarCliente();
            }


            ?>
            <div class="container-fluid">
                <form id="editarCliente" action="editar.php" method="post">

                <div class="form-group">
                        <label>Dirección</label>
                        <input type="text" class="form-control" name="dirección" value="<?php echo $cliente['dirección']; ?>" readonly>
                    </div>
                    
                    <div class="form-group">
                        <label>Correo</label>
                        <input type="text" class="form-control" name="correo" value="<?php echo $cliente['correo']; ?>" required>
                    </div>

                    <div class="form-group">
                        <label>Nombre</label>
                        <input type="text" class="form-control" name="nombre" value="<?php echo $cliente['nombre']; ?>" required>
                    </div>

                    <div class="form-group">
                        <label>Apellidos</label>
                        <input type="text" class="form-control" name="apellidos" value="<?php echo $cliente['apellidos']; ?>" required>
                    </div>

                    <button type="submit" class="btn btn-primary">Editar Cliente</button>
                </form>
                <br>
                <a href="../../index.php"><button>Volver al listado</button></a>
            </div>
        </div>
</body>

</html>