--PAQUETE PRUEBAS ASISTEA
create or replace
PACKAGE PRUEBAS_ASISTEA AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2,
    w_oid_asis IN ASISTEA.oid_te%TYPE,
    w_DNI_A IN ASISTEA.DNI_A%TYPE, 
    w_oid_te IN ASISTEA.oid_te%TYPE, salidaEsperada BOOLEAN);
PROCEDURE eliminar(nombre_prueba VARCHAR2,
    w_oid_asis IN asistea.oid_asis%TYPE, salidaEsperada BOOLEAN);
    
END PRUEBAS_ASISTEA;
/

create or replace
PACKAGE BODY PRUEBAS_ASISTEA AS
PROCEDURE inicializar AS
BEGIN
DELETE FROM ASISTEA;
END inicializar;
PROCEDURE insertar (nombre_prueba VARCHAR2,
    w_oid_asis IN ASISTEA.oid_te%TYPE,
    w_DNI_A IN ASISTEA.DNI_A%TYPE, 
    w_oid_te IN ASISTEA.oid_te%TYPE, salidaEsperada BOOLEAN) AS
salida BOOLEAN := true;
ASIS ASISTEA%ROWTYPE;
BEGIN
INSERT INTO ASISTEA(oid_asis, DNI_A, oid_te) 
        VALUES (w_oid_asis, w_DNI_A, w_oid_te);
        
select * into asis from asistea where OID_asis = w_oid_asis;
IF(asis.OID_asis<>w_oid_asis OR asis.DNI_A<>w_DNI_A OR asis.oid_te<>w_oid_te)
    
THEN salida:=false;
END IF;
COMMIT WORK;
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
ROLLBACK;
END insertar;

PROCEDURE eliminar (nombre_prueba VARCHAR2,w_oid_asis IN asistea.oid_asis%TYPE, salidaEsperada BOOLEAN) AS
salida BOOLEAN := true;
num_asis INTEGER;
BEGIN
DELETE FROM asistea WHERE OID_asis=w_oid_asis;
select count(*) into num_asis from asistea where OID_asis=w_oid_asis;
IF(num_asis<>0) THEN
salida:=false;
END IF;
COMMIT WORK;
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
ROLLBACK;
END eliminar;
END PRUEBAS_ASISTEA;
/

--CAMBIAR OID'S POR DNI'S
SET SERVEROUTPUT ON; 
BEGIN
/*PRUEBAS PRACTICA*/
PRUEBAS_ASISTEA.inicializar;
PRUEBAS_ASISTEA.insertar('Prueba 1 – insercción relacion                 ', 1 , '28905409K' , 1 ,true);
PRUEBAS_ASISTEA.insertar('Prueba 2 – insercción relacion                 ', 2 , '28905409K' , 2 ,true);
PRUEBAS_ASISTEA.insertar('Prueba 3 – insercción relacion                 ', 3 , '28905409K' , 3 ,true);
PRUEBAS_ASISTEA.insertar('Prueba 4 – insercción relacion para eliminarla ', 4 , '42034069F' , 2 ,true);
PRUEBAS_ASISTEA.eliminar('Prueba 5 – eliminar relacion                   ', 4 , true);
END;
/



