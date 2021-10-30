use proyecto2;

-- Consulta 1 --
select 
	ne.Nombre_Eleccion as Eleccion, 
	ae.anio_eleccion as Año_De_Eleccion , 
	p.pais as Pais, pa.Nombre_Partido as Partido, 
	(t1.Votos_Por_Pais_Partido * 100 / t2.Votos_Por_Pais) as Porcentaje 
from pais p 
	inner join Zona z on z.id_pais = p.id_pais
	left join voto v on v.Id_Zona = z.id_zona
	inner join partido pa on pa.id_partido = v.id_partido
	left join zona_partido zp on zp.id_zona = z.id_zona and pa.id_partido = zp.id_partido
	left join nombre_eleccion ne on ne.Id_Nombre_Eleccion = z.Id_Nombre_Eleccion
	inner join NOM_ANIO_ELECCION nae on nae.Id_Nombre_Eleccion = ne.Id_Nombre_Eleccion
	inner join anio_eleccion ae on ae.id_anio_eleccion = nae.id_anio_eleccion
	left join 	(select p.pais as Pais, sum(v.alfabeto + v.analfabeto) as Votos_Por_Pais_Partido from pais p 
				inner join Zona z on z.id_pais = p.id_pais
				left join voto v on v.Id_Zona = z.id_zona
				inner join partido pa on pa.id_partido = v.id_partido
				left join zona_partido zp on zp.id_zona = z.id_zona and pa.id_partido = zp.id_partido
				group by p.pais, pa.Nombre_Partido
				order by Votos_Por_Pais_Partido desc) t1 on t1.pais = p.pais
	left join 	(select p.pais as Pais, sum(v.alfabeto + v.analfabeto) as Votos_Por_Pais from pais p
				inner join Zona z on z.id_pais = p.id_pais
				left join voto v on v.Id_Zona = z.id_zona
				group by p.pais
				order by Votos_Por_Pais desc) t2 on t2.pais = p.pais
group by p.pais
order by porcentaje desc;

-- Consulta 2 --
select 
	p.pais as Pais, 
    d.depto as Departamento, 
    sum(v.alfabeto + v.analfabeto) as Total_Votos, 
    (sum(v.alfabeto + v.analfabeto) * 100 / t1.Votos_Pais) as Porcentaje  
from pais p
	inner join Zona z on z.id_pais = p.id_pais
	left join depto d on d.id_depto = z.id_depto
	left join voto v on v.Id_Zona = z.id_zona
	left join sexo s on s.id_sexo = v.id_sexo
	left join	(select p.pais, sum(v.alfabeto + v.analfabeto) as Votos_Pais from pais p
				inner join Zona z on z.id_pais = p.id_pais
				left join voto v on v.Id_Zona = z.id_zona
				left join sexo s on s.id_sexo = v.id_sexo
				where s.sexo = 'mujeres'
				group by p.pais
				order by p.pais, Votos_Pais desc) t1 
                on t1.pais = p.pais
where s.sexo = 'mujeres'
group by p.pais, d.depto
order by p.pais, d.depto, Total_Votos desc;

-- Consulta 3 (No Salio :c) --
select distinct
	p.id_pais as Numero_Pais, 
	p.pais as Pais, 
    pa.Nombre_Partido as Partido, 
	count(t1.id_partido) as Alcaldias 
from pais p 
	inner join Zona z on z.id_pais = p.id_pais
	left join voto v on v.Id_Zona = z.id_zona
	inner join partido pa on pa.id_partido = v.id_partido
	left join zona_partido zp on zp.id_zona = z.id_zona and pa.id_partido = zp.id_partido
	left join depto d on d.id_depto = z.id_depto
	left join municipio m on m.id_municipio = z.id_municipio
	left join 	(select distinct p.id_pais as id_Pais, p.pais as Pais, d.id_depto as id_Departamento, d.depto as Departamento, m.id_municipio as Id_Municipio, pa.id_partido as Id_Partido, sum(v.alfabeto + v.analfabeto) as Total_Votos 
				from pais p
				inner join Zona z on z.id_pais = p.id_pais
				left join voto v on v.Id_Zona = z.id_zona
                left join depto d on d.id_depto = z.id_depto
				left join municipio m on m.id_municipio = z.id_municipio
                inner join partido pa on pa.id_partido = v.id_partido
				left join zona_partido zp on zp.id_zona = z.id_zona and pa.id_partido = zp.id_partido
				group by p.pais, d.depto, m.municipio, pa.partido
				order by Id_Partido, id_Pais, id_Departamento, Id_Municipio) t1 on t1.pais = p.pais
group by t1.id_pais, t1.id_partido
order by t1.Total_Votos desc;

-- Consulta 4 --
select
	t1.pais as Pais, 
    t1.Region as Region, 
	t1.Votos_Indigenas as Votos_Indigenas 
	from (select p.pais as Pais, r.region as Region, sum(v.alfabeto + v.analfabeto) as Votos_Indigenas
		from pais p
		inner join Zona z on z.id_pais = p.id_pais
        left join region r on r.id_region = z.id_region
        left join depto d on d.id_depto = z.id_depto
		left join municipio m on m.id_municipio = z.id_municipio
		left join voto v on v.Id_Zona = z.id_zona
		left join raza ra on ra.id_raza = v.id_raza
        inner join partido pa on pa.id_partido = v.id_partido
		left join zona_partido zp on zp.id_zona = z.id_zona and pa.id_partido = zp.id_partido
        where ra.raza = 'INDIGENAS'
		group by p.pais, r.region
		order by p.pais, r.region) t1
	left join (select p.pais as Pais, sum(v.alfabeto + v.analfabeto) as Votos_Garifunas
		from pais p
		inner join Zona z on z.id_pais = p.id_pais
        left join region r on r.id_region = z.id_region
        left join depto d on d.id_depto = z.id_depto
		left join municipio m on m.id_municipio = z.id_municipio
		left join voto v on v.Id_Zona = z.id_zona
		left join raza ra on ra.id_raza = v.id_raza
        inner join partido pa on pa.id_partido = v.id_partido
		left join zona_partido zp on zp.id_zona = z.id_zona and pa.id_partido = zp.id_partido
        where ra.raza = 'GARIFUNAS'
		group by p.pais, r.region
		order by p.pais, r.region) t2 on t2.pais = t1.pais
	left join (select p.pais as Pais, sum(v.alfabeto + v.analfabeto) as Votos_Ladinos
		from pais p
		inner join Zona z on z.id_pais = p.id_pais
        left join region r on r.id_region = z.id_region
        left join depto d on d.id_depto = z.id_depto
		left join municipio m on m.id_municipio = z.id_municipio
		left join voto v on v.Id_Zona = z.id_zona
		left join raza ra on ra.id_raza = v.id_raza
        inner join partido pa on pa.id_partido = v.id_partido
		left join zona_partido zp on zp.id_zona = z.id_zona and pa.id_partido = zp.id_partido
        where ra.raza = 'LADINOS'
		group by p.pais, r.region
		order by p.pais, r.region) t3 on t3.pais = t1.pais
where t1.Votos_Indigenas > t2.Votos_Garifunas and t1.Votos_Indigenas > t3.Votos_Ladinos
group by t1.pais, t1.region
order by t1.pais, t1.region;

-- Consulta 5 --
select
	t1.pais as Pais, 
    t1.Region as Region,
    t1.Departamento as Departamento,
    t1.Municipio as Municipio,
	t1.Votos_Universitarios as Votos_Universitarios 
	from (select p.pais as Pais, d.depto as Departamento, r.region as Region, m.municipio as Municipio, 
		sum(v.Universitario) as Votos_Universitarios, 
        (sum(v.Universitario) * 100 / sum(v.Primaria + v.Nivel_Medio + v.Universitario)) as porcentaje_Universitario
		from pais p
		inner join Zona z on z.id_pais = p.id_pais
        left join region r on r.id_region = z.id_region
        left join depto d on d.id_depto = z.id_depto
		left join municipio m on m.id_municipio = z.id_municipio
		left join voto v on v.Id_Zona = z.id_zona
		group by p.pais, r.region, d.depto, m.municipio
		order by p.pais, r.region, d.depto, m.municipio) t1
	left join (select p.pais as Pais, (sum(v.Primaria) * 100 / sum(v.Primaria + v.Nivel_Medio + v.Universitario)) as porcentaje_Primaria
		from pais p
		inner join Zona z on z.id_pais = p.id_pais
        left join region r on r.id_region = z.id_region
        left join depto d on d.id_depto = z.id_depto
		left join municipio m on m.id_municipio = z.id_municipio
		left join voto v on v.Id_Zona = z.id_zona
		group by p.pais, r.region, d.depto, m.municipio
		order by p.pais, r.region, d.depto, m.municipio) t2 on t2.pais = t1.pais
	left join (select p.pais as Pais, (sum(v.Nivel_Medio) * 100 / sum(v.Primaria + v.Nivel_Medio + v.Universitario)) as porcentaje_Nivel_Medio
		from pais p
		inner join Zona z on z.id_pais = p.id_pais
        left join region r on r.id_region = z.id_region
        left join depto d on d.id_depto = z.id_depto
		left join municipio m on m.id_municipio = z.id_municipio
		left join voto v on v.Id_Zona = z.id_zona
		group by p.pais, r.region, d.depto, m.municipio
		order by p.pais, r.region, d.depto, m.municipio) t3 on t3.pais = t1.pais
where 	t1.porcentaje_Universitario > t2.porcentaje_Primaria 
and 	t1.porcentaje_Universitario > t3.porcentaje_Nivel_Medio
group by t1.pais, t1.region, t1.Departamento, t1.Municipio
order by Votos_Universitarios desc;

-- Consulta 6 --
select
	t1.Departamento as Departamento,
	t1.Votos_Mujeres_Universitarias * 100 / t3.Total_Votos as Porcentaje_Mujeres,
	t2.Votos_Hombres_Universitarios * 100 / t3.Total_Votos as Porcentaje_Hombres
	from 		(select d.depto as Departamento, sum(v.Universitario) as Votos_Mujeres_Universitarias
		from depto d
		inner join Zona z on z.id_pais = d.id_Depto
		left join voto v on v.Id_Zona = z.id_zona
		left join sexo s on s.id_sexo = v.id_sexo
        inner join partido pa on pa.id_partido = v.id_partido
		left join zona_partido zp on zp.id_zona = z.id_zona and pa.id_partido = zp.id_partido
        where s.sexo = 'mujeres' group by d.depto order by d.depto) t1
	left join 	(select d.depto as Departamento, sum(v.Universitario) as Votos_Hombres_Universitarios
		from depto d
		inner join Zona z on z.id_pais = d.id_Depto
		left join voto v on v.Id_Zona = z.id_zona
		left join sexo s on s.id_sexo = v.id_sexo
        inner join partido pa on pa.id_partido = v.id_partido
		left join zona_partido zp on zp.id_zona = z.id_zona and pa.id_partido = zp.id_partido
        where s.sexo = 'hombres' group by d.depto order by d.depto) t2 on t2.Departamento = t1.Departamento
	left join 	(select d.depto as Departamento, sum(v.Primaria + v.Nivel_Medio + v.Universitario) as Total_Votos
		from depto d
		inner join Zona z on z.id_pais = d.id_Depto
		left join voto v on v.Id_Zona = z.id_zona
        inner join partido pa on pa.id_partido = v.id_partido
		left join zona_partido zp on zp.id_zona = z.id_zona and pa.id_partido = zp.id_partido
		group by d.depto order by d.depto) t3 on t3.Departamento = t1.Departamento
where (t1.Votos_Mujeres_Universitarias * 100 / t3.Total_Votos) > (t2.Votos_Hombres_Universitarios * 100 / t3.Total_Votos)
group by t1.Departamento
order by t1.Departamento;

-- Consulta 7 --
select
	t1.pais as Pais, 
    t1.Region as Region,
	t1.Total_Votos_Region / t2.Cantidad_Departamentos as Votos_Universitarios 
	from (select p.pais as Pais, r.region as Region, sum(v.alfabeto + v.analfabeto) as Total_Votos_Region
		from pais p
		inner join Zona z on z.id_pais = p.id_pais
        left join region r on r.id_region = z.id_region
		left join voto v on v.Id_Zona = z.id_zona
		group by p.pais, r.region order by p.pais, r.region) t1
	left join (select p.pais as Pais, r.region as Region, d.depto as Departamento, count(distinct d.depto) as Cantidad_Departamentos
		from pais p
		inner join Zona z on z.id_pais = p.id_pais
        left join region r on r.id_region = z.id_region
        left join depto d on d.id_depto = z.id_depto
		left join voto v on v.Id_Zona = z.id_zona
		group by p.pais, r.region order by p.pais, r.region) t2 on t2.pais = t1.pais and t2.region = t1.region
group by t1.pais, t1.region
order by t1.pais, t1.region;

-- Consulta 8 --
select 
	p.pais as Pais,
    sum(v.Primaria) as Total_Primaria,
    sum(v.Nivel_Medio) as Total_Nivel_Medio,
    sum(v.Universitario) as Total_Universitarios 
from pais p
	inner join Zona z on z.id_pais = p.id_pais
	left join depto d on d.id_depto = z.id_depto
	left join voto v on v.Id_Zona = z.id_zona
	left join sexo s on s.id_sexo = v.id_sexo
    left join raza r on r.id_raza = v.id_raza
group by p.pais;

-- Consulta 9 --
select 
	p.pais as Pais,
    r.raza as Raza,
    (sum(v.alfabeto + v.analfabeto) * 100 / t1.Votos_Pais) as Porcentaje  
from pais p
	inner join Zona z on z.id_pais = p.id_pais
	left join depto d on d.id_depto = z.id_depto
	left join voto v on v.Id_Zona = z.id_zona
	left join sexo s on s.id_sexo = v.id_sexo
    left join raza r on r.id_raza = v.id_raza
	left join	(select p.pais, sum(v.alfabeto + v.analfabeto) as Votos_Pais from pais p
				inner join Zona z on z.id_pais = p.id_pais
				left join voto v on v.Id_Zona = z.id_zona
				group by p.pais
				order by p.pais, Votos_Pais desc) t1 
                on t1.pais = p.pais
group by p.pais, r.raza
order by p.pais, d.depto desc;

-- Consulta 11 --
select 
	p.pais as Pais,  
    sum(v.alfabeto) as Total_Votos_Mujeres_Inidigenas, 
    (sum(v.alfabeto) * 100 / t1.Votos_Pais) as Porcentaje_Votos_Mujeres_Inidigenas  
from pais p
	inner join Zona z on z.id_pais = p.id_pais
	left join depto d on d.id_depto = z.id_depto
	left join voto v on v.Id_Zona = z.id_zona
	left join sexo s on s.id_sexo = v.id_sexo
    left join raza r on r.id_raza = v.id_raza
	left join	(select p.pais, sum(v.alfabeto + v.analfabeto) as Votos_Pais from pais p
				inner join Zona z on z.id_pais = p.id_pais
				left join voto v on v.Id_Zona = z.id_zona
				group by p.pais
				order by p.pais, Votos_Pais desc) t1 
                on t1.pais = p.pais
where s.sexo = 'mujeres' and raza = 'INDIGENAS'
group by p.pais
order by p.pais, d.depto, Total_Votos_Mujeres_Inidigenas desc;

-- Consulta 12 --
select 
	p.pais as Pais,
    (sum(v.Analfabeto) * 100 / t1.Votos_Pais) as Porcentaje_Analfabetas 
from pais p
	inner join Zona z on z.id_pais = p.id_pais
	left join depto d on d.id_depto = z.id_depto
	left join voto v on v.Id_Zona = z.id_zona
	left join sexo s on s.id_sexo = v.id_sexo
    left join raza r on r.id_raza = v.id_raza
	left join	(select p.pais, sum(v.alfabeto + v.analfabeto) as Votos_Pais from pais p
				inner join Zona z on z.id_pais = p.id_pais
				left join voto v on v.Id_Zona = z.id_zona
				group by p.pais
				order by p.pais, Votos_Pais desc) t1 
                on t1.pais = p.pais
group by p.pais
order by Porcentaje_Analfabetas desc
limit 1;

-- Consulta 13 --
select 
	p.pais as Pais,
    d.depto as Departamento,
    sum(v.alfabeto + v.analfabeto) as Votos_Por_Departamento
from pais p
	inner join Zona z on z.id_pais = p.id_pais
	left join depto d on d.id_depto = z.id_depto
	left join voto v on v.Id_Zona = z.id_zona
group by p.pais, d.depto
having p.pais = 'Guatemala' and sum(v.alfabeto + v.analfabeto) > 
	(select sum(v.alfabeto + v.analfabeto)
	from pais p
	inner join Zona z on z.id_pais = p.id_pais
	left join depto d on d.id_depto = z.id_depto
	left join voto v on v.Id_Zona = z.id_zona
	where d.depto = 'Guatemala' and p.pais = 'Guatemala')
order by d.depto desc;
