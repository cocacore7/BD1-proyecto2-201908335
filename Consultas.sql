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
	left join 	(select p.id_pais as id_Pais, p.pais as Pais, d.id_depto as id_Departamento, d.depto as Departamento, m.id_municipio as Id_Municipio, pa.id_partido as Id_Partido, sum(v.alfabeto + v.analfabeto) as Total_Votos 
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
