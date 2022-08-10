-- BD EJEMPLO
-- CCOYORE LLANO JOSHET KEVIN
--  8/8/2022

use master
go

if DB_ID('BDUniversidad') is not null
	drop database BDUniversidad
go

create database BDUniversidad
go

use BDUNIVERSIDAD
go


-- CREAR TABLAS

if DB_ID('TEscuela') is not null
	drop database TEscuela
go

create table TEscuela
(
	CodEscuela char(3) primary key,
	Escuela varchar(50),
	Facultad varchar(50)
)
go

if DB_ID('TAlumno') is not null
	drop database TAlumno
go

create table TAlumno
(
	CodAlumno char(5) primary key,
	Apellidos varchar(50),
	Nombres varchar(50),
	LugarNac varchar(50),
	FechaNac datetime,
	CodEscuela char(3),
	foreign key (CodEscuela) references TEscuela
)
-- Insercion de datos Escuela

insert into TEscuela values ('E01','Sistemas','Ingenieria')
insert into TEscuela values ('E02','Civil','Ingenieria')
insert into TEscuela values ('E03','Industrial','Ingenieria')
insert into TEscuela values ('E04','Ambiental','Ingenieria')
insert into TEscuela values ('E05','Arquitectura','Ingenieria')
go

select * from TEscuela
go


-- Insercion de datos Alumno

insert into TAlumno values ('A01','Ccoyore Llano','Joshet Kevin','Cusco','2001-08-24','E01')
insert into TAlumno values ('A02','Cadenillas Naccha','Fernando','Cusco','2001-06-24','E01')
insert into TAlumno values ('A03','Peña Tejada','Pabel','Cusco','2001-02-26','E02')
insert into TAlumno values ('A04','Yabar Duran','Feren','Cusco','2002-02-13','E03')
insert into TAlumno values ('A05','Montero Rodrigo','Antonio','Cusco','2001-10-26','E04')

select * from TAlumno
go