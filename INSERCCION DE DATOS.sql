--      SEDES       SEDE     DIRECCION             PLAZAS
execute insertarsede( 1, 'Calle Pedro Mariscal 15' , '0');
execute insertarsede( 2, 'Calle Virgen de Luján 89', '0');
execute insertarsede( 3, 'Av. Palmera 27'          , '0');



-- EXAMENES                       FECHA                    TIPOEX
execute insertarexamen(1, TO_DATE('2019-08-12','YYYY-MM-DD'), 'teórico' );
execute insertarexamen(2, TO_DATE('2019-09-12','YYYY-MM-DD'), 'práctico');
execute insertarexamen(3, TO_DATE('2019-10-11','YYYY-MM-DD'), 'teórico' );
execute insertarexamen(4, TO_DATE('2019-10-30','YYYY-MM-DD'), 'práctico');


--   ALUMNOS              DNI           NOMBRE Y APELLIDO                    DIRECCION               TELEFONO   EDAD            EMAIL               INT  CARNE  HORARIO  CERTFI  CONSTRASEÑA SEDE     
EXECUTE insertarAlumno('28905409K' , 'Andres Posada Verdugo'            ,'Calle Cordoba 13'        ,'694027593' ,'19' ,'andresposada@gmail.com'    ,'1' , 'B'  ,'tarde'   ,'1' , '28905409Kk', 1 );
EXECUTE insertarAlumno('42034069F' , 'Manu Carrasco Martín'             ,'Calle Todoro Carpio 14'  ,'640987345' ,'20' ,'manucarrasco@gmail.com'    ,'1' , 'C1' ,'mañana'  ,'1' , '42034069Ff', 1 );
EXECUTE insertarAlumno('35687427G' , 'Francisco Javier Marchena Curado' ,'Calle Los Palacios 15'   ,'690345821' ,'21' ,'franciscojavier@gmail.com' ,'1' , 'B'  ,'tarde'   ,'0' , '35687427Gg', 1 );
EXECUTE insertarAlumno('12345678A' , 'Joaquin Romero Murube'            ,'Calle Buenavista 108'    ,'678912345' ,'20' ,'joaquinromero@gmail.com'   ,'1' , 'A1' ,'tarde'   ,'0' , '12345678Aa', 1 );
EXECUTE insertarAlumno('12345678B' , 'Federico García Lorca'            ,'Calle Rojo Fuego 1'      ,'657390573' ,'22' ,'federicogarcía@gmail.com'  ,'0' , 'B'  ,'tarde'   ,'1' , '12345678Bb', 2 );
EXECUTE insertarAlumno('12345678C' , 'Ana Moreno Parejo'                ,'Calle Verde Hoja 2'      ,'657894532' ,'18' ,'anamoreno@gmail.com'       ,'1' , 'B'  ,'mañana'  ,'1' , '12345678Cc', 2 );
EXECUTE insertarAlumno('12345678D' , 'María Duque Bueno'                ,'Calle Azul Zafiro 3'     ,'624570389' ,'18' ,'mariaduque@gmail.com'      ,'1' , 'B'  ,'mañana'  ,'0' , '12345678Dd', 2 );
EXECUTE insertarAlumno('12345678E' , 'Rocio Falcón Gayango'             ,'Calle Esmeralda 4'       ,'620758943' ,'19' ,'rociofalcon@gmail.com'     ,'0' , 'B'  ,'tarde'   ,'0' , '12345678Ee', 3 );
EXECUTE insertarAlumno('12345678F' , 'Antonio Jesús García Vela'        ,'Calle Olimnpo 5'         ,'657438433' ,'31' ,'antoniojesus@gmail.com'    ,'0' , 'C1' ,'mañana'  ,'0' , '12345678Ff', 3 );


--PROFESORES                DNI           NOMBRE Y APELLIDOS           DIRECCION             AÑOSC          EMAIL                PUESTO              CONSTRASEÑA  SEDE
EXECUTE insertarprofesor('65789578T', 'Antonio Velasco Carballo', 'Avenida de la Palmera 11' ,'20' ,'antoniovelasco@gmail.com'  ,'teórico'         , '65789578Tt' , 1 );
EXECUTE insertarprofesor('75047980P', 'Miguel Gallego Lopez'    , 'Calle Extremadura 89'     ,'32' ,'miguelgallego@gmail.com'   ,'práctico'        , '75047980Pp' , 1 );
EXECUTE insertarprofesor('29897665H', 'Manuel Moguer Cabeza'    , 'Avenida de la Palmera 10' ,'15' ,'manuelmoguer@gmail.com'    ,'teórico'         , '29897665Hh' , 2 );
EXECUTE insertarprofesor('78665443E', 'Jesús Barba Hueco'       , 'Av.Sevilla  54'           ,'10' ,'jesusbarba@gmail.com'      ,'práctico'        , '78665443Ee' , 2 );
EXECUTE insertarprofesor( '75041080A', 'Miguel Troncoso Karma'  , 'Calle Buena 54'           ,'29' ,'migueltroncoso@gmail.com'  ,'teórico-práctico', '75041080Aa' , 3 );
EXECUTE insertarprofesor('12345678F', 'Jesús Antonio Moreno'    , 'Calle Huésped 23'         ,'30' ,'jesusantonio@gmail.com'    ,'teórico-práctico', '12345678Ff',  3 );


--VEHICULOS               MATRICULA     MODELO           TIPOCOMB   TIPOCOCHE   ESTADO    PROFESOR
EXECUTE insertarvehiculo('6876FWF'  , 'Ford Focus'   ,  'gasolina' , 'coche' , 'bueno' , '75041080A' );
EXECUTE insertarvehiculo('8967ABC'  , 'Fiat 500'     ,  'gasoil'   , 'coche' , 'bueno' , '12345678F' );
EXECUTE insertarvehiculo('3452FGH'  , 'Dacia Sandero',  'gasolina' , 'coche' , 'bueno' , '78665443E' );


--TEORIAS             TEMA        FECHA                          PROFESOR
EXECUTE insertarteoria(1, '1' , TO_DATE('2019-05-02','YYYY-MM-DD'), '65789578T');
EXECUTE insertarteoria(2, '2' , TO_DATE('2019-05-03','YYYY-MM-DD'), '65789578T');
EXECUTE insertarteoria(3, '3' , TO_DATE('2019-05-04','YYYY-MM-DD'), '65789578T');
EXECUTE insertarteoria(4, '3' , TO_DATE('2019-05-05','YYYY-MM-DD'), '65789578T');



--INSERTAR TESTS      FALLOS      FECHA                            ALUMNO
EXECUTE insertartests( '4'  ,  TO_DATE('2019-06-29','YYYY-MM-DD'),'28905409K');
EXECUTE insertartests( '5'  ,  TO_DATE('2019-06-30','YYYY-MM-DD'),'28905409K');
EXECUTE insertartests( '30' ,  TO_DATE('2019-06-19','YYYY-MM-DD'),'28905409K');
EXECUTE insertartests( '0'  ,  TO_DATE('2019-06-20','YYYY-MM-DD'),'28905409K');



--INSERTAR ASISTEA      ALUMNO      CLASE
EXECUTE INSERTARASISTEA( '28905409K' , 1 );
EXECUTE INSERTARASISTEA( '28905409K' , 2 );
EXECUTE INSERTARASISTEA( '28905409K' , 3 );
EXECUTE INSERTARASISTEA( '42034069F' , 2 );



--PRACTICAS                ALUMNO         PROFESOR            FECHA
EXECUTE insertarPractica( '28905409K' , '75047980P' , TO_DATE('2019-06-13','YYYY-MM-DD'));
EXECUTE insertarPractica( '28905409K' , '75047980P' , TO_DATE('2019-06-14','YYYY-MM-DD'));
EXECUTE insertarPractica( '28905409K' , '75047980P' , TO_DATE('2019-06-15','YYYY-MM-DD'));
EXECUTE insertarPractica( '28905409K' , '75047980P' , TO_DATE('2019-06-16','YYYY-MM-DD'));
EXECUTE insertarPractica( '28905409K' , '75047980P' , TO_DATE('2019-06-17','YYYY-MM-DD'));
EXECUTE insertarPractica( '28905409K' , '75047980P' , TO_DATE('2019-06-18','YYYY-MM-DD'));
EXECUTE insertarPractica( '28905409K' , '75047980P' , TO_DATE('2019-06-21','YYYY-MM-DD'));
EXECUTE insertarPractica( '28905409K' , '75047980P' , TO_DATE('2019-06-22','YYYY-MM-DD'));
EXECUTE insertarPractica( '28905409K' , '75047980P' , TO_DATE('2019-06-23','YYYY-MM-DD'));
EXECUTE insertarPractica( '28905409K' , '75047980P' , TO_DATE('2019-06-24','YYYY-MM-DD'));

EXECUTE insertarPractica( '42034069F' , '75047980P' , TO_DATE('2019-06-12','YYYY-MM-DD'));
EXECUTE insertarPractica( '42034069F' , '75047980P' , TO_DATE('2019-06-30','YYYY-MM-DD'));
EXECUTE insertarPractica( '42034069F' , '75047980P' , TO_DATE('2020-04-20','YYYY-MM-DD'));




--HACEREXAMEN             ALUMNO      EX FALLOS
EXECUTE insertarhacerex( '28905409K' , 1 ,'5' );
EXECUTE insertarhacerex( '42034069F' , 1 ,'4' );
EXECUTE insertarhacerex( '28905409K' , 3 ,'2' );
EXECUTE insertarhacerex( '28905409K' , 4 ,'0' );


