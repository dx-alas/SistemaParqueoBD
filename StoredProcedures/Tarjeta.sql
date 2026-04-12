-- TABLA: Tarjeta 

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertTarjeta
    @Codigo VARCHAR(50),
    @EstadoTarjetaId INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Tarjeta WHERE Codigo = @Codigo)
        BEGIN
            PRINT 'La tarjeta que intenta registrar ya existe en la base de datos';
        END
    ELSE
        BEGIN
            INSERT INTO Tarjeta(Codigo, EstadoTarjetaId)
            VALUES (@Codigo, @EstadoTarjetaId);

            PRINT 'Registro insertado correctamente';
        END
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateTarjeta
    @TarjetaId INT,
    @Codigo VARCHAR(50),
    @EstadoTarjetaId INT
AS
BEGIN
    -- Validaciones críticas
    IF EXISTS (SELECT 1 FROM Tarjeta WHERE Codigo = @Codigo AND TarjetaId <> @TarjetaId)
        BEGIN
            PRINT 'El codigo de tarjeta ya existe en la base de datos';
        END
    ELSE
        BEGIN
            UPDATE Tarjeta
            SET Codigo = @Codigo,
                EstadoTarjetaId = @EstadoTarjetaId
            WHERE TarjetaId = @TarjetaId;

            PRINT 'Registro actualizado correctamente';
        END
END;

-- 3) SP DELETE (Eliminación lógica)
GO
CREATE OR ALTER PROCEDURE spDeleteTarjeta
    @TarjetaId INT
AS
BEGIN
    UPDATE Tarjeta
    SET EstadoTarjetaId = 2
    WHERE TarjetaId = @TarjetaId;

    PRINT 'Tarjeta eliminada correctamente';
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllTarjeta
AS
BEGIN
    SELECT
        t.TarjetaId AS 'Codigo',
        t.Codigo,
        t.EstadoTarjetaId,  
        e.Nombre AS 'EstadoTarjeta'
    FROM Tarjeta t
    INNER JOIN EstadoTarjeta e 
        ON t.EstadoTarjetaId = e.EstadoTarjetaId
    ORDER BY t.Codigo ASC;
END;

-- 5) SP SEARCH BY
GO
CREATE OR ALTER PROCEDURE spBusquedaTarjeta
    @busqueda VARCHAR(200)
AS
BEGIN
    SELECT
        t.TarjetaId AS 'Codigo',
        t.Codigo,
        t.EstadoTarjetaId,     
        e.Nombre AS 'EstadoTarjeta'
    FROM Tarjeta t
    INNER JOIN EstadoTarjeta e 
        ON t.EstadoTarjetaId = e.EstadoTarjetaId
    WHERE t.Codigo LIKE '%' + @busqueda + '%'
    ORDER BY t.Codigo ASC;
END;