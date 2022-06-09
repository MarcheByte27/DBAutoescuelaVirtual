--PAQUETE PRUEBAS PROFESORES
create or replace
PACKAGE PRUEBAS_PROFESORES AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2,
    w_DNI_P IN PROFESOR.DNI_P%TYPE, 
    w_nombre_completo IN PROFESOR.nombre_completo%TYPE,
    w_direccion IN PROFESOR.direccion%TYPE, 
    w_a�os_carne IN PROFESOR.a�os_carne%TYPE,
    w_emailP IN PROFESOR.emailP%TYPE,
    w_puesto IN PROFESOR.puesto%TYPE,
    w_contrase�aB IN PROFESOR.contrase�aB%TYPE,
    w_oid_se IN PROFESOR.oid_se%TYPE, salidaEsperada BOOLEAN);
    
PROCEDURE actualizar(nombre_prueba VARCHAR2,
    w_DNI_P IN PROFESOR.DNI_P%TYPE, 
    w_direccion IN PROFESOR.direccion%TYPE, 
    w_a�os_carne IN PROFESOR.a�os_carne%TYPE,
     w_contrase�aB IN PROFESOR.contrase�aB%TYPE, salidaEsperada BOOLEAN);
    
PROCEDURE eliminar(nombre_prueba VARCHAR2,
    w_DNI_P IN PROFESOR.DNI_P%TYPE, salidaEsperada BOOLEAN);
    
END PRUEBAS_PROFESORES;
/

create or replace
PACKAGE BODY PRUEBAS_PROFESORES AS
PROCEDURE inicializar AS
BEGIN
DELETE FROM PROFESOR;
END inicializar;
PROCEDURE insertar (nombre_prueba VARCHAR2,
w_DNI_P in profesor.DNI_P%TYPE,
w_nombre_completo in profesor.nombre_completo%TYPE,
w_direccion in profesor.direccion%TYPE,
w_a�os_carne in profesor.a�os_carne%TYPE,
w_emailP in profesor.emailP%TYPE,
w_puesto in profesor.puesto%TYPE,
w_contrase�aB IN PROFESOR.contrase�aB%TYPE,
w_oid_se in profesor.oid_se%TYPE, salidaEsperada BOOLEAN) AS
salida BOOLEAN:=true;
pro PROFESOR%ROWTYPE;
BEGIN
INSERT INTO PROFESOR(DNI_P, nombre_completo, direccion, a�os_carne, emailP, puesto, contrase�aB, oid_se)
        VALUES (w_DNI_P, w_nombre_completo, w_direccion, w_a�os_carne, w_emailP, w_puesto, w_contrase�aB, w_oid_se);
select * into pro from PROFESOR where DNI_P = w_DNI_P;
IF(pro.DNI_P<>w_DNI_P  OR pro.nombre_completo<>w_nombre_completo OR pro.direccion<>w_direccion OR pro.a�os_carne<>w_a�os_carne OR pro.emailP<>w_emailP OR pro.puesto<>w_puesto OR pro.contrase�aB<>w_contrase�aB OR pro.oid_se<>w_oid_se)
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
w_DNI_P in profesor.DNI_P%TYPE,
w_direccion in profesor.direccion%TYPE,
w_a�os_carne in profesor.a�os_carne%TYPE,
w_contrase�aB IN PROFESOR.contrase�aB%TYPE,
salidaEsperada BOOLEAN) AS
salida BOOLEAN:=true;
pro PROFESOR%ROWTYPE;
BEGIN
update profesor set direccion=w_direccion, a�os_carne=w_a�os_carne, contrase�aB=w_contrase�aB where DNI_P=w_DNI_P;
select * into pro from PROFESOR where DNI_P = w_DNI_P;
IF(pro.DNI_P<>w_DNI_P OR pro.direccion<>w_direccion OR pro.a�os_carne<>w_a�os_carne OR pro.contrase�aB<>w_contrase�aB) THEN
salida:=false;
END IF;
COMMIT WORK;
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
ROLLBACK;
END actualizar;
PROCEDURE eliminar (nombre_prueba VARCHAR2, 
w_DNI_P IN profesor.DNI_P%TYPE, salidaEsperada BOOLEAN) AS
salida BOOLEAN := true;
num_profesor INTEGER;
BEGIN
DELETE FROM PROFESOR WHERE DNI_P=w_DNI_P;
select count(*) into num_profesor from PROFESOR where DNI_P=w_DNI_P;
IF(num_profesor<>0) THEN
salida:=false;
END IF;
COMMIT WORK;
DBMS_OUTPUT.put_line( nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.put_line( nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
ROLLBACK;
END eliminar;
END PRUEBAS_PROFESORES;
/





SET SERVEROUTPUT ON; 
BEGIN
/*PRUEBAS PROFESOR*/
PRUEBAS_PROFESORES.inicializar;
PRUEBAS_PROFESORES.insertar('Prueba 1 - insercci�n profesor                 ', '65789578T', 'Antonio Velasco Carballo', 'Avenida de la Palmera 11','20'  ,'te�rico', '65789578Tt'   ,1, true);
PRUEBAS_PROFESORES.insertar('Prueba 2 - insercci�n profesor a eliminar      ', '55378768R', 'Alfonso Perez Duarte'    , 'Calle Almeria 54'        ,'12'  ,'pr�ctico', '55378768Rr' ,1, true);
PRUEBAS_PROFESORES.insertar('Prueba 3 - insercci�n profesor                 ', '75047980P', 'Miguel Gallego Lopez'    , 'Calle Extremadura 89'    ,'32'  ,'pr�ctico', '75047980Pp'  ,1, true);
PRUEBAS_PROFESORES.insertar('Prueba 4 - insercci�n profesor con mismo dni   ', '75047980P', 'Miguel Gallego Lopez'    , 'Calle Extremadura 23'    ,'17'  ,'te�rico', '75047980Pp'  ,2, false);

PRUEBAS_PROFESORES.actualizar('Prueba 5 - actualizaci�n profesor              ','75047980P','Calle Castelar 18','32','75047980Pp', true);
PRUEBAS_PROFESORES.eliminar('Prueba 6 - eliminar profesor                   ', '55378768R',true);

PRUEBAS_PROFESORES.insertar('Prueba 7 - insercci�n profesor                 ', '29897665H', 'Manuel Moguer Cabeza'     , 'Avenida de la Palmera 10' ,'15'  ,'te�rico', '29897665Hh' ,2 , true);
PRUEBAS_PROFESORES.insertar('Prueba 8 - insercci�n profesor                 ', '78665443E', 'Jes�s Barba Hueco'        , 'Av.Sevilla  54'           ,'10'  ,'pr�ctico', '78665443Ee' ,2 , true);
PRUEBAS_PROFESORES.insertar('Prueba 9 - insercci�n profesor                 ', '75041080A', 'Miguel Troncoso Karma'    , 'Calle Buena 54'           ,'29'  ,'te�rico-pr�ctico','75041080Aa' ,3, true);
 
PRUEBAS_PROFESORES.insertar('Prueba 10 - insercci�n profesor                ', '12345678F', 'Jes�s Antonio Moreno'     , 'Calle Hu�sped 23'         ,'30'  ,'te�rico-pr�ctico', '12345678Ff', 3 , true);
END;
/

