
--RN-01
CREATE OR REPLACE TRIGGER Examen_certificado
BEFORE INSERT OR UPDATE ON HACEREX
FOR EACH ROW
DECLARE
    w_certificado alumno.certificado%TYPE;
BEGIN
    SELECT certificado INTO w_certificado FROM Alumno WHERE DNI_A = :NEW.DNI_A;
    IF (w_certificado = 0) 
    THEN raise_application_error
      (-20008, 'El alumno debe tener el certificado médico');
    END IF;
END;
/



--RN-03
CREATE OR REPLACE TRIGGER Estado_Vehiculo
BEFORE INSERT ON VEHICULO
FOR EACH ROW
DECLARE
    w_tipo vehiculo.tipo_estado%TYPE;
BEGIN
    w_tipo := 'malo';
    IF( :NEW.tipo_estado = w_tipo)
    THEN raise_application_error(-20030, 'No se pueden insertar vehiculos en mal estado');
    END IF;
END;
/



--RN-04
CREATE OR REPLACE TRIGGER practicas
BEFORE INSERT ON HACEREX
FOR EACH ROW
DECLARE
w_num_prac NUMBER;
w_tipo1 examen.tipo%TYPE;
w_tipo2 examen.tipo%TYPE;
w_apto_teorico NUMBER := 0;
BEGIN
    select tipo into w_tipo1 from EXAMEN where oid_ex = :NEW.oid_ex;
    select count(*)  into w_num_prac from PRACTICA WHERE DNI_A = :NEW.DNI_A;
    IF (w_tipo1 = 'práctico' AND w_num_prac < 10) 
            THEN raise_application_error(-20080,'Debe dar 10 practicas minimo para ir seguro a examen');
    END IF;
   
    select tipo into w_tipo2 from EXAMEN WHERE oid_ex = :NEW.oid_ex;
    IF(w_tipo2 = 'práctico')
       THEN SELECT count(apto) into w_apto_teorico from HACEREX WHERE apto = 1 AND DNI_A = :NEW.DNI_A;
        IF( w_apto_teorico = 0 )
        THEN raise_application_error(-20035, 'No ha aprobado el teórico y no se puede presentar al práctico');
        END IF;
    END IF;
END;
/