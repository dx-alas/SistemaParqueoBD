-- TABLA: EstadoCorte

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertEstadoCorte
    @Nombre VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM EstadoCorte WHERE Nombre = @Nombre)
        BEGIN
            PRINT 'El estado de corte que intenta registrar ya existe en la base de datos';
        END
    ELSE
        BEGIN
            INSERT INTO EstadoCorte(Nombre)
            VALUES (@Nombre);

            PRINT 'Registro insertado correctamente';
        END
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateEstadoCorte
    @EstadoCorteId INT,
    @Nombre VARCHAR(50)
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM EstadoCorte 
        WHERE Nombre = @Nombre 
        AND EstadoCorteId <> @EstadoCorteId
    )
        BEGIN
            PRINT 'El estado de corte ya existe en la base de datos';
        END
    ELSE
        BEGIN
            UPDATE EstadoCorte
            SET Nombre = @Nombre
            WHERE EstadoCorteId = @EstadoCorteId;

            PRINT 'Registro actualizado correctamente';
        END
END;

-- 3) SP DELETE
GO
CREATE OR ALTER PROCEDURE spDeleteEstadoCorte
    @EstadoCorteId INT
AS
BEGIN
    DELETE FROM EstadoCorte
    WHERE EstadoCorteId = @EstadoCorteId;

    PRINT 'Registro eliminado correctamente';
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllEstadoCorte
AS
BEGIN
    SELECT
        EstadoCorteId,
        Nombre
    FROM EstadoCorte
    ORDER BY EstadoCorteId DESC;
END;

-- 5) SP SELECT BY ID
GO
CREATE OR ALTER PROCEDURE spSelectEstadoCorteById
    @EstadoCorteId INT
AS
BEGIN
    SELECT
        EstadoCorteId,
        Nombre
    FROM EstadoCorte
    WHERE EstadoCorteId = @EstadoCorteId;
END;