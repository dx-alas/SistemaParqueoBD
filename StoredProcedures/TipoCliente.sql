-- TABLA: TipoCliente

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertTipoCliente
    @Nombre VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT * FROM TipoCliente WHERE Nombre = @Nombre)
    BEGIN
        PRINT 'El Tipo de cliente que intenta registrar ya existe en la base de datos';
    END
    ELSE
    BEGIN
        INSERT INTO TipoCliente(Nombre)
        VALUES (@Nombre);
    END
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateTipoCliente
    @TipoClienteId INT,
    @Nombre VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT * FROM TipoCliente WHERE Nombre = @Nombre AND TipoClienteId <> @TipoClienteId)
    BEGIN
        PRINT 'El Tipo de cliente ya existe en la base de datos';
    END
    ELSE
    BEGIN
        UPDATE TipoCliente
        SET Nombre = @Nombre
        WHERE TipoClienteId = @TipoClienteId;
    END
END;

-- 3) SP DELETE
GO
CREATE OR ALTER PROCEDURE spDeleteTipoCliente
    @TipoClienteId INT
AS
BEGIN
    DELETE FROM TipoCliente
    WHERE TipoClienteId = @TipoClienteId;
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllTipoCliente
AS
BEGIN
    SELECT 
        TipoClienteId AS 'Codigo',
        Nombre AS 'Nombre'
    FROM TipoCliente
    ORDER BY Nombre ASC;
END;

-- 5) SP SEARCH BY
GO
CREATE OR ALTER PROCEDURE spBusquedaTipoCliente
    @busqueda VARCHAR(200)
AS
BEGIN
    SELECT
        TipoClienteId AS 'Codigo',
        Nombre AS 'Nombre'
    FROM TipoCliente
    WHERE Nombre LIKE '%' + @busqueda + '%'
    ORDER BY Nombre ASC;
END;