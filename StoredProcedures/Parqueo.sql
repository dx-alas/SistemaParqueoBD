-- TABLA: Parqueo

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertParqueo
    @CapacidadTotal INT
AS
BEGIN
    INSERT INTO Parqueo(CapacidadTotal)
    VALUES (@CapacidadTotal);

    PRINT 'Registro insertado correctamente';
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateParqueo
    @ParqueoId INT,
    @CapacidadTotal INT
AS
BEGIN
    UPDATE Parqueo
    SET CapacidadTotal = @CapacidadTotal
    WHERE ParqueoId = @ParqueoId;

    PRINT 'Registro actualizado correctamente';
END;

-- 3) SP DELETE
GO
CREATE OR ALTER PROCEDURE spDeleteParqueo
    @ParqueoId INT
AS
BEGIN
    DELETE FROM Parqueo
    WHERE ParqueoId = @ParqueoId;

    PRINT 'Registro eliminado correctamente';
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllParqueo
AS
BEGIN
    SELECT
        ParqueoId,
        CapacidadTotal
    FROM Parqueo;
END;

-- 5) SP SEARCH BY
GO
CREATE OR ALTER PROCEDURE spSelectParqueoById
    @ParqueoId INT
AS
BEGIN
    SELECT
        ParqueoId,
        CapacidadTotal
    FROM Parqueo
    WHERE ParqueoId = @ParqueoId;
END;