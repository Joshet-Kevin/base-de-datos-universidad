--Procedimientos almacenados
-- Joshet Kevin Ccoyore Llano
-- 8/8/2022

-- PA PARA ESCUELA

USE master
go

if OBJECT_ID('spListarEscuela') is not null
	drop proc spListarEscuela
go

use BDUniversidad
go
--LISTAR ESCUELA
create proc spListarEscuela
as
begin
	select CodEscuela, Escuela, Facultad from TEscuela
end
go

exec spListarEscuela
go



if OBJECT_ID('spAgregarEscuela') is not null
	drop proc spAgregarEscuela
go

use BDUniversidad
go
--AGREGAR ESCUELA
create proc spAgregarEscuela
@CodEscuela char(3), @Escuela varchar(50),  @Facultad varchar(50)
as
begin
	-- CodEscuela no pueder ser duplicado
	if not exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
	-- Escuela no pueder ser duplicado
		if not exists(select Escuela from TEscuela where Escuela=@Escuela)
			begin
				insert into TEscuela values(@CodEscuela,@Escuela,@Facultad)
				select CodError = 0, Mensaje = 'Se inserto correctamente escuela'
			end
		else select CodError = 1, Mensaje = 'ERROR: Escuela duplicado'
	else select CodError = 1, Mensaje = 'ERROR: CodEscuela duplicado'
end
go

exec spAgregarEscuela 'E06','Enfermeria','Ciencias de la Salud'


--ACTIVIDAD: IMPLEMENTAR  ELIMINAR, ACTUALIZAR Y BUSCAR 
--PRESENTAR PARA EL DIA MIERCOLES 10 DE AGOSTO A TRAVES DE AULA VIRTUAL

--ELIMINAR ESCUELA

if OBJECT_ID('spEliminarEscuela') is not null
	drop proc spEliminarEscuela
go

use BDUniversidad
go

create proc spEliminarEscuela
@CodEscuela char(3) 
as

begin
	if not exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		begin
			select CodError = 3 , Mensaje = 'El registro no existe'
		end
	else
		begin
			delete from TEscuela where CodEscuela = @CodEscuela
			select CodError = 0, Mensaje = 'Se elimino correctamente escuela'
		end
end
go

exec spEliminarEscuela 'E06'

--Actualizar ESCUELA

if OBJECT_ID('spActualizarEscuela') is not null
	drop proc spActualizarEscuela
go

use BDUniversidad
go

create proc spActualizarEscuela
@CodEscuela char(3), @Escuela varchar(50),  @Facultad varchar(50)
as
begin
	if not exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		begin
			select CodError = 3 , Mensaje = 'El registro no existe'
		end
	else
		begin
			update TEscuela set 
				Escuela = @Escuela,
				Facultad = @Facultad where CodEscuela = @CodEscuela
			select CodError = 0, Mensaje = 'Se actualizo correctamente escuela'
		end
end
go



exec spActualizarEscuela 'E03','Enfermeria','Ciencias de la Salud'

--BUSCAR ESCUELA

if OBJECT_ID('spBuscarEscuela') is not null
	drop proc spBuscarEscuela
go

use BDUniversidad
go

create proc spBuscarEscuela
@CodEscuela char(3)
as
begin
	
	if not exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		begin
			select CodError = 3 , Mensaje = 'La escuela no existe'
		end
	else
		begin
			
			select e.CodEscuela,e.Escuela,a.CodAlumno,a.Apellidos,a.Nombres from 
			TEscuela e inner join TAlumno a on 
			e.CodEscuela = a.CodEscuela where e.CodEscuela = @CodEscuela
		end
end
go

exec spBuscarEscuela 'E01'


 

-----------------------------------------------------------------------------

if OBJECT_ID('spListarAlumno') is not null
	drop proc spListarAlumno
go

use BDUniversidad
go
--LISTAR ALUMNO
create proc spListarAlumno
as
begin
	select CodAlumno, Apellidos, Nombres, LugarNac,FechaNac,CodEscuela from TAlumno
end
go

exec spListarAlumno
go

--AGREGAR ALUMNO

if OBJECT_ID('spAgregarAlumno') is not null
	drop proc spAgregarAlumno
go

use BDUniversidad
go
--AGREGAR ALUMNO
create proc spAgregarAlumno
@CodAlumno char(3), @Apellidos varchar(50),@Nombres varchar(50)
,@LugarNac varchar(50), @FechaNac datetime, @CodEscuela char(3)

as
begin
	-- CodAlumno no pueder ser duplicado
	if not exists(select @CodAlumno from TAlumno where CodAlumno=@CodAlumno)
	-- Alumno no pueder ser duplicado
		if not exists(select CodAlumno from TAlumno where CodAlumno=@CodAlumno)
			begin
				insert into TAlumno values(
				@CodAlumno,@Apellidos,@Nombres,@LugarNac,@FechaNac,@CodEscuela)
				select CodError = 0, Mensaje = 'Se inserto correctamente escuela'
			end
		else select CodError = 1, Mensaje = 'ERROR: Alumno duplicado'
	else select CodError = 1, Mensaje = 'ERROR: CodAlumno duplicado'
end
go

exec spListarAlumno
EXEC spAgregarAlumno 'A06','Luciana','Martinez','Arequipa','2000-10-26','E04'

--ACTIVIDAD: IMPLEMENTAR  ELIMINAR, ACTUALIZAR Y BUSCAR 
--PRESENTAR PARA EL DIA MIERCOLES 10 DE AGOSTO A TRAVES DE AULA VIRTUAL

--ELIMINAR ALUMNO

if OBJECT_ID('spEliminarAlumno') is not null
	drop proc spEliminarAlumno
go

use BDUniversidad
go

create proc spEliminarAlumno
@CodAlumno char(3) 
as

begin
	if not exists(select CodAlumno from TAlumno where CodAlumno=@CodAlumno)
		begin
			select CodError = 3 , Mensaje = 'El registro no existe'
		end
	else
		begin
			delete from TAlumno where CodAlumno = @CodAlumno
			select CodError = 0, Mensaje = 'Se elimino correctamente alumno'
		end
end
go


exec spEliminarAlumno 'A06' 

--Actualizar ALUMNO

if OBJECT_ID('spActualizarAlumno') is not null
	drop proc spActualizarAlumno
go

use BDUniversidad
go

create proc spActualizarAlumno
@CodAlumno char(3), @Apellidos varchar(50),@Nombres varchar(50)
,@LugarNac varchar(50), @FechaNac datetime, @CodEscuela char(3)

as
begin
	if not exists(select CodAlumno from TAlumno where CodAlumno=@CodAlumno)
		begin
			select CodError = 3 , Mensaje = 'El registro no existe'
		end
	else
		begin
			update TAlumno set 
				Apellidos = @Apellidos,
				Nombres = @Nombres,
				LugarNac = @LugarNac,
				FechaNac = @FechaNac,
				CodEscuela = @CodEscuela where CodAlumno = @CodAlumno
			select CodError = 0, Mensaje = 'Se actualizo correctamente alumno'
		end
end
go



exec spActualizarAlumno 'A05','Montero Rodrigo','Antonio','Arquipa','1999-09-12','E04'

--BUSCAR ALUMNO

if OBJECT_ID('spBuscarAlumno') is not null
	drop proc spBuscarAlumno
go

use BDUniversidad
go

create proc spBuscarAlumno
@CodAlumno char(3)
as
begin
	
	if not exists(select CodAlumno from TAlumno where CodAlumno=@CodAlumno)
		begin
			select CodError = 3 , Mensaje = 'La escuela no existe'
		end
	else
		begin
			
			select CodAlumno,Apellidos,Nombres,LugarNac,FechaNac,CodEscuela
			from TAlumno where CodAlumno = @CodAlumno

		end
end
go

exec spListarAlumno

exec spBuscarAlumno 'A03'

