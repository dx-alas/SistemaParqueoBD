-- TABLA: TipoVehiculo

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertTipoVehiculo
    @Nombre VARCHAR(50),
    @Precio DECIMAL(10,2),
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM TipoVehiculo WHERE Nombre = @Nombre)
        BEGIN
            SET @Mensaje = 'El tipo de vehiculo ya existe en la base de datos';
        END
    ELSE
        BEGIN
            INSERT INTO TipoVehiculo(Nombre, Precio)
            VALUES(@Nombre, @Precio);
            SET @Mensaje = 'Registro insertado correctamente';
        END
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateTipoVehiculo
    @TipoVehiculoId INT,
    @Nombre VARCHAR(50),
    @Precio DECIMAL(10,2),
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM TipoVehiculo WHERE Nombre = @Nombre AND TipoVehiculoId <> @TipoVehiculoId)
        BEGIN
            SET @Mensaje = 'El Tipo de vehiculo ya existe en la base de datos';
        END
    ELSE
        BEGIN
            UPDATE TipoVehiculo
            SET Nombre = @Nombre,
                Precio = @Precio
            WHERE TipoVehiculoId = @TipoVehiculoId;

            SET @Mensaje = 'Registro actualizado correctamente';
        END
END;

-- 3) SP DELETE
GO
CREATE OR ALTER PROCEDURE spDeleteTipoVehiculo
    @TipoVehiculoId INT,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    DELETE FROM TipoVehiculo
    WHERE TipoVehiculoId = @TipoVehiculoId;

    SET @Mensaje = 'Registro eliminado correctamente';
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllTipoVehiculo
AS
BEGIN
    SELECT 
        TipoVehiculoId AS 'Codigo',
        Nombre AS 'Nombre',
        Precio
    FROM TipoVehiculo
    ORDER BY Nombre ASC;
END;

-- 5) SP SEARCH BY
GO
CREATE OR ALTER PROCEDURE spBusquedaTipoVehiculo
    @busqueda VARCHAR(200)
AS
BEGIN
    SELECT
        TipoVehiculoId AS 'Codigo',
        Nombre AS 'Nombre',
        Precio
    FROM TipoVehiculo
    WHERE Nombre LIKE '%' + @busqueda + '%'
    ORDER BY Nombre ASC;
END;