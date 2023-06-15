<?php

require_once "bd.php";

class envios {

    private $db;
    private $cod_envío;
    private $dirección;
    private $estado;
    private $descripcion;
    private $informacion_extra;
    


    //CONSTRUCTOR

    function __construct(){
        $bd = new bd();
        $this->db = $bd->conectarBD();
    }


    function obtenerListadoEnvios(){
        try{
            $querySelect = "SELECT * FROM obtener_listado_envios()";
            $listaEnvios = $this->db->prepare($querySelect);
            $listaEnvios->execute();

            if ($listaEnvios) {
                $resultados = $listaEnvios->fetchAll(PDO::FETCH_CLASS, "envios");
                return $resultados;
            } else {
                echo "Ocurrió un error inesperado al obtener el Listado de Envíos";
            }
        }
        catch (Exception $ex) {
            echo "Ocurrió un error: " . $ex->getMessage();
            return null;
        }
    }

    function insertarEnvio(){
        try {
            $queryInsertar = "CALL pro_insertar_envio($this)";
            $instanciaDB = $this->db->prepare($queryInsertar);
            $respuestaInsertar = $instanciaDB->execute();

            if ($respuestaInsertar) {  
                echo "Envío creado correctamente";
                header("Location:../../indexEnvios.php");
            } else {
                echo "Ocurrió un error inesperado al crear el cliente";
            }
        } catch (Exception $ex) {
            echo "Ocurrió un error: " . $ex->getMessage();
            return null;
        }
    }

    function eliminarEnvio($codigo_envio){
        try {
            $queryBorrar = "CALL pro_eliminar_envio('$codigo_envio');";
            $respuestaBorrar = $this->db->query($queryBorrar);

            if ($respuestaBorrar) {
                echo "Envío eliminado correctamente";
                header("Location:../../indexEnvios.php");
            } else {
                echo "Ocurrió un error inesperado al eliminar el Envío";
            }
        } catch (Exception $ex) {
            echo "Ocurrió un error: " . $ex->getMessage();
            return null;
        }
    }

    function obtenerEnvio($codigo_envio){
        try {
            $querySelect = "SELECT * from obtener_envio('$codigo_envio');";
            
            $instanciaDB = $this->db->prepare($querySelect);

            $instanciaDB->execute();

            if ($instanciaDB) {
                return $instanciaDB->fetch();
            } else {
                echo "Ocurrió un error inesperado al recuperar el Envío seleccionado";
            }
        } catch (Exception $ex) {
            echo "Ocurrió un error: " . $ex->getMessage();
            return null;
        }
    }

    function actualizarEnvio(){
        try {  
            $querySelect = "CALL pro_actualizar_envio($this);";
    
            $respuestaSelect = $this->db->query($querySelect);

            if($respuestaSelect){ 
                echo "Se actualizó correctamente el envío seleccionado";
                header("Location:../../indexEnvios.php");
            }
            else{
                echo "Ocurrió un error inesperado al recuperar el envío seleccionado";
            }


        } catch (Exception $ex) {
            echo "Ocurrió un error: " . $ex->getMessage();
            return null;
        }
    }
    

    public function __toString(){
        //nota para el Juan del futuro, los atributos de aquí deben ir en el mismo orden que en el procedimiento de postgres.
        if ($this->cod_envío) {
            return "('$this->cod_envío', '$this->dirección', '$this->descripcion', '$this->informacion_extra', '$this->estado')";
        } else {
            return "(null, '$this->dirección', '$this->descripcion', '$this->informacion_extra', '$this->estado')";
        }
    }

    //GETTERS

    function getCodEnvio(){
        return $this->cod_envío;
    }

    function getDescripcion(){
        return $this->descripcion;
    }

    function getInformacionExtra(){
        return $this->informacion_extra;
    }

    function getDireccion(){
        return $this->dirección;
    }

    function getEstado(){
        return $this->estado;
    }


    // SETTERS


    public function setCodEnvio($cod_envío) {
        $this->cod_envío = $cod_envío;
    }

    public function setEstado($estado) {
        $this->estado = $estado;
    }   

    public function setDireccion($dirección) {
        $this->dirección = $dirección;
    }

    public function setDescripcion($dirección) {
        $this->dirección = $dirección;
    }

    public function setInformacionExtra($dirección) {
        $this->dirección = $dirección;
    }

}

?>