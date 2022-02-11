/* Universidad Técnica Particular de Loja
Ingeniería en Ciencias de la Computación
Materia: Fundamentos de Base de Datos - Octubre 2021 - Febrero 2022
Proyecto Final - Ciclo de vida de bases de datos relacionales normalizada
Estudiante: Lady Lilibeth Puchaicela Calva | llpuchaicela[@]utpl.edu.ec
Profesor: Nelson Piedra | http://investigacion.utpl.edu.ec/nopiedra
Fecha: Loja, 10 de febrero del 2022
*/


# ⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘【 PROYECTO INTEGRADOR 】  ⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘
# ❧ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙  ❧ 【     FORMATEADO Y CORRECCIONES     】 ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙


# ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧ ❧【   movie_dataset_cleaned  】 ☙ ☙  ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙ ☙
-- Crear tabla con correccion y formateo completo de campos: crew, cast, keywords y director
-- Eliminacion previa de tabla formateada
DROP TABLE IF EXISTS movie_dataset_cleaned;
-- Crear tabla movie_dataset_cleaned
CREATE TABLE movie_dataset_cleaned  AS
SELECT
-- Traer los campos de la tabla movie_dataset que no se corrigen
	   `index`, budget, genres, homepage, id,original_language, original_title, overview,
       popularity, production_companies, production_countries,release_date, revenue,
       runtime, spoken_languages, `status`,tagline, title, vote_average, vote_count,
--  Convertir y reemplazar unicodes de campo cast en caracteres
       CONVERT
              (REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE
              (REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE
              (REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE
              (REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE
              (REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE
              (REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE
              (REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE
              (REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE
              (REPLACE(cast,
           '\\u00e1','á'),'\\u00e5','å'),'\\u00e9','é'),'\\u00eb','ë'),'\\u00ed','í'),'\\u00e0','à'),
           '\\u00f1','ñ'),'\\u00f8','ø'),'\\u042','B'),'\\u0438','N'),'\\u044f','я'),'\\u0421','C'),
           '\\u043d','H'),'\\u0440','p'),'\\u0433','r'),'\\u044c','b'),'\\u067e','پ'),'\\u06cc','ی'),
           '\\u0645','م'),'\\u0627','ا'),'\\u0646','ن'),'\\u0646','ع'),'\\u062f','د'),'\\u00e8','è'),
           '\\u00f3','ó'),'\\u0160','Š'),'\\u0107','ć'),'\\u0107','ć'),'\\u00f6','ö'),'\\u00e4','ä'),
           '\\u00e4','ô'),'\\u00e4','ç'),'\\u0144','ń'),'\\u2019','’'),'\\u00fc','ü'),'\\u00c1','Á'),
           '\\u00ea','ê'),'\\u00ea','ê'),'\\u00e7','ç'),'\\u00dc','Ü'),'\\u0159','ř'),'\\u00d8','Ø'),
           '\\u00fa','ú'),'\\u010d','č'),'\\u010d','č'),'\\u00f0','ð'),'\\u0219','ș'),'\\u00d3','Ó'),
           '\\u0110','Đ'),'\\u0161','š'),'\\u0101','ā'),'\\u00c5','Å'),'\\u043b','л'),'\\u014c','Ō'),
           '\\u016b','ū'),'\\u014d','ō'),'\\u015b','ś'),'\\u00ef','ï'),'\\u021b','ț'),'\\u00c9b','ಛ'),
           '\\u00f4','ô'),'\\u0301','´'),'\\u00fb','û'),'\\u00fb','û'),'\\u1ed7','ỗ'),'\\u1ecb','ị'),
           '\\u1ea3','ả'),'\\u1ebf','ế'),'\\u015f','ş'),'\\u015ea','D'),'\\u017e','ž'),'\\u00c0','À'),
           '\\u0131','ı'),'\\u011f','ğ'),'\\u1ec1','ề'),'\\u0639','ع'),'\\u00ee','îع'),'\\u00e6','æ'),
           '\\u00c9','É'),'\\u00df','ß'),'\\u015ea','ᗪ')
           using utf8mb4) AS Cast,

--  Convertir y reemplazar unicodes de campo crew en caracteres

	CONVERT(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE
	       (REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE
	       (REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE
	       (REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE
	       (REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE
	       (REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE
	       (REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE
	       (REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Crew,'\\\\', '\\'),
	        """", "'"),"', '", """, """),"': '", """: """),"': ", """: "),", '", ", """),"{'", "{"""), "\\t", ""),
	        '\\u00e9', 'é'),'\\u00e1', 'á'),'\\u00f1', 'ñ'),'\\u00c9', 'É'), '\\u0159','ř'),'\\u00f4', 'ô'),
	        '\\u00f3','ó'),'\\u00ed','í'),'\\u00d8','Ø'),'\\u00f8','ø'),'\\u00c5','Å'),'\\u00f6','ö'),
	        '\\u0142','ɫ'),'\\u017','ž'),'\\u0161','š'),'\\u00e8','è'),'\\u0144','ń'),'\\u00e7','ç'),
	        '\\u00ef','ï'),'\\u0160','Š'),'\\u00fc','ü'),'\\u00d3','Ó'),'\\u00fd','ý'),'\\u00cf','ï'),
            '\\u00e3','ã'),'\\u00ee','î'),'\\u00e2','â'),'\\u00e4','ä'),'\\u00e5','å'),'\\u00eb','ë'),
	        '\\u00eb','ë'),'\\u00fa','ú'),'\\u00df','þ'),'\\u00f0','ð'),'\\u00c1','Á'),'\\u0107','ć'),
	        '\\u015','𓍃'),'\\u0165','ť'),'\\u00ea','ê'),'\\u014c','Ō'),'\\u00c0','À'),'\\u2019','’'),
	        '\\u00fb','û'),'\\u00e6','æ'),'\\u00fe','þ'),'\\u0141','Ł '),'\\u0411','Б'),'\\u043e','o'),
            '\\u0440','p'),'\\u0438','и'),'\\u0441','с'),'\\u0421','C'),'\\u0443','y'),'\\u0442','T'),
	        '\\u0430','a'),'\\u0446','ц'),'\\u043a','k'),'\\u0439','й'),'\\u010d','č'),'\\u5f20','张 '),
	        '\\u7acb','立'),'\\u00d6','Ö'),'\\u0441','с'),'\\u010c','Č'),'\\u00cd','Í'),'\\u00f5','õ'),
	        '\\u00e0','à'),'\\u00f2','ò'), '\\u00d4','Ô'),'\\u011b','ě'),'\\u00de','Þ'),'\\u00ec','ì'),
            '\\u00da','Ú'),'\\u010e','Ď'),'\\u0433','r'), """'", """"), "'""", """")using utf8mb4) AS Crew,

--  Convertir y reemplazar unicodes de campo director en caracteres
       CONVERT(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE
              (REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE
              (REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(director,
           '\\u00e1','á'),'\\u00e4','ä'),'\\u00f3','ó'),'\\u00e9','é'),'\\u00d8','Ø'),'\\u00ed','í'),
           '\\u00e8','è'),'\\u00e7','ç'),'\\u00f4','ô'),'\\u0159','ř'),'\\u00f8','ø'),'\\u00c5','Å'),
           '\\u00f6','ö'),'\\u00e5','å'),'\\u00ef','ï'),'\\u00e6','æ'),'\\u00fb','û'),'\\u00c0','À'),
           '\\u00c1','Á'),'\\u00c9','É'),'\\u014c','Ō'),'\\u0161','š'),'\\u0142','ɫ'),'\\u0144','ń'),
           '\\u017','ž'),'\\u00f1','ñ')USING utf8mb4) AS Director,
       
--  Convertir y reemplazar unicodes de campo KEYWORDS en caracteres
        CONVERT(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE
            (REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( REPLACE(REPLACE
            (REPLACE(REPLACE(REPLACE(keywords,
            '\\u00e9','é'),'\\u4efb','任'),'\\u00f4','ô'),'\\u00f3','ó'),'\\u00fa','ú'),'\\u00e4','ô'),
            '\\u00a0',' '),'\\u2013','–'),'\\u00f6','ö'),'\\u07ed','߭'),'\\u5730','地'),'\\u5976','奶'),
            '\\u9738','霸'),'\\u5367','卧'),'\\u5e95','底'),'\\u80e9','胩'),'\\u80a5','肥'),'\\u5988','妈'),
            '\\u7206','爆'),'\\u52a1','务'),'\\u8d85','超'),'\\u7ea7','级'),'\\u00df','级')
            using utf8mb4) AS keywords
		FROM movie_dataset ;

