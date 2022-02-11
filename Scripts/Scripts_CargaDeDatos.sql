/* Universidad Técnica Particular de Loja
Ingeniería en Ciencias de la Computación
Materia: Fundamentos de Base de Datos - Octubre 2021 - Febrero 2022
Proyecto Final - Ciclo de vida de bases de datos relacionales normalizada
Estudiante: Lady Lilibeth Puchaicela Calva | llpuchaicela[@]utpl.edu.ec
Profesor: Nelson Piedra | http://investigacion.utpl.edu.ec/nopiedra
Fecha: Loja, 10 de febrero del 2022
*/

# ⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘【  PROYECTO INTEGRADOR 】  ⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘

# ❧ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙  ❧ 【     SCRIPS DE DATOS      】 ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙

# ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ 【 TABLA PERSON  】 ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙

-- Carga de datos a tabla PERSON (id_crew, name, gender)
INSERT INTO Person
SELECT DISTINCT id_crew, name, gender
FROM tmp_crew ;
# ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ 【 TABLA CREDIT    】 ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙

-- Carga de datos a tabla CREDIT (credit_id,id_crew,department,job)
INSERT INTO credit
SELECT DISTINCT credit_id,id_crew,department,job
FROM tmp_crew ;
# ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ 【 TABLA MOVIE_CREW    】 ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙

-- Carga de datos a tabla movie_crew (idMovie, credit_id) -- 129,581

INSERT INTO movie_crew
SELECT DISTINCT id_movie,credit_id
FROM tmp_crew;

# ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ 【 TABLA PRODUCCION_COMPANIES    】 ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙
-- Carga de datos a tabla production_companies (idcompany,name)
INSERT INTO production_companies(idcompany,name)
SELECT DISTINCT id_company,name_company
FROM tmp_production_companies ;

# ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧【 TABLA MOVIE_COMPANIES   】 ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙

-- Carga de datos a tabla movie_company (idcompany,id_movie)
INSERT INTO movie_companies(idcompany,idMovie)
SELECT DISTINCT id_company,id_movie
FROM tmp_production_companies ;


# ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧【 TABLA PRODUCCION_COUNTRIES    】 ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙

-- Carga de datos a la tabla oficial production_country (sin registros duplicados) - 88
INSERT INTO production_countries
SELECT DISTINCT iso31661, name FROM tmp_production_countries;

# ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ 【 TABLA MOVIE_COUNTRIES    】 ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙
-- Carga de datos a la tabla oficial movie_country (sin registros duplicados) -6436
INSERT INTO movie_countries
SELECT DISTINCT  idMovie,iso31661
FROM tmp_production_countries;


# ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ 【 CARGA DATA TABLA LANGUAGE  】 ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙

-- Carga de datos en la tabla oficial language (sin registros duplicados).
INSERT INTO `language`
SELECT DISTINCT iso6391, name
FROM tmp_spoken_languages;
-- Inserción de un lenguaje faltante para la relción
-- con el campo `original_language` - Total Registros: 88
INSERT INTO `language`
VALUES ('nb', 'noruego bokmål');

# ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ 【 CARGA DATA TABLA SPOKEN LANGUAGE 】 ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙

-- Carga de datos a la tabla oficial spoken_languages -  6.937
INSERT INTO spoken_languages
SELECT DISTINCT idMovie, iso6391
FROM tmp_spoken_languages;
-- Eliminación de la tabla temporal de spoken_languages
DROP TABLE IF EXISTS tmp_spoken_languages;
# ❧ ❧ ❧ ❧ 【 CARGA DATA TABLA  DIRECTOR 】 ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙
-- Carga de datos a la tabla oficial director (sin registros duplicados) - Total Registros: 2.578

INSERT INTO director
SELECT DISTINCT id_crew,name FROM tmp_crew
WHERE department = "Directing" AND job = "Director";

# ❧ ❧ ❧  【 CARGA DATA TABLA  MOVIE 】 ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙

-- Carga de datos a la tabla oficial movie - Total Registros: 4.803
INSERT INTO movie
SELECT * FROM (
	SELECT DISTINCT id, `index`, budget,
		IF(homepage != "", homepage, NULL),
		-- IF(keywords != "", keywords, NULL),
		original_language, original_title,
		IF(overview != "", overview, NULL),
		popularity,	release_date, revenue, runtime, `status`,
		IF(tagline != "", tagline, NULL),
		title, vote_average, vote_count,
		-- IF(cast != "", cast, NULL),
		IF(director != "", tc.id_crew, NULL) idDirector
	FROM movie_dataset_cleaned
	LEFT JOIN tmp_crew tc ON (director IN (tc.name, ""))
	WHERE tc.job = "Director"
) t
-- WHERE idDirector NOT IN (1009253, 930212) OR idDirector is NULL ;

-- SELECT director.idDirector, director.name FROM director WHERE idDirector=930212;


# ❧ ❧ ❧❧ 【 CARGA DATA TABLA  GENRES 】 ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙

-- Carga de datos del campo multivaluado `genres` en la tabla oficial genre - Total Registros: 21

INSERT INTO genre (name, idGenre)
SELECT DISTINCT * FROM(
	SELECT DISTINCT IF(genres LIKE '%Science Fiction%', "Science Fiction",
		SUBSTRING_INDEX(SUBSTRING_INDEX(genres," ", -4)," ", 1)) AS genero,
	    md5(IF(genres LIKE '%Science Fiction%', "Science Fiction",
		SUBSTRING_INDEX(SUBSTRING_INDEX(genres," ", -4)," ", 1))) AS idGenre
	FROM movie_dataset
)t WHERE genero != "" AND genero != "Science" AND genero != "Fiction";


# ❧ ❧ ❧  【 CARGA DATA TABLA  MOVIE GENRES 】 ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙

-- Carga de datos a la tabla oficial movies_genres - Total Registros: 12.127

INSERT INTO movie_genres
SELECT DISTINCT idGenre, id FROM movie_dataset_cleaned, genre
WHERE genres LIKE CONCAT('%',name,'%');


# ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ 【 TABLA CAST    】 ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙
-- Carga de datos a tabla cast desde la tabla tmp_cast
INSERT INTO cast(idCast,actor)
SELECT DISTINCT idCast,actor
FROM tmp_cast ;

# ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧【 TABLA MOVIE_CAST   】 ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙

-- Carga de datos a tabla movie_cast desde la tabla tmp_cast
INSERT INTO movie_cast(idMovie,idCast)
SELECT DISTINCT idMovie,idCast
FROM tmp_cast ;

# ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ 【 TABLA KEYWORDS    】 ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙
-- Carga de datos a tabla keywords desde la tabla tmp_Keywords
INSERT INTO keywords(idKeyword,word)
SELECT DISTINCT idKeyword,word
FROM tmp_keywords ;

# ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧【 TABLA MOVIE_CAST   】 ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙

-- Carga de datos a tabla movie_cast desde la tabla tmp_Keywords
INSERT INTO movie_cast(idMovie,idCast)
SELECT DISTINCT idMovie,idCast
FROM tmp_cast ;
