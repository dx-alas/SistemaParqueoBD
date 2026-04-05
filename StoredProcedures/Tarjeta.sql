-- TABLA: Tarjeta 

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertTarjeta
    @Codigo VARCHAR(50),
    @EstadoTarjetaId INT,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    -- Validación clave foránea
    IF NOT EXISTS (SELECT 1 FROM EstadoTarjeta WHERE EstadoTarjetaId = @EstadoTarjetaId)
        BEGIN
            SET @Mensaje = 'El estado de tarjeta seleccionado no existe';
            RETURN;
        END

    IF EXISTS (SELECT 1 FROM Tarjeta WHERE Codigo = @Codigo)
        BEGIN
            SET @Mensaje = 'La tarjeta que intenta registrar ya existe en la base de datos';
        END
    ELSE
        BEGIN
            INSERT INTO Tarjeta(Codigo, EstadoTarjetaId)
            VALUES (@Codigo, @EstadoTarjetaId);

            SET @Mensaje = 'Registro insertado correctamente';
        END
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateTarjeta
    @Id INT,
    @Codigo VARCHAR(50),
    @EstadoTarjetaId INT,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    -- Validaciones críticas
    IF NOT EXISTS (SELECT 1 FROM Tarjeta WHERE TarjetaId = @Id)
        BEGIN
            SET @Mensaje = 'La tarjeta que intenta actualizar no existe';
            RETURN;
        END

    IF NOT EXISTS (SELECT 1 FROM EstadoTarjeta WHERE EstadoTarjetaId = @EstadoTarjetaId)
        BEGIN
            SET @Mensaje = 'El estado de tarjeta seleccionado no existe';
            RETURN;
        END

    IF EXISTS (SELECT 1 FROM Tarjeta WHERE Codigo = @Codigo AND TarjetaId <> @Id)
        BEGIN
            SET @Mensaje = 'El codigo de tarjeta ya existe en la base de datos';
        END
    ELSE
        BEGIN
            UPDATE Tarjeta
            SET Codigo = @Codigo,
                EstadoTarjetaId = @EstadoTarjetaId
            WHERE TarjetaId = @Id;

            SET @Mensaje = 'Registro actualizado correctamente';
        END
END;

-- 3) SP DELETE (Eliminación lógica)
GO
CREATE OR ALTER PROCEDURE spDeleteTarjeta
    @Id INT,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Tarjeta WHERE TarjetaId = @Id)
        BEGIN
            SET @Mensaje = 'La tarjeta que intenta eliminar no existe';
            RETURN;
        END

    UPDATE Tarjeta
    SET EstadoTarjetaId = 2
    WHERE TarjetaId = @Id;

    SET @Mensaje = 'Tarjeta eliminada correctamente';
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