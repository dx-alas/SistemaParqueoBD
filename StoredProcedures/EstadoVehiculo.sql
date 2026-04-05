-- TABLA: EstadoVehiculo

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertEstadoVehiculo
    @Nombre VARCHAR(50),
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM EstadoVehiculo WHERE Nombre = @Nombre)
        BEGIN
            SET @Mensaje = 'El estado de vehiculo que intenta registrar ya existe en la base de datos';
        END
    ELSE
        BEGIN
            INSERT INTO EstadoVehiculo(Nombre)
            VALUES (@Nombre);

            SET @Mensaje = 'Registro insertado correctamente';
        END
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateEstadoVehiculo
    @EstadoVehiculoId INT,
    @Nombre VARCHAR(50),
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM EstadoVehiculo WHERE Nombre = @Nombre AND EstadoVehiculoId <> @EstadoVehiculoId)
        BEGIN
            SET @Mensaje = 'El estado de vehiculo ya existe en la base de datos';
        END
    ELSE
        BEGIN
            UPDATE EstadoVehiculo
            SET Nombre = @Nombre
            WHERE EstadoVehiculoId = @EstadoVehiculoId;

            SET @Mensaje = 'Registro actualizado correctamente';
        END
END;

-- 3) SP DELETE
GO
CREATE OR ALTER PROCEDURE spDeleteEstadoVehiculo
    @EstadoVehiculoId INT,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    DELETE FROM EstadoVehiculo
    WHERE EstadoVehiculoId = @EstadoVehiculoId;

    SET @Mensaje = 'Registro eliminado correctamente';
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllEstadoVehiculo
AS
BEGIN
    SELECT 
        EstadoVehiculoId AS 'Codigo',
        Nombre AS 'Nombre'
    FROM EstadoVehiculo
    ORDER BY Nombre ASC;
END;

-- 5) SP SEARCH BY
GO
CREATE OR ALTER PROCEDURE spBusquedaEstadoVehiculo
    @busqueda VARCHAR(200)
AS
BEGIN
    SELECT
        EstadoVehiculoId AS 'Codigo',
        Nombre AS 'Nombre'
    FROM EstadoVehiculo
    WHERE Nombre LIKE '%' + @busqueda + '%'
    ORDER BY Nombre ASC;
END;