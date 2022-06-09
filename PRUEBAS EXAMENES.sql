--PAQUETE PRUEBAS EXAMENES
create or replace
PACKAGE PRUEBAS_EXAMENES AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2,
    w_oid_ex IN examen.oid_ex%TYPE,
    w_fecha IN examen.fecha%TYPE,
    w_tipo IN examen.tipo%TYPE, salidaEsperada BOOLEAN);
PROCEDURE eliminar(nombre_prueba VARCHAR2,
    w_oid_ex IN examen.oid_ex%TYPE, salidaEsperada BOOLEAN);
    
END PRUEBAS_EXAMENES;
/

create or replace
PACKAGE BODY PRUEBAS_EXAMENES AS
PROCEDURE inicializar AS
BEGIN
DELETE FROM EXAMEN;
END inicializar;
PROCEDURE insertar (nombre_prueba VARCHAR2,
    w_oid_ex IN examen.oid_ex%TYPE,
    w_fecha IN examen.fecha%TYPE,
    w_tipo IN examen.tipo%TYPE, salidaEsperada BOOLEAN) AS
salida BOOLEAN := true;
EX EXAMEN%ROWTYPE;
BEGIN
insert into EXAMEN (OID_EX, fecha, tipo) 
    values( w_oid_ex, w_fecha, w_tipo);
select * into ex from EXAMEN where OID_EX = w_oid_ex;
IF(ex.oid_ex<> w_oid_ex OR ex.fecha<>w_fecha OR ex.tipo<>w_tipo )
THEN salida:=false;
END IF;
COMMIT WORK;
DBMS_OUTPUT.put_line(nombre_prueba|| ':' || ASSERT_EQUALS(salida,salidaEsperada));
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.put_line(nombre_prueba|| ':' || ASSERT_EQUALS(false,salidaEsperada));
ROLLBACK;
END insertar;

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_ex IN examen.oid_ex%TYPE, salidaEsperada BOOLEAN) AS
salida BOOLEAN := true;
num_examenes INTEGER;
BEGIN
DELETE FROM EXAMEN WHERE OID_EX = w_oid_ex;
select count(*) into num_examenes from EXAMEN where OID_EX=w_oid_ex;
IF(num_examenes<>0) THEN
salida:=false;
END IF;
COMMIT WORK;
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
ROLLBACK;
END eliminar;
END PRUEBAS_EXAMENES;
/


SET SERVEROUTPUT ON; 
BEGIN
/*PRUEBAS EXAMEN*/
PRUEBAS_EXAMENES.insertar('Prueba 1 – inserción examen             ',1,TO_DATE('2019-08-12','YYYY-MM-DD'), 'teórico'  , true);
PRUEBAS_EXAMENES.insertar('Prueba 2 – inserción examen             ',2,TO_DATE('2019-09-12','YYYY-MM-DD'), 'práctico' , true);
PRUEBAS_EXAMENES.insertar('Prueba 3 – inserción examen             ',3,TO_DATE('2019-10-11','YYYY-MM-DD'), 'teórico'  , true);
PRUEBAS_EXAMENES.insertar('Prueba 4 – inserción examen             ',4,TO_DATE('2019-10-30','YYYY-MM-DD'), 'práctico' , true);
PRUEBAS_EXAMENES.insertar('Prueba 5 – inserción examen a eliminar  ',5,TO_DATE('2019-11-19','YYYY-MM-DD'), 'teórico'  , true);
PRUEBAS_EXAMENES.eliminar('Prueba 6 – eliminar  examen             ',5,true);
END;
/





