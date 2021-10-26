use proyecto2;


INSERT INTO NOMBRE_ELECCION (Nombre_Eleccion)
    select distinct 
    TEMPORAL.NOMBRE_ELECCION 
    from TEMPORAL;
    
INSERT INTO ANIO_ELECCION (Anio_Eleccion)
    select distinct 
    TEMPORAL.ANIO_ELECCION 
    from TEMPORAL;
    
INSERT INTO NOM_ANIO_ELECCION (Id_Nombre_Eleccion, Id_Anio_Eleccion)
    select distinct
    ne.Id_Nombre_Eleccion,
    ae.Id_Anio_Eleccion 
    from temporal t
    inner join NOMBRE_ELECCION ne on ne.Nombre_Eleccion = t.NOMBRE_ELECCION
    inner join ANIO_ELECCION ae on ae.Anio_Eleccion = t.ANIO_ELECCION;

INSERT INTO PAIS (Pais)
    select distinct 
    TEMPORAL.PAIS 
    from TEMPORAL;
    
INSERT INTO REGION (Region)
    select distinct 
    TEMPORAL.REGION 
    from TEMPORAL;

INSERT INTO DEPTO (Depto)
    select distinct 
    TEMPORAL.DEPTO 
    from TEMPORAL;
    
INSERT INTO MUNICIPIO (Municipio)
    select distinct 
    TEMPORAL.MUNICIPIO 
    from TEMPORAL;
    
INSERT INTO ZONA (Id_Pais, Id_Region, Id_Depto, Id_Municipio, Id_Nombre_Eleccion)
    select distinct
    p.Id_Pais,
    r.Id_Region,
    d.Id_Depto,
    m.Id_Municipio,
    ne.Id_Nombre_Eleccion
    from temporal t
    inner join PAIS p on p.Pais = t.PAIS
    inner join REGION r on r.Region = t.REGION
    inner join DEPTO d on d.Depto = t.DEPTO
    inner join MUNICIPIO m on m.Municipio = t.MUNICIPIO
    inner join NOMBRE_ELECCION ne on ne.Nombre_Eleccion = t.NOMBRE_ELECCION;

INSERT INTO PARTIDO (Partido, Nombre_Partido)
    select distinct 
    TEMPORAL.PARTIDO,
    TEMPORAL.NOMBRE_PARTIDO
    from TEMPORAL
    order by TEMPORAL.PARTIDO;
    
INSERT INTO ZONA_PARTIDO (Id_Zona, Id_Partido)
    select distinct
    z.Id_Zona,
    pa.Id_Partido
    from temporal t
    inner join PAIS p on p.Pais = t.PAIS
    inner join REGION r on r.Region = t.REGION
    inner join DEPTO d on d.Depto = t.DEPTO
    inner join MUNICIPIO m on m.Municipio = t.MUNICIPIO
    inner join PARTIDO pa on pa.Partido = t.PARTIDO
    inner join ZONA z on z.Id_Pais = p.Id_Pais and z.Id_Region = r.Id_Region and z.Id_Depto = d.Id_Depto and z.Id_Municipio = m.Id_Municipio;

INSERT INTO SEXO (Sexo)
    select distinct 
    TEMPORAL.SEXO 
    from TEMPORAL;

INSERT INTO RAZA (Raza)
    select distinct 
    TEMPORAL.RAZA 
    from TEMPORAL;
    
INSERT INTO VOTO (Analfabeto, Alfabeto, Primaria, Nivel_Medio, Universitario, Id_Sexo, Id_Raza, Id_Zona, Id_Partido)
    select distinct
    cast(t.ANALFABETOS as UNSIGNED),
    cast(t.ALFABETOS as UNSIGNED),
    cast(t.PRIMARIA as UNSIGNED),
    cast(t.NIVEL_MEDIO as UNSIGNED),
    cast(t.UNIVERSITARIOS as UNSIGNED),
    s.Id_Sexo,
    ra.Id_Raza,
    z.Id_Zona,
    pa.Id_Partido
    from temporal t
    inner join PAIS p on p.Pais = t.PAIS
    inner join REGION r on r.Region = t.REGION
    inner join DEPTO d on d.Depto = t.DEPTO
    inner join MUNICIPIO m on m.Municipio = t.MUNICIPIO
    inner join PARTIDO pa on pa.Partido = t.PARTIDO
    inner join SEXO s on s.Sexo = t.SEXO
    inner join RAZA ra on ra.Raza = t.RAZA
    inner join ZONA z on z.Id_Pais = p.Id_Pais and z.Id_Region = r.Id_Region and z.Id_Depto = d.Id_Depto and z.Id_Municipio = m.Id_Municipio;
