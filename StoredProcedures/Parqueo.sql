-- TABLA: Parqueo

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertParqueo
    @CapacidadTotal INT,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    INSERT INTO Parqueo(CapacidadTotal)
    VALUES (@CapacidadTotal);

    SET @Mensaje = 'Registro insertado correctamente';
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateParqueo
    @Id INT,
    @CapacidadTotal INT,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Parqueo WHERE ParqueoId = @Id)
        BEGIN
            SET @Mensaje = 'El parqueo que intenta actualizar no existe';
            RETURN;
        END

    UPDATE Parqueo
    SET CapacidadTotal = @CapacidadTotal
    WHERE ParqueoId = @Id;

    SET @Mensaje = 'Registro actualizado correctamente';
END;

-- 3) SP DELETE
GO
CREATE OR ALTER PROCEDURE spDeleteParqueo
    @Id INT,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Parqueo WHERE ParqueoId = @Id)
        BEGIN
            SET @Mensaje = 'El parqueo que intenta eliminar no existe';
            RETURN;
        END

    DELETE FROM Parqueo
    WHERE ParqueoId = @Id;

    SET @Mensaje = 'Registro eliminado correctamente';
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllParqueo
AS
BEGIN
    SELECT
        ParqueoId AS 'Codigo',
        CapacidadTotal
    FROM Parqueo;
END;

-- 5) SP SEARCH BY
GO
CREATE OR ALTER PROCEDURE spBusquedaParqueo
    @busqueda VARCHAR(200)
AS
BEGIN
    SELECT
        ParqueoId AS 'Codigo',
        CapacidadTotal
    FROM Parqueo
    WHERE CAST(CapacidadTotal AS VARCHAR) LIKE '%' + @busqueda + '%';
END;