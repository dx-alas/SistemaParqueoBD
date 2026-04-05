-- TABLA: Vehiculo (NECESITA ELIMINACION LOGICA)

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertVehiculo
    @ClienteId INT,
    @Placa VARCHAR(20),
    @TipoVehiculoId INT,
    @EstadoVehiculoId INT = 1,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    -- Validaciones críticas
    IF NOT EXISTS (SELECT 1 FROM Cliente WHERE ClienteId = @ClienteId)
        BEGIN
            SET @Mensaje = 'El cliente no existe';
            RETURN;
        END

    IF NOT EXISTS (SELECT 1 FROM TipoVehiculo WHERE TipoVehiculoId = @TipoVehiculoId)
        BEGIN
            SET @Mensaje = 'El tipo de vehiculo no existe';
            RETURN;
        END

    IF NOT EXISTS (SELECT 1 FROM EstadoVehiculo WHERE EstadoVehiculoId = @EstadoVehiculoId)
        BEGIN
            SET @Mensaje = 'El estado de vehiculo no existe';
            RETURN;
        END

    IF EXISTS (SELECT 1 FROM Vehiculo WHERE Placa = @Placa)
        BEGIN
            SET @Mensaje = 'El vehiculo que intenta registrar ya existe en la base de datos';
        END
    ELSE
        BEGIN
            INSERT INTO Vehiculo(ClienteId, Placa, TipoVehiculoId, EstadoVehiculoId)
            VALUES (@ClienteId, @Placa, @TipoVehiculoId, @EstadoVehiculoId);

            SET @Mensaje = 'Registro insertado correctamente';
        END
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateVehiculo
    @Id INT,
    @ClienteId INT,
    @Placa VARCHAR(20),
    @TipoVehiculoId INT,
    @EstadoVehiculoId INT,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    -- Validaciones críticas
    IF NOT EXISTS (SELECT 1 FROM Vehiculo WHERE VehiculoId = @Id)
        BEGIN
            SET @Mensaje = 'El vehiculo que intenta actualizar no existe';
            RETURN;
        END

    IF NOT EXISTS (SELECT 1 FROM Cliente WHERE ClienteId = @ClienteId)
        BEGIN
            SET @Mensaje = 'El cliente no existe';
            RETURN;
        END

    IF NOT EXISTS (SELECT 1 FROM TipoVehiculo WHERE TipoVehiculoId = @TipoVehiculoId)
        BEGIN
            SET @Mensaje = 'El tipo de vehiculo no existe';
            RETURN;
        END

    IF NOT EXISTS (SELECT 1 FROM EstadoVehiculo WHERE EstadoVehiculoId = @EstadoVehiculoId)
        BEGIN
            SET @Mensaje = 'El estado de vehiculo no existe';
            RETURN;
        END

    IF EXISTS (SELECT 1 FROM Vehiculo WHERE Placa = @Placa AND VehiculoId <> @Id)
        BEGIN
            SET @Mensaje = 'La placa ya existe en la base de datos';
        END
    ELSE
        BEGIN
            UPDATE Vehiculo
            SET ClienteId = @ClienteId,
                Placa = @Placa,
                TipoVehiculoId = @TipoVehiculoId,
                EstadoVehiculoId = @EstadoVehiculoId
            WHERE VehiculoId = @Id;

            SET @Mensaje = 'Registro actualizado correctamente';
        END
END;

-- 3) SP DELETE (lógica)
GO
CREATE OR ALTER PROCEDURE spDeleteVehiculo
    @Id INT,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Vehiculo WHERE VehiculoId = @Id)
        BEGIN
            SET @Mensaje = 'El vehiculo que intenta eliminar no existe';
            RETURN;
        END

    UPDATE Vehiculo
    SET EstadoVehiculoId = 2
    WHERE VehiculoId = @Id;

    SET @Mensaje = 'Vehiculo eliminado correctamente';
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllVehiculo
AS
BEGIN
    SELECT
        v.VehiculoId AS 'Codigo',
        c.Nombre AS 'Cliente',
        v.Placa,
        t.Nombre AS 'TipoVehiculo',
        e.Nombre AS 'EstadoVehiculo'
    FROM Vehiculo v
    INNER JOIN Cliente c ON v.ClienteId = c.ClienteId
    INNER JOIN TipoVehiculo t ON v.TipoVehiculoId = t.TipoVehiculoId
    INNER JOIN EstadoVehiculo e ON v.EstadoVehiculoId = e.EstadoVehiculoId
    WHERE v.EstadoVehiculoId = 1
    ORDER BY v.Placa ASC;
END;

-- 5) SP SEARCH BY
GO
CREATE OR ALTER PROCEDURE spBusquedaVehiculo
    @busqueda VARCHAR(200)
AS
BEGIN
    SELECT
        v.VehiculoId AS 'Codigo',
        c.Nombre AS 'Cliente',
        v.Placa,
        t.Nombre AS 'TipoVehiculo',
        e.Nombre AS 'EstadoVehiculo'
    FROM Vehiculo v
    INNER JOIN Cliente c ON v.ClienteId = c.ClienteId
    INNER JOIN TipoVehiculo t ON v.TipoVehiculoId = t.TipoVehiculoId
    INNER JOIN EstadoVehiculo e ON v.EstadoVehiculoId = e.EstadoVehiculoId
    WHERE v.EstadoVehiculoId = 1
      AND v.Placa LIKE '%' + @busqueda + '%'
    ORDER BY v.Placa ASC;
END;