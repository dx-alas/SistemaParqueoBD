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
    TipoClienteId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE TipoVehiculo (
    TipoVehiculoId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL UNIQUE,
    Precio DECIMAL(10,2) NOT NULL CHECK (Precio > 0)
);

CREATE TABLE EstadoUsuario (
    EstadoUsuarioId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Rol (
    RolId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE EstadoTarjeta (
    EstadoTarjetaId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE EstadoTicket (
    EstadoTicketId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE EstadoEmpleado (
    EstadoEmpleadoId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Empleado(
    EmpleadoId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    DUI VARCHAR(9) NOT NULL UNIQUE,
    Correo VARCHAR(50) NULL,
    Telefono VARCHAR(15) NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    EstadoEmpleadoId INT NOT NULL DEFAULT 1,
    FOREIGN KEY (EstadoEmpleadoId) REFERENCES EstadoEmpleado(EstadoEmpleadoId)
);

CREATE TABLE Usuario (
    UsuarioId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL UNIQUE,
    Clave VARCHAR(255) NOT NULL,
    EmpleadoId INT NOT NULL UNIQUE,
    RolId INT NOT NULL,
    EstadoUsuarioId INT NOT NULL DEFAULT 1,
    FOREIGN KEY (EmpleadoId) REFERENCES Empleado(EmpleadoId),
    FOREIGN KEY (RolId) REFERENCES Rol(RolId),
    FOREIGN KEY (EstadoUsuarioId) REFERENCES EstadoUsuario(EstadoUsuarioId)
);

CREATE TABLE Tarjeta (
    TarjetaId INT PRIMARY KEY IDENTITY,
    Codigo VARCHAR(50) NOT NULL UNIQUE,
    EstadoTarjetaId INT NOT NULL,
    FOREIGN KEY (EstadoTarjetaId) REFERENCES EstadoTarjeta(EstadoTarjetaId)
);

CREATE TABLE EstadoCliente (
    EstadoClienteId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Cliente ( 
    ClienteId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Telefono VARCHAR(20),
    TipoDocumento VARCHAR(20) NOT NULL CHECK (TipoDocumento IN ('DUI', 'CR')), 
    DUI VARCHAR(9) NULL UNIQUE,
    CarnetExtranjero VARCHAR(20) NULL UNIQUE,
    TarjetaId INT NOT NULL,
    TipoClienteId INT NOT NULL,
    EstadoClienteId INT NOT NULL DEFAULT 1, 

    FOREIGN KEY (TipoClienteId) REFERENCES TipoCliente(TipoClienteId),
    FOREIGN KEY (TarjetaId) REFERENCES Tarjeta(TarjetaId),
    FOREIGN KEY (EstadoClienteId) REFERENCES EstadoCliente(EstadoClienteId),

    CHECK (
        (TipoDocumento = 'DUI' AND DUI IS NOT NULL AND CarnetExtranjero IS NULL)
        OR
        (TipoDocumento = 'CR' AND CarnetExtranjero IS NOT NULL AND DUI IS NULL)
    )
);

CREATE TABLE Parqueo ( 
    ParqueoId INT PRIMARY KEY IDENTITY,
    CapacidadTotal INT NOT NULL CHECK (CapacidadTotal > 0)
);

CREATE TABLE EstadoVehiculo (
    EstadoVehiculoId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL UNIQUE
); -- NUEVA (ADD ENTITY)

CREATE TABLE Vehiculo (
    VehiculoId INT PRIMARY KEY IDENTITY,
    Placa VARCHAR(20) NOT NULL UNIQUE,
    ClienteId INT NOT NULL,
    TipoVehiculoId INT NOT NULL,
    EstadoVehiculoId INT NOT NULL DEFAULT 1, -- 1 = Activo por defecto
    FOREIGN KEY (ClienteId) REFERENCES Cliente(ClienteId),
    FOREIGN KEY (TipoVehiculoId) REFERENCES TipoVehiculo(TipoVehiculoId),
    FOREIGN KEY (EstadoVehiculoId) REFERENCES EstadoVehiculo(EstadoVehiculoId)
);

CREATE TABLE CorteCaja (
    CorteId INT PRIMARY KEY IDENTITY,
    Fecha DATE NOT NULL,
    HoraInicio TIME NOT NULL,
    HoraEntrega TIME NULL,
    MontoInicial DECIMAL(10,2) NULL CHECK (MontoInicial >= 0),
    MontoTotal DECIMAL(10,2) NULL CHECK (MontoTotal >= 0),
    ObservacionInicial VARCHAR(255) NULL,
    ObservacionFinal VARCHAR(255) NULL,
    UsuarioAperturaId INT NOT NULL,  -- Administrador que abre el corte
    UsuarioCierreId INT NULL,        -- Administrador que cierra el corte
    FOREIGN KEY (UsuarioAperturaId) REFERENCES Usuario(UsuarioId),
    FOREIGN KEY (UsuarioCierreId) REFERENCES Usuario(UsuarioId)
);

CREATE TABLE MultaTicket (
    MultaId INT PRIMARY KEY IDENTITY,
    Concepto VARCHAR(100) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL CHECK (Precio > 0)
);

CREATE TABLE EstadoPermanencia (
    EstadoPermanenciaId INT PRIMARY KEY IDENTITY,
    Estado VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Ticket (
    TicketId INT PRIMARY KEY IDENTITY,
    Fecha DATE NOT NULL,
    HoraEntrada TIME NOT NULL,
    HoraSalida TIME NULL,
    Total DECIMAL(10,2) NULL CHECK (Total >= 0),
    TarjetaId INT NOT NULL,
    CorteId INT NULL,
    EstadoTicketId INT NOT NULL DEFAULT 1,
    UsuarioId INT NOT NULL,
    MultaId INT NULL,
    EstadoPermanenciaId INT NOT NULL DEFAULT 1,

    FOREIGN KEY (TarjetaId) REFERENCES Tarjeta(TarjetaId),
    FOREIGN KEY (CorteId) REFERENCES CorteCaja(CorteId),
    FOREIGN KEY (EstadoTicketId) REFERENCES EstadoTicket(EstadoTicketId),
    FOREIGN KEY (UsuarioId) REFERENCES Usuario(UsuarioId),
    FOREIGN KEY (MultaId) REFERENCES MultaTicket(MultaId),
    FOREIGN KEY (EstadoPermanenciaId) REFERENCES EstadoPermanencia(EstadoPermanenciaId)
);