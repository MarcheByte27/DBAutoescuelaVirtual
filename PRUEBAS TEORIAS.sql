--PAQUETE PRUEBAS TEORIA
create or replace
PACKAGE PRUEBAS_TEORIAS AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2,
    w_oid_te IN teoria.oid_te%TYPE,
    w_tema IN teoria.tema%TYPE, 
    w_fecha IN teoria.fecha%TYPE,
    w_DNI_P IN teoria.DNI_P%TYPE, salidaEsperada BOOLEAN);
PROCEDURE eliminar(nombre_prueba VARCHAR2,
    w_oid_te IN teoria.oid_te%TYPE, salidaEsperada BOOLEAN);
    
END PRUEBAS_TEORIAS;
/

create or replace
PACKAGE BODY PRUEBAS_TEORIAS AS
PROCEDURE inicializar AS
BEGIN
DELETE FROM TEORIA;
END inicializar;
PROCEDURE insertar (nombre_prueba VARCHAR2,
    w_oid_te IN teoria.oid_te%TYPE,
    w_tema IN teoria.tema%TYPE, 
    w_fecha IN teoria.fecha%TYPE,
    w_DNI_P IN teoria.DNI_P%TYPE, salidaEsperada BOOLEAN) AS
salida BOOLEAN := true;
TE TEORIA%ROWTYPE;
BEGIN
INSERT INTO TEORIA(oid_te, tema, fecha, DNI_P) 
        VALUES (w_oid_te,w_tema, w_fecha, w_DNI_P);
        
select * into TE from TEORIA where OID_TE = w_oid_te;
IF(te.OID_TE<>w_oid_te OR te.tema<>w_tema OR te.fecha<>w_fecha
     OR te.DNI_P<>w_DNI_P)
    
THEN salida:=false;
END IF;
COMMIT WORK;
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
ROLLBACK;
END insertar;

PROCEDURE eliminar (nombre_prueba VARCHAR2,w_oid_te IN teoria.oid_te%TYPE, salidaEsperada BOOLEAN) AS
salida BOOLEAN := true;
num_teorias INTEGER;
BEGIN
DELETE FROM teoria WHERE OID_te=w_oid_te;
select count(*) into num_teorias from teoria where OID_te=w_oid_te;
IF(num_teorias<>0) THEN
salida:=false;
END IF;
COMMIT WORK;
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
ROLLBACK;
END eliminar;
END PRUEBAS_TEORIAS;
/



--cambiar el numero 1 de la referencia por el primer dni

SET SERVEROUTPUT ON;
BEGIN
/*PRUEBAS TEORIA SEDE 1*/
PRUEBAS_TEORIAS.insertar('Prueba 1 – insercción teoria                     ',1, '1' , TO_DATE('2019-05-02','YYYY-MM-DD'), '65789578T' ,true);
PRUEBAS_TEORIAS.insertar('Prueba 2 – insercción teoria                     ',2, '2' , TO_DATE('2019-05-03','YYYY-MM-DD'), '65789578T' ,true);
PRUEBAS_TEORIAS.insertar('Prueba 3 – insercción teoria                     ',3, '3' , TO_DATE('2019-05-04','YYYY-MM-DD'), '65789578T' ,true);
PRUEBAS_TEORIAS.insertar('Prueba 4 – insercción teoria a eliminar          ',4, '3' , TO_DATE('2019-05-05','YYYY-MM-DD'), '65789578T' ,true);

PRUEBAS_TEORIAS.insertar('Prueba 5 – insercción teoria con tema inexistente', 5 , '15', TO_DATE('2020-06-12','YYYY-MM-DD'),'65789578T',false);
PRUEBAS_TEORIAS.eliminar('Prueba 6 – eliminar teoria                       ',4,true);
END;
/





