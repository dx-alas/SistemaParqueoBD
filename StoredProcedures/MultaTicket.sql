-- TABLA: MultaTicket

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertMultaTicket
    @Concepto VARCHAR(100),
    @Precio DECIMAL(10,2)
AS
BEGIN
    INSERT INTO MultaTicket(Concepto, Precio)
    VALUES (@Concepto, @Precio);

    PRINT 'Registro insertado correctamente';
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateMultaTicket
    @MultaId INT,
    @Concepto VARCHAR(100),
    @Precio DECIMAL(10,2)
AS
BEGIN
    UPDATE MultaTicket
    SET Concepto = @Concepto,
        Precio = @Precio
    WHERE MultaId = @MultaId;

    PRINT 'Registro actualizado correctamente';
END;

-- 3) SP DELETE
GO
CREATE OR ALTER PROCEDURE spDeleteMultaTicket
    @MultaId INT
AS
BEGIN
    DELETE FROM MultaTicket
    WHERE MultaId = @MultaId;

    PRINT 'Registro eliminado correctamente';
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