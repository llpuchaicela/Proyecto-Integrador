/* Universidad Técnica Particular de Loja
Ingeniería en Ciencias de la Computación
Materia: Fundamentos de Base de Datos - Octubre 2021 - Febrero 2022
Proyecto Final - Ciclo de vida de bases de datos relacionales normalizada
Estudiante: Lady Lilibeth Puchaicela Calva | llpuchaicela[@]utpl.edu.ec
Profesor: Nelson Piedra | http://investigacion.utpl.edu.ec/nopiedra
Fecha: Loja, 10 de febrero del 2022
*/

# ⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘【  PROYECTO INTEGRADOR 】  ⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘
# ❧ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙  ❧ 【     PROCEDIMIENTOS      】 ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙

####################################################################################

-- Crear procedimiento
-- Crear tabla temp_crew  para posterior carga de datos en
-- tablas person, credit, movie_crew
-- Corrección dato de KENNET LONERGAN
####################################################################################


# ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧【   PROCEDIMIENTOS_CREW  】 ☙ ☙  ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙
-- Borrar si existe una versión anterior (re-crear el procedimiento)
DROP PROCEDURE IF EXISTS Json2Relational_crew ;
DELIMITER //
CREATE PROCEDURE Json2Relational_crew()
BEGIN
	DECLARE i INT Default 0 ;
-- crear tabla temporal para almacenar datos de crew que están en JSON
	DROP TABLE IF EXISTS tmp_crew;
    CREATE TABlE tmp_crew  (id_movie INT,id_crew  INT,job  VARCHAR(200),gender INT,
        credit_id  VARCHAR(50), department VARCHAR(50), name       VARCHAR(400));
   simple_loop: LOOP
    -- CARGA de datos del objeto JSON en la tabla temporal
	INSERT INTO tmp_crew
        SELECT idMovie,idCrew,job,gender,credit_id,department,
			IF(name LIKE '"''%' AND name LIKE '%''"',
				REPLACE(REPLACE(REPLACE(name, """'", """"),"'""", """"), """", ""),REPLACE(name, """", ""))
		FROM(SELECT id as idMovie,
				JSON_EXTRACT(CONVERT(crew USING utf8mb4), CONCAT("$[",i,"].id")) AS idCrew,
				REPLACE(JSON_EXTRACT(CONVERT(crew USING utf8mb4),CONCAT("$[",i,"].credit_id")), """", "") AS credit_id,
				REPLACE(JSON_EXTRACT(CONVERT(crew USING utf8mb4),CONCAT("$[",i,"].job")), """", "") AS job,
				REPLACE(JSON_EXTRACT(CONVERT(crew USING utf8mb4),CONCAT("$[",i,"].department")), """", "") AS department,
				JSON_EXTRACT(CONVERT(crew USING utf8mb4),CONCAT("$[",i,"].gender")) AS gender,
			    JSON_EXTRACT(CONVERT(crew USING utf8mb4), CONCAT("$[",i,"].name")) AS name
			FROM movie_dataset_cleaned
			WHERE id IN (SELECT id FROM movie_dataset_cleaned WHERE i <= JSON_LENGTH(crew))) t;
		SET i=i+1;
     	IF i=436 THEN
            LEAVE simple_loop;
      END IF;
   END LOOP simple_loop;
   -- limpieza de registros nulos
   DELETE FROM tmp_crew WHERE id_crew IS NULL ; --  tuplas en tmp_crew
END //
DELIMITER ;
Call Json2Relational_crew();
ALTER TABLE tmp_crew ADD PRIMARY KEY (id_movie, credit_id);

# ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧❧ 【  CORRECCION   】 ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙

-- Update corrección de genero para Kenneth Lonergan en tabla temp_crew
UPDATE tmp_crew
SET gender = 2
WHERE id_crew = 30711 ;

####################################################################################
-- Crear procedimiento
-- Crear tabla temp_production_companies  para posterior carga de datos en
-- tablas production_companies, movie_companies
####################################################################################

# ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ 【 PROCEDIMIENTO  PRODUCTION_COMPANY 】 ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙

-- Borrar si existe una versión anterior (re-crear el procedimiento)
DROP PROCEDURE IF EXISTS json_production_companies ;
DELIMITER //
-- Crear procedimiento para production_companies
CREATE PROCEDURE json_production_companies()
BEGIN
	DECLARE i INT Default 0 ;
	-- crear tabla temporal para almacenar datos de production_companies que están en JSON
	DROP TABLE IF EXISTS tmp_production_companies ;
    CREATE TABlE tmp_production_companies (id_movie INT, id_company   INT, name_company VARCHAR(100));
	-- ciclo repetitivo para ir cargando datos desde el arreglo JSON hacia la tabla temporal
  simple_loop: LOOP
    -- cargando datos del objeto JSON en la tabla temporal
		INSERT INTO tmp_production_companies
		    (id_movie, id_company, name_company)
		SELECT id as id_Movie,
			JSON_EXTRACT(CONVERT(production_companies using utf8mb4),
			    CONCAT("$[",i,"].id")) AS id_company,
			JSON_EXTRACT(CONVERT(production_companies using utf8mb4),
			    CONCAT("$[",i,"].name")) AS name_company
		FROM movie_dataset m ;
			SET i=i+1;
     	IF i=10 THEN
            LEAVE simple_loop;
      END IF;
   END LOOP simple_loop;
   DELETE FROM tmp_production_companies WHERE id_company IS NULL ;
END //
DELIMITER ;
-- llamada al procedimiento
Call json_production_companies();
ALTER TABLE tmp_production_companies ADD PRIMARY KEY (id_movie, id_company);


####################################################################################
-- Crear procedimiento
-- Crear tabla tmp_production_countries  para posterior carga de datos en
-- tablas production_countries, movie_countries
####################################################################################

# ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧  【 PROCEDIMIENTO PRODUCCION_COUNTRIES    】 ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙

-- Creación de la tabla tmp_production_countries para almacenar los campos del JSON de production_countries.
CREATE TABLE IF NOT EXISTS tmp_production_countries(
	idMovie INT,   iso31661 char(2), name varchar(30));
-- Procedimiento para cargar la data en la tabla tmp_crew.
DROP PROCEDURE IF EXISTS Json2_production_countries;
DELIMITER //
CREATE PROCEDURE Json2_production_countries()
BEGIN
	DECLARE i INT DEFAULT 0;
	WHILE i <= 11 DO
    -- Carga datos del objeto JSON en la tabla temporal.
    INSERT INTO tmp_production_countries
    SELECT DISTINCT * FROM (SELECT id AS idMovie,
			REPLACE(JSON_EXTRACT(production_countries,
			    CONCAT("$[",i,"].iso_3166_1")), """", "") AS iso31661,
			REPLACE(JSON_EXTRACT(production_countries,
			    CONCAT("$[",i,"].name")), """", "") AS name
		FROM movie_dataset
		WHERE id IN (SELECT id
		FROM movie_dataset_cleaned
		WHERE i <= JSON_LENGTH(production_countries))) t;
    -- Limpieza de registros nulos en la tabla temporal production_countries.
	DELETE FROM tmp_production_countries
	WHERE iso31661 IS NULL;
	SET i=i+1;
	END WHILE;
END //
DELIMITER ;
-- Llamada al procedimiento.
CALL Json2_production_countries();
-- Asignación de clave primaria en la tabla tmp_production_countries.
ALTER TABLE tmp_production_countries ADD PRIMARY KEY (idMovie, iso31661) ;

####################################################################################
-- Crear procedimientos
-- Crear tabla tmp_spoken_languages  para posterior carga de datos en
-- tablas spoken_languages, movie_languages
####################################################################################

# ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ 【 PROCEDIMIENTO Spoken_Languages  】 ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙
-- Creación de la tabla tmp_spoken_languages para almacenar los campos del JSON de spoken_languages.
CREATE TABLE IF NOT EXISTS tmp_spoken_languages (
    idMovie INT,iso6391 CHAR(2), name VARCHAR(50));
-- Procedimiento para cargar la data en la tabla tmp_spoken_languages.
DROP PROCEDURE IF EXISTS Json2_spoken_languages;
DELIMITER //
CREATE PROCEDURE Json2_spoken_languages()
BEGIN
	DECLARE i INT DEFAULT 0;
	WHILE i <= 8 DO
    CREATE TABLE IF NOT EXISTS tmp_spoken_languages (
    idMovie INT, iso6391 CHAR(2), name VARCHAR(50));
    INSERT INTO tmp_spoken_languages
    SELECT DISTINCT * FROM (
		SELECT id AS idMovie,
			REPLACE(JSON_EXTRACT(spoken_languages,CONCAT("$[",i,"].iso_639_1")), """", "") AS iso6391,
			REPLACE(JSON_EXTRACT(spoken_languages,CONCAT("$[",i,"].name")), """", "") AS name
		FROM movie_dataset_cleaned
		WHERE id IN (SELECT id FROM movie_dataset_cleaned
		WHERE i <= JSON_LENGTH(spoken_languages))) t;
	SET i=i+1;
	END WHILE;
    -- Limpieza de registros nulos en la tabla temporal spoken_languages.
	DELETE FROM tmp_spoken_languages
	WHERE iso6391 IS NULL;
END //
DELIMITER ;
-- Llamada al procedimiento.
CALL Json2_spoken_languages();
-- Asignación de clave primaria en la tabla SPOKEN_LANGUAGES
ALTER TABLE tmp_spoken_languages ADD PRIMARY KEY (idMovie, iso6391) ;


####################################################################################
-- Crear procedimiento
-- Crear tabla tmp_cast para posterior carga de datos en
-- tablas cast, movie_cast
####################################################################################


# ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧【   PROCEDIMIENTO CAST 】 ☙ ☙  ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙

-- Borrar si existe una versión anterior (re-crear el procedimiento)
DROP PROCEDURE IF EXISTS Json2Relational_cast ;
DELIMITER //
CREATE PROCEDURE Json2Relational_cast()
BEGIN
	DECLARE i INT Default 0 ;
	-- crear tabla temporal para almacenar datos de production_companies que están en JSON
	DROP TABLE IF EXISTS tmp_cast ;
    CREATE TABlE tmp_cast ( idMovie  INT(11), idCast  VARCHAR(50),actor   VARCHAR(125));
	-- ciclo repetitivo para ir cargando datos desde el arreglo JSON hacia la tabla temporal
  simple_loop: LOOP
    -- cargando datos del objeto JSON en la tabla temporal
INSERT INTO tmp_cast
SELECT idMovie,
        MD5(REPLACE(JSON_EXTRACT(actor,CONCAT("$[",i,"]")),"""","")) AS idActor,
         REPLACE(JSON_EXTRACT(actor,CONCAT("$[",i,"]")),"""","") AS actor
-- JSON_VALID(actor)
FROM( SELECT  id AS idMovie,
       REPLACE(REPLACE(CONCAT('["',
            IF(SpacesNumber >= 13, CONCAT(SUBSTRING_INDEX(SUBSTRING_INDEX(cast, ' ', -14), ' ', 2), '","'), '') ,
            IF(SpacesNumber >= 11, CONCAT(SUBSTRING_INDEX(SUBSTRING_INDEX(cast, ' ', -12), ' ', 2), '","'), '') ,
            IF(SpacesNumber >= 9, CONCAT(SUBSTRING_INDEX(SUBSTRING_INDEX(cast, ' ', -10), ' ', 2), '","'), '') ,
            IF(SpacesNumber >= 7, CONCAT(SUBSTRING_INDEX(SUBSTRING_INDEX(cast, ' ', -8), ' ', 2), '","'), '') ,
            IF(SpacesNumber >= 5, CONCAT(SUBSTRING_INDEX(SUBSTRING_INDEX(cast, ' ', -6), ' ', 2), '","'), '') ,
            IF(SpacesNumber >=3, CONCAT(SUBSTRING_INDEX(SUBSTRING_INDEX(cast, ' ', -4), ' ', 2), '","'), '') ,
        		IF(SpacesNumber >=1, CONCAT(SUBSTRING_INDEX(cast, ' ', -2), ''), ' '),
       '"]'),"_", " "),"Delete", " ") AS actor,
	SUBSTRING(cast, 1, LOCATE(" ", cast, LOCATE(" ", cast)+1)),
	SUBSTRING(cast, LOCATE(" ", cast, LOCATE(" ", cast)+1)+1)
FROM( SELECT id, cast, LENGTH(cast) - LENGTH(REPLACE(cast, ' ', '')) AS SpacesNumber
FROM( SELECT id,
        REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
        REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
        REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
        REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
        REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
        REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
        REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
        REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
        REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
        REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
        REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(cast,
        ' "', "'"),'" ', " ' "),'  ', ' '),' Jr.', '_Jr.'), ' Jr ', '_Jr '), 'E.G. ', 'E.G._'), ' the ', ' the_'),
        ' The ', ' The_'), ' de ','_de'), 'Le Gros',' LeGros'), ' Le ','_Le '), ' Al ',' Al_'),'J. T.', 'J._T.'),
        'E. J.', 'E._J.'),' J. ', '_J. '),'50 ', '50_'), 'R. D.','R._D.'), 'Billy Bob Thornton', 'Billy_Bob Thornton'),
        'M ', 'M_'), ' T. ',' T._'), 'G. W.', 'G._W.'), ' G. ', ' G._'), ' W. ', ' W._'),'K. D.', 'K._D.'),
        'K. C.', 'K._C.'), 'D. B.', 'D._B.'), 'D. L.', 'D._L.') , ' D. ', ' D._'),'Xzibit', 'Xzi bit'),
        ' L. ', ' L._'), ' C. ', ' C._'), 'William Scott', 'William+Scott'),'R. H.','R._H.'), ' R. ', ' R._'),
        'T.I.', 'T. I.'), ' O. ', ' O._'), ' H. ', ' H._'), ' A. ', ' A._'), ' E. ', ' E._'), ' P. ', ' P._'),
        ' F. ', ' F._'), ' F. ', ' F._'),' B. ', ' B._'),' Madonna ',' Madonna Delete '),'J._Cobb',' J. Cobb '),
            ' E.G._Marshall ',' E.G. Marshall'),' Hauser ',' Hauser Delete '),' Mako ',' Mako Delete '),
            ' Eminem ',' Eminem Delete '),' Mastrantonio ',' Mastrantonio Delete '),'the-Cable Guy','the_Cable_Guy'),
            'Tupac Amaru Shakur', 'Tupac Amaru_Shakur'),'Putu Dinda Pratika', 'Putu Dinda_Pratika'),
            'Shriman Umeshanad Brahmachari','Shriman Umeshanad_Brahmachari'),'Leon Isaac Kennedy','Leon Isaac-Kennedy'),
            ' Wilbur ''Hi-Fi'' White',' Wilbur ''Hi-Fi''_White'),'Patricia Reyes Spíndola','Patricia Reyes_Spíndola'),
            'Kotto Jim Brown', 'Kotto Jim_Brown'), 'Penelope Ann Miller', 'Penelope Ann_Miller'),
            'Vinícius de Oliveira', 'Vinícius de_Oliveira'),'Jane Galloway Heitz', 'Jane Galloway_Heitz'),
            '=Ice Cube Morris', ' Ice Cube_Morris'),' Lucille La Verne', ' Lucille La_Verne'),
            'Stormare Joel Grey', 'Stormare Joel-Grey'), 'Paul Le Mat', 'Paul Le-Mat'),
            'Jamie Lee Curtis', 'Jamie Lee_Curtis'),'Tung Thanh Tran', 'Tung Thanh_Tran'),
            'Sarah Michelle Gellar', 'Sarah Michelle_Gellar'),'Joe Don Baker', 'Joe Don-Baker'),
            'Olivia de Havilland', 'Olivia de_Havilland'), 'Stormare Joel Grey', 'Stormare Joel_Grey'),
            'Jackie Earle Haley', 'Jackie Earle_Haley'),'Gael García Bernal', 'Gael García_Bernal'),
            'Robert De Niro', 'Robert De_Niro'),  'Ana López Mercado', 'Ana López_Mercado'),
            'Laura San Giacomo', 'Laura San_Giacomo'), 'Krafft-Raschig', 'Krafft _Raschig'),
            'Randall Duk Kim', 'Randall Duk_Kim'),  'David Sanin Paz', 'David Sanin_Paz'),
            'Mark Boone Junior', 'Mark Boone_Junior'), 'Edward James Olmos', 'Edward James_Olmos'),
            'Tony Leung Chiu-Wai', 'Tony-Leung Chiu_Wai'), 'Tom Everett Scott', 'Tom Everett_Scott'),
            'Seann William Scott', 'Seann William_Scott'), 'Tony Lo Bianco', 'Tony Lo_Bianco'),
            'Louise Lemoine Torrès', 'Louise Lemoine_Torrès'),'Billy Bob Thornton', 'Billy Bob_Thornton'),
            'Jonathan Ke Quan', 'Jonathan Ke_Quan'),'Benicio del Toro', 'Benicio del_Toro'),
            'Mary Elizabeth Mastrantonio', 'Mary Elizabeth_Mastrantonio'),
            'Philip Seymour Hoffman', 'Philip Seymour_Hoffman'),'Jonathan Rhys Meyers', 'Jonathan Rhys_Meyers'),
            'Charles Martin Smith', 'Charles Martin_Smith'),'Tim Blake Nelson', 'Tim Blake_Nelson'),
            'Anthony Michael Hall', 'Anthony Michael_Hall'),'Robert Sean Leonard', 'Robert Sean_Leonard'),
            'Max von Sydow', 'Max von_Sydow'),'Brendan Sexton III', 'Brendan Sexton_III'),
            'Marcia Gay Harden', 'Marcia Gay_Harden'), 'Thomas Bo Larsen', 'Thomas Bo_Larsen'),
            'Philip Baker Hall', 'Philip Baker_Hall'), 'Harry Dean Stanton', 'Harry Dean_Stanton'),
            'Lisa Ann Walter', 'Lisa Ann_Walter'),'Gian Maria Volonté', 'Gian Maria_Volonté'),
            'Gordon Liu Chia-Hui', 'Gordon Liu_Chia_Hui'), 'Kristin Scott Thomas', 'Kristin Scott_Thomas'),
            'Gordon Liu Chia-Hui', 'Gordon Liu_Chia_Hui'), 'Tommy Lee Jones', 'Tommy Lee_Jones'),
            'Lee Van Cleef', 'Lee Van_Cleef'),'Nicole de Boer', 'Nicole de_Boer'),
            'Dick Van Dyke', 'Dick Van_Dyke'),'Catalina Sandino Moreno', 'Catalina Sandino_Moreno'),
            'Michael Clarke Duncan', 'Michael Clarke_Duncan'), 'Sarah Jessica Parker', 'Sarah Jessica_Parker'),
            'Helena Bonham Carter', 'Helena Bonham_Carter'), 'Bryce Dallas Howard', 'Bryce Dallas_Howard'),
            'Helena Bonham Carter', 'Helena Bonham_Carter'),'Thomas Haden Church', 'Thomas Haden_Church'),
            'Mario Van Peebles', 'Mario Van_Peebles'),'Helena Bonham Carter', 'Helena Bonham_Carter'),
            'Deborah Kara Unger', 'Deborah Kara_Unger'),'Klaus Maria Brandauer', 'Klaus Maria_Brandauer'),
            'Lara Flynn Boyle', 'Lara Flynn_Boyle'),'Alexandra Maria Lara', 'Alexandra Maria_Lara'),
            'Michele Lamar Richards', 'Michele Lamar_Richards'),'Jonny Lee Miller', 'Jonny Lee_Miller'),
            'Haley Joel Osment', 'Haley Joel_Osment'),'Dick Van Dyke', 'Dick Van_Dyke'),
            'Rik Van Nutter', 'Rik Van_Nutter') AS cast
FROM movie_dataset_cleaned)t1)t2)t3
    WHERE idMovie IN(SELECT id FROM movie_dataset_cleaned
    WHERE i<= JSON_LENGTH(CONCAT('["', REPLACE(REPLACE(actor, ' ', '","'),"_"," "),'"]')));
        SET i=i+1;
            IF i=14 THEN
                LEAVE simple_loop;
          END IF;
       END LOOP simple_loop;
     DELETE FROM tmp_cast WHERE actor = "";
END //
DELIMITER ;
Call Json2Relational_cast();
ALTER TABLE tmp_cast ADD PRIMARY KEY (id_movie, idCast);

####################################################################################
-- Crear procedimiento
-- Crear tabla tmp_keywords para posterior carga de datos en
-- tablas keywords, movie_keywords
####################################################################################

# ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧【   PROCEDIMIENTO KEYWORDS 】 ☙ ☙  ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙
-- Borrar si existe una versión anterior (re-crear el procedimiento)
DROP PROCEDURE IF EXISTS Json2Relational_Keywords;
DELIMITER //
CREATE PROCEDURE Json2Relational_Keywords()
BEGIN
	DECLARE i INT Default 0 ;
	-- crear tabla temporal para almacenar datos de pdocuction_companies que están en JSON
	DROP TABLE IF EXISTS tmp_keywords ;
    CREATE TABlE IF NOT EXISTS tmp_keywords
    (   idMovie  INT(11),idKeyword  VARCHAR(50),word VARCHAR(100));
	-- ciclo repetitivo para ir cargando datos desde el arreglo JSON hacia la tabla temporal
    WHILE i<=14 DO
	INSERT INTO tmp_keywords
    SELECT id AS idMovie,
   MD5(REPLACE(JSON_EXTRACT(CONCAT('["', REPLACE(REPLACE(keywords, ' ', '","'),"_"," "),'"]'),
			    CONCAT("$[",i,"]")),"""","")) AS idWord,
			REPLACE(JSON_EXTRACT(CONCAT('["', REPLACE(REPLACE(keywords, ' ', '","'),"_"," "),'"]'),
			    CONCAT("$[",i,"]")),"""","") AS word
		FROM(SELECT id,
		    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
            REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
            REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(keywords,
            '" ', " '"),' on ', ' on_'),' of ', ' of_'),' and ', ' and_'),' a ', ' a_'),
            ' at ', ' at_'),' ii ', ' ii_'),' vu ', '_vu '),' u.s. ', ' u.s._'),' dc ', ' dc_'),
            'dc ', 'dc_'),' mi6 ', '_mi6 '),' d.c. ', ' d.c._'),' to ', ' to_'),' the ', ' the_'),
            ' de ', ' de_'),' by ', ' by_'),' tu ', ' tu_'),' st ', ' st_'),' st. ', ' st._'),
		    ' in ', ' in_'),' s1 ', '_s1 '),' all ', ' all_'),' al ', ' al_'),' 1 ', '_1 '),
		    ' 51 ', '_51 '),' 11 2021 ', '_11 2021 '),'"trudy jackson"', "'trudy_jackson'") AS keywords
FROM movie_dataset_cleaned)t
    WHERE  id IN (SELECT  id FROM movie_dataset_cleaned
        WHERE i<= JSON_LENGTH(CONCAT('["',REPLACE(keywords,' ', '","'),'"]')));
    SET i=i+1;
    END WHILE;
	DELETE FROM tmp_keywords WHERE  word IS NULL OR word ="";
END //
DELIMITER ;
Call Json2Relational_Keywords();
ALTER TABLE tmp_keywords ADD PRIMARY KEY (id_movie, idWord);

####################################################################################
-- Dropeo de tablas temporales
-- una ves creadas las tablas originales
####################################################################################

# ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧【   DROP TABLAS TEMPORAL 】 ☙ ☙  ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙

DROP TABLE tmp_crew;
DROP TABLE tmp_production_companies;
DROP TABLE tmp_production_countries;
DROP TABLE tmp_spoken_languages;
DROP TABLE tmp_keywords;
DROP TABLE tmp_cast;

####################################################################################
-- Dropeo de procedimientos
-- creados anteriormente
####################################################################################

# ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧【   DROP PROCEDIMIENTOS 】 ☙ ☙  ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙

DROP PROCEDURE Json2Relational_crew;
DROP PROCEDURE Json2_production_countries;
DROP PROCEDURE Json2_spoken_languages;
DROP PROCEDURE Json2Relational_Keywords;
DROP PROCEDURE Json2Relational_cast;


