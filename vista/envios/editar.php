<!DOCTYPE html>
<html>

<?php
include "../../componentes/head.php";
require "../../modelo/envios.php";
?>

<body>
    <div class="container-fluid">
        <div class="jumbotron">
            <h1>Editar Envío: </h1>
            <br>

            <?php

            if (isset($_GET['cod_envio']) && !empty($_GET['cod_envio'])) {
                $cod_envio = $_GET['cod_envio'];
                $envios = new envios();
                $envio = $envios->obtenerEnvio($cod_envio);         
            }


            if (
                isset($_POST['cod_envio'])
                && isset($_POST['direccion'])
                && isset($_POST['estado'])
            ) {
                $cod_envio = $_POST['cod_envio'];
                $estado = $_POST['estado'];
                $direccion = $_POST['direccion'];


                $envio = new envios();
                
                $envio->setCodEnvio($cod_envio);
                $envio->setEstado($estado);
                $envio->setDireccion($direccion);


                echo $envio->actualizarEnvio();
            }


            ?>
            <div class="container-fluid">
                <form id="editarCliente" action="editar.php" method="post">

                <div class="form-group">
                        <label>Código de envío</label>
                        <input type="text" class="form-control" name="cod_envio" value="<?php echo $envio['cod_envío']; ?>" readonly>
                    </div>
                    
                    <div class="form-group">
                        <label>Dirección</label>
                        <input type="text" class="form-control" name="direccion" value="<?php echo $envio['dirección']; ?>" readonly>
                    </div>

                    <div class="form-group">
                        <label>Estado</label>
                        <input type="text" class="form-control" name="estado" value="<?php echo $envio['estado']; ?>" required>
                    </div>



                    <button type="submit" class="btn btn-primary">Editar Envío</button>
                </form>
                <br>
                <a href="../../indexEnvios.php"><button>Volver al listado</button></a>
            </div>
        </div>
</body>

</html>