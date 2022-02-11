
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

