--PAQUETE PRUEBAS VEHICULO
create or replace
PACKAGE PRUEBAS_VEHICULOS AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2,
    w_matricula        IN vehiculo.matricula%TYPE,
    w_modelo           IN vehiculo.modelo%TYPE,
    w_tipo_combustible IN vehiculo.tipo_combustible%TYPE,
    w_tipo_vehiculo    IN vehiculo.tipo_vehiculo%TYPE,
    w_tipo_estado      IN vehiculo.tipo_estado%TYPE,
    w_dni_p          IN vehiculo.dni_p%TYPE, salidaEsperada BOOLEAN);
PROCEDURE actualizar (nombre_prueba VARCHAR2,
    w_matricula      IN vehiculo.matricula%TYPE,
    w_tipo_estado IN vehiculo.tipo_estado%TYPE,
    w_dni_p     IN vehiculo.dni_p%TYPE, salidaEsperada BOOLEAN);
PROCEDURE eliminar(nombre_prueba VARCHAR2,
    w_matricula IN vehiculo.matricula%TYPE, salidaEsperada BOOLEAN);
    
END PRUEBAS_VEHICULOS;
/


create or replace
PACKAGE BODY PRUEBAS_VEHICULOS AS
PROCEDURE inicializar AS
BEGIN
DELETE FROM VEHICULO;
END inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2,
    w_matricula        IN vehiculo.matricula%TYPE,
    w_modelo           IN vehiculo.modelo%TYPE,
    w_tipo_combustible IN vehiculo.tipo_combustible%TYPE,
    w_tipo_vehiculo    IN vehiculo.tipo_vehiculo%TYPE,
    w_tipo_estado      IN vehiculo.tipo_estado%TYPE,
    w_dni_p          IN vehiculo.dni_p%TYPE, salidaEsperada BOOLEAN) AS
salida BOOLEAN := true;
ve VEHICULO%ROWTYPE;
BEGIN
insert into VEHICULO (matricula, modelo, tipo_combustible, tipo_vehiculo, tipo_estado, dni_p) 
    values( w_matricula, w_modelo, w_tipo_combustible, w_tipo_vehiculo, w_tipo_estado, w_dni_p);
select * into ve from VEHICULO where matricula = w_matricula;
IF( ve.matricula<>w_matricula OR ve.modelo<>w_modelo
    OR ve.tipo_combustible<>w_tipo_combustible OR ve.tipo_vehiculo<>w_tipo_vehiculo OR ve.tipo_estado<>w_tipo_estado OR ve.dni_p<>w_dni_p)
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
    w_matricula IN vehiculo.matricula%TYPE,
    w_tipo_estado IN vehiculo.tipo_estado%TYPE,
    w_dni_p IN vehiculo.dni_p%TYPE, salidaEsperada BOOLEAN) AS
salida BOOLEAN:=true;
ve VEHICULO%ROWTYPE;
BEGIN
update vehiculo set tipo_estado=w_tipo_estado, dni_p=w_dni_p where matricula=w_matricula;
select * into ve from VEHICULO where matricula = w_matricula;
IF(ve.matricula<>w_matricula OR ve.tipo_estado<>w_tipo_estado OR ve.dni_p<>w_dni_p) THEN
salida:=false;
END IF;
COMMIT WORK;
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
ROLLBACK;
END actualizar;
PROCEDURE eliminar (nombre_prueba VARCHAR2,w_matricula IN vehiculo.matricula%TYPE, salidaEsperada BOOLEAN) AS
salida BOOLEAN := true;
num_vehiculos INTEGER;
BEGIN
DELETE FROM VEHICULO WHERE matricula=w_matricula;
select count(*) into num_vehiculos from VEHICULO where matricula=w_matricula;
IF(num_vehiculos<>0) THEN
salida:=false;
END IF;
COMMIT WORK;
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
ROLLBACK;
END eliminar;
END PRUEBAS_VEHICULOS;
/




SET SERVEROUTPUT ON; 
BEGIN
/*PRUEBAS VEHICULOS*/
PRUEBAS_VEHICULOS.inicializar;
PRUEBAS_VEHICULOS.insertar  ('Prueba 1 - insercción vehiculo                         ', '6876FWF'  , 'Ford Focus'   ,  'gasolina' , 'coche' , 'bueno' , '75041080A' , true);

PRUEBAS_VEHICULOS.insertar  ('Prueba 2 - insercción vehiculo                         ', '8967ABC'  , 'Fiat 500'     ,  'gasoil'   , 'coche' , 'bueno' , '12345678F' , true);
PRUEBAS_VEHICULOS.insertar  ('Prueba 3 - insercción vehiculo a actualizar            ', '3452FGH'  , 'Dacia Sandero',  'gasolina' , 'coche' , 'bueno' , '75047980P' , true);
PRUEBAS_VEHICULOS.actualizar('Prueba 5 – actualizar profesor de vehículo             ', '3452FGH' , 'bueno', '78665443E' , true);

PRUEBAS_VEHICULOS.insertar  ('Prueba 6 - insercción vehiculo en mal estado           ', '9623LMN'  , 'Toyota Aygo'  ,  'gasoil'   , 'coche' , 'malo'  , '12345678F' , false);
PRUEBAS_VEHICULOS.insertar  ('Prueba 7 - insercción vehiculo con matrícula no valida ', 'ABC1131A' , 'Renault Clio' ,  'gasoil'   , 'coche' , 'bueno' , '12345678F' , false);

PRUEBAS_VEHICULOS.eliminar  ('Prueba 8 - eliminar vehiculo                           ', '8967ABC' ,true);
END;
/
