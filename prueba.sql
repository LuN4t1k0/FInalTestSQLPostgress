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
