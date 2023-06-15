<!DOCTYPE html>
<html>

<?php
include "../../componentes/head.php";
require "../../modelo/envios.php";
?>

<body>
    <div class="container-fluid">
        <div class="jumbotron">
            <h1>Crear Envío </h1>
            <br>

            <?php
            if (isset($_GET['direccion']) && !empty($_GET['direccion'])) {
                $direccionCliente = $_GET['direccion'];
                require_once "../../modelo/cliente.php";
                $direccionCliente = $_GET['direccion'];
                $clientes = new cliente();
                $cliente = $clientes->obtenerCliente($direccionCliente);             
                        
            }

            
            if (
                isset($_POST['dirección'])
                && isset($_POST['estado'])
                && isset($_POST['cod_envío'])
            ) {
                $direccion = $_POST['dirección'];
                $estado = $_POST['estado'];
                $cod_envio = $_POST['cod_envío'];

                $envio = new envios();
                
                $envio->setDireccion($direccion);
                $envio->setEstado($estado);
                $envio->setCodEnvio($cod_envio);

                echo $envio->insertarEnvio();
            }

            ?>
           <form action="insertar.php" method="post">
                    
                <div class="form-group">
                    <label>Dirección</label>
                    <input type="text" class="form-control" name="dirección" value="<?php echo $cliente['dirección']; ?>" readonly>
                </div>

                <div class="form-group">
                    <label>Estado</label>
                    <input type="text" class="form-control" name="estado" required>
                </div>

                <div class="form-group">
                    <label>Código envío</label>
                    <input type="text" class="form-control" name="cod_envío" required>
                </div>

                <button type="submit" class="btn btn-primary">Crear Envío</button>
            </form>
                <br>
                <a href="../../indexEnvios.php"><button>Volver al listado</button></a>
            </div>
        </div>
</body>

</html>