--TABLA: CorteCaja

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertCorteCaja
	@Fecha DATE,
	@HoraInicio TIME,
	@HoraEntrega TIME,
	@MontoInicial DECIMAL(10,2),
	@MontoTotal DECIMAL(10,2),
	@ObservacionInicial VARCHAR(250),
	@ObservacionFinal VARCHAR(250),
	@UsuarioId INT
AS
BEGIN
	INSERT INTO CorteCaja(Fecha, HoraInicio, HoraEntrega, MontoInicial, MontoTotal, ObservacionInicial, ObservacionFinal, UsuarioId)
	VALUES (@Fecha, @HoraInicio, @HoraEntrega, @MontoInicial, @MontoTotal, @ObservacionInicial, @ObservacionFinal, @UsuarioId);
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateCorteCaja
	@Id INT,
	@Fecha DATE,
	@HoraInicio TIME,
	@HoraEntrega TIME,
	@MontoInicial DECIMAL(10,2),
	@MontoTotal DECIMAL(10,2),
	@ObservacionInicial VARCHAR(250),
	@ObservacionFinal VARCHAR(250),
	@UsuarioId INT
AS
BEGIN
	UPDATE CorteCaja
	SET Fecha = @Fecha,
		HoraInicio = @HoraInicio,
		HoraEntrega = @HoraEntrega,
		MontoInicial = @MontoInicial,
		MontoTotal = @MontoTotal,
		ObservacionInicial = @ObservacionInicial,
		ObservacionFinal = @ObservacionFinal,
		UsuarioId = @UsuarioId
	WHERE CorteId = @Id;
END;

-- 3) SP DELETE
GO
CREATE OR ALTER PROCEDURE spDeleteCorteCaja
	@Id INT
AS
BEGIN
	DELETE FROM CorteCaja
	WHERE CorteId = @Id;
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllCorteCaja
AS
BEGIN
	SELECT
		c.CorteId AS 'Codigo',
		c.Fecha,
		c.HoraInicio,
		c.HoraEntrega,
		c.MontoInicial,
		c.MontoTotal,
		c.ObservacionInicial,
		c.ObservacionFinal,
		u.Nombre AS 'Usuario'
	FROM CorteCaja c
	INNER JOIN Usuario u ON c.UsuarioId = u.UsuarioId
	ORDER BY c.Fecha DESC;
END;

-- 5) SP SEARCH BY
GO
CREATE OR ALTER PROCEDURE spBusquedaCorteCaja
	@busqueda VARCHAR(200)
AS
BEGIN
	SELECT
		c.CorteId AS 'Codigo',
		c.Fecha,
		c.HoraInicio,
		c.HoraEntrega,
		c.MontoInicial,
		c.MontoTotal,
		c.ObservacionInicial,
		c.ObservacionFinal,
		u.Nombre AS 'Usuario'
	FROM CorteCaja c
	INNER JOIN Usuario u ON c.UsuarioId = u.UsuarioId
	WHERE u.Nombre LIKE '%' + @busqueda + '%'
	ORDER BY c.Fecha DESC;
END;
