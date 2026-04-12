-- TABLA: EstadoUsuario

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertEstadoUsuario
    @Nombre VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM EstadoUsuario WHERE Nombre = @Nombre)
        BEGIN
            PRINT 'El Estado de usuario que intenta registrar ya existe en la base de datos';
        END
    ELSE
        BEGIN
            INSERT INTO EstadoUsuario(Nombre)
            VALUES (@Nombre);
            PRINT 'Registro insertado correctamente';
        END
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateEstadoUsuario
    @EstadoUsuarioId INT,
    @Nombre VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM EstadoUsuario WHERE Nombre = @Nombre AND EstadoUsuarioId <> @EstadoUsuarioId)
        BEGIN
            PRINT 'El Estado de usuario ya existe en la base de datos';
        END
    ELSE
        BEGIN
            UPDATE EstadoUsuario
            SET Nombre = @Nombre
            WHERE EstadoUsuarioId = @EstadoUsuarioId;

            PRINT 'Registro actualizado correctamente';
        END
END;

-- 3) SP DELETE
GO
CREATE OR ALTER PROCEDURE spDeleteEstadoUsuario
    @EstadoUsuarioId INT
AS
BEGIN
    DELETE FROM EstadoUsuario
    WHERE EstadoUsuarioId = @EstadoUsuarioId;

    PRINT 'Registro eliminado correctamente';
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllEstadoUsuario
AS
BEGIN
    SELECT
        EstadoUsuarioId,
        Nombre
    FROM EstadoUsuario
    ORDER BY Nombre ASC;
END;

-- 5) SP SEARCH BY
GO
CREATE OR ALTER PROCEDURE spSelectEstadoUsuarioById
    @EstadoUsuarioId INT
AS
BEGIN
    SELECT
        EstadoUsuarioId,
        Nombre
    FROM EstadoUsuario
    WHERE EstadoUsuarioId = @EstadoUsuarioId;
END;