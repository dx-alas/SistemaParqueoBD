-- TABLA: EstadoPermanencia

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertEstadoPermanencia
    @Nombre VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM EstadoPermanencia WHERE Nombre = @Nombre)
        BEGIN
            PRINT 'El estado de permanencia que intenta registrar ya existe en la base de datos';
        END
    ELSE
        BEGIN
            INSERT INTO EstadoPermanencia(Nombre)
            VALUES (@Nombre);

            PRINT 'Registro insertado correctamente';
        END
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateEstadoPermanencia
    @EstadoPermanenciaId INT,
    @Nombre VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM EstadoPermanencia WHERE Nombre = @Nombre AND EstadoPermanenciaId <> @EstadoPermanenciaId)
        BEGIN
            PRINT 'El estado de permanencia ya existe en la base de datos';
        END
    ELSE
        BEGIN
            UPDATE EstadoPermanencia
            SET Nombre = @Nombre
            WHERE EstadoPermanenciaId = @EstadoPermanenciaId;

            PRINT 'Registro actualizado correctamente';
        END
END;

-- 3) SP DELETE
GO
CREATE OR ALTER PROCEDURE spDeleteEstadoPermanencia
    @EstadoPermanenciaId INT
AS
BEGIN
    DELETE FROM EstadoPermanencia
    WHERE EstadoPermanenciaId = @EstadoPermanenciaId;

    PRINT 'Registro eliminado correctamente';
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllEstadoPermanencia
AS
BEGIN
    SELECT
        EstadoPermanenciaId,
        Nombre
    FROM EstadoPermanencia
    ORDER BY EstadoPermanenciaId DESC
END;

-- 5) SP SELECT BY
GO
CREATE OR ALTER PROCEDURE spSelectEstadoPermanenciaById
    @EstadoPermanenciaId INT
AS
BEGIN
    SELECT
        EstadoPermanenciaId,
        Nombre
    FROM EstadoPermanencia
    WHERE EstadoPermanenciaId = @EstadoPermanenciaId;
END;