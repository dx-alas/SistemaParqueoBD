-- TABLA: EstadoPermanencia

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertEstadoPermanencia
    @Estado VARCHAR(50),
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM EstadoPermanencia WHERE Estado = @Estado)
        BEGIN
            SET @Mensaje = 'El estado de permanencia que intenta registrar ya existe en la base de datos';
        END
    ELSE
        BEGIN
            INSERT INTO EstadoPermanencia(Estado)
            VALUES (@Estado);

            SET @Mensaje = 'Registro insertado correctamente';
        END
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateEstadoPermanencia
    @Id INT,
    @Estado VARCHAR(50),
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM EstadoPermanencia WHERE EstadoPermanenciaId = @Id)
        BEGIN
            SET @Mensaje = 'El estado de permanencia que intenta actualizar no existe';
            RETURN;
        END

    IF EXISTS (SELECT 1 FROM EstadoPermanencia WHERE Estado = @Estado AND EstadoPermanenciaId <> @Id)
        BEGIN
            SET @Mensaje = 'El estado de permanencia ya existe en la base de datos';
        END
    ELSE
        BEGIN
            UPDATE EstadoPermanencia
            SET Estado = @Estado
            WHERE EstadoPermanenciaId = @Id;

            SET @Mensaje = 'Registro actualizado correctamente';
        END
END;

-- 3) SP DELETE
GO
CREATE OR ALTER PROCEDURE spDeleteEstadoPermanencia
    @Id INT,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM EstadoPermanencia WHERE EstadoPermanenciaId = @Id)
        BEGIN
            SET @Mensaje = 'El estado de permanencia que intenta eliminar no existe';
            RETURN;
        END

    DELETE FROM EstadoPermanencia
    WHERE EstadoPermanenciaId = @Id;

    SET @Mensaje = 'Registro eliminado correctamente';
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