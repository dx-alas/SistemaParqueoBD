CREATE DATABASE SistemaParqueoUnab;
GO
USE SistemaParqueoUnab;
GO

-- TABLAS NECESARIAS PARA PROBAR LOGIN
CREATE TABLE EstadoUsuario (
    EstadoUsuarioId INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Rol (
    RolId INT PRIMARY KEY IDENTITY,
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
GO

-- DATOS DE PRUEBA
INSERT INTO EstadoUsuario (Nombre)
VALUES 
('Activo'),
('Inactivo');

INSERT INTO Rol (Nombre)
VALUES 
('Administrador');

INSERT INTO EstadoEmpleado (Nombre)
VALUES 
('Activo'),
('Inactivo');


INSERT INTO Empleado 
    (Nombre, Apellido, DUI, Correo, Telefono, Direccion, EstadoEmpleadoId)
VALUES
    ('Admin', 'Sistema', '123456789', 'admin@unab.com', '70000000', 'UNAB',1);
 
INSERT INTO Usuario 
    (Nombre, Clave, EmpleadoId, RolId, EstadoUsuarioId)
VALUES
    ('admin', '123', 1, 1, 1);
GO

-- PROCEDIMIENTOS ALMACENADOS

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertUsuario
    @Nombre VARCHAR(50),
    @Clave VARCHAR(255),
    @EmpleadoId INT,
    @RolId INT,
    @EstadoUsuarioId INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Usuario WHERE EmpleadoId = @EmpleadoId)
        BEGIN
            PRINT 'El empleado ya tiene un usuario asignado';
            RETURN;
        END

    IF EXISTS (SELECT 1 FROM Usuario WHERE Nombre = @Nombre)
        BEGIN
            PRINT 'El usuario que intenta registrar ya existe en la base de datos';
        END
    ELSE
        BEGIN
            INSERT INTO Usuario(Nombre, Clave, EmpleadoId, RolId, EstadoUsuarioId)
            VALUES (@Nombre, @Clave, @EmpleadoId, @RolId, @EstadoUsuarioId);

            PRINT 'Registro insertado correctamente';
        END
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateUsuario
    @UsuarioId INT,
    @Nombre VARCHAR(50),
    @Clave VARCHAR(255),
    @EmpleadoId INT,
    @RolId INT,
    @EstadoUsuarioId INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Usuario WHERE EmpleadoId = @EmpleadoId AND UsuarioId <> @UsuarioId)
        BEGIN
            PRINT 'El empleado ya tiene un usuario asignado';
            RETURN;
        END

    IF EXISTS (SELECT 1 FROM Usuario WHERE Nombre = @Nombre AND UsuarioId <> @UsuarioId)
        BEGIN
            PRINT 'El usuario con ese nombre ya existe en la base de datos';
        END
    ELSE
        BEGIN
            UPDATE Usuario
            SET Nombre = @Nombre,
                Clave = @Clave,
                EmpleadoId = @EmpleadoId,
                RolId = @RolId,
                EstadoUsuarioId = @EstadoUsuarioId
            WHERE UsuarioId = @UsuarioId;

            PRINT 'Registro actualizado correctamente';
        END
END;

-- 3) SP DELETE (Eliminación lógica)
GO
CREATE OR ALTER PROCEDURE spDeleteUsuario
    @UsuarioId INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Usuario WHERE UsuarioId = @UsuarioId)
        BEGIN
            PRINT 'El usuario que intenta eliminar no existe';
            RETURN;
        END

    UPDATE Usuario
    SET EstadoUsuarioId = 2
    WHERE UsuarioId = @UsuarioId;

    PRINT 'Usuario eliminado correctamente';
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllUsuario
AS
BEGIN
    SELECT 
        u.UsuarioId,
        u.Nombre,
        u.Clave,
        u.EmpleadoId,
        u.RolId,
        u.EstadoUsuarioId,
        r.Nombre,
        e.Nombre
    FROM Usuario u
    INNER JOIN Rol r ON u.RolId = r.RolId
    INNER JOIN EstadoUsuario e ON u.EstadoUsuarioId = e.EstadoUsuarioId
    ORDER BY u.Nombre ASC;
END;

-- 5) SP SELECT BY ID
GO
CREATE OR ALTER PROCEDURE spSelectUsuarioById
    @UsuarioId INT
AS
BEGIN
    SELECT 
        u.UsuarioId,
        u.Nombre,
        u.Clave,
        u.EmpleadoId,
        u.RolId,
        u.EstadoUsuarioId,
        r.Nombre,
        e.Nombre
    FROM Usuario u
    INNER JOIN Rol r ON u.RolId = r.RolId
    INNER JOIN EstadoUsuario e ON u.EstadoUsuarioId = e.EstadoUsuarioId
    WHERE u.UsuarioId = @UsuarioId;
END;

-- SP LOGIN
GO
CREATE OR ALTER PROCEDURE spUsuarioLogin
    @Nombre VARCHAR(50),
    @Clave VARCHAR(255)
AS
BEGIN
    SELECT 
        UsuarioId,
        Nombre,
        Clave,
        EmpleadoId,
        RolId,
        EstadoUsuarioId
    FROM Usuario
    WHERE Nombre = @Nombre
      AND Clave = @Clave
      AND EstadoUsuarioId = 1;
END;
GO