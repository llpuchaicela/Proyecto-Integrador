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
