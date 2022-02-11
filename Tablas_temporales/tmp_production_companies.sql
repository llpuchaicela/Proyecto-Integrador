
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

