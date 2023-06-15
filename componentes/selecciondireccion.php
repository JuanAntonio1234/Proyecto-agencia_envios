<div class="form-group">
    <label>Direcciones</label>
    <br>
    <select class="form-select" name="dirección" aria-label="">
        <?php

        $clientes = new cliente();
        $listadoClientes = $clientes->obtenerListadoClientes();

        foreach ($listadoClientes as $cliente) {
                echo "<option value=" . $cliente->getDireccion();
                if (isset($idsJuegosSeleccionados)) {
                    foreach ($idsJuegosSeleccionados as $idJuego) {
                        if ($juego->getId() == $idJuego['id']) {
                            echo " selected='selected' ";
                        }
                    }
                }
                echo ">" . $juego->getNombre() . "</option>";
        }

        ?>
    </select>
</div>