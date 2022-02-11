
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
