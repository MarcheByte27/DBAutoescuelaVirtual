--PAQUETE PRUEBAS PRACTICAS
create or replace
PACKAGE PRUEBAS_PRACTICAS AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2,
    w_oid_pra IN practica.oid_pra%TYPE,
    w_DNI_A IN practica.DNI_A%TYPE,
    w_DNI_P IN practica.DNI_P%TYPE,
    w_fecha IN practica.fecha%TYPE, salidaEsperada BOOLEAN);
PROCEDURE eliminar(nombre_prueba VARCHAR2,
    w_oid_pra IN practica.oid_pra%TYPE, salidaEsperada BOOLEAN);
    
END PRUEBAS_PRACTICAS;
/


create or replace
PACKAGE BODY PRUEBAS_PRACTICAS AS
PROCEDURE inicializar AS
BEGIN
DELETE FROM PRACTICA;
END inicializar;
PROCEDURE insertar (nombre_prueba VARCHAR2,w_oid_pra IN practica.oid_pra%TYPE,
    w_DNI_A IN practica.DNI_A%TYPE,
    w_DNI_P IN practica.DNI_P%TYPE,
    w_fecha IN practica.fecha%TYPE, salidaEsperada BOOLEAN) AS
salida BOOLEAN := true;
pra PRACTICA%ROWTYPE;
BEGIN
insert into PRACTICA (OID_PRA,DNI_A, DNI_P,fecha) 
    values( w_oid_pra, w_DNI_A, w_DNI_P,w_fecha);
select * into pra from PRACTICA where OID_PRA = w_oid_pra;
IF(pra.oid_pra<> w_oid_pra OR pra.DNI_A<>w_DNI_A OR pra.DNI_P<>w_DNI_P OR pra.fecha<>w_fecha)
THEN salida:=false;
END IF;
COMMIT WORK;
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
ROLLBACK;
END insertar;

PROCEDURE eliminar(nombre_prueba VARCHAR2,w_oid_pra IN practica.oid_pra%TYPE, salidaEsperada BOOLEAN) AS
salida BOOLEAN := true;
num_practicas INTEGER;
BEGIN
DELETE FROM PRACTICA WHERE OID_PRA = w_oid_pra;
select count(*) into num_practicas from PRACTICA where OID_PRA=w_oid_pra;
IF(num_practicas<>0) THEN
salida:=false;
END IF;
COMMIT WORK;
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
ROLLBACK;
END eliminar;
END PRUEBAS_PRACTICAS;
/


--CAMBIAR LOS OID POR DNI'S
--PARA PODER INSERTAR UN EXAMEN PRÁCTICO CORRECTAMENTE AL ALUMNO 1 con el profesor 3
EXECUTE insertarPractica( 1 , '28905409K' , '75047980P' , TO_DATE('2019-06-13','YYYY-MM-DD'));
EXECUTE insertarPractica( 2 , '28905409K' , '75047980P' , TO_DATE('2019-06-14','YYYY-MM-DD'));
EXECUTE insertarPractica( 3 , '28905409K' , '75047980P' , TO_DATE('2019-06-15','YYYY-MM-DD'));
EXECUTE insertarPractica( 4 , '28905409K' , '75047980P' , TO_DATE('2019-06-16','YYYY-MM-DD'));
EXECUTE insertarPractica( 5 , '28905409K' , '75047980P' , TO_DATE('2019-06-17','YYYY-MM-DD'));
EXECUTE insertarPractica( 6 , '28905409K' , '75047980P' , TO_DATE('2019-06-18','YYYY-MM-DD'));
EXECUTE insertarPractica( 7 , '28905409K' , '75047980P' , TO_DATE('2019-06-21','YYYY-MM-DD'));
EXECUTE insertarPractica( 8 , '28905409K' , '75047980P' , TO_DATE('2019-06-22','YYYY-MM-DD'));
EXECUTE insertarPractica( 9 , '28905409K' , '75047980P' , TO_DATE('2019-06-23','YYYY-MM-DD'));
EXECUTE insertarPractica( 10 , '28905409K' , '75047980P' , TO_DATE('2019-06-24','YYYY-MM-DD'));



SET SERVEROUTPUT ON; 
BEGIN
/*PRUEBAS PRACTICA*/
PRUEBAS_PRACTICAS.insertar('Prueba 1 – insercción practica ', 11 , '42034069F' , '75047980P' , TO_DATE('2019-06-12','YYYY-MM-DD'), true);
PRUEBAS_PRACTICAS.insertar('Prueba 2 – insercción practica ', 12 , '42034069F' , '75047980P' , TO_DATE('2019-06-30','YYYY-MM-DD'), true);
PRUEBAS_PRACTICAS.insertar('Prueba 3 – insercción practica ', 13 , '42034069F' , '75047980P' , TO_DATE('2020-04-20','YYYY-MM-DD'), true);
PRUEBAS_PRACTICAS.eliminar('Prueba 4 – eliminar practica   ', 12 , true);
END;
/

