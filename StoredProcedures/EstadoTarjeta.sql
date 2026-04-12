-- TABLA: EstadoTarjeta

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertEstadoTarjeta
    @Nombre VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM EstadoTarjeta WHERE Nombre = @Nombre)
        BEGIN
            PRINT 'El Estado de tarjeta que intenta registrar ya existe en la base de datos';
        END
    ELSE
        BEGIN
            INSERT INTO EstadoTarjeta(Nombre)
            VALUES (@Nombre);
            PRINT 'Registro insertado correctamente';
        END
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateEstadoTarjeta
    @EstadoTarjetaId INT,
    @Nombre VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM EstadoTarjeta WHERE Nombre = @Nombre AND EstadoTarjetaId <> @EstadoTarjetaId)
        BEGIN
            PRINT 'El Estado de tarjeta ya existe en la base de datos';
        END
    ELSE
        BEGIN
            UPDATE EstadoTarjeta
            SET Nombre = @Nombre
            WHERE EstadoTarjetaId = @EstadoTarjetaId;

            PRINT 'Registro actualizado correctamente';
        END
END;

-- 3) SP DELETE
GO
CREATE OR ALTER PROCEDURE spDeleteEstadoTarjeta
    @EstadoTarjetaId INT
AS
BEGIN
    DELETE FROM EstadoTarjeta
    WHERE EstadoTarjetaId = @EstadoTarjetaId;

    PRINT 'Registro eliminado correctamente';
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllEstadoTarjeta
AS
BEGIN
    SELECT 
        EstadoTarjetaId AS 'Codigo',
        Nombre AS 'Nombre'
    FROM EstadoTarjeta
    ORDER BY Nombre ASC;
END;

-- 5) SP SEARCH BY
GO
CREATE OR ALTER PROCEDURE spBusquedaEstadoTarjeta
    @busqueda VARCHAR(200)
AS
BEGIN
    SELECT
        EstadoTarjetaId AS 'Codigo',
        Nombre AS 'Nombre'
    FROM EstadoTarjeta
    WHERE Nombre LIKE '%' + @busqueda + '%'
    ORDER BY Nombre ASC;
END;