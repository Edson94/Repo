----Edson Rafael Carrillo Carrasco
----Script Angel Guardian
----12/03/2021
if exists(select * from sys.all_objects where name = 'Negocio' and type='U')
begin 
	drop table Negocio
end 
go
create table Negocio(
	IdNegocio int identity(1,1) PRIMARY KEY,
	IdImagen int not null,
	Nombre nvarchar(100) not null,
	RazonSocial text not null,
	PuntuacionPromedio int not null,
	Fecha datetime not null,
	CONSTRAINT fk_Negocio_Imagen FOREIGN KEY(IdImagen) REFERENCES Imagen(IdImagen)
)
go 
if exists(select * from sys.all_objects where name = 'Imagen' and type = 'U')
begin
	drop table Imagen 
end
go  
create table Imagen(
	IdImagen int identity(1,1) PRIMARY KEY,
	Nombre nvarchar(500) not null,
	Ruta text not null,
	Size float not null,
	Fecha datetime not null 
)
go
if exists(select * from sys.all_objects where name = 'Estatus' and type = 'U')
begin
	drop table Estatus 
end 
go 
create table Estatus(
	IdEstatus int identity(1,1) PRIMARY KEY,
	Nombre nvarchar(50) not null,
	Fecha Datetime not null
)
go
if exists(select * from sys.all_objects where name = 'Servicio' and type = 'U')
begin
	drop table Servicio 
end 
go
create table Servicio(
	IdServicio int identity(1,1) PRIMARY KEY,
	IdNegocio int not null,
	Puntuacion int not null,
	Nombre nvarchar(500) not null,
	Descripcion text not null,
	Duracion float not null,
	Precio float not null,
	Fecha datetime not null,
	CONSTRAINT fk_Servicio_Negocio FOREIGN KEY(IdNegocio) REFERENCES Negocio(IdNegocio)
)
go
if exists(select * from sys.all_objects where name = 'Usuario' and type = 'U')
begin 
	drop table Usuario
end 
go 
create table Usuario(
	IdUsuario int identity(1,1) PRIMARY KEY,
	NickName nvarchar(50) not null,
	Nombre nvarchar(200) not null,
	ApellidoPaterno nvarchar(50) not null,
	ApellidoMaterno nvarchar(50) not null,
	Celular int not null,
	Email nvarchar(50) not null,
	Consumidor bit not null,
	Fecha datetime not null
)
go
if not exists(select * from sys.all_objects where name = 'Direccion' and type = 'U')
begin
	drop table Direccion 
end 
go
create table Direccion(
	IdDireccion int PRIMARY KEY,
	Lugar nvarchar(200) not null,
	Calle nvarchar(200) not null,
	Referencia text not null,
	NumeroExterior int not null,
	Latitud decimal(19,2) not null,
	Longitud decimal(19,2) not null
)
go
if not exists(select * from sys.all_objects where name = 'Comprobante' and type = 'U')
begin
	drop table Comprobante 
end 
go
create table Comprobante(
	IdComprobante int identity(1,1) PRIMARY KEY,
	IdUsuario int not null,
	IdNegocio int not null,
	Efectivo bit not null,
	IdEstatus int not null,
	IdDireccion int not null,
	Puntuacion int not null,
	Precio float not null,
	Fecha datetime not null,
	CONSTRAINT fk_Comprobante_Usuario FOREIGN KEY(IdUsuario) REFERENCES Usuario(IdUsuario),
	CONSTRAINT fk_Comprobante_Negocio FOREIGN KEY(IdNegocio) REFERENCES Negocio(IdNegocio),
	CONSTRAINT fk_Comprobante_Direccion FOREIGN KEY(IdDireccion) REFERENCES Direccion(IdDireccion),
	CONSTRAINT fk_Comprobante_Estatus FOREIGN KEY(IdEstatus) REFERENCES Estatus(IdEstatus)
)
go
if not exists(select * from sys.all_objects where name = 'ComprobanteDetalle' and type = 'U')
begin
	drop table ComprobanteDetalle 
end 
go
create table ComprobanteDetalle(
	IdComprobanteDetalle int identity(1,1) PRIMARY KEY,
	IdComprobante int not null,
	IdServicio int not null, 
	IdEstatus int not null,
	Puntuacion int not null,
	Precio float not null,
	Cambio float null,
	Fecha datetime not null,
	CONSTRAINT fk_ComprobanteDetalle_Comprobante FOREIGN KEY(IdComprobante) REFERENCES Comprobante(IdComprobante),
	CONSTRAINT fk_ComprobanteDetalle_Servicio FOREIGN KEY(IdServicio) REFERENCES Servicio(IdServicio),
	CONSTRAINT fk_ComprobanteDetalle_Estatus FOREIGN KEY(IdEstatus) REFERENCES Estatus(IdEstatus)
)
