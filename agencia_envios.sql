PGDMP     :    .                {           agencia_envios    14.8    14.8    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    18025    agencia_envios    DATABASE     j   CREATE DATABASE agencia_envios WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Spanish_Spain.1252';
    DROP DATABASE agencia_envios;
                postgres    false            n           1247    18028    tipo_cliente    TYPE     �   CREATE TYPE public.tipo_cliente AS (
	"dirección" character varying(50),
	correo character varying(30),
	nombre character varying(20),
	apellidos character varying(50)
);
    DROP TYPE public.tipo_cliente;
       public          postgres    false            q           1247    18031 
   tipo_envio    TYPE     �   CREATE TYPE public.tipo_envio AS (
	"cod_envío" integer,
	"dirección" character varying(50),
	"descripción" character varying(256),
	informacion_extra character varying(250),
	estado character varying(30)
);
    DROP TYPE public.tipo_envio;
       public          postgres    false            t           1247    18034    tipo_producto    TYPE     r   CREATE TYPE public.tipo_producto AS (
	cod_producto integer,
	estado character varying(50),
	proveedor integer
);
     DROP TYPE public.tipo_producto;
       public          postgres    false            w           1247    18037    tipo_proveedor    TYPE     5  CREATE TYPE public.tipo_proveedor AS (
	cod_proveedor integer,
	nombre_proveedor character varying(255),
	direccion character varying(255),
	pais character varying(255),
	estado character varying(255),
	ciudad character varying(255),
	codigo_postal character varying(255),
	telefono character varying(255)
);
 !   DROP TYPE public.tipo_proveedor;
       public          postgres    false                       1255    18249    eliminar_envios()    FUNCTION     �   CREATE FUNCTION public.eliminar_envios() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM envio WHERE dirección = OLD.dirección;
    RETURN OLD;
END;
$$;
 (   DROP FUNCTION public.eliminar_envios();
       public          postgres    false            	           1255    18255    eliminar_productos()    FUNCTION     �   CREATE FUNCTION public.eliminar_productos() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM producto WHERE proveedor = OLD.cod_proveedor;
    RETURN OLD;
END;
$$;
 +   DROP FUNCTION public.eliminar_productos();
       public          postgres    false            �            1255    18038 "   obtener_cliente(character varying)    FUNCTION     �   CREATE FUNCTION public.obtener_cliente("direcciónnn" character varying) RETURNS SETOF public.tipo_cliente
    LANGUAGE plpgsql
    AS $$BEGIN
   RETURN QUERY SELECT * FROM cliente where cliente.dirección=direcciónnn;
END;
$$;
 H   DROP FUNCTION public.obtener_cliente("direcciónnn" character varying);
       public          postgres    false    878            �            1259    18039    envio    TABLE     0   CREATE TABLE public.envio OF public.tipo_envio;
    DROP TABLE public.envio;
       public         heap    postgres    false    881                       1255    18044    obtener_envio(integer)    FUNCTION     �   CREATE FUNCTION public.obtener_envio(codigo_envio integer) RETURNS SETOF public.envio
    LANGUAGE plpgsql
    AS $$BEGIN
	RETURN QUERY SELECT * FROM envio WHERE envio.cod_envío = codigo_envio;
END;$$;
 :   DROP FUNCTION public.obtener_envio(codigo_envio integer);
       public          postgres    false    213            �            1259    18045    cliente    TABLE     4   CREATE TABLE public.cliente OF public.tipo_cliente;
    DROP TABLE public.cliente;
       public         heap    postgres    false    878            �            1255    18048    obtener_listado_clientes()    FUNCTION     �   CREATE FUNCTION public.obtener_listado_clientes() RETURNS SETOF public.cliente
    LANGUAGE plpgsql
    AS $$BEGIN
   RETURN QUERY SELECT * FROM cliente;
END;$$;
 1   DROP FUNCTION public.obtener_listado_clientes();
       public          postgres    false    214            �            1255    18049    obtener_listado_envios()    FUNCTION     �   CREATE FUNCTION public.obtener_listado_envios() RETURNS SETOF public.envio
    LANGUAGE plpgsql
    AS $$BEGIN
   RETURN QUERY SELECT * FROM envio;
END;$$;
 /   DROP FUNCTION public.obtener_listado_envios();
       public          postgres    false    213            �            1259    18050    producto    TABLE     6   CREATE TABLE public.producto OF public.tipo_producto;
    DROP TABLE public.producto;
       public         heap    postgres    false    884            �            1255    18053    obtener_listado_productos()    FUNCTION     �   CREATE FUNCTION public.obtener_listado_productos() RETURNS SETOF public.producto
    LANGUAGE plpgsql
    AS $$BEGIN
   RETURN QUERY SELECT * FROM producto;
END;$$;
 2   DROP FUNCTION public.obtener_listado_productos();
       public          postgres    false    215            �            1259    18054    cod_prov_sec    SEQUENCE     u   CREATE SEQUENCE public.cod_prov_sec
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.cod_prov_sec;
       public          postgres    false            �            1259    18055 	   proveedor    TABLE        CREATE TABLE public.proveedor OF public.tipo_proveedor (
    cod_proveedor DEFAULT nextval('public.cod_prov_sec'::regclass)
);
    DROP TABLE public.proveedor;
       public         heap    postgres    false    216    887            �            1255    18061    obtener_listado_proveedores()    FUNCTION     �   CREATE FUNCTION public.obtener_listado_proveedores() RETURNS SETOF public.proveedor
    LANGUAGE plpgsql
    AS $$BEGIN
	RETURN QUERY SELECT * FROM proveedor;
END;$$;
 4   DROP FUNCTION public.obtener_listado_proveedores();
       public          postgres    false    217            �            1255    18062    obtener_producto(integer)    FUNCTION     �   CREATE FUNCTION public.obtener_producto(codigo_producto integer) RETURNS SETOF public.producto
    LANGUAGE plpgsql
    AS $$BEGIN
   RETURN QUERY SELECT * FROM producto where producto.cod_producto=codigo_producto;
END;
$$;
 @   DROP FUNCTION public.obtener_producto(codigo_producto integer);
       public          postgres    false    215            �            1255    18063    obtener_proveedor(integer)    FUNCTION     �   CREATE FUNCTION public.obtener_proveedor(codigo_proveedor integer) RETURNS SETOF public.proveedor
    LANGUAGE plpgsql
    AS $$BEGIN
	RETURN QUERY SELECT * FROM proveedor WHERE proveedor.cod_proveedor = codigo_proveedor;
END;$$;
 B   DROP FUNCTION public.obtener_proveedor(codigo_proveedor integer);
       public          postgres    false    217            �            1255    18064 +   pro_actualizar_cliente(public.tipo_cliente) 	   PROCEDURE     /  CREATE PROCEDURE public.pro_actualizar_cliente(IN clientee public.tipo_cliente)
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE cliente 
    SET correo = clientee.correo,
        nombre = clientee.nombre,
        apellidos = clientee.apellidos
    WHERE cliente.dirección=clientee.dirección;
END;
$$;
 O   DROP PROCEDURE public.pro_actualizar_cliente(IN clientee public.tipo_cliente);
       public          postgres    false    878            �            1255    18065 "   pro_actualizar_envio(public.envio) 	   PROCEDURE     *  CREATE PROCEDURE public.pro_actualizar_envio(IN env public.envio)
    LANGUAGE plpgsql
    AS $$BEGIN
UPDATE envio SET
	dirección = env.dirección,
	descripción = env.descripción,
	informacion_extra = env.informacion_extra,
	estado = env.estado
	WHERE envio.cod_envío = env.cod_envío;
END;$$;
 A   DROP PROCEDURE public.pro_actualizar_envio(IN env public.envio);
       public          postgres    false    213            �            1255    18066 (   pro_actualizar_producto(public.producto) 	   PROCEDURE     �   CREATE PROCEDURE public.pro_actualizar_producto(IN prod public.producto)
    LANGUAGE plpgsql
    AS $$BEGIN
	UPDATE producto SET
	estado = prod.estado,
	proveedor = prod.proveedor
	WHERE producto.cod_producto = prod.cod_producto;
END;$$;
 H   DROP PROCEDURE public.pro_actualizar_producto(IN prod public.producto);
       public          postgres    false    215            �            1255    18067 *   pro_actualizar_proveedor(public.proveedor) 	   PROCEDURE     �  CREATE PROCEDURE public.pro_actualizar_proveedor(IN prov public.proveedor)
    LANGUAGE plpgsql
    AS $$BEGIN
	UPDATE proveedor SET
	nombre_proveedor = prov.nombre_proveedor,
	direccion = prov.direccion,
	pais = prov.pais,
	estado = prov.estado,
	ciudad = prov.ciudad,
	codigo_postal = prov.codigo_postal,
	telefono = prov.telefono WHERE proveedor.cod_proveedor = prov.cod_proveedor;
END;$$;
 J   DROP PROCEDURE public.pro_actualizar_proveedor(IN prov public.proveedor);
       public          postgres    false    217            �            1255    18068 '   pro_eliminar_cliente(character varying) 	   PROCEDURE     �   CREATE PROCEDURE public.pro_eliminar_cliente(IN "direcciónnn" character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM cliente WHERE cliente.dirección=direcciónnn;
END;
$$;
 Q   DROP PROCEDURE public.pro_eliminar_cliente(IN "direcciónnn" character varying);
       public          postgres    false                        1255    18069    pro_eliminar_envio(integer) 	   PROCEDURE     �   CREATE PROCEDURE public.pro_eliminar_envio(IN codigo_envio integer)
    LANGUAGE plpgsql
    AS $$BEGIN
	DELETE FROM envio WHERE envio.cod_envío = codigo_envio;
END;$$;
 C   DROP PROCEDURE public.pro_eliminar_envio(IN codigo_envio integer);
       public          postgres    false                       1255    18070    pro_eliminar_producto(integer) 	   PROCEDURE     �   CREATE PROCEDURE public.pro_eliminar_producto(IN codigo_producto integer)
    LANGUAGE plpgsql
    AS $$BEGIN
DELETE FROM producto WHERE producto.cod_producto = codigo_producto;
END;$$;
 I   DROP PROCEDURE public.pro_eliminar_producto(IN codigo_producto integer);
       public          postgres    false                       1255    18071    pro_eliminar_proveedor(integer) 	   PROCEDURE     �   CREATE PROCEDURE public.pro_eliminar_proveedor(IN codigo_proveedor integer)
    LANGUAGE plpgsql
    AS $$BEGIN
	DELETE FROM proveedor WHERE proveedor.cod_proveedor = codigo_proveedor;
END;$$;
 K   DROP PROCEDURE public.pro_eliminar_proveedor(IN codigo_proveedor integer);
       public          postgres    false                       1255    18072 )   pro_insertar_cliente(public.tipo_cliente) 	   PROCEDURE        CREATE PROCEDURE public.pro_insertar_cliente(IN nuevo_cliente public.tipo_cliente)
    LANGUAGE plpgsql
    AS $$BEGIN
	INSERT INTO cliente (dirección,correo,nombre,apellidos) 
	VALUES (nuevo_cliente.dirección,nuevo_cliente.correo,nuevo_cliente.nombre,nuevo_cliente.apellidos);
END;$$;
 R   DROP PROCEDURE public.pro_insertar_cliente(IN nuevo_cliente public.tipo_cliente);
       public          postgres    false    878                       1255    18073     pro_insertar_envio(public.envio) 	   PROCEDURE       CREATE PROCEDURE public.pro_insertar_envio(IN env public.envio)
    LANGUAGE plpgsql
    AS $$BEGIN
	INSERT INTO envio(cod_envío, dirección, descripción, informacion_extra, estado)
	VALUES (env.cod_envío, env.dirección, env.descripción, env.informacion_extra, env.estado);
END;$$;
 ?   DROP PROCEDURE public.pro_insertar_envio(IN env public.envio);
       public          postgres    false    213                       1255    18074 &   pro_insertar_producto(public.producto) 	   PROCEDURE     �   CREATE PROCEDURE public.pro_insertar_producto(IN prod public.producto)
    LANGUAGE plpgsql
    AS $$BEGIN
INSERT INTO producto (cod_producto, estado, proveedor)
VALUES (prod.cod_producto, prod.estado, prod.proveedor);
END;$$;
 F   DROP PROCEDURE public.pro_insertar_producto(IN prod public.producto);
       public          postgres    false    215                       1255    18075 (   pro_insertar_proveedor(public.proveedor) 	   PROCEDURE     Q  CREATE PROCEDURE public.pro_insertar_proveedor(IN prov public.proveedor)
    LANGUAGE plpgsql
    AS $$BEGIN
	INSERT INTO proveedor(nombre_proveedor, direccion, pais, estado, ciudad, codigo_postal, telefono)
	VALUES (prov.nombre_proveedor, prov.direccion, prov.pais, prov.estado, prov.ciudad, prov.codigo_postal, prov.telefono);
END;$$;
 H   DROP PROCEDURE public.pro_insertar_proveedor(IN prov public.proveedor);
       public          postgres    false    217            �            1259    18076    agencia_arroja_facturas    TABLE     �   CREATE TABLE public.agencia_arroja_facturas (
    "dirección_sede" character varying(100) NOT NULL,
    cod_factura numeric(9,0) NOT NULL,
    trial079 character(1)
);
 +   DROP TABLE public.agencia_arroja_facturas;
       public         heap    postgres    false            �           0    0    TABLE agencia_arroja_facturas    COMMENT     <   COMMENT ON TABLE public.agencia_arroja_facturas IS 'TRIAL';
          public          postgres    false    218            �           0    0 0   COLUMN agencia_arroja_facturas."dirección_sede"    COMMENT     O   COMMENT ON COLUMN public.agencia_arroja_facturas."dirección_sede" IS 'TRIAL';
          public          postgres    false    218            �           0    0 *   COLUMN agencia_arroja_facturas.cod_factura    COMMENT     I   COMMENT ON COLUMN public.agencia_arroja_facturas.cod_factura IS 'TRIAL';
          public          postgres    false    218            �           0    0 '   COLUMN agencia_arroja_facturas.trial079    COMMENT     F   COMMENT ON COLUMN public.agencia_arroja_facturas.trial079 IS 'TRIAL';
          public          postgres    false    218            �            1259    18079    agencia_emite_albaranes    TABLE     �   CREATE TABLE public.agencia_emite_albaranes (
    "dirección_sede" character varying(100) NOT NULL,
    "cod_albarán" numeric(9,0) NOT NULL,
    trial079 character(1)
);
 +   DROP TABLE public.agencia_emite_albaranes;
       public         heap    postgres    false            �           0    0    TABLE agencia_emite_albaranes    COMMENT     <   COMMENT ON TABLE public.agencia_emite_albaranes IS 'TRIAL';
          public          postgres    false    219            �           0    0 0   COLUMN agencia_emite_albaranes."dirección_sede"    COMMENT     O   COMMENT ON COLUMN public.agencia_emite_albaranes."dirección_sede" IS 'TRIAL';
          public          postgres    false    219            �           0    0 -   COLUMN agencia_emite_albaranes."cod_albarán"    COMMENT     L   COMMENT ON COLUMN public.agencia_emite_albaranes."cod_albarán" IS 'TRIAL';
          public          postgres    false    219            �           0    0 '   COLUMN agencia_emite_albaranes.trial079    COMMENT     F   COMMENT ON COLUMN public.agencia_emite_albaranes.trial079 IS 'TRIAL';
          public          postgres    false    219            �            1259    18082    agencia_envios    TABLE     y   CREATE TABLE public.agencia_envios (
    "dirección_sede" character varying(100) NOT NULL,
    trial079 character(1)
);
 "   DROP TABLE public.agencia_envios;
       public         heap    postgres    false            �           0    0    TABLE agencia_envios    COMMENT     3   COMMENT ON TABLE public.agencia_envios IS 'TRIAL';
          public          postgres    false    220            �           0    0 '   COLUMN agencia_envios."dirección_sede"    COMMENT     F   COMMENT ON COLUMN public.agencia_envios."dirección_sede" IS 'TRIAL';
          public          postgres    false    220            �           0    0    COLUMN agencia_envios.trial079    COMMENT     =   COMMENT ON COLUMN public.agencia_envios.trial079 IS 'TRIAL';
          public          postgres    false    220            �            1259    18085 	   albaranes    TABLE     �   CREATE TABLE public.albaranes (
    "codigo_albarán" numeric(9,0) NOT NULL,
    detalles character varying(100) NOT NULL,
    trial079 character(1)
);
    DROP TABLE public.albaranes;
       public         heap    postgres    false            �           0    0    TABLE albaranes    COMMENT     .   COMMENT ON TABLE public.albaranes IS 'TRIAL';
          public          postgres    false    221            �           0    0 "   COLUMN albaranes."codigo_albarán"    COMMENT     A   COMMENT ON COLUMN public.albaranes."codigo_albarán" IS 'TRIAL';
          public          postgres    false    221            �           0    0    COLUMN albaranes.detalles    COMMENT     8   COMMENT ON COLUMN public.albaranes.detalles IS 'TRIAL';
          public          postgres    false    221            �           0    0    COLUMN albaranes.trial079    COMMENT     8   COMMENT ON COLUMN public.albaranes.trial079 IS 'TRIAL';
          public          postgres    false    221            �            1259    18088 	   almacenes    TABLE     �   CREATE TABLE public.almacenes (
    "ubicación" character varying(100) NOT NULL,
    capacidad_paquetes numeric(5,0) NOT NULL,
    trial079 character(1)
);
    DROP TABLE public.almacenes;
       public         heap    postgres    false            �           0    0    TABLE almacenes    COMMENT     .   COMMENT ON TABLE public.almacenes IS 'TRIAL';
          public          postgres    false    222            �           0    0    COLUMN almacenes."ubicación"    COMMENT     <   COMMENT ON COLUMN public.almacenes."ubicación" IS 'TRIAL';
          public          postgres    false    222            �           0    0 #   COLUMN almacenes.capacidad_paquetes    COMMENT     B   COMMENT ON COLUMN public.almacenes.capacidad_paquetes IS 'TRIAL';
          public          postgres    false    222            �           0    0    COLUMN almacenes.trial079    COMMENT     8   COMMENT ON COLUMN public.almacenes.trial079 IS 'TRIAL';
          public          postgres    false    222            �            1259    18091 
   base_datos    TABLE     �   CREATE TABLE public.base_datos (
    tablas numeric(2,0) NOT NULL,
    cantidad_registros numeric(9,0) NOT NULL,
    trial082 character(1)
);
    DROP TABLE public.base_datos;
       public         heap    postgres    false            �           0    0    TABLE base_datos    COMMENT     /   COMMENT ON TABLE public.base_datos IS 'TRIAL';
          public          postgres    false    223            �           0    0    COLUMN base_datos.tablas    COMMENT     7   COMMENT ON COLUMN public.base_datos.tablas IS 'TRIAL';
          public          postgres    false    223            �           0    0 $   COLUMN base_datos.cantidad_registros    COMMENT     C   COMMENT ON COLUMN public.base_datos.cantidad_registros IS 'TRIAL';
          public          postgres    false    223            �           0    0    COLUMN base_datos.trial082    COMMENT     9   COMMENT ON COLUMN public.base_datos.trial082 IS 'TRIAL';
          public          postgres    false    223            �            1259    18094    ciudades    TABLE     �   CREATE TABLE public.ciudades (
    nombre character varying(20) NOT NULL,
    cantidad_oficinas numeric(2,0) NOT NULL,
    trial082 character(1)
);
    DROP TABLE public.ciudades;
       public         heap    postgres    false            �           0    0    TABLE ciudades    COMMENT     -   COMMENT ON TABLE public.ciudades IS 'TRIAL';
          public          postgres    false    224            �           0    0    COLUMN ciudades.nombre    COMMENT     5   COMMENT ON COLUMN public.ciudades.nombre IS 'TRIAL';
          public          postgres    false    224            �           0    0 !   COLUMN ciudades.cantidad_oficinas    COMMENT     @   COMMENT ON COLUMN public.ciudades.cantidad_oficinas IS 'TRIAL';
          public          postgres    false    224            �           0    0    COLUMN ciudades.trial082    COMMENT     7   COMMENT ON COLUMN public.ciudades.trial082 IS 'TRIAL';
          public          postgres    false    224            �            1259    18097    clientes_firman_nota    TABLE     �   CREATE TABLE public.clientes_firman_nota (
    "dirección" character varying(50) NOT NULL,
    cod_nota numeric(9,0) NOT NULL,
    trial082 character(1)
);
 (   DROP TABLE public.clientes_firman_nota;
       public         heap    postgres    false            �           0    0    TABLE clientes_firman_nota    COMMENT     9   COMMENT ON TABLE public.clientes_firman_nota IS 'TRIAL';
          public          postgres    false    225                        0    0 (   COLUMN clientes_firman_nota."dirección"    COMMENT     G   COMMENT ON COLUMN public.clientes_firman_nota."dirección" IS 'TRIAL';
          public          postgres    false    225                       0    0 $   COLUMN clientes_firman_nota.cod_nota    COMMENT     C   COMMENT ON COLUMN public.clientes_firman_nota.cod_nota IS 'TRIAL';
          public          postgres    false    225                       0    0 $   COLUMN clientes_firman_nota.trial082    COMMENT     C   COMMENT ON COLUMN public.clientes_firman_nota.trial082 IS 'TRIAL';
          public          postgres    false    225            �            1259    18100    clientes_pagan_facturas    TABLE     �   CREATE TABLE public.clientes_pagan_facturas (
    "dirección" character varying(50) NOT NULL,
    cod_factura numeric(9,0) NOT NULL,
    trial082 character(1)
);
 +   DROP TABLE public.clientes_pagan_facturas;
       public         heap    postgres    false                       0    0    TABLE clientes_pagan_facturas    COMMENT     <   COMMENT ON TABLE public.clientes_pagan_facturas IS 'TRIAL';
          public          postgres    false    226                       0    0 +   COLUMN clientes_pagan_facturas."dirección"    COMMENT     J   COMMENT ON COLUMN public.clientes_pagan_facturas."dirección" IS 'TRIAL';
          public          postgres    false    226                       0    0 *   COLUMN clientes_pagan_facturas.cod_factura    COMMENT     I   COMMENT ON COLUMN public.clientes_pagan_facturas.cod_factura IS 'TRIAL';
          public          postgres    false    226                       0    0 '   COLUMN clientes_pagan_facturas.trial082    COMMENT     F   COMMENT ON COLUMN public.clientes_pagan_facturas.trial082 IS 'TRIAL';
          public          postgres    false    226            �            1259    18103    facturas    TABLE     �   CREATE TABLE public.facturas (
    codigo_factura numeric(9,0) NOT NULL,
    importe numeric(7,2) NOT NULL,
    trial082 character(1)
);
    DROP TABLE public.facturas;
       public         heap    postgres    false                       0    0    TABLE facturas    COMMENT     -   COMMENT ON TABLE public.facturas IS 'TRIAL';
          public          postgres    false    227                       0    0    COLUMN facturas.codigo_factura    COMMENT     =   COMMENT ON COLUMN public.facturas.codigo_factura IS 'TRIAL';
          public          postgres    false    227            	           0    0    COLUMN facturas.importe    COMMENT     6   COMMENT ON COLUMN public.facturas.importe IS 'TRIAL';
          public          postgres    false    227            
           0    0    COLUMN facturas.trial082    COMMENT     7   COMMENT ON COLUMN public.facturas.trial082 IS 'TRIAL';
          public          postgres    false    227            �            1259    18106    gestor_paquetes    TABLE     �   CREATE TABLE public.gestor_paquetes (
    dni character varying(9) NOT NULL,
    nombre character varying(15) NOT NULL,
    apellidos character varying(30),
    edad numeric(2,0) NOT NULL,
    trial082 character(1)
);
 #   DROP TABLE public.gestor_paquetes;
       public         heap    postgres    false                       0    0    TABLE gestor_paquetes    COMMENT     4   COMMENT ON TABLE public.gestor_paquetes IS 'TRIAL';
          public          postgres    false    228                       0    0    COLUMN gestor_paquetes.dni    COMMENT     9   COMMENT ON COLUMN public.gestor_paquetes.dni IS 'TRIAL';
          public          postgres    false    228                       0    0    COLUMN gestor_paquetes.nombre    COMMENT     <   COMMENT ON COLUMN public.gestor_paquetes.nombre IS 'TRIAL';
          public          postgres    false    228                       0    0     COLUMN gestor_paquetes.apellidos    COMMENT     ?   COMMENT ON COLUMN public.gestor_paquetes.apellidos IS 'TRIAL';
          public          postgres    false    228                       0    0    COLUMN gestor_paquetes.edad    COMMENT     :   COMMENT ON COLUMN public.gestor_paquetes.edad IS 'TRIAL';
          public          postgres    false    228                       0    0    COLUMN gestor_paquetes.trial082    COMMENT     >   COMMENT ON COLUMN public.gestor_paquetes.trial082 IS 'TRIAL';
          public          postgres    false    228            �            1259    18109    gestor_paquetes_almacenes    TABLE     �   CREATE TABLE public.gestor_paquetes_almacenes (
    dni character varying(9) NOT NULL,
    "ubicación" character varying(100) NOT NULL,
    trial082 character(1)
);
 -   DROP TABLE public.gestor_paquetes_almacenes;
       public         heap    postgres    false                       0    0    TABLE gestor_paquetes_almacenes    COMMENT     >   COMMENT ON TABLE public.gestor_paquetes_almacenes IS 'TRIAL';
          public          postgres    false    229                       0    0 $   COLUMN gestor_paquetes_almacenes.dni    COMMENT     C   COMMENT ON COLUMN public.gestor_paquetes_almacenes.dni IS 'TRIAL';
          public          postgres    false    229                       0    0 -   COLUMN gestor_paquetes_almacenes."ubicación"    COMMENT     L   COMMENT ON COLUMN public.gestor_paquetes_almacenes."ubicación" IS 'TRIAL';
          public          postgres    false    229                       0    0 )   COLUMN gestor_paquetes_almacenes.trial082    COMMENT     H   COMMENT ON COLUMN public.gestor_paquetes_almacenes.trial082 IS 'TRIAL';
          public          postgres    false    229            �            1259    18112    jefe    TABLE     �   CREATE TABLE public.jefe (
    dni character varying(9) NOT NULL,
    nombre character varying(15) NOT NULL,
    apellidos character varying(30),
    edad numeric(2,0) NOT NULL,
    trial082 character(1)
);
    DROP TABLE public.jefe;
       public         heap    postgres    false                       0    0 
   TABLE jefe    COMMENT     )   COMMENT ON TABLE public.jefe IS 'TRIAL';
          public          postgres    false    230                       0    0    COLUMN jefe.dni    COMMENT     .   COMMENT ON COLUMN public.jefe.dni IS 'TRIAL';
          public          postgres    false    230                       0    0    COLUMN jefe.nombre    COMMENT     1   COMMENT ON COLUMN public.jefe.nombre IS 'TRIAL';
          public          postgres    false    230                       0    0    COLUMN jefe.apellidos    COMMENT     4   COMMENT ON COLUMN public.jefe.apellidos IS 'TRIAL';
          public          postgres    false    230                       0    0    COLUMN jefe.edad    COMMENT     /   COMMENT ON COLUMN public.jefe.edad IS 'TRIAL';
          public          postgres    false    230                       0    0    COLUMN jefe.trial082    COMMENT     3   COMMENT ON COLUMN public.jefe.trial082 IS 'TRIAL';
          public          postgres    false    230            �            1259    18115    nota_entrega    TABLE     �   CREATE TABLE public.nota_entrega (
    cod_nota numeric(9,0) NOT NULL,
    estado character varying(50) NOT NULL,
    "información_extra" character varying(500),
    trial082 character(1)
);
     DROP TABLE public.nota_entrega;
       public         heap    postgres    false                       0    0    TABLE nota_entrega    COMMENT     1   COMMENT ON TABLE public.nota_entrega IS 'TRIAL';
          public          postgres    false    231                       0    0    COLUMN nota_entrega.cod_nota    COMMENT     ;   COMMENT ON COLUMN public.nota_entrega.cod_nota IS 'TRIAL';
          public          postgres    false    231                       0    0    COLUMN nota_entrega.estado    COMMENT     9   COMMENT ON COLUMN public.nota_entrega.estado IS 'TRIAL';
          public          postgres    false    231                       0    0 (   COLUMN nota_entrega."información_extra"    COMMENT     G   COMMENT ON COLUMN public.nota_entrega."información_extra" IS 'TRIAL';
          public          postgres    false    231                       0    0    COLUMN nota_entrega.trial082    COMMENT     ;   COMMENT ON COLUMN public.nota_entrega.trial082 IS 'TRIAL';
          public          postgres    false    231            �            1259    18120    oficinas    TABLE     �   CREATE TABLE public.oficinas (
    "ubicación" character varying(100) NOT NULL,
    cantidad_trabajadores numeric(2,0) NOT NULL,
    trial082 character(1)
);
    DROP TABLE public.oficinas;
       public         heap    postgres    false                        0    0    TABLE oficinas    COMMENT     -   COMMENT ON TABLE public.oficinas IS 'TRIAL';
          public          postgres    false    232            !           0    0    COLUMN oficinas."ubicación"    COMMENT     ;   COMMENT ON COLUMN public.oficinas."ubicación" IS 'TRIAL';
          public          postgres    false    232            "           0    0 %   COLUMN oficinas.cantidad_trabajadores    COMMENT     D   COMMENT ON COLUMN public.oficinas.cantidad_trabajadores IS 'TRIAL';
          public          postgres    false    232            #           0    0    COLUMN oficinas.trial082    COMMENT     7   COMMENT ON COLUMN public.oficinas.trial082 IS 'TRIAL';
          public          postgres    false    232            �            1259    18123    países    TABLE     �   CREATE TABLE public."países" (
    nombre character varying(20) NOT NULL,
    cantidad_ciudades numeric(3,0) NOT NULL,
    trial082 character(1)
);
    DROP TABLE public."países";
       public         heap    postgres    false            $           0    0    TABLE "países"    COMMENT     .   COMMENT ON TABLE public."países" IS 'TRIAL';
          public          postgres    false    233            %           0    0    COLUMN "países".nombre    COMMENT     6   COMMENT ON COLUMN public."países".nombre IS 'TRIAL';
          public          postgres    false    233            &           0    0 "   COLUMN "países".cantidad_ciudades    COMMENT     A   COMMENT ON COLUMN public."países".cantidad_ciudades IS 'TRIAL';
          public          postgres    false    233            '           0    0    COLUMN "países".trial082    COMMENT     8   COMMENT ON COLUMN public."países".trial082 IS 'TRIAL';
          public          postgres    false    233            �            1259    18126    personal    TABLE       CREATE TABLE public.personal (
    dni character varying(9) NOT NULL,
    cantidad_trabajadores integer NOT NULL,
    nombre character varying(15) NOT NULL,
    apellidos character varying(30) NOT NULL,
    edad numeric(2,0) NOT NULL,
    trial082 character(1)
);
    DROP TABLE public.personal;
       public         heap    postgres    false            (           0    0    TABLE personal    COMMENT     -   COMMENT ON TABLE public.personal IS 'TRIAL';
          public          postgres    false    234            )           0    0    COLUMN personal.dni    COMMENT     2   COMMENT ON COLUMN public.personal.dni IS 'TRIAL';
          public          postgres    false    234            *           0    0 %   COLUMN personal.cantidad_trabajadores    COMMENT     D   COMMENT ON COLUMN public.personal.cantidad_trabajadores IS 'TRIAL';
          public          postgres    false    234            +           0    0    COLUMN personal.nombre    COMMENT     5   COMMENT ON COLUMN public.personal.nombre IS 'TRIAL';
          public          postgres    false    234            ,           0    0    COLUMN personal.apellidos    COMMENT     8   COMMENT ON COLUMN public.personal.apellidos IS 'TRIAL';
          public          postgres    false    234            -           0    0    COLUMN personal.edad    COMMENT     3   COMMENT ON COLUMN public.personal.edad IS 'TRIAL';
          public          postgres    false    234            .           0    0    COLUMN personal.trial082    COMMENT     7   COMMENT ON COLUMN public.personal.trial082 IS 'TRIAL';
          public          postgres    false    234            �            1259    18129    personal_acude_reuniones    TABLE     �   CREATE TABLE public.personal_acude_reuniones (
    dni character varying(9) NOT NULL,
    "cod_reunión" numeric(9,0) NOT NULL,
    trial082 character(1)
);
 ,   DROP TABLE public.personal_acude_reuniones;
       public         heap    postgres    false            /           0    0    TABLE personal_acude_reuniones    COMMENT     =   COMMENT ON TABLE public.personal_acude_reuniones IS 'TRIAL';
          public          postgres    false    235            0           0    0 #   COLUMN personal_acude_reuniones.dni    COMMENT     B   COMMENT ON COLUMN public.personal_acude_reuniones.dni IS 'TRIAL';
          public          postgres    false    235            1           0    0 .   COLUMN personal_acude_reuniones."cod_reunión"    COMMENT     M   COMMENT ON COLUMN public.personal_acude_reuniones."cod_reunión" IS 'TRIAL';
          public          postgres    false    235            2           0    0 (   COLUMN personal_acude_reuniones.trial082    COMMENT     G   COMMENT ON COLUMN public.personal_acude_reuniones.trial082 IS 'TRIAL';
          public          postgres    false    235            �            1259    18132 "   personal_cantidad_trabajadores_seq    SEQUENCE     �   CREATE SEQUENCE public.personal_cantidad_trabajadores_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.personal_cantidad_trabajadores_seq;
       public          postgres    false    234            3           0    0 "   personal_cantidad_trabajadores_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.personal_cantidad_trabajadores_seq OWNED BY public.personal.cantidad_trabajadores;
          public          postgres    false    236            �            1259    18133    repartidores    TABLE     �   CREATE TABLE public.repartidores (
    dni character varying(9) NOT NULL,
    nombre character varying(15) NOT NULL,
    apellidos character varying(30) NOT NULL,
    edad numeric(2,0) NOT NULL,
    trial085 character(1)
);
     DROP TABLE public.repartidores;
       public         heap    postgres    false            4           0    0    TABLE repartidores    COMMENT     1   COMMENT ON TABLE public.repartidores IS 'TRIAL';
          public          postgres    false    237            5           0    0    COLUMN repartidores.dni    COMMENT     6   COMMENT ON COLUMN public.repartidores.dni IS 'TRIAL';
          public          postgres    false    237            6           0    0    COLUMN repartidores.nombre    COMMENT     9   COMMENT ON COLUMN public.repartidores.nombre IS 'TRIAL';
          public          postgres    false    237            7           0    0    COLUMN repartidores.apellidos    COMMENT     <   COMMENT ON COLUMN public.repartidores.apellidos IS 'TRIAL';
          public          postgres    false    237            8           0    0    COLUMN repartidores.edad    COMMENT     7   COMMENT ON COLUMN public.repartidores.edad IS 'TRIAL';
          public          postgres    false    237            9           0    0    COLUMN repartidores.trial085    COMMENT     ;   COMMENT ON COLUMN public.repartidores.trial085 IS 'TRIAL';
          public          postgres    false    237            �            1259    18136 	   reuniones    TABLE     �   CREATE TABLE public.reuniones (
    "cod_reunión" numeric(9,0) NOT NULL,
    asunto character varying(50) NOT NULL,
    cantidad_trabajadores numeric(2,0) NOT NULL,
    trial085 character(1)
);
    DROP TABLE public.reuniones;
       public         heap    postgres    false            :           0    0    TABLE reuniones    COMMENT     .   COMMENT ON TABLE public.reuniones IS 'TRIAL';
          public          postgres    false    238            ;           0    0    COLUMN reuniones."cod_reunión"    COMMENT     >   COMMENT ON COLUMN public.reuniones."cod_reunión" IS 'TRIAL';
          public          postgres    false    238            <           0    0    COLUMN reuniones.asunto    COMMENT     6   COMMENT ON COLUMN public.reuniones.asunto IS 'TRIAL';
          public          postgres    false    238            =           0    0 &   COLUMN reuniones.cantidad_trabajadores    COMMENT     E   COMMENT ON COLUMN public.reuniones.cantidad_trabajadores IS 'TRIAL';
          public          postgres    false    238            >           0    0    COLUMN reuniones.trial085    COMMENT     8   COMMENT ON COLUMN public.reuniones.trial085 IS 'TRIAL';
          public          postgres    false    238            �            1259    18139 
   secretaria    TABLE     �   CREATE TABLE public.secretaria (
    dni character varying(9) NOT NULL,
    nombre character varying(15) NOT NULL,
    apellidos character varying(30),
    edad numeric(2,0) NOT NULL,
    trial085 character(1)
);
    DROP TABLE public.secretaria;
       public         heap    postgres    false            ?           0    0    TABLE secretaria    COMMENT     /   COMMENT ON TABLE public.secretaria IS 'TRIAL';
          public          postgres    false    239            @           0    0    COLUMN secretaria.dni    COMMENT     4   COMMENT ON COLUMN public.secretaria.dni IS 'TRIAL';
          public          postgres    false    239            A           0    0    COLUMN secretaria.nombre    COMMENT     7   COMMENT ON COLUMN public.secretaria.nombre IS 'TRIAL';
          public          postgres    false    239            B           0    0    COLUMN secretaria.apellidos    COMMENT     :   COMMENT ON COLUMN public.secretaria.apellidos IS 'TRIAL';
          public          postgres    false    239            C           0    0    COLUMN secretaria.edad    COMMENT     5   COMMENT ON COLUMN public.secretaria.edad IS 'TRIAL';
          public          postgres    false    239            D           0    0    COLUMN secretaria.trial085    COMMENT     9   COMMENT ON COLUMN public.secretaria.trial085 IS 'TRIAL';
          public          postgres    false    239            �            1259    18142    secretaria_organiza_reuniones    TABLE     �   CREATE TABLE public.secretaria_organiza_reuniones (
    dni character varying(9) NOT NULL,
    "cod_reunión" numeric(9,0) NOT NULL,
    trial085 character(1)
);
 1   DROP TABLE public.secretaria_organiza_reuniones;
       public         heap    postgres    false            E           0    0 #   TABLE secretaria_organiza_reuniones    COMMENT     B   COMMENT ON TABLE public.secretaria_organiza_reuniones IS 'TRIAL';
          public          postgres    false    240            F           0    0 (   COLUMN secretaria_organiza_reuniones.dni    COMMENT     G   COMMENT ON COLUMN public.secretaria_organiza_reuniones.dni IS 'TRIAL';
          public          postgres    false    240            G           0    0 3   COLUMN secretaria_organiza_reuniones."cod_reunión"    COMMENT     R   COMMENT ON COLUMN public.secretaria_organiza_reuniones."cod_reunión" IS 'TRIAL';
          public          postgres    false    240            H           0    0 -   COLUMN secretaria_organiza_reuniones.trial085    COMMENT     L   COMMENT ON COLUMN public.secretaria_organiza_reuniones.trial085 IS 'TRIAL';
          public          postgres    false    240            �            1259    18145    señoras_limpieza    TABLE     �   CREATE TABLE public."señoras_limpieza" (
    dni character varying(9) NOT NULL,
    nombre character varying(15) NOT NULL,
    apellidos character varying(15),
    edad numeric(2,0) NOT NULL,
    trial085 character(1)
);
 '   DROP TABLE public."señoras_limpieza";
       public         heap    postgres    false            I           0    0    TABLE "señoras_limpieza"    COMMENT     8   COMMENT ON TABLE public."señoras_limpieza" IS 'TRIAL';
          public          postgres    false    241            J           0    0    COLUMN "señoras_limpieza".dni    COMMENT     =   COMMENT ON COLUMN public."señoras_limpieza".dni IS 'TRIAL';
          public          postgres    false    241            K           0    0 !   COLUMN "señoras_limpieza".nombre    COMMENT     @   COMMENT ON COLUMN public."señoras_limpieza".nombre IS 'TRIAL';
          public          postgres    false    241            L           0    0 $   COLUMN "señoras_limpieza".apellidos    COMMENT     C   COMMENT ON COLUMN public."señoras_limpieza".apellidos IS 'TRIAL';
          public          postgres    false    241            M           0    0    COLUMN "señoras_limpieza".edad    COMMENT     >   COMMENT ON COLUMN public."señoras_limpieza".edad IS 'TRIAL';
          public          postgres    false    241            N           0    0 #   COLUMN "señoras_limpieza".trial085    COMMENT     B   COMMENT ON COLUMN public."señoras_limpieza".trial085 IS 'TRIAL';
          public          postgres    false    241            �            1259    18148 #   señoreslimpieza_trabajan_almacenes    TABLE     �   CREATE TABLE public."señoreslimpieza_trabajan_almacenes" (
    dni character varying(9) NOT NULL,
    "ubicación" character varying(100) NOT NULL,
    trial085 character(1)
);
 9   DROP TABLE public."señoreslimpieza_trabajan_almacenes";
       public         heap    postgres    false            O           0    0 +   TABLE "señoreslimpieza_trabajan_almacenes"    COMMENT     J   COMMENT ON TABLE public."señoreslimpieza_trabajan_almacenes" IS 'TRIAL';
          public          postgres    false    242            P           0    0 0   COLUMN "señoreslimpieza_trabajan_almacenes".dni    COMMENT     O   COMMENT ON COLUMN public."señoreslimpieza_trabajan_almacenes".dni IS 'TRIAL';
          public          postgres    false    242            Q           0    0 9   COLUMN "señoreslimpieza_trabajan_almacenes"."ubicación"    COMMENT     X   COMMENT ON COLUMN public."señoreslimpieza_trabajan_almacenes"."ubicación" IS 'TRIAL';
          public          postgres    false    242            R           0    0 5   COLUMN "señoreslimpieza_trabajan_almacenes".trial085    COMMENT     T   COMMENT ON COLUMN public."señoreslimpieza_trabajan_almacenes".trial085 IS 'TRIAL';
          public          postgres    false    242            �            1259    18151 
   vehículos    TABLE     �   CREATE TABLE public."vehículos" (
    "matrícula" character varying(20) NOT NULL,
    "kilómetros" numeric(9,2) NOT NULL,
    dni_repartidor character varying(9),
    trial085 character(1)
);
     DROP TABLE public."vehículos";
       public         heap    postgres    false            S           0    0    TABLE "vehículos"    COMMENT     1   COMMENT ON TABLE public."vehículos" IS 'TRIAL';
          public          postgres    false    243            T           0    0     COLUMN "vehículos"."matrícula"    COMMENT     ?   COMMENT ON COLUMN public."vehículos"."matrícula" IS 'TRIAL';
          public          postgres    false    243            U           0    0 !   COLUMN "vehículos"."kilómetros"    COMMENT     @   COMMENT ON COLUMN public."vehículos"."kilómetros" IS 'TRIAL';
          public          postgres    false    243            V           0    0 "   COLUMN "vehículos".dni_repartidor    COMMENT     A   COMMENT ON COLUMN public."vehículos".dni_repartidor IS 'TRIAL';
          public          postgres    false    243            W           0    0    COLUMN "vehículos".trial085    COMMENT     ;   COMMENT ON COLUMN public."vehículos".trial085 IS 'TRIAL';
          public          postgres    false    243            �           2604    18154    personal cantidad_trabajadores    DEFAULT     �   ALTER TABLE ONLY public.personal ALTER COLUMN cantidad_trabajadores SET DEFAULT nextval('public.personal_cantidad_trabajadores_seq'::regclass);
 M   ALTER TABLE public.personal ALTER COLUMN cantidad_trabajadores DROP DEFAULT;
       public          postgres    false    236    234            �          0    18076    agencia_arroja_facturas 
   TABLE DATA           [   COPY public.agencia_arroja_facturas ("dirección_sede", cod_factura, trial079) FROM stdin;
    public          postgres    false    218   X      �          0    18079    agencia_emite_albaranes 
   TABLE DATA           ^   COPY public.agencia_emite_albaranes ("dirección_sede", "cod_albarán", trial079) FROM stdin;
    public          postgres    false    219   u      �          0    18082    agencia_envios 
   TABLE DATA           E   COPY public.agencia_envios ("dirección_sede", trial079) FROM stdin;
    public          postgres    false    220   �      �          0    18085 	   albaranes 
   TABLE DATA           J   COPY public.albaranes ("codigo_albarán", detalles, trial079) FROM stdin;
    public          postgres    false    221   �      �          0    18088 	   almacenes 
   TABLE DATA           O   COPY public.almacenes ("ubicación", capacidad_paquetes, trial079) FROM stdin;
    public          postgres    false    222   �      �          0    18091 
   base_datos 
   TABLE DATA           J   COPY public.base_datos (tablas, cantidad_registros, trial082) FROM stdin;
    public          postgres    false    223   �      �          0    18094    ciudades 
   TABLE DATA           G   COPY public.ciudades (nombre, cantidad_oficinas, trial082) FROM stdin;
    public          postgres    false    224         �          0    18045    cliente 
   TABLE DATA           J   COPY public.cliente ("dirección", correo, nombre, apellidos) FROM stdin;
    public          postgres    false    214   #      �          0    18097    clientes_firman_nota 
   TABLE DATA           P   COPY public.clientes_firman_nota ("dirección", cod_nota, trial082) FROM stdin;
    public          postgres    false    225   �      �          0    18100    clientes_pagan_facturas 
   TABLE DATA           V   COPY public.clientes_pagan_facturas ("dirección", cod_factura, trial082) FROM stdin;
    public          postgres    false    226   �      �          0    18039    envio 
   TABLE DATA           f   COPY public.envio ("cod_envío", "dirección", "descripción", informacion_extra, estado) FROM stdin;
    public          postgres    false    213   �      �          0    18103    facturas 
   TABLE DATA           E   COPY public.facturas (codigo_factura, importe, trial082) FROM stdin;
    public          postgres    false    227   h      �          0    18106    gestor_paquetes 
   TABLE DATA           Q   COPY public.gestor_paquetes (dni, nombre, apellidos, edad, trial082) FROM stdin;
    public          postgres    false    228   �      �          0    18109    gestor_paquetes_almacenes 
   TABLE DATA           P   COPY public.gestor_paquetes_almacenes (dni, "ubicación", trial082) FROM stdin;
    public          postgres    false    229   �      �          0    18112    jefe 
   TABLE DATA           F   COPY public.jefe (dni, nombre, apellidos, edad, trial082) FROM stdin;
    public          postgres    false    230   �      �          0    18115    nota_entrega 
   TABLE DATA           X   COPY public.nota_entrega (cod_nota, estado, "información_extra", trial082) FROM stdin;
    public          postgres    false    231   �      �          0    18120    oficinas 
   TABLE DATA           Q   COPY public.oficinas ("ubicación", cantidad_trabajadores, trial082) FROM stdin;
    public          postgres    false    232   �      �          0    18123    países 
   TABLE DATA           H   COPY public."países" (nombre, cantidad_ciudades, trial082) FROM stdin;
    public          postgres    false    233         �          0    18126    personal 
   TABLE DATA           a   COPY public.personal (dni, cantidad_trabajadores, nombre, apellidos, edad, trial082) FROM stdin;
    public          postgres    false    234   3      �          0    18129    personal_acude_reuniones 
   TABLE DATA           Q   COPY public.personal_acude_reuniones (dni, "cod_reunión", trial082) FROM stdin;
    public          postgres    false    235   P      �          0    18050    producto 
   TABLE DATA           C   COPY public.producto (cod_producto, estado, proveedor) FROM stdin;
    public          postgres    false    215   m      �          0    18055 	   proveedor 
   TABLE DATA           ~   COPY public.proveedor (cod_proveedor, nombre_proveedor, direccion, pais, estado, ciudad, codigo_postal, telefono) FROM stdin;
    public          postgres    false    217   �      �          0    18133    repartidores 
   TABLE DATA           N   COPY public.repartidores (dni, nombre, apellidos, edad, trial085) FROM stdin;
    public          postgres    false    237   �      �          0    18136 	   reuniones 
   TABLE DATA           \   COPY public.reuniones ("cod_reunión", asunto, cantidad_trabajadores, trial085) FROM stdin;
    public          postgres    false    238   �      �          0    18139 
   secretaria 
   TABLE DATA           L   COPY public.secretaria (dni, nombre, apellidos, edad, trial085) FROM stdin;
    public          postgres    false    239   �      �          0    18142    secretaria_organiza_reuniones 
   TABLE DATA           V   COPY public.secretaria_organiza_reuniones (dni, "cod_reunión", trial085) FROM stdin;
    public          postgres    false    240   �      �          0    18145    señoras_limpieza 
   TABLE DATA           U   COPY public."señoras_limpieza" (dni, nombre, apellidos, edad, trial085) FROM stdin;
    public          postgres    false    241         �          0    18148 #   señoreslimpieza_trabajan_almacenes 
   TABLE DATA           \   COPY public."señoreslimpieza_trabajan_almacenes" (dni, "ubicación", trial085) FROM stdin;
    public          postgres    false    242   ,      �          0    18151 
   vehículos 
   TABLE DATA           ]   COPY public."vehículos" ("matrícula", "kilómetros", dni_repartidor, trial085) FROM stdin;
    public          postgres    false    243   I      X           0    0    cod_prov_sec    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.cod_prov_sec', 23, true);
          public          postgres    false    216            Y           0    0 "   personal_cantidad_trabajadores_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.personal_cantidad_trabajadores_seq', 1, false);
          public          postgres    false    236            �           2606    18156    proveedor cod_proveedor_unique 
   CONSTRAINT     b   ALTER TABLE ONLY public.proveedor
    ADD CONSTRAINT cod_proveedor_unique UNIQUE (cod_proveedor);
 H   ALTER TABLE ONLY public.proveedor DROP CONSTRAINT cod_proveedor_unique;
       public            postgres    false    217                       2606    18158     agencia_envios pk_agencia_envios 
   CONSTRAINT     m   ALTER TABLE ONLY public.agencia_envios
    ADD CONSTRAINT pk_agencia_envios PRIMARY KEY ("dirección_sede");
 J   ALTER TABLE ONLY public.agencia_envios DROP CONSTRAINT pk_agencia_envios;
       public            postgres    false    220                       2606    18160    albaranes pk_albaranes 
   CONSTRAINT     c   ALTER TABLE ONLY public.albaranes
    ADD CONSTRAINT pk_albaranes PRIMARY KEY ("codigo_albarán");
 @   ALTER TABLE ONLY public.albaranes DROP CONSTRAINT pk_albaranes;
       public            postgres    false    221                       2606    18162    almacenes pk_almacenes 
   CONSTRAINT     ^   ALTER TABLE ONLY public.almacenes
    ADD CONSTRAINT pk_almacenes PRIMARY KEY ("ubicación");
 @   ALTER TABLE ONLY public.almacenes DROP CONSTRAINT pk_almacenes;
       public            postgres    false    222                       2606    18164    ciudades pk_ciudades 
   CONSTRAINT     V   ALTER TABLE ONLY public.ciudades
    ADD CONSTRAINT pk_ciudades PRIMARY KEY (nombre);
 >   ALTER TABLE ONLY public.ciudades DROP CONSTRAINT pk_ciudades;
       public            postgres    false    224                       2606    18166    facturas pk_facturas 
   CONSTRAINT     ^   ALTER TABLE ONLY public.facturas
    ADD CONSTRAINT pk_facturas PRIMARY KEY (codigo_factura);
 >   ALTER TABLE ONLY public.facturas DROP CONSTRAINT pk_facturas;
       public            postgres    false    227                       2606    18168    nota_entrega pk_nota_entrega 
   CONSTRAINT     `   ALTER TABLE ONLY public.nota_entrega
    ADD CONSTRAINT pk_nota_entrega PRIMARY KEY (cod_nota);
 F   ALTER TABLE ONLY public.nota_entrega DROP CONSTRAINT pk_nota_entrega;
       public            postgres    false    231                       2606    18170    oficinas pk_oficinas 
   CONSTRAINT     \   ALTER TABLE ONLY public.oficinas
    ADD CONSTRAINT pk_oficinas PRIMARY KEY ("ubicación");
 >   ALTER TABLE ONLY public.oficinas DROP CONSTRAINT pk_oficinas;
       public            postgres    false    232                       2606    18172    países pk_países 
   CONSTRAINT     X   ALTER TABLE ONLY public."países"
    ADD CONSTRAINT "pk_países" PRIMARY KEY (nombre);
 @   ALTER TABLE ONLY public."países" DROP CONSTRAINT "pk_países";
       public            postgres    false    233                       2606    18174    personal pk_personal 
   CONSTRAINT     j   ALTER TABLE ONLY public.personal
    ADD CONSTRAINT pk_personal PRIMARY KEY (dni, cantidad_trabajadores);
 >   ALTER TABLE ONLY public.personal DROP CONSTRAINT pk_personal;
       public            postgres    false    234    234                        2606    18176    reuniones pk_reuniones 
   CONSTRAINT     `   ALTER TABLE ONLY public.reuniones
    ADD CONSTRAINT pk_reuniones PRIMARY KEY ("cod_reunión");
 @   ALTER TABLE ONLY public.reuniones DROP CONSTRAINT pk_reuniones;
       public            postgres    false    238            )           2606    18178    vehículos pk_vehículos 
   CONSTRAINT     d   ALTER TABLE ONLY public."vehículos"
    ADD CONSTRAINT "pk_vehículos" PRIMARY KEY ("matrícula");
 F   ALTER TABLE ONLY public."vehículos" DROP CONSTRAINT "pk_vehículos";
       public            postgres    false    243            �           2606    18180    envio primarykeycod 
   CONSTRAINT     V   ALTER TABLE ONLY public.envio
    ADD CONSTRAINT primarykeycod UNIQUE ("cod_envío");
 =   ALTER TABLE ONLY public.envio DROP CONSTRAINT primarykeycod;
       public            postgres    false    213            �           2606    18182    producto primarykeycodigo 
   CONSTRAINT     \   ALTER TABLE ONLY public.producto
    ADD CONSTRAINT primarykeycodigo UNIQUE (cod_producto);
 C   ALTER TABLE ONLY public.producto DROP CONSTRAINT primarykeycodigo;
       public            postgres    false    215            �           2606    18184    cliente primarykeydir 
   CONSTRAINT     X   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT primarykeydir UNIQUE ("dirección");
 ?   ALTER TABLE ONLY public.cliente DROP CONSTRAINT primarykeydir;
       public            postgres    false    214            �           1259    18185    fk1_agencia_arroja_facturas    INDEX     l   CREATE INDEX fk1_agencia_arroja_facturas ON public.agencia_arroja_facturas USING btree ("dirección_sede");
 /   DROP INDEX public.fk1_agencia_arroja_facturas;
       public            postgres    false    218            �           1259    18186    fk1_agencia_emite_albaranes    INDEX     l   CREATE INDEX fk1_agencia_emite_albaranes ON public.agencia_emite_albaranes USING btree ("dirección_sede");
 /   DROP INDEX public.fk1_agencia_emite_albaranes;
       public            postgres    false    219            	           1259    18187    fk1_clientes_firman_nota    INDEX     a   CREATE INDEX fk1_clientes_firman_nota ON public.clientes_firman_nota USING btree ("dirección");
 ,   DROP INDEX public.fk1_clientes_firman_nota;
       public            postgres    false    225                       1259    18188    fk1_clientes_pagan_facturas    INDEX     g   CREATE INDEX fk1_clientes_pagan_facturas ON public.clientes_pagan_facturas USING btree ("dirección");
 /   DROP INDEX public.fk1_clientes_pagan_facturas;
       public            postgres    false    226                       1259    18189    fk1_gestor_paquetes_almacenes    INDEX     b   CREATE INDEX fk1_gestor_paquetes_almacenes ON public.gestor_paquetes_almacenes USING btree (dni);
 1   DROP INDEX public.fk1_gestor_paquetes_almacenes;
       public            postgres    false    229                       1259    18190    fk1_personal_acude_reuniones    INDEX     `   CREATE INDEX fk1_personal_acude_reuniones ON public.personal_acude_reuniones USING btree (dni);
 0   DROP INDEX public.fk1_personal_acude_reuniones;
       public            postgres    false    235            %           1259    18191 '   fk1_señoreslimpieza_trabajan_almacenes    INDEX     z   CREATE INDEX "fk1_señoreslimpieza_trabajan_almacenes" ON public."señoreslimpieza_trabajan_almacenes" USING btree (dni);
 =   DROP INDEX public."fk1_señoreslimpieza_trabajan_almacenes";
       public            postgres    false    242            �           1259    18192    fk2_agencia_arroja_facturas    INDEX     f   CREATE INDEX fk2_agencia_arroja_facturas ON public.agencia_arroja_facturas USING btree (cod_factura);
 /   DROP INDEX public.fk2_agencia_arroja_facturas;
       public            postgres    false    218                        1259    18193    fk2_agencia_emite_albaranes    INDEX     i   CREATE INDEX fk2_agencia_emite_albaranes ON public.agencia_emite_albaranes USING btree ("cod_albarán");
 /   DROP INDEX public.fk2_agencia_emite_albaranes;
       public            postgres    false    219            
           1259    18194    fk2_clientes_firman_nota    INDEX     ]   CREATE INDEX fk2_clientes_firman_nota ON public.clientes_firman_nota USING btree (cod_nota);
 ,   DROP INDEX public.fk2_clientes_firman_nota;
       public            postgres    false    225                       1259    18195    fk2_clientes_pagan_facturas    INDEX     f   CREATE INDEX fk2_clientes_pagan_facturas ON public.clientes_pagan_facturas USING btree (cod_factura);
 /   DROP INDEX public.fk2_clientes_pagan_facturas;
       public            postgres    false    226                       1259    18196    fk2_gestor_paquetes_almacenes    INDEX     k   CREATE INDEX fk2_gestor_paquetes_almacenes ON public.gestor_paquetes_almacenes USING btree ("ubicación");
 1   DROP INDEX public.fk2_gestor_paquetes_almacenes;
       public            postgres    false    229                       1259    18197    fk2_personal_acude_reuniones    INDEX     k   CREATE INDEX fk2_personal_acude_reuniones ON public.personal_acude_reuniones USING btree ("cod_reunión");
 0   DROP INDEX public.fk2_personal_acude_reuniones;
       public            postgres    false    235            &           1259    18198 '   fk2_señoreslimpieza_trabajan_almacenes    INDEX     �   CREATE INDEX "fk2_señoreslimpieza_trabajan_almacenes" ON public."señoreslimpieza_trabajan_almacenes" USING btree ("ubicación");
 =   DROP INDEX public."fk2_señoreslimpieza_trabajan_almacenes";
       public            postgres    false    242                       1259    18199    fk_gestor_paquetes    INDEX     M   CREATE INDEX fk_gestor_paquetes ON public.gestor_paquetes USING btree (dni);
 &   DROP INDEX public.fk_gestor_paquetes;
       public            postgres    false    228                       1259    18200    fk_jefe    INDEX     7   CREATE INDEX fk_jefe ON public.jefe USING btree (dni);
    DROP INDEX public.fk_jefe;
       public            postgres    false    230                       1259    18201    fk_repartidores    INDEX     G   CREATE INDEX fk_repartidores ON public.repartidores USING btree (dni);
 #   DROP INDEX public.fk_repartidores;
       public            postgres    false    237            !           1259    18202    fk_secretaria    INDEX     C   CREATE INDEX fk_secretaria ON public.secretaria USING btree (dni);
 !   DROP INDEX public.fk_secretaria;
       public            postgres    false    239            "           1259    18203 !   fk_secretaria_organiza_reuniones1    INDEX     j   CREATE INDEX fk_secretaria_organiza_reuniones1 ON public.secretaria_organiza_reuniones USING btree (dni);
 5   DROP INDEX public.fk_secretaria_organiza_reuniones1;
       public            postgres    false    240            #           1259    18204 !   fk_secretaria_organiza_reuniones2    INDEX     u   CREATE INDEX fk_secretaria_organiza_reuniones2 ON public.secretaria_organiza_reuniones USING btree ("cod_reunión");
 5   DROP INDEX public.fk_secretaria_organiza_reuniones2;
       public            postgres    false    240            $           1259    18205    fk_señoras_limpieza    INDEX     U   CREATE INDEX "fk_señoras_limpieza" ON public."señoras_limpieza" USING btree (dni);
 *   DROP INDEX public."fk_señoras_limpieza";
       public            postgres    false    241            '           1259    18206    fk_vehiculos_repartidores    INDEX     \   CREATE INDEX fk_vehiculos_repartidores ON public."vehículos" USING btree (dni_repartidor);
 -   DROP INDEX public.fk_vehiculos_repartidores;
       public            postgres    false    243                       1259    18207    idx_cantidad_trabajadores    INDEX     f   CREATE UNIQUE INDEX idx_cantidad_trabajadores ON public.personal USING btree (cantidad_trabajadores);
 -   DROP INDEX public.idx_cantidad_trabajadores;
       public            postgres    false    234            2           2620    18250    cliente eliminar_envios_trigger    TRIGGER     ~   CREATE TRIGGER eliminar_envios_trigger AFTER DELETE ON public.cliente FOR EACH ROW EXECUTE FUNCTION public.eliminar_envios();
 8   DROP TRIGGER eliminar_envios_trigger ON public.cliente;
       public          postgres    false    214    264            3           2620    18256 #   proveedor eliminar_producto_trigger    TRIGGER     �   CREATE TRIGGER eliminar_producto_trigger AFTER DELETE ON public.proveedor FOR EACH ROW EXECUTE FUNCTION public.eliminar_productos();
 <   DROP TRIGGER eliminar_producto_trigger ON public.proveedor;
       public          postgres    false    217    265            *           2606    18208 3   agencia_arroja_facturas fk1_agencia_arroja_facturas    FK CONSTRAINT     �   ALTER TABLE ONLY public.agencia_arroja_facturas
    ADD CONSTRAINT fk1_agencia_arroja_facturas FOREIGN KEY ("dirección_sede") REFERENCES public.agencia_envios("dirección_sede") ON UPDATE CASCADE ON DELETE CASCADE;
 ]   ALTER TABLE ONLY public.agencia_arroja_facturas DROP CONSTRAINT fk1_agencia_arroja_facturas;
       public          postgres    false    220    3330    218            ,           2606    18213 3   agencia_emite_albaranes fk1_agencia_emite_albaranes    FK CONSTRAINT     �   ALTER TABLE ONLY public.agencia_emite_albaranes
    ADD CONSTRAINT fk1_agencia_emite_albaranes FOREIGN KEY ("dirección_sede") REFERENCES public.agencia_envios("dirección_sede") ON UPDATE CASCADE ON DELETE CASCADE;
 ]   ALTER TABLE ONLY public.agencia_emite_albaranes DROP CONSTRAINT fk1_agencia_emite_albaranes;
       public          postgres    false    3330    220    219            +           2606    18218 3   agencia_arroja_facturas fk2_agencia_arroja_facturas    FK CONSTRAINT     �   ALTER TABLE ONLY public.agencia_arroja_facturas
    ADD CONSTRAINT fk2_agencia_arroja_facturas FOREIGN KEY (cod_factura) REFERENCES public.facturas(codigo_factura) ON UPDATE CASCADE ON DELETE CASCADE;
 ]   ALTER TABLE ONLY public.agencia_arroja_facturas DROP CONSTRAINT fk2_agencia_arroja_facturas;
       public          postgres    false    3342    218    227            -           2606    18223 3   agencia_emite_albaranes fk2_agencia_emite_albaranes    FK CONSTRAINT     �   ALTER TABLE ONLY public.agencia_emite_albaranes
    ADD CONSTRAINT fk2_agencia_emite_albaranes FOREIGN KEY ("cod_albarán") REFERENCES public.albaranes("codigo_albarán") ON UPDATE CASCADE ON DELETE CASCADE;
 ]   ALTER TABLE ONLY public.agencia_emite_albaranes DROP CONSTRAINT fk2_agencia_emite_albaranes;
       public          postgres    false    221    3332    219            .           2606    18228 7   gestor_paquetes_almacenes fk2_gestor_paquetes_almacenes    FK CONSTRAINT     �   ALTER TABLE ONLY public.gestor_paquetes_almacenes
    ADD CONSTRAINT fk2_gestor_paquetes_almacenes FOREIGN KEY ("ubicación") REFERENCES public.almacenes("ubicación") ON UPDATE CASCADE ON DELETE CASCADE;
 a   ALTER TABLE ONLY public.gestor_paquetes_almacenes DROP CONSTRAINT fk2_gestor_paquetes_almacenes;
       public          postgres    false    229    222    3334            /           2606    18233 5   personal_acude_reuniones fk2_personal_acude_reuniones    FK CONSTRAINT     �   ALTER TABLE ONLY public.personal_acude_reuniones
    ADD CONSTRAINT fk2_personal_acude_reuniones FOREIGN KEY ("cod_reunión") REFERENCES public.reuniones("cod_reunión") ON UPDATE CASCADE ON DELETE CASCADE;
 _   ALTER TABLE ONLY public.personal_acude_reuniones DROP CONSTRAINT fk2_personal_acude_reuniones;
       public          postgres    false    235    238    3360            1           2606    18238 K   señoreslimpieza_trabajan_almacenes fk2_señoreslimpieza_trabajan_almacenes    FK CONSTRAINT     �   ALTER TABLE ONLY public."señoreslimpieza_trabajan_almacenes"
    ADD CONSTRAINT "fk2_señoreslimpieza_trabajan_almacenes" FOREIGN KEY ("ubicación") REFERENCES public.almacenes("ubicación") ON UPDATE CASCADE ON DELETE CASCADE;
 y   ALTER TABLE ONLY public."señoreslimpieza_trabajan_almacenes" DROP CONSTRAINT "fk2_señoreslimpieza_trabajan_almacenes";
       public          postgres    false    3334    222    242            0           2606    18243 ?   secretaria_organiza_reuniones fk_secretaria_organiza_reuniones2    FK CONSTRAINT     �   ALTER TABLE ONLY public.secretaria_organiza_reuniones
    ADD CONSTRAINT fk_secretaria_organiza_reuniones2 FOREIGN KEY ("cod_reunión") REFERENCES public.reuniones("cod_reunión") ON UPDATE CASCADE ON DELETE CASCADE;
 i   ALTER TABLE ONLY public.secretaria_organiza_reuniones DROP CONSTRAINT fk_secretaria_organiza_reuniones2;
       public          postgres    false    238    240    3360            �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   �   x�M��	�0ߺ*���G ��"+�bIg���RB����.3,��	�Z���bZ���I]�쮆�s��^��{� ���X3�a2��3��Х��U�b�R^ZD�/F�߱�S�Q�=�(	�N����t=�      �      x������ � �      �      x������ � �      �   g   x�]�;
�P�zf��f	"i�����<cx��G[�S�V^	n=)BD/�;¡���/�ꗿ�!��)S��ҙ��atC�璵}�O�r��_�\�K���=$v      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   .   x�3�tL.�,��44�2�tI-I��L�̹�8=��r�\1z\\\ ��      �   �   x�U�Mj�@�ךS��?q�.Kh�	%4�BPF"��5��^�X%�,��%]8�V�ӧW��bw���r�O�R��ڋ�:]lI��L�$��$�4�9��|w��T�cYV�+kx�?�W��z
Ap?ꙥ�6��\��%��'�}�wI�����$1V�A��4P�`��y�W��S���ŌM���I���~����e�S�(�a���9���A�Em���>Vι_�n�      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �     