-- TABLA: EstadoPermanencia

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertEstadoPermanencia
    @Estado VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM EstadoPermanencia WHERE Estado = @Estado)
        BEGIN
            PRINT 'El estado de permanencia que intenta registrar ya existe en la base de datos';
        END
    ELSE
        BEGIN
            INSERT INTO EstadoPermanencia(Estado)
            VALUES (@Estado);

            PRINT 'Registro insertado correctamente';
        END
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateEstadoPermanencia
    @EstadoPermanenciaId INT,
    @Estado VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM EstadoPermanencia WHERE Estado = @Estado AND EstadoPermanenciaId <> @EstadoPermanenciaId)
        BEGIN
            PRINT 'El estado de permanencia ya existe en la base de datos';
        END
    ELSE
        BEGIN
            UPDATE EstadoPermanencia
            SET Estado = @Estado
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
        EstadoPermanenciaId AS 'Codigo',
        Estado
    FROM EstadoPermanencia;
END;

-- 5) SP SEARCH BY
GO
CREATE OR ALTER PROCEDURE spBusquedaEstadoPermanencia
    @busqueda VARCHAR(200)
AS
BEGIN
    SELECT
        EstadoPermanenciaId AS 'Codigo',
        Estado
    FROM EstadoPermanencia
    WHERE Estado LIKE '%' + @busqueda + '%';
END;