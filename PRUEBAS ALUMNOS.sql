--PAQUETE PRUEBAS ALUMNOS
create or replace
PACKAGE PRUEBAS_ALUMNOS AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2,
    w_DNI_a IN alumno.DNI_a%TYPE,
    w_nombre_completo IN alumno.nombre_completo%TYPE,
    w_direccion IN alumno.direccion%TYPE,
    w_telefono IN alumno.telefono%TYPE,
    w_edad IN alumno.edad%TYPE,
    w_emailA IN alumno.emailA%TYPE,
    w_cursoInt IN alumno.cursoInt%TYPE,
    w_tipoC IN alumno.tipoc%TYPE,
    w_tipoH IN alumno.tipoh%TYPE,
    w_certificado IN alumno.certificado%TYPE,
    w_contraseñaA IN alumno.contraseñaA%TYPE,
    w_oid_se IN alumno.oid_se%TYPE, salidaEsperada BOOLEAN);
PROCEDURE actualizar(nombre_prueba VARCHAR2,
    w_DNI_a IN alumno.DNI_a%TYPE, 
    w_direccion IN alumno.direccion%TYPE, 
    w_telefono IN alumno.telefono%TYPE, 
    w_edad IN alumno.edad%TYPE,
    w_certificado IN alumno.certificado%TYPE,
    w_contraseñaA IN alumno.contraseñaA%TYPE,
    salidaEsperada BOOLEAN);
PROCEDURE eliminar(nombre_prueba VARCHAR2,
    w_DNI_a IN alumno.DNI_a%TYPE, salidaEsperada BOOLEAN);
    
    
END PRUEBAS_ALUMNOS;
/




create or replace
PACKAGE BODY PRUEBAS_ALUMNOS AS
PROCEDURE inicializar AS
BEGIN
DELETE FROM ALUMNO;
END inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2,
    w_DNI_a IN alumno.DNI_a%TYPE,
    w_nombre_completo IN alumno.nombre_completo%TYPE,
    w_direccion IN alumno.direccion%TYPE,
    w_telefono IN alumno.telefono%TYPE,
    w_edad IN alumno.edad%TYPE,
    w_emailA IN alumno.emailA%TYPE,
    w_cursoInt IN alumno.cursoInt%TYPE,
    w_tipoC IN alumno.tipoc%TYPE,
    w_tipoH IN alumno.tipoh%TYPE,
    w_certificado IN alumno.certificado%TYPE,
    w_contraseñaA IN alumno.contraseñaA%TYPE,
    w_oid_se IN alumno.oid_se%TYPE, salidaEsperada BOOLEAN) AS
salida BOOLEAN := true;
alum ALUMNO%ROWTYPE;
BEGIN
insert into ALUMNO (
DNI_a, nombre_completo, direccion, telefono, edad, emailA, cursoInt, tipoC, tipoH, certificado, contraseñaA, OID_SE) 
    values(w_DNI_a, w_nombre_completo, w_direccion, w_telefono, w_edad,w_emailA, w_cursoInt, w_tipoC, w_tipoH, w_certificado, w_contraseñaA, w_oid_se);
select * into alum from ALUMNO where DNI_a = w_DNI_a;
IF( alum.DNI_a<>w_DNI_a OR alum.nombre_completo<>w_nombre_completo 
    OR alum.direccion<>w_direccion OR alum.telefono<>w_telefono OR alum.edad<>w_edad OR alum.emailA<>w_emailA OR alum.cursoInt<>w_cursoInt 
    OR alum.tipoC<>w_tipoC OR alum.tipoH<>w_tipoH OR alum.certificado<>w_certificado OR alum.contraseñaA<>w_contraseñaA OR alum.OID_SE<>w_oid_se)
THEN salida:=false;
END IF;
COMMIT WORK;
DBMS_OUTPUT.put_line( nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.put_line( nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
ROLLBACK;
END insertar;
PROCEDURE actualizar(nombre_prueba VARCHAR2,
    w_DNI_a IN alumno.DNI_a%TYPE,
    w_direccion IN alumno.direccion%TYPE, 
    w_telefono IN alumno.telefono%TYPE, 
    w_edad IN alumno.edad%TYPE,
    w_certificado IN alumno.certificado%TYPE,
    w_contraseñaA IN alumno.contraseñaA%TYPE,
    salidaEsperada BOOLEAN) AS
salida BOOLEAN:=true;
alum ALUMNO%ROWTYPE;
BEGIN
update alumno set direccion=w_direccion, telefono=w_telefono, edad=w_edad, certificado=w_certificado, contraseñaA=w_contraseñaA where DNI_a=w_DNI_a;
select * into alum from ALUMNO where DNI_a = w_DNI_a;
IF(alum.DNI_A<>w_DNI_A OR alum.direccion<>w_direccion OR alum.telefono<>w_telefono OR alum.edad<>w_edad 
    OR alum.certificado<>w_certificado OR alum.contraseñaA<>w_contraseñaA) THEN
salida:=false;
END IF;
COMMIT WORK;
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
ROLLBACK;
END actualizar;
PROCEDURE eliminar ( nombre_prueba VARCHAR2,
w_DNI_a IN alumno.DNI_a%TYPE, salidaEsperada BOOLEAN) AS
salida BOOLEAN := true;
num_alumnos INTEGER;
BEGIN
DELETE FROM ALUMNO WHERE DNI_a=w_DNI_a;
select count(*) into num_alumnos from ALUMNO where DNI_a=w_DNI_a;
IF(num_alumnos<>0) THEN
salida:=false;
END IF;
COMMIT WORK;
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
ROLLBACK;
END eliminar;
END PRUEBAS_ALUMNOS;
/




SET SERVEROUTPUT ON; 
BEGIN
/*PRUEBAS ALUMNO*/
PRUEBAS_ALUMNOS.inicializar;
PRUEBAS_ALUMNOS.insertar('Prueba 1 - inserción alumno                ','28905409K', 'Andres Posada Verdugo'            ,'Calle Cordoba 13'      ,'694027593' ,'19' ,'1' ,'B'  ,'tarde'   ,'0' , '28905409Kk',1 ,true); 
PRUEBAS_ALUMNOS.insertar('Prueba 2 - inserción alumno                ','42034069F', 'Manu Carrasco Martín'             ,'Calle Todoro Carpio 14','640987345' ,'20' ,'1' ,'C1' ,'mañana'  ,'1', '42034069Ff',1 ,true);  
PRUEBAS_ALUMNOS.insertar('Prueba 3 - inserción alumno                ','35687427G', 'Francisco Javier Marchena Curado' ,'Calle Los Palacios 15' ,'690345821' ,'21' ,'1' ,'B'  ,'tarde'   ,'0', '35687427Gg',1 ,true);
PRUEBAS_ALUMNOS.insertar('Prueba 4 - inserción alumno a eliminar     ','29643875E', 'Jose Miguel Piñero Zambrana'      ,'Calle Trobal 16'       ,'622565840' ,'30' ,'0' ,'C1'  ,'mañana' ,'0','29643875Ee' ,1 ,true);

PRUEBAS_ALUMNOS.insertar('Prueba 5 - inserción alumno con mismo DNI_a  ','29643875E','Antonio Rodriguez Fernandez'       ,'Calle Las Musas 17'    ,'614326978' ,'34' ,'0' ,'B'  ,'mañana'  ,'0','29643875Ee' ,1 ,false);
PRUEBAS_ALUMNOS.actualizar('Prueba 6 - actualizacion de certificado    ', '28905409K' ,'Calle Cordoba','694027593','19','1','28905409Kk',true);

PRUEBAS_ALUMNOS.eliminar('Prueba 7 - eliminar alumno                 ','29643875E',true);

PRUEBAS_ALUMNOS.insertar('Prueba 8 - inserción alumno                ','12345678A' , 'Joaquin Romero Murube'           ,'Calle Buenavista 108'    ,'678912345' ,'20' ,'1' ,'A1' ,'tarde'   ,'0','12345678Aa' ,1 ,true); 
PRUEBAS_ALUMNOS.insertar('Prueba 9 - inserción alumno                ','12345678B' , 'Federico García Lorca'           ,'Calle Rojo Fuego 1'      ,'657390573' ,'22' ,'0' ,'B'  ,'tarde'   ,'1' ,'12345678Bb',2 ,true); 
PRUEBAS_ALUMNOS.insertar('Prueba 10 - inserción alumno               ','12345678C' , 'Ana Moreno Parejo'               ,'Calle Verde Hoja 2'      ,'657894532' ,'18' ,'1' ,'B'  ,'mañana'  ,'1' ,'12345678Cc' ,2 ,true); 
PRUEBAS_ALUMNOS.insertar('Prueba 11 - inserción alumno               ','12345678D' , 'María Duque Bueno'               ,'Calle Azul Zafiro 3'     ,'624570389' ,'18' ,'1' ,'B'  ,'mañana'  ,'0' ,'12345678Dd',2 ,true); 
PRUEBAS_ALUMNOS.insertar('Prueba 12 - inserción alumno               ','12345678E' , 'Rocio Falcón Gayango'            ,'Calle Esmeralda 4'       ,'620758943' ,'19' ,'0' ,'B'  ,'tarde'   ,'0','12345678Ee' ,3 ,true); 
PRUEBAS_ALUMNOS.insertar('Prueba 13 - inserción alumno               ','12345678F' , 'Antonio Jesús García Vela'       ,'Calle Olimnpo 5'         ,'657438433' ,'31' ,'0' ,'C1'  ,'mañana'  ,'0' ,'12345678Ff',3 ,true); 
END;
/