# DOCUMENTACION

## Modelo Logico

![Modelo Logico](https://github.com/cocacore7/bd1-proyecto2-201908335/blob/main/Logico.png)

## Modelo Relacional

![Modelo Relacional](https://github.com/cocacore7/bd1-proyecto2-201908335/blob/main/Relacional.png)

## Primera Forma De Normalizacion

Se utilizo la primera forma de normalizacion para las siguientes tablas del modelo entidad relacion de modo que no existieran grupos de valores repetidos. Eliminando los grupos repetidos de las tablas individuales, creando una tabla independiente para cada conjunto de datos relacionados e identificandolos con una clave principal.

![Entidad 1](https://github.com/cocacore7/bd1-proyecto2-201908335/blob/main/Primera_Forma/1F_1.PNG)

![Entidad 2](https://github.com/cocacore7/bd1-proyecto2-201908335/blob/main/Primera_Forma/1F_2.PNG)

![Entidad 3](https://github.com/cocacore7/bd1-proyecto2-201908335/blob/main/Primera_Forma/1F_3.PNG)

![Entidad 4](https://github.com/cocacore7/bd1-proyecto2-201908335/blob/main/Primera_Forma/1F_4.PNG)

![Entidad 5](https://github.com/cocacore7/bd1-proyecto2-201908335/blob/main/Primera_Forma/1F_5.PNG)

![Entidad 6](https://github.com/cocacore7/bd1-proyecto2-201908335/blob/main/Primera_Forma/1F_6.PNG)

![Entidad 7](https://github.com/cocacore7/bd1-proyecto2-201908335/blob/main/Primera_Forma/1F_7.PNG)

## Segunda Forma De Normalizacion

Se utilizo la segunda forma de normalizacion para las siguientes tablas del modelo entidad relacion de modo que no existieran dependencias funcionales parciales. Creando tablas independientes para conjuntos de valores que se apliquen a varios registros y Relacionando estas tablas con una clave externa.

![Entidad 1](https://github.com/cocacore7/bd1-proyecto2-201908335/blob/main/Segunda_Forma/2F_1.PNG)

![Entidad 2](https://github.com/cocacore7/bd1-proyecto2-201908335/blob/main/Segunda_Forma/2F_2.PNG)

![Entidad 3](https://github.com/cocacore7/bd1-proyecto2-201908335/blob/main/Segunda_Forma/2F_3.PNG)

![Entidad 4](https://github.com/cocacore7/bd1-proyecto2-201908335/blob/main/Segunda_Forma/2F_4.PNG)

## Tercera Forma De Normalizacion

Se utilizo la tercera forma de normalizacion para las siguientes tablas del modelo entidad relacion de modo que se verificara  que no existieran dependencias transitivas entre las columnas de una tabla. Se eliminaron los campos que no dependan de la clave. 

![Entidad 1](https://github.com/cocacore7/bd1-proyecto2-201908335/blob/main/Tercera_Forma/3F_1.PNG)

## Entidades

- Nombre_Eleccion
- Nom_Anio_Eleccion
- Anio_Eleccion
- Pais
- Region
- Depto
- Municipio
- Zona
- Partido
- Zona_Partido
- Sexo
- Raza
- Voto

## Listado De Atributos

- Nombre_Eleccion

| No | Nombre             | Tipo         | Primary | Forean | Unique | Not Null |
|----|--------------------|--------------|---------|--------|--------|----------|
| 1  | Id_Nombre_Eleccion | Integer      | x       |        |        | x        |
| 2  | Nombre_Eleccion    | Varchar(100) |         |        |        | x        |

- Anio_Eleccion

| No | Nombre           | Tipo    | Primary | Forean | Unique | Not Null |
|----|------------------|---------|---------|--------|--------|----------|
| 1  | Id_Anio_Eleccion | Integer | x       |        |        | x        |
| 2  | Anio_Eleccion    | Integer |         |        |        | x        |

- Nom_Anio_Eleccion

| No | Nombre             | Tipo    | Primary | Forean | Unique | Not Null |
|----|--------------------|---------|---------|--------|--------|----------|
| 1  | Id_Anio_Eleccion   | Integer |         | x      |        | x        |
| 2  | Id_Nombre_Eleccion | Integer |         | x      |        | x        |

- Pais

| No | Nombre  | Tipo         | Primary | Forean | Unique | Not Null |
|----|---------|--------------|---------|--------|--------|----------|
| 1  | Id_Pais | Integer      | x       |        |        | x        |
| 2  | Pais    | Varchar(100) |         |        |        | x        |

- Region

| No | Nombre    | Tipo         | Primary | Forean | Unique | Not Null |
|----|-----------|--------------|---------|--------|--------|----------|
| 1  | Id_Region | Integer      | x       |        |        | x        |
| 2  | Region    | Varchar(100) |         |        |        | x        |

- Depto

| No | Nombre   | Tipo         | Primary | Forean | Unique | Not Null |
|----|----------|--------------|---------|--------|--------|----------|
| 1  | Id_Depto | Integer      | x       |        |        | x        |
| 2  | Depto    | Varchar(100) |         |        |        | x        |

- Municipio

| No | Nombre       | Tipo         | Primary | Forean | Unique | Not Null |
|----|--------------|--------------|---------|--------|--------|----------|
| 1  | Id_Municipio | Integer      | x       |        |        | x        |
| 2  | Municipio    | Varchar(100) |         |        |        | x        |

- Zona

| No | Nombre             | Tipo    | Primary | Forean | Unique | Not Null |
|----|--------------------|---------|---------|--------|--------|----------|
| 1  | Id_Zona            | Integer | x       |        |        | x        |
| 2  | Id_Pais            | Integer |         | x      |        | x        |
| 3  | Id_Region          | Integer |         | x      |        | x        |
| 4  | Id_Depto           | Integer |         | x      |        | x        |
| 5  | Id_Municipio       | Integer |         | x      |        | x        |
| 6  | Id_Nombre_Eleccion | Integer |         | x      |        | x        |

- Partido

| No | Nombre         | Tipo         | Primary | Forean | Unique | Not Null |
|----|----------------|--------------|---------|--------|--------|----------|
| 1  | Id_Partido     | Integer      | x       |        |        | x        |
| 2  | Partido        | Varchar(30)  |         |        |        | x        |
| 3  | Nombre_Partido | Varchar(100) |         |        |        | x        |

- Zona_Partido

| No | Nombre          | Tipo    | Primary | Forean | Unique | Not Null |
|----|-----------------|---------|---------|--------|--------|----------|
| 1  | Id_Zona_Partido | Integer | x       |        |        | x        |
| 2  | Id_Zona         | Integer |         | x      |        | x        |
| 3  | Id_Partido      | Integer |         | x      |        | x        |

- Sexo

| No | Nombre  | Tipo         | Primary | Forean | Unique | Not Null |
|----|---------|--------------|---------|--------|--------|----------|
| 1  | Id_Sexo | Integer      | x       |        |        | x        |
| 2  | Sexo    | Varchar(100) |         |        |        | x        |

- Raza

| No | Nombre  | Tipo         | Primary | Forean | Unique | Not Null |
|----|---------|--------------|---------|--------|--------|----------|
| 1  | Id_Raza | Integer      | x       |        |        | x        |
| 2  | Raza    | Varchar(100) |         |        |        | x        |

- Voto

| No | Nombre         | Tipo    | Primary | Forean | Unique | Not Null |
|----|----------------|---------|---------|--------|--------|----------|
| 1  | Id_Voto        | Integer | x       |        |        | x        |
| 2  | Analfabetos    | Integer |         |        |        | x        |
| 3  | Alfabetos      | Integer |         |        |        | x        |
| 4  | Primaria       | Integer |         |        |        | x        |
| 5  | Nivel_Medio    | Integer |         |        |        | x        |
| 6  | Universitarios | Integer |         |        |        | x        |
| 7  | Id_Sexo        | Integer |         | x      |        | x        |
| 8  | Id_Raza        | Integer |         | x      |        | x        |
| 9  | Id_Zona        | Integer |         | x      |        | x        |
| 10 | Id_Partido     | Integer |         | x      |        | x        |

## Relaciones Entre Entidades

- Anio_Eleccion puede tener una o muchas Nom_Anio_Elecciones
- Nom_Eleccion puede tener una o muchas Nom_Anio_Elecciones
- Nom_Eleccion puede tener una o muchas Zonas
- Pais puede pertenecer a una o muchas Zonas
- Region puede pertenecer a una o muchas Zonas
- Depto puede pertenecer a una o muchas Zonas
- Municipio puede pertenecer a una o muchas Zonas
- Zona puede pertenecer a una o muchas Zona_Partidos
- Zona puede tener uno o muchos Votos
- Sexo Puede pertenecer a uno o muchos Votos
- Raza puede pertenecer a uno o muchos Votos
- Partido puede pertenecer a uno o muchos Votos
- Partido puede pertenecer a uno o muchos Zona_Partidos

## Restricciones Para Utilizar

- Sin Restricciones

## Consideracion De Diseño

- Se decidio Relacionar como Zona a las tablas pais, region, depto y municipio ya que asi se establecia en el enunciado del proyecto y las elecciones pueden variar, ya sea para presidente, municipales, regionales, etc.
- Se decidio registrar como voto todos los votos en cada distinta zona y partido registrado almacenando los datos numericos de educacion media, estudiantes, etc.
- Se decidio separar Anio De Seleccion con el Nombre de Seleccion para permitir llevar un registro, ya que en el enunciado se solicita la posibilidad de poder comparar estos registros de distintos años.
