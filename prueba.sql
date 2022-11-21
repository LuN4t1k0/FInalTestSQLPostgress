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
Insert into peliculas (nombre, anno) VALUES('Harry Potter : El Pricipe Mestizo', 2009);
Insert into peliculas (nombre, anno) VALUES('The Martian', 2015);
Insert into peliculas (nombre, anno) VALUES('Iron Man', 2008);
Insert into peliculas (nombre, anno) VALUES('Matrix', 1999);
Insert into peliculas (nombre, anno) VALUES('Star Wars: episodio IV - una nueva esperanza', 1977);