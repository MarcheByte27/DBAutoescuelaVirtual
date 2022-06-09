--Procedimientos
CREATE OR REPLACE PROCEDURE insertarSede(
w_oid_se in sede.oid_se%TYPE,
w_direccion in sede.direccion%TYPE,
w_plazas_ocupadas in sede.plazas_ocupadas%TYPE)
IS
BEGIN
    INSERT INTO SEDE(oid_se, direccion, plazas_ocupadas) VALUES (w_oid_se, w_direccion, w_plazas_ocupadas);
COMMIT WORK;
END insertarSede;
/


CREATE OR REPLACE PROCEDURE insertarAlumno(
w_DNI IN alumno.dni_a%TYPE,
w_nombre_completo IN alumno.nombre_completo%TYPE,
w_direccion IN alumno.direccion%TYPE,
w_telefono IN alumno.telefono%TYPE,
w_edad IN alumno.edad%TYPE,
w_emailA in alumno.emaila%TYPE,
w_cursoInt IN alumno.cursoInt%TYPE,
w_tipoC IN alumno.tipoc%TYPE,
w_tipoH IN alumno.tipoh%TYPE,
w_certificado IN alumno.certificado%TYPE,
w_contraseñaA IN alumno.contraseñaA%TYPE,
w_oid_se IN alumno.oid_se%TYPE)
IS
BEGIN
    INSERT INTO ALUMNO(DNI_A, nombre_completo, direccion, telefono, edad,emailA ,cursoInt, tipoC, tipoH, certificado,contraseñaA, oid_se) 
                            VALUES (w_DNI,w_nombre_completo, w_direccion, w_telefono, w_edad, w_emailA, w_cursoInt, w_tipoC, w_tipoH, w_certificado,w_contraseñaA ,w_oid_se);
                            BEGIN
                                UPDATE SEDE SET plazas_ocupadas = plazas_ocupadas + 1 where oid_se=w_oid_se;
                            END;
COMMIT WORK;
END insertarAlumno;
/

CREATE OR REPLACE PROCEDURE eliminarAlumno(
w_DNI_a IN alumno.dni_a%TYPE)
IS
    w_oid_se sede.oid_se%TYPE;
BEGIN
    SELECT oid_se into w_oid_se from alumno where DNI_a=w_DNI_a;
    DELETE FROM ALUMNO WHERE DNI_a=w_DNI_a;
                            BEGIN
                                UPDATE SEDE SET plazas_ocupadas = plazas_ocupadas - 1 where oid_se=w_oid_se;
                            END;
COMMIT WORK;
END eliminarAlumno;
/

CREATE OR REPLACE PROCEDURE modificarAlumno(
w_DNI IN alumno.dni_a%TYPE,
w_direccion IN alumno.direccion%TYPE,
w_telefono IN alumno.telefono%TYPE,
w_edad IN alumno.edad%TYPE,
w_emailA in alumno.emaila%TYPE,
w_certificado IN alumno.certificado%TYPE)
IS
BEGIN
    UPDATE ALUMNO set direccion=w_direccion, telefono=w_telefono, edad=w_edad, certificado= w_certificado, emaila=w_emailA WHERE DNI_A= w_DNI;
                            
COMMIT WORK;
END modificarAlumno;
/

CREATE OR REPLACE PROCEDURE modificarProfesor(
w_DNI IN profesor.dni_P%TYPE,
w_direccion IN profesor.direccion%TYPE,
w_años_carnet IN profesor.años_carne%type,
w_puesto in profesor.puesto%TYPE)
IS
BEGIN
    UPDATE PROFESOR set direccion=w_direccion, años_carne=w_años_carnet, puesto=w_puesto WHERE DNI_P= w_DNI;                        
COMMIT WORK;
END modificarProfesor;
/




CREATE OR REPLACE PROCEDURE insertarProfesor(
w_DNI in profesor.dni_p%TYPE,
w_nombre_completo in profesor.nombre_completo%TYPE,
w_direccion in profesor.direccion%TYPE,
w_años_carne in profesor.años_carne%TYPE,
w_emailp in profesor.emailp%type,
w_puesto in profesor.puesto%type,
w_contraseñab in profesor.contraseñab%type,
w_oid_se in profesor.oid_se%TYPE)
IS
BEGIN
    INSERT INTO PROFESOR(dni_p, nombre_completo, direccion, años_carne,emailp ,puesto, contraseñab, oid_se)
        VALUES (w_dni, w_nombre_completo, w_direccion, w_años_carne,w_emailp ,w_puesto ,w_contraseñab, w_oid_se);
COMMIT WORK;
END insertarProfesor;
/



CREATE OR REPLACE PROCEDURE insertarExamen(
w_oid in examen.oid_ex%type,
w_fecha in examen.fecha%TYPE,
w_tipo in examen.tipo%TYPE)
IS
BEGIN
    INSERT INTO EXAMEN(OID_EX, fecha, tipo) VALUES (w_oid, w_fecha, w_tipo);
COMMIT WORK;
END insertarExamen;
/


CREATE OR REPLACE PROCEDURE insertarExamenPagina(
w_fecha in examen.fecha%TYPE,
w_tipo in examen.tipo%TYPE)
IS
BEGIN
    INSERT INTO EXAMEN(OID_EX, fecha, tipo) VALUES (OIDEXAMEN.nextval,w_fecha, w_tipo);
COMMIT WORK;
END insertarExamenPagina;
/



CREATE OR REPLACE PROCEDURE eliminarExamen(
w_ID IN examen.oid_ex%TYPE)
IS
BEGIN
    DELETE FROM EXAMEN WHERE oid_ex=w_ID;                      
COMMIT WORK;
END eliminarExamen;
/

CREATE OR REPLACE PROCEDURE modificarExamen(
w_ID IN examen.oid_ex%TYPE,
w_fecha IN examen.fecha%TYPE,
w_tipo IN examen.tipo%type)
IS
BEGIN
    UPDATE EXAMEN set fecha=w_fecha, tipo=w_tipo WHERE oid_ex= w_ID;                        
COMMIT WORK;
END modificarExamen;
/

CREATE OR REPLACE PROCEDURE insertarPractica(
w_dni_a in practica.dni_a%TYPE,
w_dni_p in practica.dni_p%TYPE,
w_fecha in practica.fecha%TYPE)
IS
BEGIN
    INSERT INTO PRACTICA(oid_pra, dni_a, dni_p, fecha) VALUES (OIDPRACTICO.nextval, w_dni_a, w_dni_p, w_fecha);
COMMIT WORK;
END insertarPractica;
/

CREATE OR REPLACE PROCEDURE insertarVehiculo (
w_matricula in vehiculo.matricula%TYPE,
w_modelo in vehiculo.modelo%TYPE,
w_tipo_combustible in vehiculo.tipo_combustible%TYPE,
w_tipo_vehiculo in vehiculo.tipo_vehiculo%TYPE,
w_tipo_estado in vehiculo.tipo_estado%TYPE,
w_dni_p in vehiculo.dni_p%TYPE)
IS
BEGIN
    INSERT INTO VEHICULO( matricula, modelo, tipo_combustible, tipo_vehiculo, tipo_estado, dni_p) 
                                    VALUES ( w_matricula, w_modelo, w_tipo_combustible, w_tipo_vehiculo, w_tipo_estado, w_dni_p);
COMMIT WORK;
END insertarVehiculo;
/


CREATE OR REPLACE PROCEDURE insertarTeoria(
w_oid in teoria.oid_te%type,
w_tema in teoria.tema%TYPE,
w_fecha in teoria.fecha%TYPE,
w_dni_p in teoria.dni_p%TYPE)
IS
BEGIN
    INSERT INTO TEORIA(oid_te, tema, fecha, dni_p) VALUES (w_oid ,w_tema, w_fecha, w_dni_p);
COMMIT WORK;
END insertarTeoria;
/

CREATE OR REPLACE PROCEDURE insertarTests(
w_fallos in tests.fallos%TYPE,
w_fecha in tests.fecha%TYPE,
w_dni_a in tests.dni_a%TYPE)
IS
BEGIN
    INSERT INTO TESTS(oid_test, fallos, fecha, dni_a) VALUES ( OIDTESTS.nextval ,w_fallos, w_fecha, w_dni_a);
COMMIT WORK;
END insertarTests;
/



CREATE OR REPLACE PROCEDURE insertarHacerEx(
w_dni_a in hacerex.dni_a%TYPE,
w_oid_ex in hacerex.oid_ex%TYPE,
w_fallos in hacerex.fallos%TYPE)
IS
BEGIN
    IF(w_fallos > 3)
        THEN
        INSERT INTO HACEREX(oid_hacer, dni_a, oid_ex, fallos, apto) VALUES (OIDHACEREX.nextval, w_dni_a, w_oid_ex, w_fallos, 0);
    END IF;
    IF(w_fallos <= 3)
    THEN
        INSERT INTO HACEREX(oid_hacer, dni_a, oid_ex, fallos, apto) VALUES (OIDHACEREX.nextval, w_dni_a, w_oid_ex, w_fallos, 1);
    END IF;
COMMIT WORK;
END insertarHacerEx;
/







CREATE OR REPLACE PROCEDURE insertarAsisteA(
w_dni_a in asistea.dni_a%TYPE,
w_oid_te in asistea.oid_te%TYPE
)
IS
BEGIN
    INSERT INTO ASISTEA( oid_asis, dni_a, oid_te) VALUES (OIDASISTEA.nextval, w_dni_a, w_oid_te);
COMMIT WORK;
END insertarAsisteA;
/


