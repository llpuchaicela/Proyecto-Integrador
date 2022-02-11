/* Universidad Técnica Particular de Loja
Ingeniería en Ciencias de la Computación
Materia: Fundamentos de Base de Datos - Octubre 2021 - Febrero 2022
Proyecto Final - Ciclo de vida de bases de datos relacionales normalizada
Estudiante: Lady Lilibeth Puchaicela Calva | llpuchaicela[@]utpl.edu.ec
Profesor: Nelson Piedra | http://investigacion.utpl.edu.ec/nopiedra
Fecha: Loja, 10 de febrero del 2022
*/

# ⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘  PROYECTO INTEGRADOR   ⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘
#⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘
# ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ 【 CREAR DE DATABASE 】 ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙

USE movie;
USE datasetproyect;

# ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ 【       DDL         】 ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙
-- ---------------------------------------------------------------------------------------------------------------------
--
-- Eliminación previa de tablas
--
-- ----------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS `language`;
DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS credit;
DROP TABLE IF EXISTS director;
DROP TABLE IF EXISTS movie;
DROP TABLE IF EXISTS genre;
DROP TABLE IF EXISTS cast;
DROP TABLE IF EXISTS keywords;
DROP TABLE IF EXISTS movie_genres;
DROP TABLE IF EXISTS spoken_languages;
DROP TABLE IF EXISTS movie_crew;
DROP TABLE IF EXISTS production_companies;
DROP TABLE IF EXISTS movie_companies;
DROP TABLE IF EXISTS production_country;
DROP TABLE IF EXISTS movie_country;
DROP TABLE IF EXISTS movie_cast;
DROP TABLE IF EXISTS movie_keywords;

####################################################
#                                                  #
#           Normalización                          #
#           PRIMERA FORMA NORMA 1FN                #
#           Tablas separadas                       #
#   Movie   → id (PK),index, budget, homepage,     #
#             original_title,language(FK)          #
#             overview, popularity,                #
#             released_date,revenue,               #
#             runtime,status,tagline               #
#             title, vote_average,                 #
#             vote_count,director (FK)             #
#  spoken_languages  →  iso6391, language          #
#  production_companies → idCompany, name          #
#  production_countries → iso31661 , name          #
#  cast      → idCast , actor                      #
#  keywords  → idKeywords, word                    #
#  Genres    → idGenres, genre                     #
#  Crew    → idCrew, name, job, gender             #
#            , department, creditId                #
#                                                  #
#           SEGUNDA FORMA NORMAL                   #
#  movie_languages  →  iso6391, idMovie            #
#  movie_companies  → idCompany, idMovie           #
#  movie_countries  → iso31661 , idMovie           #
#  movie_cast       → idCast , idMovie             #
#  movie_keywords   → idKeywords, idMovie          #
#  movie_Genres     → idGenres, idMovie            #
#  movie_Crew       → idCrew,  idMovie             #
#                                                  #
#          TERCER FORMA NORMAL                     #
#  movie_Crew    → cerditId,  idMovie              #
#  person        → idPerson,name, gender           #
#  credit        → idPerson, creditId,job,         #
#                  department                      #
#                                                  #
#####################################################


# Estructura de la tabla `movie`            \\Primera forma normal//
-- ---------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS movie (
    idMovie INT(11) NOT NULL,
    `index` INT(5) NOT NULL,
    budget INT(12) NOT NULL CHECK (budget >= 0),
    homepage VARCHAR(150) DEFAULT NULL,
    language CHAR(2) NOT NULL,
    original_title VARCHAR(90) NOT NULL,
    overview VARCHAR(1000) DEFAULT NULL,
    popularity DECIMAL(25,21) NOT NULL CHECK (popularity >= 0),
    release_date DATE CHECK (YEAR(release_date) >= 1900),
    revenue BIGINT(10) NOT NULL CHECK (revenue >= 0),
    runtime DECIMAL(4,1) COMMENT 'Tiempo de la película en minutos.'
        CHECK (runtime >= 0  AND runtime <= 500),
    status VARCHAR(15) NOT NULL CHECK (status = 'Released'
        OR status = 'Rumored'
        OR status = 'Post Production'),
    tagline VARCHAR(255) DEFAULT NULL,
    title VARCHAR(90) NOT NULL,
    vote_average DECIMAL(3 , 1 ) NOT NULL CHECK (vote_average >= 0 AND vote_average <= 10),
    vote_count INT(10) NOT NULL CHECK (vote_count >= 0),
    director INT(11) DEFAULT NULL,
    PRIMARY KEY (idMovie),
    CONSTRAINT fk_movie_language FOREIGN KEY (language)
        REFERENCES `language` (iso6391),
	CONSTRAINT fk_movie_crew FOREIGN KEY (director)
        REFERENCES director (idDirector)
);

-- ---------------------------------------------------------------------------------------------------------------------

####################################################
#                                                  #
#           TABLA Spoken_Languages                 #
#   Obtenida por primera forma normal      2FN     #
#   Primery key  :  iso6391                        #
#   Relación con tabla movie_languages             #
#                                                  #
#####################################################

# Estructura de la tabla `spoken_languages`         \\Primera forma normal//
-- ---------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS spoken_languages (
    idMovie INT(11) NOT NULL,
    iso6391 CHAR(2) NOT NULL,
    PRIMARY KEY (idMovie , iso6391),
    CONSTRAINT `fk_spoken_languages_movie` FOREIGN KEY (idMovie)
        REFERENCES movie (idMovie),
    CONSTRAINT `fk_spoken_languages_language` FOREIGN KEY (iso6391)
        REFERENCES `language` (iso6391)
);
-- ---------------------------------------------------------------------------------------------------------------------

####################################################
#                                                  #
#           TABLA  Languages                       #
#   Obtenida por segunda forma normal      2FN     #
#   Primery key  :  idMoive, iso6391               #
#   Relación con tabla languages                   #
#   Resultante de la tabla languages               #
#                                                  #
#####################################################

# Estructura de la tabla `language`  \\Primera forma normal//
-- ---------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `language` (
    iso6391 CHAR(2) NOT NULL,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY (iso6391)
);
-- ---------------------------------------------------------------------------------------------------------------------

####################################################
#                                                  #
#           TABLA  person                          #
#   Obtenida por segunda forma normal      3FN     #
#   Primery key  :  idPerson                       #
#   Resultante de la tabla Crew                    #
#                                                  #
#####################################################

# Estructura de la tabla `person`    \\Segunda forma normal//
-- ---------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS person (
    idPerson INT(11) NOT NULL,
    name VARCHAR(50) NOT NULL,
    gender INT(1) NOT NULL COMMENT 'Genero del tripulante; 0 es sin especificar,
		1 mujer y 2 hombre' CHECK (gender >= 0 AND gender <= 2),
    PRIMARY KEY (idPerson)
);
-- ---------------------------------------------------------------------------------------------------------------------

####################################################
#                                                  #
#           TABLA  Languages                       #
#   Obtenida por segunda forma normal      3FN     #
#   Primery key  :  idMovie, iso6391               #
#   Foreign key  :  idPerson                       #
#   Relación con tabla person                      #
#   Resultante de la tabla crew                    #
#                                                  #
#####################################################

# Estructura de la tabla `credit`       \\Tercera forma normal//
-- ---------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS credit (
    creditId VARCHAR(25) NOT NULL,
    idPerson INT(11) NOT NULL,
    job VARCHAR(75) NOT NULL,
    department VARCHAR(25) NOT NULL,
    PRIMARY KEY (creditId),
    CONSTRAINT `fk_credit_person` FOREIGN KEY (idPerson)
        REFERENCES person (idPerson)
);
-- ---------------------------------------------------------------------------------------------------------------------

####################################################
#                                                  #
#           TABLA  movie_crew                      #
#   Obtenida por segunda forma normal      3FN     #
#   Primery key  :  idMovie, creditId              #
#   Relación con tabla credit                      #
#   Resultante de campo Crew                       #
#                                                  #
#####################################################

# Estructura de la tabla `movie_crew`           \\Segunda forma normal//
-- ---------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS movie_crew (
    idMovie INT(11) NOT NULL,
    creditId VARCHAR(25) NOT NULL,
    PRIMARY KEY (idMovie , creditId),
    CONSTRAINT `fk_crew_movie` FOREIGN KEY (idMovie)
        REFERENCES movie (idMovie),
    CONSTRAINT `fk_crew_credit` FOREIGN KEY (creditId)
        REFERENCES credit (creditId)
);
-- ---------------------------------------------------------------------------------------------------------------------

####################################################
#                                                  #
#           TABLA  director                        #
#   Obtenida por segunda forma normal      3FN     #
#   Primery key  :  idDirector, creditId           #
#   Foreign key  :  idMovie, creditId              #
#   Relación con tabla person                      #
#                                                  #
#####################################################

# Estructura de la tabla `director`        \\Campo sacado como tabla debido a la relacion que existe con person//
-- ---------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS director (
    idDirector INT(11) NOT NULL,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (idDirector)
);

-- ---------------------------------------------------------------------------------------------------------------------

####################################################
#                                                  #
#           TABLA Genres                           #
#   Obtenida por primera forma normal      1FN     #
#   Primery key  :  idGenre                        #
#                                                  #
#####################################################

# Estructura de la tabla `genre`        \\Primera forma normal//
-- ---------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS genre (
    idGenre INT(11) NOT NULL AUTO_INCREMENT,
    name VARCHAR(15) NOT NULL,
    PRIMARY KEY (idGenre)
);
-- ---------------------------------------------------------------------------------------------------------------------

####################################################
#                                                  #
#           TABLA movie_genres                     #
#   Obtenida por segunda forma normal      2FN     #
#   Primery key  :  idGenre, idMovie               #
#   Relación con tabla genre                       #
#                                                  #
#####################################################


# Estructura de la tabla `movie_genres`       \\Segunda forma normal//
-- ---------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS movie_genres (
    idMovie INT(11) NOT NULL,
    idGenre INT(11) NOT NULL,
    PRIMARY KEY (idMovie , idGenre),
    CONSTRAINT `fk_orientation_movie` FOREIGN KEY (idMovie)
        REFERENCES movie (idMovie),
    CONSTRAINT `fk_orientation_genre` FOREIGN KEY (idGenre)
        REFERENCES genre (idGenre)
);
-- ---------------------------------------------------------------------------------------------------------------------

####################################################
#                                                  #
#           TABLA production_companies             #
#   Obtenida por primera forma normal      1FN     #
#   Primery key  :  idCompany                      #
#                                                  #
#####################################################


# Estructura de la tabla `production_companies`     \\Primera forma normal//
-- ---------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS production_companies (
    idCompany INT(11) NOT NULL,
    name VARCHAR(85) NOT NULL,
    PRIMARY KEY (idCompany)
);
-- ---------------------------------------------------------------------------------------------------------------------
####################################################
#                                                  #
#           TABLA movie_companies             #
#   Obtenida por primera forma normal      1FN     #
#   Primery key  :  idCompany, idMovie             #
#   Tabla resultante de production_companies       #
#                                                  #
#####################################################

# Estructura de la tabla `movie_companies`          \\Segunda forma normal//
-- ---------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS movie_companies (
    idMovie INT(11) NOT NULL,
    idCompany INT(11) NOT NULL,
    PRIMARY KEY (idMovie , idCompany),
    CONSTRAINT `fk_production_companies_movie` FOREIGN KEY (idMovie)
        REFERENCES movie (idMovie),
    CONSTRAINT `fk_production_companies_company` FOREIGN KEY (idCompany)
        REFERENCES production_companies (idCompany)
);
-- ---------------------------------------------------------------------------------------------------------------------

####################################################
#                                                  #
#           TABLA production_countries             #
#   Obtenida por primera forma normal      1FN     #
#   Primery key  :  iso31661,name                  #
#                                                  #
#####################################################


# Estructura de la tabla `production_countries`   \\Primera forma normal//
-- ---------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS production_countries (
    iso31661 CHAR(2) NOT NULL,
    name VARCHAR(30) NOT NULL,
    PRIMARY KEY (iso31661)
);
-- ---------------------------------------------------------------------------------------------------------------------

####################################################
#                                                  #
#           TABLA movie_countries             #
#   Obtenida por primera forma normal      1FN     #
#   Primery key  :  iso31661 , idMovie             #
#   Tabla resultante de production_countries       #
#                                                  #
#####################################################

# Estructura de la tabla `movie_countries`      \\Segunda forma normal//
-- ---------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS movie_countries (
    idMovie INT(11) NOT NULL,
    iso31661 CHAR(2) NOT NULL,
    PRIMARY KEY (idMovie , iso31661),
    CONSTRAINT `fk_production_countries_movie` FOREIGN KEY (idMovie)
        REFERENCES movie (idMovie),
    CONSTRAINT `fk_production_countries_country` FOREIGN KEY (iso31661)
        REFERENCES production_countries (iso31661)
);
-- ---------------------------------------------------------------------------------------------------------------------

####################################################
#                                                  #
#           TABLA cast                             #
#   Obtenida por primera forma normal      1FN     #
#   Primery key  :  idCast                         #
#                                                  #
#####################################################


-- Estructura de la tabla `cast`            \\Primera forma normal//
--
-- ---------------------------------------------------------------------------------------------------------------------
CREATE TABLE  cast (
    idCast VARCHAR(50) NOT NULL,
    actor VARCHAR(75) NOT NULL,
    PRIMARY KEY (idCast)
);
-- ---------------------------------------------------------------------------------------------------------------------

####################################################
#                                                  #
#           TABLA movie_cast                       #
#   Obtenida por segunda forma normal      2FN     #
#   Primery key  :  idMovie   , idCast             #
#   Tabla resultante de cast                       #
#                                                  #
#####################################################

# Estructura de la tabla `movie_cast`      \\Segunda forma normal//
-- ---------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS movie_cast (
    idMovie INT(11) NOT NULL,
    idCast VARCHAR(50) NOT NULL,
    PRIMARY KEY (idMovie , idCast),
    CONSTRAINT `fk_cast_movie`
        FOREIGN KEY (idMovie)
        REFERENCES movie (idMovie),
    CONSTRAINT `fk_cast_movie_cast`
        FOREIGN KEY (idCast)
        REFERENCES cast (idCast)
);
-- ---------------------------------------------------------------------------------------------------------------------

####################################################
#                                                  #
#           TABLA KEYWORDS                         #
#   Obtenida por primera forma normal      1FN     #
#   Primery key  :  idCast                         #
#                                                  #
#####################################################


-- Estructura de la tabla `keywords`            \\Primera forma normal//
--
-- ---------------------------------------------------------------------------------------------------------------------
CREATE TABLE  keywords (
    idKeyword VARCHAR(50) NOT NULL,
    word VARCHAR(100) NOT NULL,
    PRIMARY KEY (idKeyword)
);
-- ---------------------------------------------------------------------------------------------------------------------

####################################################
#                                                  #
#           TABLA MOVIE_KEYWORDS                   #
#   Obtenida por primera forma normal      2FN     #
#   Primery key  :  idKeywords, idMovie            #
#   Tabla resultante de keywords                   #
#                                                  #
#####################################################


# Estructura de la tabla `movie_keywords`      \\Segunda forma normal//
-- ---------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS movie_keywords (
    idMovie INT(11) NOT NULL,
    idkeyword VARCHAR(50) NOT NULL,
    PRIMARY KEY (idMovie , idkeyword),
    CONSTRAINT `fk_keywords_movie`
        FOREIGN KEY (idMovie)
        REFERENCES movie (idMovie),
    CONSTRAINT `fk_keywords_movie_keywords`
        FOREIGN KEY (idkeyword)
        REFERENCES keywords (idkeyword)
);





