
SET serverout on;

--RF-01: , SEDE 1:
EXECUTE nums_profesores('1');



--RF-02: , ALUMNO 1, con DNI 28905409K
EXECUTE obtener_teorico('28905409K');
EXECUTE obtener_practico('28905409K');


--RF-03: , ALUMNO 1, con DNI 28905409K
EXECUTE numero_test('28905409K')



--RF-04:
SELECT  DISTINCT media_edad_alumnos from ALUMNO;

