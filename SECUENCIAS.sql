
DROP SEQUENCE OIDExamen;
CREATE SEQUENCE  OIDExamen START WITH 1 INCREMENT BY 1 MAXVALUE 500;
CREATE OR REPLACE TRIGGER TR_OIDExamen
BEFORE INSERT ON Examen
FOR EACH ROW 
BEGIN 
SELECT OIDExamen.NEXTVAL INTO :NEW.OID_EX FROM DUAL;
END; 
/

DROP SEQUENCE OIDTests;
CREATE SEQUENCE  OIDTests START WITH 1 INCREMENT BY 1 MAXVALUE 500;
CREATE OR REPLACE TRIGGER TR_OIDTest
BEFORE INSERT ON Tests
FOR EACH ROW  
BEGIN 
SELECT OIDTests.NEXTVAL INTO :NEW.OID_TEST FROM DUAL;
END; 
/

DROP SEQUENCE OIDTeorico;
CREATE SEQUENCE  OIDTeorico START WITH 1 INCREMENT BY 1 MAXVALUE 500;
CREATE OR REPLACE TRIGGER TR_OIDTeorico
BEFORE INSERT ON Teoria
FOR EACH ROW 
BEGIN 
SELECT OIDTeorico.NEXTVAL INTO :NEW.OID_TE FROM DUAL;
END; 
/

DROP SEQUENCE OIDPractico;
CREATE SEQUENCE  OIDPractico START WITH 1 INCREMENT BY 1 MAXVALUE 500;
CREATE OR REPLACE TRIGGER TR_OIDPractico
BEFORE INSERT ON Practica 
FOR EACH ROW 
BEGIN 
SELECT OIDPractico.NEXTVAL INTO :NEW.OID_PRA FROM DUAL;
END; 
/


DROP SEQUENCE OIDHacerEx;
CREATE SEQUENCE  OIDHacerEx START WITH 1 INCREMENT BY 1 MAXVALUE 500;
CREATE OR REPLACE TRIGGER TR_OIDHacerEx
BEFORE INSERT ON HacerEx 
FOR EACH ROW 
BEGIN 
SELECT OIDHacerEx.NEXTVAL INTO :NEW.OID_Hacer  FROM DUAL;
END; 
/

DROP SEQUENCE OIDAsisteA;
CREATE SEQUENCE  OIDAsisteA START WITH 1 INCREMENT BY 1 MAXVALUE 500;
CREATE OR REPLACE TRIGGER TR_OIDAsisteA
BEFORE INSERT ON AsisteA
FOR EACH ROW 
BEGIN 
SELECT OIDAsisteA.NEXTVAL INTO :NEW.OID_ASIS  FROM DUAL;
END; 
/