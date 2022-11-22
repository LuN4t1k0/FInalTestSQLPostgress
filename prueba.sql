--Author Cristian Venegas
--subjet Prueba Final Modulo SQL Desafio Latam G21

--  Creacion base datos
CREATE DATABASE prueba_final_cristian_venegas_674 -- 1. Crea el modelo (revisa bien cuál es el tipo de relación antes de crearlo), respeta las claves primarias, foráneas y tipos de datos.

--1. Tabla Peliculas
CREATE TABLE Peliculas (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(255),
  anno INTEGER
);

-- Tabla Tags
CREATE TABLE tags (id SERIAL PRIMARY KEY, tag VARCHAR(32));

--Tabla Intermedia necesaria porque la relacion entre la tabla Peliculas y TAGS es N:N
CREATE TABLE pelicula_tags (
  pelicula_id BIGINT,
  tag_id BIGINT,
  FOREIGN KEY (pelicula_id) REFERENCES peliculas (id),
  FOREIGN KEY (tag_id) REFERENCES tags (id)
);

--2. Inserta 5 películas y 5 tags, la primera película tiene que tener 3 tags asociados, la segunda película debe tener dos tags asociados. (1 punto)

--Peliculas
INSERT INTO peliculas (nombre, anno) VALUES('Harry Potter : El Pricipe Mestizo', 2009);
INSERT INTO peliculas (nombre, anno) VALUES('The Martian', 2015);
INSERT INTO peliculas (nombre, anno) VALUES('Iron Man', 2008);
INSERT INTO peliculas (nombre, anno) VALUES('Matrix', 1999);
INSERT INTO peliculas (nombre, anno) VALUES('Star Wars: episodio IV - una nueva esperanza', 1977);

--Tags
INSERT INTO tags (tag) VALUES ('Aventuras');
INSERT INTO tags (tag) VALUES ('Ciencia Ficción');
INSERT INTO tags (tag) VALUES ('Terror');
INSERT INTO tags (tag) VALUES ('Fantasía');
INSERT INTO tags (tag) VALUES ('Drama');

--Tabla Intemedia Peliculas_tags
INSER INTO pelicula_tags (pelicula_id, tag_id) VALUES (1,1);
INSER INTO pelicula_tags (pelicula_id, tag_id) VALUES (1,2);
INSER INTO pelicula_tags (pelicula_id, tag_id) VALUES (1,4);
INSER INTO pelicula_tags (pelicula_id, tag_id) VALUES (2,1);
INSER INTO pelicula_tags (pelicula_id, tag_id) VALUES (2,2);

--3. Cuenta la cantidad de tags que tiene cada película. Si una película no tiene tags debe
select
  peliculas.nombre,
  count(pelicula_tags.tag_id)
From
  peliculas
  LEFT JOIN pelicula_tags on peliculas.id = pelicula_tags.pelicula_id
GROUP by
  peliculas.nombre;


--Modelo 2 : Preguntas-Respuesta-Usuarios
--4. Crea las tablas respetando los nombres, tipos, claves primarias y foráneas y tipos de datos.
-- Tabla Preguntas
CREATE TABLE preguntas (
  id SERIAL PRIMARY KEY,
  pregunta VARCHAR(255),
  respuesta_correcta VARCHAR
);


--Tabla Usuarios
CREATE TABLE usuarios(
  id SERIAL PRIMARY key,
  nombre VARCHAR(255),
  edad INTEGER
);

--Tabla Respuestas
CREATE TABLE respuestas (
  id SERIAL PRIMARY KEY,
  respuesta VARCHAR(255),
  usuario_id BIGINT,
  pregunta_id BIGINT,
  FOREIGN KEy (usuario_id) REFERENCES usuarios (id),
  FOREIGN KEy (pregunta_id) REFERENCES preguntas (id)
);


-- 5. Agrega datos, 5 usuarios y 5 preguntas, la primera pregunta debe estar contestada dos veces correctamente por distintos usuarios, la pregunta 2 debe estar contestada correctamente sólo por un usuario, y las otras 2 respuestas deben estar incorrectas 
-- Contestada correctamente significa que la respuesta indicada en la tabla respuestas es exactamente igual al texto indicado en la tabla de preguntas

--ploblamiento tabla Usuarios
INSERT INTO usuarios (nombre, edad) VALUES ('Fernando',29);
INSERT INTO usuarios (nombre, edad) VALUES ('Dirk',33);
INSERT INTO usuarios (nombre, edad) VALUES ('Consuelo',30);
INSERT INTO usuarios (nombre, edad) VALUES ('Daniel',25);
INSERT INTO usuarios (nombre, edad) VALUES ('Enzo',33);

--ploblamiento tabla Preguntas
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('Qué estuvo haciendo Capitana Marvel durante todo este tiempo', 'Pacificando en el espacio' );
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('Loki está vivo', 'Esta vivo pero atrapado en una TVA de otro universo' );
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('Cómo encontró Capitana Marvel a Tony Stark y Nebula', 'Por covencion siempre se debe acudir a un llamado de alarta en el espacio' );
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('Qué pasó con Gamora', 'Gamora murio en el sacrificio de obtener la gema del alma, pero su version de 2014 esta viva en nuestra linea de tiempo actual' );
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('¿Qué pasó con el Mjolnir, el Thor del pasado se quedó sin martillo?', 'Odin lo llevo a la estrella de los enanos donde obtubo una version disferente del storm Braker ' );

--ploblamiento tabla respuestas
INSERT INTO respuestas (respuesta, usuario_id, pregunta_id ) VALUES('Pacificando en el espacio',3,1);
INSERT INTO respuestas (respuesta, usuario_id, pregunta_id ) VALUES('Pacificando en el espacio',4,1);
INSERT INTO respuestas (respuesta, usuario_id, pregunta_id ) VALUES('Esta vivo pero atrapado en una TVA de otro universo',1,2);
INSERT INTO respuestas (respuesta, usuario_id, pregunta_id ) VALUES('Esta muerto',2,2);
INSERT INTO respuestas (respuesta, usuario_id, pregunta_id ) VALUES('Lo mataron porque termino su contrato',5,2);

--6. Cuenta la cantidad de respuestas correctas totales por usuario (independiente de la pregunta)
select
  usuarios.nombre,
  count(preguntas.respuesta_correcta) as Respuestas_correctas
from
  preguntas
  RIGHT JOIN respuestas on respuestas.respuesta = preguntas.respuesta_correcta
  JOIN usuarios on usuarios.id = respuestas.usuario_id
GROUP by
  usuario_id,
  usuarios.nombre;

-- 7.Por cada pregunta, en la tabla preguntas, cuenta cuántos usuarios tuvieron la respuesta correcta.
select
  preguntas.pregunta,
  COUNT(respuestas.usuario_id) as Respuesta_correctas
from
  respuestas
  RIGHT JOIN preguntas on respuestas.pregunta_id = preguntas.id
group BY
  preguntas.pregunta;


--8. Implementa borrado en cascada de las respuestas al borrar un usuario y borrar el primer usuario para probar la implementación.

--8.1 Implementacion 
ALTER TABLE respuestas DROP CONSTRAINT respuestas_usuario_id_fkey, ADD FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE;

--8.2 Eliminacion Usuario 
DELETE FROM usuarios WHERE id = 1;

--9. Crea una restricción que impida insertar usuarios menores de 18 años en la base de datos.
ALTER TABLE usuarios ADD CHECK (edad > 18); 

--10. Altera la tabla existente de usuarios agregando el campo email con la restricción de único.
ALTER TABLE usuarios ADD email VARCHAR(50) UNIQUE;