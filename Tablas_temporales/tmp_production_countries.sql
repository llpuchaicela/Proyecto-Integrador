
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
