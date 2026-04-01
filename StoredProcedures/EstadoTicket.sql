--TABLA: EstadoTicket

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertEstadoTicket
	@Nombre VARCHAR(50)
AS
BEGIN
	IF EXISTS (SELECT * FROM EstadoTicket WHERE Nombre = @Nombre)
	BEGIN
		PRINT 'El Estado de ticket que intenta registrar ya existe en la base de datos';
	END
	ELSE
	BEGIN
		INSERT INTO EstadoTicket(Nombre)
		VALUES (@Nombre);
	END
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateEstadoTicket
	@EstadoTicketId INT,
	@Nombre VARCHAR(50)
AS
BEGIN
	IF EXISTS (SELECT * FROM EstadoTicket WHERE Nombre = @Nombre AND EstadoTicketId <> @EstadoTicketId)
	BEGIN
		PRINT 'El Estado de ticket ya existe en la base de datos';
	END
	ELSE
	BEGIN
		UPDATE EstadoTicket
		SET Nombre = @Nombre
		WHERE EstadoTicketId = @EstadoTicketId;
	END
END;

-- 3) SP DELETE
GO
CREATE OR ALTER PROCEDURE spDeleteEstadoTicket
	@EstadoTicketId INT
AS
BEGIN
	DELETE FROM EstadoTicket
	WHERE EstadoTicketId = @EstadoTicketId;
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllEstadoTicket
AS
BEGIN
	SELECT 
		EstadoTicketId AS 'Codigo',
		Nombre AS 'Nombre'
	FROM EstadoTicket
	ORDER BY Nombre ASC;
END;

-- 5) SP SEARCH BY
GO
CREATE OR ALTER PROCEDURE spBusquedaEstadoTicket
	@busqueda VARCHAR(200)
AS
BEGIN
	SELECT
		EstadoTicketId AS 'Codigo',
		Nombre AS 'Nombre'
	FROM EstadoTicket
	WHERE Nombre LIKE '%' + @busqueda + '%'
	ORDER BY Nombre ASC;
END;