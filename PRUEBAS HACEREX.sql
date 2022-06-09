--PAQUETE PRUEBAS HACER EXAMENES
create or replace
PACKAGE PRUEBAS_HACEREX AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2,
    w_oid_hacer in hacerex.oid_hacer%type,
    w_DNI_A    IN hacerex.DNI_A%TYPE,
    w_oid_ex    IN hacerex.oid_ex%TYPE,
    w_fallos    IN hacerex.fallos%TYPE,
    w_apto      IN hacerex.apto%TYPE, salidaEsperada BOOLEAN);
PROCEDURE eliminar(nombre_prueba VARCHAR2,
    w_oid_hacer in hacerex.oid_hacer%type, salidaEsperada BOOLEAN);
    
END PRUEBAS_HACEREX;
/

create or replace
PACKAGE BODY PRUEBAS_HACEREX AS
PROCEDURE inicializar AS
BEGIN
DELETE FROM HACEREX;
END inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2,
    w_oid_hacer in hacerex.oid_hacer%type,
    w_DNI_A    IN hacerex.DNI_A%TYPE,
    w_oid_ex    IN hacerex.oid_ex%TYPE,
    w_fallos    IN hacerex.fallos%TYPE,
    w_apto      IN hacerex.apto%TYPE, salidaEsperada BOOLEAN) AS
salida BOOLEAN := true;
hac HACEREX%ROWTYPE;
BEGIN
insert into HACEREX (oid_hacer, DNI_A,oid_ex, fallos, apto) 
    values(w_oid_hacer, w_DNI_A,w_oid_ex ,w_fallos, w_apto);
select * into hac from HACEREX where oid_hacer = w_oid_hacer;
IF(hac.oid_hacer<>w_oid_hacer OR hac.DNI_A<>w_DNI_A OR hac.oid_ex <> w_oid_ex OR hac.fallos<>w_fallos OR hac.apto<>w_apto )
THEN salida:=false;
END IF;
COMMIT WORK;
DBMS_OUTPUT.put_line(nombre_prueba|| ':' || ASSERT_EQUALS(salida,salidaEsperada));
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.put_line(nombre_prueba|| ':' || ASSERT_EQUALS(false,salidaEsperada));
ROLLBACK;
END insertar;

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_hacer IN hacerex.oid_hacer%TYPE, salidaEsperada BOOLEAN) AS
salida BOOLEAN := true;
num_examenes INTEGER;
BEGIN
DELETE FROM HACEREX WHERE OID_HACER = w_oid_HACER;
select count(*) into num_examenes from HACEREX where OID_HACER=w_oid_HACER;
IF(num_examenes<>0) THEN
salida := false;
END IF;
COMMIT WORK;
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
ROLLBACK;
END eliminar;
END PRUEBAS_HACEREX;
/


--CAMBIAR OID POR DNI

SET SERVEROUTPUT ON;
BEGIN
/*PRUEBAS HACEREX GENERALES*/
PRUEBAS_HACEREX.inicializar;                                                         --        al        ex  fal  ap
PRUEBAS_HACEREX.insertar('Prueba 1 - inserción hacer examen                          ',1 , '28905409K' , 1 ,'5', '0' ,true);  --suspende teorico alum 1
PRUEBAS_HACEREX.insertar('Prueba 2 - inserción hacer examen                          ',2 , '42034069F' , 1 ,'4', '0' ,true);  --suspende teorico alum 2
PRUEBAS_HACEREX.insertar('Prueba 3 - inserción hacer examen                          ',3 , '28905409K' , 3 ,'2', '1' ,true);  --aprueba teorico alum 1
PRUEBAS_HACEREX.insertar('Prueba 4 - inserción hacer examen                          ',4 , '28905409K' , 4 ,'0', '1' ,true); --aprueba práctico alum 1 (con 10 prácticas y aprobando examen teórico)
PRUEBAS_HACEREX.eliminar('Prueba 5 - eliminar hacer examen                           ',2 ,true);
END;
/


/* PRUEBAS HACEREX DE TRIGGER */
SET SERVEROUTPUT ON;
BEGIN
PRUEBAS_HACEREX.inicializar;
PRUEBAS_HACEREX.insertar('PRUEBA TRIGGER 1 - inserción hacer examen teórico de alumno sin certificado         ',5 , '12345678A' , 1 ,'0', '1' ,false);
PRUEBAS_HACEREX.insertar('PRUEBA TRIGGER 2 - inserción hacer examen prático de alumno sin 10 prácticas        ',6 , '35687427G' , 2, '0', '0' ,false);
PRUEBAS_HACEREX.insertar('PRUEBA TRIGGER 3 - inserción hacer examen práctico sin presentarse aprobar teórico  ',7 , '42034069F' , 1 ,'0', '1' ,false);
END;
/

