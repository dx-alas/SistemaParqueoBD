-- TABLA: EstadoCliente

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertEstadoCliente
    @Nombre VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM EstadoCliente WHERE Nombre = @Nombre)
        BEGIN
            PRINT 'El estado de cliente que intenta registrar ya existe en la base de datos';
        END
    ELSE
        BEGIN
            INSERT INTO EstadoCliente(Nombre)
            VALUES (@Nombre);

            PRINT 'Registro insertado correctamente';
        END
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateEstadoCliente
    @EstadoClienteId INT,
    @Nombre VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM EstadoCliente WHERE Nombre = @Nombre AND EstadoClienteId <> @EstadoClienteId)
        BEGIN
            PRINT 'El estado de cliente ya existe en la base de datos';
        END
    ELSE
        BEGIN
            UPDATE EstadoCliente
            SET Nombre = @Nombre
            WHERE EstadoClienteId = @EstadoClienteId;

            PRINT 'Registro actualizado correctamente';
        END
END;

-- 3) SP DELETE
GO
CREATE OR ALTER PROCEDURE spDeleteEstadoCliente
    @EstadoClienteId INT
AS
BEGIN
    DELETE FROM EstadoCliente
    WHERE EstadoClienteId = @EstadoClienteId;

    PRINT 'Registro eliminado correctamente';
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllEstadoCliente
AS
BEGIN
    SELECT 
        EstadoClienteId,
        Nombre
    FROM EstadoCliente
    ORDER BY Nombre ASC;
END;

-- 5) SP SEARCH BY
GO
CREATE OR ALTER PROCEDURE spSelectEstadoClienteById
    @EstadoClienteId INT
AS
BEGIN
    SELECT
        EstadoClienteId,
        Nombre
    FROM EstadoCliente
    WHERE EstadoClienteId = @EstadoClienteId;
END;