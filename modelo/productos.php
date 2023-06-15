<?php

require_once "bd.php";

class productos {

    private $db;
    private $cod_producto;
    private $estado;
    private $proveedor;
    


    //CONSTRUCTOR

    function __construct(){
        $bd = new bd();
        $this->db = $bd->conectarBD();

    }


    //MÉTODOS PROPIOS DE CLASE.

    function obtenerListadoProductos(){
        try{
            $querySelect = "SELECT * FROM obtener_listado_productos()";
            $listaProductos = $this->db->prepare($querySelect);
            $listaProductos->execute();

            if ($listaProductos) {
                $resultados = $listaProductos->fetchAll(PDO::FETCH_CLASS, "productos");
                return $resultados;
            } else {
                echo "Ocurrió un error inesperado al obtener el Listado de Productos";
            }
        }
        catch (Exception $ex) {
            echo "Ocurrió un error: " . $ex->getMessage();
            return null;
        }
    }  

    function insertarProducto(){
        try {
            $queryInsertar = "CALL pro_insertar_producto($this)";
            $instanciaDB = $this->db->prepare($queryInsertar);
            $respuestaInsertar = $instanciaDB->execute();

            if ($respuestaInsertar) {  
                echo "Producto creado correctamente";
                header("Location:../../indexProductos.php");
            } else {
                echo "Ocurrió un error inesperado al crear el producto";
            }
        } catch (Exception $ex) {
            echo "Ocurrió un error: " . $ex->getMessage();
            return null;
        }
    }

    function eliminarProducto($cod_producto){
        try {
            $queryBorrar = "CALL pro_eliminar_producto('$cod_producto');";
            $respuestaBorrar = $this->db->query($queryBorrar);

            if ($respuestaBorrar) {
                echo "Producto eliminado correctamente";
                header("Location:../../indexProductos.php");
            } else {
                echo "Ocurrió un error inesperado al eliminar el Producto";
            }
        } catch (Exception $ex) {
            echo "Ocurrió un error: " . $ex->getMessage();
            return null;
        }
    }

    function obtenerProducto($cod_producto){
        try {
            $querySelect = "SELECT * from obtener_producto('$cod_producto');";
            
            $instanciaDB = $this->db->prepare($querySelect);

            $instanciaDB->execute();

            if ($instanciaDB) {
                return $instanciaDB->fetch();
            } else {
                echo "Ocurrió un error inesperado al recuperar el Producto seleccionado";
            }
        } catch (Exception $ex) {
            echo "Ocurrió un error: " . $ex->getMessage();
            return null;
        }
    }

    function actualizarProducto(){
        try {  
            $querySelect = "CALL pro_actualizar_producto($this);";
    
            $respuestaSelect = $this->db->query($querySelect);

            if($respuestaSelect){ 
                echo "Se actualizó correctamente el producto seleccionado";
                header("Location:../../indexProductos.php");
            }
            else{
                echo "Ocurrió un error inesperado al recuperar el producto seleccionado";
            }


        } catch (Exception $ex) {
            echo "Ocurrió un error: " . $ex->getMessage();
            return null;
        }
    }

    public function __toString(){
        if ($this->cod_producto) {
            return "('$this->cod_producto', '$this->estado', '$this->proveedor')";
        } else {
            return "(null, '$this->estado', '$this->proveedor')";
        }
    }


    //GETTERS

    function getCodigoProducto(){
        return $this->cod_producto;
    }

    function getEstado(){
        return $this->estado;
    }

    function getProveedor(){
        return $this->proveedor;
    }


    // SETTERS


    public function setCodigoProducto($cod_producto) {
        $this->cod_producto = $cod_producto;
    }

    public function setEstado($estado) {
        $this->estado = $estado;
    }   

    public function setProveedor($proveedor) {
        $this->proveedor = $proveedor;
    }

}

?>