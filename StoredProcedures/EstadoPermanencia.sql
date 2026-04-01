--TABLA: EstadoPermanencia

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertEstadoPermanencia
	@Estado VARCHAR(50)
AS
BEGIN
	INSERT INTO EstadoPermanencia(Estado)
	VALUES (@Estado);
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateEstadoPermanencia
	@Id INT,
	@Estado VARCHAR(50)
AS
BEGIN
	UPDATE EstadoPermanencia
	SET Estado = @Estado
	WHERE EstadoPermanenciaId = @Id;
END;

-- 3) SP DELETE
GO
CREATE OR ALTER PROCEDURE spDeleteEstadoPermanencia
	@Id INT
AS
BEGIN
	DELETE FROM EstadoPermanencia
	WHERE EstadoPermanenciaId = @Id;
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