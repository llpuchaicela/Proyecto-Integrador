
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

