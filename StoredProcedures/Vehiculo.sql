-- TABLA: Vehiculo (NECESITA ELIMINACION LOGICA)

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertVehiculo
    @ClienteId INT,
    @Placa VARCHAR(20),
    @TipoVehiculoId INT,
    @EstadoVehiculoId INT = 1
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Vehiculo WHERE Placa = @Placa)
        BEGIN
            PRINT 'El vehiculo que intenta registrar ya existe en la base de datos';
        END
    ELSE
        BEGIN
            INSERT INTO Vehiculo(ClienteId, Placa, TipoVehiculoId, EstadoVehiculoId)
            VALUES (@ClienteId, @Placa, @TipoVehiculoId, @EstadoVehiculoId);

            PRINT 'Registro insertado correctamente';
        END
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateVehiculo
    @VehiculoId INT,
    @ClienteId INT,
    @Placa VARCHAR(20),
    @TipoVehiculoId INT,
    @EstadoVehiculoId INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Vehiculo WHERE Placa = @Placa AND VehiculoId <> @VehiculoId)
        BEGIN
            PRINT 'La placa ya existe en la base de datos';
        END
    ELSE
        BEGIN
            UPDATE Vehiculo
            SET ClienteId = @ClienteId,
                Placa = @Placa,
                TipoVehiculoId = @TipoVehiculoId,
                EstadoVehiculoId = @EstadoVehiculoId
            WHERE VehiculoId = @VehiculoId;

            PRINT 'Registro actualizado correctamente';
        END
END;

-- 3) SP DELETE (lógica)
GO
CREATE OR ALTER PROCEDURE spDeleteVehiculo
    @VehiculoId INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Vehiculo WHERE VehiculoId = @VehiculoId)
        BEGIN
            PRINT 'El vehiculo que intenta eliminar no existe';
            RETURN;
        END

    UPDATE Vehiculo
    SET EstadoVehiculoId = 2
    WHERE VehiculoId = @VehiculoId;

    PRINT 'Vehiculo eliminado correctamente';
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