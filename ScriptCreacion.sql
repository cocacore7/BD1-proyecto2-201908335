create database proyecto2;
use proyecto2;

CREATE TABLE NOMBRE_ELECCION(
	Id_Nombre_Eleccion INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
	Nombre_Eleccion VARCHAR(100) NOT NULL
);

CREATE TABLE ANIO_ELECCION(
	Id_Anio_Eleccion INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
	Anio_Eleccion VARCHAR(100) NOT NULL
);

CREATE TABLE NOM_ANIO_ELECCION(
	Id_Nom_Anio_Eleccion INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
	Id_Nombre_Eleccion INTEGER NOT NULL,
	Id_Anio_Eleccion INTEGER NOT NULL,
	foreign key (Id_Nombre_Eleccion) references NOMBRE_ELECCION(Id_Nombre_Eleccion) on update cascade on delete cascade,
	foreign key (Id_Anio_Eleccion) references ANIO_ELECCION(Id_Anio_Eleccion) on update cascade on delete cascade
);

CREATE TABLE PAIS(
	Id_Pais INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
	Pais VARCHAR(100) NOT NULL
);

CREATE TABLE REGION(
	Id_Region INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
	Region VARCHAR(100) NOT NULL
);

CREATE TABLE DEPTO(
	Id_Depto INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
	Depto VARCHAR(100) NOT NULL
);

CREATE TABLE MUNICIPIO(
	Id_Municipio INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
	Municipio VARCHAR(100) NOT NULL
);

CREATE TABLE ZONA(
	Id_Zona INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
	Id_Pais INTEGER NOT NULL,
	Id_Region INTEGER NOT NULL,
	Id_Depto INTEGER NOT NULL,
	Id_Municipio INTEGER NOT NULL,
	Id_Nombre_Eleccion INTEGER NOT NULL,
	foreign key (Id_Pais) references PAIS(Id_Pais) on update cascade on delete cascade,
	foreign key (Id_Region) references REGION(Id_Region) on update cascade on delete cascade,
	foreign key (Id_Depto) references DEPTO(Id_Depto) on update cascade on delete cascade,
	foreign key (Id_Municipio) references MUNICIPIO(Id_Municipio) on update cascade on delete cascade,
	foreign key (Id_Nombre_Eleccion) references NOMBRE_ELECCION(Id_Nombre_Eleccion) on update cascade on delete cascade
);

CREATE TABLE PARTIDO(
	Id_Partido INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
	Partido VARCHAR(30) NOT NULL,
	Nombre_Partido VARCHAR(100) NOT NULL
);

CREATE TABLE ZONA_PARTIDO(
	Id_Zona_Partido INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
	Id_Zona INTEGER NOT NULL,
	Id_Partido INTEGER NOT NULL,
	foreign key (Id_Zona) references ZONA(Id_Zona) on update cascade on delete cascade,
	foreign key (Id_Partido) references PARTIDO(Id_Partido) on update cascade on delete cascade
);

CREATE TABLE SEXO(
	Id_Sexo INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
	Sexo VARCHAR(100) NOT NULL
);

CREATE TABLE RAZA(
	Id_Raza INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
	Raza VARCHAR(100) NOT NULL
);

CREATE TABLE VOTO(
	Id_Voto INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
	Analfabeto INTEGER NOT NULL,
	Alfabeto INTEGER NOT NULL,
	Primaria INTEGER NOT NULL,
	Nivel_Medio INTEGER NOT NULL,
	Universitario INTEGER NOT NULL,
	Id_Sexo INTEGER NOT NULL,
	Id_Raza INTEGER NOT NULL,
	Id_Zona INTEGER NOT NULL,
	Id_Partido INTEGER NOT NULL,
	foreign key (Id_Sexo) references SEXO(Id_Sexo) on update cascade on delete cascade,
	foreign key (Id_Raza) references RAZA(Id_Raza) on update cascade on delete cascade,
	foreign key (Id_Zona) references ZONA(Id_Zona) on update cascade on delete cascade,
	foreign key (Id_Partido) references PARTIDO(Id_Partido) on update cascade on delete cascade
);





DROP TABLE VOTO;
DROP TABLE ZONA_PARTIDO;

DROP TABLE ZONA;
DROP TABLE NOM_ANIO_ELECCION;

DROP TABLE NOMBRE_ELECCION;
DROP TABLE ANIO_ELECCION;
DROP TABLE PAIS;
DROP TABLE REGION;
DROP TABLE DEPTO;
DROP TABLE MUNICIPIO;
DROP TABLE PARTIDO;
DROP TABLE SEXO;
DROP TABLE RAZA;




DROP DATABASE proyecto2;