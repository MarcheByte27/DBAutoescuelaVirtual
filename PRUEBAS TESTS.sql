--PAQUETE PRUEBAS TESTS
create or replace
PACKAGE PRUEBAS_TESTS AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2,
    w_oid_test in tests.oid_test%TYPE,
    w_fallos in tests.fallos%TYPE,
    w_fecha in tests.fecha%TYPE,
    w_DNI_A in tests.DNI_A%TYPE, salidaEsperada BOOLEAN);
PROCEDURE eliminar(nombre_prueba VARCHAR2,
    w_oid_test IN tests.oid_test%TYPE, salidaEsperada BOOLEAN);
    
END PRUEBAS_TESTS;
/

create or replace
PACKAGE BODY PRUEBAS_TESTS AS
PROCEDURE inicializar AS
BEGIN
DELETE FROM ALUMNO;
END inicializar;
PROCEDURE insertar (nombre_prueba VARCHAR2,
    w_oid_test in tests.oid_test%TYPE,
    w_fallos in tests.fallos%TYPE,
    w_fecha in tests.fecha%TYPE,
    w_DNI_A in tests.DNI_A%TYPE, salidaEsperada BOOLEAN) AS
salida BOOLEAN := true;
tes TESTS%ROWTYPE;
BEGIN
INSERT INTO TESTS(oid_test, fallos, fecha, DNI_A) 
    VALUES (w_oid_test,w_fallos, w_fecha, w_DNI_A);
select * into tes from TESTS where OID_TEST = w_oid_test;
IF(tes.OID_TEST<>w_oid_test OR tes.fallos<>w_fallos OR tes.fecha<>w_fecha  OR tes.DNI_A<>w_DNI_A )
THEN salida:=false;
END IF;
COMMIT WORK;
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
ROLLBACK;
END insertar;

PROCEDURE eliminar (nombre_prueba VARCHAR2,
    w_oid_test IN tests.oid_test%TYPE, salidaEsperada BOOLEAN) AS
salida BOOLEAN := true;
num_tests INTEGER;
BEGIN
DELETE FROM TESTS WHERE OID_TEST=w_oid_test;
select count(*) into num_tests from TESTS where OID_TEST=w_oid_test;
IF(num_tests<>0) THEN
salida:=false;
END IF;
COMMIT WORK;
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
ROLLBACK;
END eliminar;
END PRUEBAS_TESTS;
/


--cambiar el numero 1 de la referencia por el primer dni

SET SERVEROUTPUT ON; 
BEGIN
/* PRUEBAS TEST DEL ALUMNO 1 */
PRUEBAS_TESTS.inicializar;
PRUEBAS_TESTS.insertar('Prueba 1 – insercción test con fallos negativos         ', 1, '-1',  TO_DATE('2019-06-29','YYYY-MM-DD'),'28905409K',false);
PRUEBAS_TESTS.insertar('Prueba 2 – insercción test                              ', 2, '4' ,  TO_DATE('2019-06-29','YYYY-MM-DD'),'28905409K',true);
PRUEBAS_TESTS.insertar('Prueba 3 – insercción test                              ', 3, '5' ,  TO_DATE('2019-06-30','YYYY-MM-DD'),'28905409K',true);
PRUEBAS_TESTS.insertar('Prueba 4 – insercción test                              ', 4, '30',  TO_DATE('2019-06-19','YYYY-MM-DD'),'28905409K',true);
PRUEBAS_TESTS.insertar('Prueba 5 – insercción test                              ', 5, '0' ,  TO_DATE('2019-06-20','YYYY-MM-DD'),'28905409K',true);
PRUEBAS_TESTS.insertar('Prueba 6 – insercción test con más fallos que preguntas ', 6, '31',  TO_DATE('2019-06-12','YYYY-MM-DD'),'28905409K',false);
PRUEBAS_TESTS.eliminar('Prueba 7 – eliminar test                                ', 2,true);
END;
/
