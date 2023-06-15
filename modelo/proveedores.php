<?php

require_once "bd.php";

class proveedores {

    private $db;
    private $cod_proveedor;
    private $nombre_proveedor;
    private $direccion;
    private $ciudad;
    private $estado;
    private $pais;
    private $codigo_postal;
    private $telefono;
    
    
    //Tabla SQL:

    //CREATE TABLE `proveedores` (
    //    `cod_proveedor` INT AUTO_INCREMENT PRIMARY KEY,
    //    `nombre_proveedor` VARCHAR(100) NOT NULL,
    //    `direccion` VARCHAR(200) NOT NULL,
    //    `ciudad` VARCHAR(50) NOT NULL,
    //    `estado` VARCHAR(50) NOT NULL,
    //    `pais` VARCHAR(50) NOT NULL,
    //    `codigo_postal` VARCHAR(10) NOT NULL,
    //    `telefono` VARCHAR(20) NOT NULL
    //  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
      

    //CONSTRUCTOR

    function __construct(){
        $bd = new bd();
        $this->db = $bd->conectarBD();
    }


        //MÉTODOS PROPIOS DE CLASE.

        function obtenerListadoProveedores(){
            try{
                $querySelect = "SELECT * FROM obtener_listado_proveedores()";
                $listaProvedores = $this->db->prepare($querySelect);
                $listaProvedores->execute();
    
                if ($listaProvedores) {
                    $resultados = $listaProvedores->fetchAll(PDO::FETCH_CLASS, "proveedores");
                    return $resultados;
                } else {
                    echo "Ocurrió un error inesperado al obtener el Listado de Proveedores";
                }
            }
            catch (Exception $ex) {
                echo "Ocurrió un error: " . $ex->getMessage();
                return null;
            }
        }

        function insertarProveedor(){
            try {
                $queryInsertar = "CALL pro_insertar_proveedor($this)";
    
                $instanciaDB = $this->db->prepare($queryInsertar);
                echo var_dump($queryInsertar);
    
                $respuestaInsertar = $instanciaDB->execute();
    
                if ($respuestaInsertar) {  
                    echo "Proveedor creado correctamente";
                    header("Location:../../indexProveedores.php");
                } else {
                    echo "Ocurrió un error inesperado al crear el proveedor";
                }
            } catch (Exception $ex) {
                echo "Ocurrió un error: " . $ex->getMessage();
                return null;
            }
        }


        function eliminarProveedor($cod_proveedor){
            try {
                $queryBorrar = "CALL pro_eliminar_proveedor('$cod_proveedor');";
                $respuestaBorrar = $this->db->query($queryBorrar);
    
                if ($respuestaBorrar) {
                    echo "Proveedor eliminado correctamente";
                    header("Location:../../indexProveedores.php");
                } else {
                    echo "Ocurrió un error inesperado al eliminar el proveedor";
                }
            } catch (Exception $ex) {
                echo "Ocurrió un error: " . $ex->getMessage();
                return null;
            }
        }

        function obtenerProveedor($codigo){
            try {
                $querySelect = "SELECT * from obtener_proveedor('$codigo');";
                
                $instanciaDB = $this->db->prepare($querySelect);
    
                $instanciaDB->execute();
    
                if ($instanciaDB) {
                    return $instanciaDB->fetch();
                } else {
                    echo "Ocurrió un error inesperado al recuperar el Proveedor seleccionado";
                }
            } catch (Exception $ex) {
                echo "Ocurrió un error: " . $ex->getMessage();
                return null;
            }
        }

        function actualizarProveedor(){
            try {  
                $querySelect = "CALL pro_actualizar_proveedor($this);";
        
                $respuestaSelect = $this->db->query($querySelect);
    
                if($respuestaSelect){ 
                    echo "Se actualizó correctamente el proveedor seleccionado";
                    header("Location:../../indexProveedores.php");
                }
                else{
                    echo "Ocurrió un error inesperado al recuperar el proveedor seleccionado";
                }
    
    
            } catch (Exception $ex) {
                echo "Ocurrió un error: " . $ex->getMessage();
                return null;
            }
        }

        public function __toString(){
            if ($this->cod_proveedor) {
                return "('$this->cod_proveedor', '$this->nombre_proveedor', '$this->direccion', '$this->ciudad', '$this->estado', '$this->pais', '$this->codigo_postal', '$this->telefono')";
            } else {
                return "(null, '$this->nombre_proveedor', '$this->direccion', '$this->ciudad', '$this->estado', '$this->pais', '$this->codigo_postal', '$this->telefono')";
            }
        }


    
    //GETTERS



    function getCodigoProveedor(){
        return $this->cod_proveedor;
    }

    function getNombreProveedor(){
        return $this->nombre_proveedor;
    }

    function getDireccion(){
        return $this->direccion;
    }

    function getCiudad(){
        return $this->ciudad;
    }

    function getPais(){
        return $this->pais;
    }

    function getEstado(){
        return $this->estado;
    }

    function getCodigoPostal(){
        return $this->codigo_postal;
    }

    function getTelefono(){
        return $this->telefono;
    }




    // SETTERS

    public function setCodigoProveedor($codigo_proveedor) {
        $this->cod_proveedor = $codigo_proveedor;
    }

    public function setNombreProveedor($nombre_proveedor) {
        $this->nombre_proveedor = $nombre_proveedor;
    }   
    
    public function setDireccion($direccion) {
        $this->direccion = $direccion;
    }   

    public function setCiudad($ciudad) {
        $this->ciudad = $ciudad;
    }  

    public function setEstado($estado) {
        $this->estado = $estado;
    }

    public function setPais($pais) {
        $this->pais = $pais;
    } 

    public function setCodigoPostal($codigo_postal) {
        $this->codigo_postal = $codigo_postal;
    }   

    public function setTelefono($telefono) {
        $this->telefono = $telefono;
    }   

}

?>