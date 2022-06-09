
-- RF-01
CREATE OR REPLACE PROCEDURE nums_profesores(w_oid_se sede.oid_se%TYPE)
IS
CURSOR C2 IS SELECT oid_se, nombre_completo, puesto FROM PROFESOR WHERE w_oid_se = oid_se;
w_number NUMBER := 0;
BEGIN
FOR fila IN C2 LOOP
EXIT WHEN C2%NOTFOUND;
        w_number := w_number + 1;
        DBMS_OUTPUT.PUT_LINE('El profesor ' || fila.nombre_completo || 'trabaja como: ' ||fila.puesto  );
        
END LOOP;
    DBMS_OUTPUT.PUT_LINE('El número de profesores en la sede ' || w_oid_se || ' es : ' || w_number );
END;
/



--REQUISITO FUNCIONAL 2
CREATE OR REPLACE PROCEDURE obtener_teorico(w_DNI_A IN ALUMNO.DNI_A%TYPE)
IS
CURSOR C2 IS SELECT DNI_A,apto,fallos,tipo,OID_EX,FECHA FROM HACEREX NATURAL JOIN ALUMNO NATURAL JOIN EXAMEN WHERE w_DNI_A=DNI_A;
BEGIN
DBMS_OUTPUT.PUT_LINE('LOS RESULTADOS DE LOS EXÁMENES TEÓRICOS REALIZADOS POR USTED SON: ');
FOR fila IN C2 LOOP
EXIT WHEN C2%NOTFOUND;
        IF(fila.TIPO ='teórico')
        THEN
        DBMS_OUTPUT.PUT_LINE('Con identificador '||fila.OID_EX||', cuya fecha es '||fila.FECHA||' tuvo '||fila.FALLOS||' fallos '||' y el resultado de su examen es '||fila.APTO);
END IF;
END LOOP;
END;
/

CREATE OR REPLACE PROCEDURE obtener_practico(w_DNI_A IN ALUMNO.DNI_A%TYPE)
IS
CURSOR C2 IS SELECT DNI_A,APTO,FALLOS,TIPO,OID_EX,FECHA FROM EXAMEN NATURAL JOIN ALUMNO natural join HACEREX WHERE w_DNI_A=DNI_A;
BEGIN
DBMS_OUTPUT.PUT_LINE('LOS RESULTADOS DE LOS EXÁMENES PRÁCTICOS REALIZADOS POR USTED SON: ');
FOR fila IN C2 LOOP
EXIT WHEN C2%NOTFOUND;
        IF(fila.TIPO ='práctico')
        THEN
        DBMS_OUTPUT.PUT_LINE('Con identificador '||fila.OID_EX||', cuya fecha es '||fila.FECHA||' tuvo '||fila.FALLOS||' fallos '||' y el resultado de su examen es '||fila.APTO);
END IF;
END LOOP;
END;
/




-- RF-03
CREATE OR REPLACE PROCEDURE numero_test(w_DNI_A IN ALUMNO.DNI_A%TYPE)
IS
CURSOR c1 is select DNI_A,OID_TEST, fallos  from ALUMNO NATURAL JOIN TESTS where w_DNI_A=DNI_A;
BEGIN
DBMS_OUTPUT.PUT_LINE('TODOS LOS TESTS HECHOS POR EL ALUMNO');
FOR fila IN c1 LOOP
EXIT WHEN c1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Test con ID: ' || fila.OID_TEST||' , y con los fallos '|| fila.fallos);
END LOOP;
END;
/




-- RF-04
CREATE OR REPLACE FUNCTION media_edad_alumnos
RETURN NUMBER is w_media NUMBER(2);
BEGIN
select avg(edad) INTO w_media from ALUMNO;
RETURN w_media;
END media_edad_alumnos;
/


