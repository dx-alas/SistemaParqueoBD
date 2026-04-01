--TABLA: Ticket

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertTicket
	@Fecha DATE,
	@HoraEntrada TIME,
	@HoraSalida TIME = NULL,
	@Total DECIMAL(10,2),
	@VehiculoId INT,
	@TarjetaId INT,
	@CorteId INT,
	@EstadoTicketId INT,
	@UsuarioAutorizaId INT,
	@UsuarioId INT,
	@MultaId INT = NULL,
	@EstadoPermanenciaId INT
AS
BEGIN
	INSERT INTO Ticket
        (Fecha, HoraEntrada, HoraSalida, Total, VehiculoId, TarjetaId, CorteId, EstadoTicketId, UsuarioAutorizaId, UsuarioId, MultaId, EstadoPermanenciaId)
	VALUES 
        (@Fecha, @HoraEntrada, @HoraSalida, @Total, @VehiculoId, @TarjetaId, @CorteId, @EstadoTicketId, @UsuarioAutorizaId, @UsuarioId, @MultaId, @EstadoPermanenciaId);
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateTicket
	@Id INT,
	@Fecha DATE,
	@HoraEntrada TIME,
	@HoraSalida TIME,
	@Total DECIMAL(10,2),
	@VehiculoId INT,
	@TarjetaId INT,
	@CorteId INT,
	@EstadoTicketId INT,
	@UsuarioAutorizaId INT,
	@UsuarioId INT,
	@MultaId INT,
	@EstadoPermanenciaId INT
AS
BEGIN
	UPDATE Ticket
	SET Fecha = @Fecha,
		HoraEntrada = @HoraEntrada,
		HoraSalida = @HoraSalida,
		Total = @Total,
		VehiculoId = @VehiculoId,
		TarjetaId = @TarjetaId,
		CorteId = @CorteId,
		EstadoTicketId = @EstadoTicketId,
		UsuarioAutorizaId = @UsuarioAutorizaId,
		UsuarioId = @UsuarioId,
		MultaId = @MultaId,
		EstadoPermanenciaId = @EstadoPermanenciaId
	WHERE TicketId = @Id;
END;

-- 3) SP DELETE
GO
CREATE OR ALTER PROCEDURE spDeleteTicket
	@Id INT
AS
BEGIN
	DELETE FROM Ticket
	WHERE TicketId = @Id;
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllTicket
AS
BEGIN
	SELECT
		t.TicketId AS 'Codigo',
		t.Fecha,
		t.HoraEntrada,
		t.HoraSalida,
		t.Total,
		t.TarjetaId,
		t.CorteId,
		t.MultaId,
		v.Placa,
		u.Nombre AS 'Usuario',
		e.EstadoTicket,
		ep.Estado AS 'EstadoPermanencia'
	FROM Ticket t
	INNER JOIN Vehiculo v ON t.VehiculoId = v.VehiculoId
	INNER JOIN Usuario u ON t.UsuarioId = u.UsuarioId
	INNER JOIN EstadoTicket e ON t.EstadoTicketId = e.EstadoTicketId
	INNER JOIN EstadoPermanencia ep ON t.EstadoPermanenciaId = ep.EstadoPermanenciaId
	ORDER BY t.Fecha DESC;
END;

-- 5) SP SEARCH BY
GO
CREATE OR ALTER PROCEDURE spBusquedaTicket
	@busqueda VARCHAR(200)
AS
BEGIN
	SELECT
		t.TicketId AS 'Codigo',
		t.Fecha,
		t.HoraEntrada,
		t.HoraSalida,
		t.Total,
		t.TarjetaId,
		t.CorteId,
		t.MultaId,
		v.Placa,
		u.Nombre AS 'Usuario',
		e.EstadoTicket,
		ep.Estado AS 'EstadoPermanencia'
	FROM Ticket t
	INNER JOIN Vehiculo v ON t.VehiculoId = v.VehiculoId
	INNER JOIN Usuario u ON t.UsuarioId = u.UsuarioId
	INNER JOIN EstadoTicket e ON t.EstadoTicketId = e.EstadoTicketId
	INNER JOIN EstadoPermanencia ep ON t.EstadoPermanenciaId = ep.EstadoPermanenciaId
	WHERE v.Placa LIKE '%' + @busqueda + '%'
	ORDER BY t.Fecha DESC;
END;