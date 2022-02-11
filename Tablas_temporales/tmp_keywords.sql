
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