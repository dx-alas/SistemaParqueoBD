-- TABLA: MultaTicket

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertMultaTicket
    @Concepto VARCHAR(100),
    @Precio DECIMAL(10,2),
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    INSERT INTO MultaTicket(Concepto, Precio)
    VALUES (@Concepto, @Precio);

    SET @Mensaje = 'Registro insertado correctamente';
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateMultaTicket
    @Id INT,
    @Concepto VARCHAR(100),
    @Precio DECIMAL(10,2),
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM MultaTicket WHERE MultaId = @Id)
        BEGIN
            SET @Mensaje = 'La multa que intenta actualizar no existe';
            RETURN;
        END

    UPDATE MultaTicket
    SET Concepto = @Concepto,
        Precio = @Precio
    WHERE MultaId = @Id;

    SET @Mensaje = 'Registro actualizado correctamente';
END;

-- 3) SP DELETE
GO
CREATE OR ALTER PROCEDURE spDeleteMultaTicket
    @Id INT,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM MultaTicket WHERE MultaId = @Id)
        BEGIN
            SET @Mensaje = 'La multa que intenta eliminar no existe';
            RETURN;
        END

    DELETE FROM MultaTicket
    WHERE MultaId = @Id;

    SET @Mensaje = 'Registro eliminado correctamente';
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllMultaTicket
AS
BEGIN
    SELECT
        MultaId AS 'Codigo',
        Concepto,
        Precio
    FROM MultaTicket;
END;

-- 5) SP SEARCH BY
GO
CREATE OR ALTER PROCEDURE spBusquedaMultaTicket
    @busqueda VARCHAR(200)
AS
BEGIN
    SELECT
        MultaId AS 'Codigo',
        Concepto,
        Precio
    FROM MultaTicket
    WHERE Concepto LIKE '%' + @busqueda + '%';
END;