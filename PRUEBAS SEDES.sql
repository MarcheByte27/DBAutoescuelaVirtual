CREATE OR REPLACE FUNCTION ASSERT_EQUALS(salida BOOLEAN, salida_esperada BOOLEAN) 
RETURN VARCHAR2 AS
BEGIN
IF(salida=salida_esperada) THEN
RETURN 'EXITO';
ELSE
RETURN 'FALLO';
END IF;
END ASSERT_EQUALS;
/

--PAQUETE PRUEBAS SEDES
create or replace
PACKAGE PRUEBAS_SEDES AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2,
    w_oid_se IN SEDE.oid_se%TYPE,
    w_direccion IN SEDE.direccion%TYPE,
    w_plazas_ocupadas IN SEDE.plazas_ocupadas%TYPE, salidaEsperada BOOLEAN);
PROCEDURE actualizar(nombre_prueba VARCHAR2,
    w_oid_se IN SEDE.oid_se%TYPE, 
    w_plazas_ocupadas IN SEDE.plazas_ocupadas%TYPE,
    salidaEsperada BOOLEAN);
    
PROCEDURE eliminar(nombre_prueba VARCHAR2,
    w_oid_se IN SEDE.oid_se%TYPE, salidaEsperada BOOLEAN);
    
END PRUEBAS_SEDES;
/

create or replace
PACKAGE BODY PRUEBAS_SEDES AS
PROCEDURE inicializar AS
BEGIN
DELETE FROM SEDE;
END inicializar;
PROCEDURE insertar (nombre_prueba VARCHAR2,
w_oid_se in sede.oid_se%TYPE,
w_direccion in sede.direccion%TYPE,
w_plazas_ocupadas in sede.plazas_ocupadas%TYPE, salidaEsperada BOOLEAN) AS
salida BOOLEAN:=true;
se SEDE%ROWTYPE;
BEGIN
INSERT INTO SEDE(OID_SE, direccion, plazas_ocupadas)
        VALUES (w_oid_se, w_direccion, w_plazas_ocupadas);
select * into se from SEDE where OID_SE = w_oid_se;
IF(se.OID_SE<>w_oid_se OR se.direccion<>w_direccion OR se.plazas_ocupadas<>w_plazas_ocupadas)
THEN salida:=false;
END IF;
COMMIT WORK;
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
ROLLBACK;
END insertar;
PROCEDURE actualizar (nombre_prueba VARCHAR2,
w_oid_se in sede.oid_se%TYPE,
w_plazas_ocupadas in sede.plazas_ocupadas%TYPE,
salidaEsperada BOOLEAN) AS
salida BOOLEAN:=true;
se SEDE%ROWTYPE;
BEGIN
update sede set plazas_ocupadas=w_plazas_ocupadas where oid_se=w_oid_se;
select * into se from SEDE where OID_SE = w_oid_se;
IF(se.OID_SE<>w_oid_se OR se.plazas_ocupadas<>w_plazas_ocupadas) THEN
salida:=false;
END IF;
COMMIT WORK;
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
ROLLBACK;
END actualizar;
PROCEDURE eliminar (nombre_prueba VARCHAR2,w_oid_se IN sede.oid_se%TYPE, salidaEsperada BOOLEAN) AS
salida BOOLEAN := true;
num_sede INTEGER;
BEGIN
DELETE FROM SEDE WHERE OID_SE=w_oid_se;
select count(*) into num_sede from SEDE where OID_SE=w_oid_se;
IF(num_sede<>0) THEN
salida:=false;
END IF;
COMMIT WORK;
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
ROLLBACK;
END eliminar;
END PRUEBAS_SEDES;
/



SET SERVEROUTPUT ON; 
BEGIN
/*PRUEBAS SEDE*/
PRUEBAS_SEDES.inicializar;
PRUEBAS_SEDES.insertar('Prueba 1 – insercción sede                                       ', 1, 'Calle Pedro Mariscal 15', '5', true);
PRUEBAS_SEDES.insertar('Prueba 2 – insercción sede                                       ', 2, 'Calle Virgen de Luján 89', '3', true);
PRUEBAS_SEDES.actualizar('Prueba 3 – actualizar plazas                                     ', 2, '3',true );
PRUEBAS_SEDES.insertar('Prueba 4 – insercción sede                                       ', 3, 'Av. Palmera 27', '2', true);
PRUEBAS_SEDES.insertar('Prueba 5 – insercción sede con más plazas ocupadas de las debida ', 4, 'Av. Palmera 27', '31', false);
PRUEBAS_SEDES.insertar('Prueba 6 – insercción sede a eliminar                            ', 5, ' Calle Borrosa 20', '15', true);
PRUEBAS_SEDES.eliminar('Prueba 7 – eliminar sede                                         ', 5, true);
END;
/


