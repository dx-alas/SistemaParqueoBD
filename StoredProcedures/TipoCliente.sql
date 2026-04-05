-- TABLA: TipoCliente

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertTipoCliente
    @Nombre VARCHAR(50),
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM TipoCliente WHERE Nombre = @Nombre)
        BEGIN
            SET @Mensaje = 'El Tipo de cliente que intenta registrar ya existe en la base de datos';
        END
    ELSE
        BEGIN
            INSERT INTO TipoCliente(Nombre)
            VALUES (@Nombre);
            SET @Mensaje = 'Registro insertado correctamente';
        END
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateTipoCliente
    @TipoClienteId INT,
    @Nombre VARCHAR(50),
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM TipoCliente WHERE Nombre = @Nombre AND TipoClienteId <> @TipoClienteId)
        BEGIN
            SET @Mensaje = 'El Tipo de cliente ya existe en la base de datos';
        END
    ELSE
        BEGIN
            UPDATE TipoCliente
            SET Nombre = @Nombre
            WHERE TipoClienteId = @TipoClienteId;

            SET @Mensaje = 'Registro actualizado correctamente';
        END
END;

-- 3) SP DELETE
GO
CREATE OR ALTER PROCEDURE spDeleteTipoCliente
    @TipoClienteId INT,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    DELETE FROM TipoCliente
    WHERE TipoClienteId = @TipoClienteId;

    SET @Mensaje = 'Registro eliminado correctamente';
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