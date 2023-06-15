<?php

require_once "bd.php";

class cliente {

    private $db;
    private $dirección;
    private $correo;
    private $nombre;
    private $apellidos;


    //CONSTRUCTOR

    function __construct(){
        $bd = new bd();
        $this->db = $bd->conectarBD();
    }



    
    function obtenerListadoClientes(){
        try{
            $querySelect = "SELECT * FROM obtener_listado_clientes()";
            $listaClientes = $this->db->prepare($querySelect);
            $listaClientes->execute();

            if ($listaClientes) {
                $resultados = $listaClientes->fetchAll(PDO::FETCH_CLASS, "cliente");
                return $resultados;
            } else {
                echo "Ocurrió un error inesperado al obtener el Listado de Clientes";
            }
        }
        catch (Exception $ex) {
            echo "Ocurrió un error: " . $ex->getMessage();
            return null;
        }
    }

    function insertarCliente(){
        try {
            $queryInsertar = "CALL pro_insertar_cliente($this)";
            $instanciaDB = $this->db->prepare($queryInsertar);
            $respuestaInsertar = $instanciaDB->execute();

            if ($respuestaInsertar) {  
                echo "Cliente creado correctamente";
                header("Location:../../index.php");
            } else {
                echo "Ocurrió un error inesperado al crear el cliente";
            }
        } catch (Exception $ex) {
            echo "Ocurrió un error: " . $ex->getMessage();
            return null;
        }
    }

    function eliminarCliente($direccionCliente){
        try {
            $queryBorrar = "CALL pro_eliminar_cliente('$direccionCliente');";
            $respuestaBorrar = $this->db->query($queryBorrar);

            if ($respuestaBorrar) {
                echo "Cliente eliminado correctamente";
                header("Location:../../index.php");
            } else {
                echo "Ocurrió un error inesperado al eliminar el cliente";
            }
        } catch (Exception $ex) {
            echo "Ocurrió un error: " . $ex->getMessage();
            return null;
        }
    }

    function obtenerCliente($dirección){
        try {
            $querySelect = "SELECT * from obtener_cliente('$dirección');";
            
            $instanciaDB = $this->db->prepare($querySelect);

            $instanciaDB->execute();

            if ($instanciaDB) {
                return $instanciaDB->fetch();
            } else {
                echo "Ocurrió un error inesperado al recuperar el Cliente seleccionado";
            }
        } catch (Exception $ex) {
            echo "Ocurrió un error: " . $ex->getMessage();
            return null;
        }
    }

    function actualizarCliente(){
        try {  
            $querySelect = "CALL pro_actualizar_cliente($this);";
    
            $respuestaSelect = $this->db->query($querySelect);

            if($respuestaSelect){ 
                echo "Se actualizó correctamente el cliente seleccionado";
                header("Location:../../index.php");
            }
            else{
                echo "Ocurrió un error inesperado al recuperar el cliente seleccionado";
            }


        } catch (Exception $ex) {
            echo "Ocurrió un error: " . $ex->getMessage();
            return null;
        }
    }


    public function __toString(){
        if ($this->dirección) {
            return "('$this->dirección', '$this->correo', '$this->nombre', '$this->apellidos')";
        } else {
            return "(null, '$this->dirección', '$this->correo', '$this->nombre', '$this->apellidos')";
        }
    }


    //GETTERS

    function getDireccion(){
        return $this->dirección;
    }

    function getCorreo(){
        return $this->correo;
    }

    function getNombre(){
        return $this->nombre;
    }

    function getApellidos(){
        return $this->apellidos;
    }


    // SETTERS


    public function setDirección($direccion) {
        $this->dirección = $direccion;
    }
    public function setCorreo($correo) {
        $this->correo = $correo;
    }
    public function setNombre($nombre) {
        $this->nombre = $nombre;
    }
    public function setApellidos($apellidos) {
        $this->apellidos = $apellidos;
    }


}

?>