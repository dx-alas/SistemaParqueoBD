/*
    Base de Datos Sistema Parqueo UNAB
    Analisis y Diseño de Sistemas 
    Grupo de trabajo 1
*/

CREATE DATABASE SistemaParqueoUnab;
GO

USE SistemaParqueoUnab;
GO

CREATE TABLE TipoCliente (
    TipoClienteId INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL
); -- 

CREATE TABLE TipoVehiculo (
    TipoVehiculoId INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL
); --

CREATE TABLE EstadoUsuario (
    EstadoUsuarioId INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL
); -- 

CREATE TABLE Rol (
    RolId INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL
); -- 

CREATE TABLE EstadoTarjeta (
    EstadoTarjetaId INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL
); -- 

CREATE TABLE EstadoTicket (
    EstadoTicketId INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL
); -- 

CREATE TABLE EstadoEmpleado (
    EstadoEmpleadoId INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL
); -- NUEVA

CREATE TABLE Empleado(
    EmpleadoId INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    DUI VARCHAR(9) NOT NULL UNIQUE,
    Correo VARCHAR(50) NULL,
    Telefono VARCHAR(15) NULL,
    EstadoEmpleadoId INT NOT NULL DEFAULT 1,
    FOREIGN KEY (EstadoEmpleadoId) REFERENCES EstadoEmpleado(EstadoEmpleadoId)
); -- 

CREATE TABLE Usuario (
    UsuarioId INT IDENTITY(1,1) PRIMARY KEY,
    EmpleadoId INT,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Correo VARCHAR(100) NOT NULL UNIQUE,
    Clave VARCHAR(100) NOT NULL,
    RolId INT,
    EstadoUsuarioId INT,
    FOREIGN KEY (EmpleadoId) REFERENCES Empleado(EmpleadoId),
    FOREIGN KEY (RolId) REFERENCES Rol(RolId),
    FOREIGN KEY (EstadoUsuarioId) REFERENCES EstadoUsuario(EstadoUsuarioId)
); -- 

CREATE TABLE Tarjeta (
    TarjetaId INT IDENTITY(1,1) PRIMARY KEY,
    Codigo VARCHAR(50) NOT NULL,
    EstadoTarjetaId INT,
    FOREIGN KEY (EstadoTarjetaId) REFERENCES EstadoTarjeta(EstadoTarjetaId)
); -- 

CREATE TABLE Cliente ( 
    ClienteId INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Telefono VARCHAR(20),
    DUI VARCHAR(9),
    TarjetaId INT,
    TipoClienteId INT,
    FOREIGN KEY (TipoClienteId) REFERENCES TipoCliente(TipoClienteId),
    FOREIGN KEY (TarjetaId) REFERENCES Tarjeta(TarjetaId)
); --

CREATE TABLE Parqueo (
    ParqueoId INT IDENTITY(1,1) PRIMARY KEY,
    CapacidadTotal INT NOT NULL
); --

CREATE TABLE Vehiculo (
    VehiculoId INT IDENTITY(1,1) PRIMARY KEY,
    ClienteId INT NOT NULL,
    Placa VARCHAR(20) NOT NULL,
    TipoVehiculoId INT,
    FOREIGN KEY (ClienteId) REFERENCES Cliente(ClienteId),
    FOREIGN KEY (TipoVehiculoId) REFERENCES TipoVehiculo(TipoVehiculoId)
); -- 

CREATE TABLE CorteCaja (
    CorteId INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATE NOT NULL,
    HoraInicio TIME NOT NULL,
    HoraEntrega TIME,
    MontoInicial DECIMAL(10,2),
    MontoTotal DECIMAL(10,2),
	ObservacionInicial varchar(250) null,
	ObservacionFinal varchar(250) null,
    UsuarioId INT,
    FOREIGN KEY (UsuarioId) REFERENCES Usuario(UsuarioId)
); -- 

CREATE TABLE MultaTicket (
    MultaId INT IDENTITY(1,1) PRIMARY KEY,
    Concepto VARCHAR(100) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL
); -- 

CREATE TABLE EstadoPermanencia (
    EstadoPermanenciaId INT IDENTITY(1,1) PRIMARY KEY,
    Estado VARCHAR(50) NOT NULL
); -- 


CREATE TABLE UsuarioAutoriza (
    UsuarioAutorizaId INT IDENTITY(1,1) PRIMARY KEY,
    UsuarioId INT NOT NULL,
    FOREIGN KEY (UsuarioId) REFERENCES Usuario(UsuarioId)
);

CREATE TABLE Ticket (
    TicketId INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATE NOT NULL,
    HoraEntrada TIME NOT NULL,
	HoraSalida TIME NULL,
    Total DECIMAL(10,2),
    VehiculoId INT,
    TarjetaId INT,
    CorteId INT,
    EstadoTicketId INT,
    UsuarioAutorizaId INT,
    UsuarioId INT,
	MultaId INT,
    EstadoPermanenciaId INT,
    FOREIGN KEY (VehiculoId) REFERENCES Vehiculo(VehiculoId),
    FOREIGN KEY (TarjetaId) REFERENCES Tarjeta(TarjetaId),
    FOREIGN KEY (CorteId) REFERENCES CorteCaja(CorteId),
    FOREIGN KEY (EstadoTicketId) REFERENCES EstadoTicket(EstadoTicketId),
    FOREIGN KEY (UsuarioId) REFERENCES Usuario(UsuarioId),
    FOREIGN KEY (UsuarioAutorizaId) REFERENCES UsuarioAutoriza(UsuarioAutorizaId),
	FOREIGN KEY (MultaId) REFERENCES MultaTicket(MultaId),
    FOREIGN KEY (EstadoPermanenciaId) REFERENCES EstadoPermanencia(EstadoPermanenciaId)
);