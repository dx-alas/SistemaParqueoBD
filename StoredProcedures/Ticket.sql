--TABLA: Ticket

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertTicket
    @Fecha DATE,
    @HoraEntrada TIME,
    @TarjetaId INT,
    @UsuarioId INT,
    @EstadoTicketId INT,
    @EstadoPermanenciaId INT,
    @MultaId INT = NULL
AS
BEGIN
    INSERT INTO Ticket
        (Fecha, HoraEntrada, TarjetaId, UsuarioId, EstadoTicketId, EstadoPermanenciaId, MultaId)
    VALUES 
        (@Fecha, @HoraEntrada, @TarjetaId, @UsuarioId, @EstadoTicketId, @EstadoPermanenciaId, @MultaId);

    PRINT 'Registro insertado correctamente';
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateTicket
    @TicketId INT,
    @HoraSalida TIME,
    @Total DECIMAL(10,2),
    @CorteId INT,
    @EstadoTicketId INT,
    @MultaId INT,
    @EstadoPermanenciaId INT
AS
BEGIN
    UPDATE Ticket
    SET HoraSalida = @HoraSalida,
        Total = @Total,
        CorteId = @CorteId,
        EstadoTicketId = @EstadoTicketId,
        MultaId = @MultaId,
        EstadoPermanenciaId = @EstadoPermanenciaId
    WHERE TicketId = @TicketId;

    PRINT 'Registro actualizado correctamente';
END;

-- 3) SP DELETE
GO
CREATE OR ALTER PROCEDURE spDeleteTicket
    @TicketId INT
AS
BEGIN
    PRINT 'No se permite eliminar tickets';
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllTicket
AS
BEGIN
    SELECT 
        TicketId,
        Fecha,
        HoraEntrada,
        HoraSalida,
        Total,
        TarjetaId,
        CorteId,
        MultaId,
        UsuarioId,
        EstadoTicketId,
        EstadoPermanenciaId
    FROM Ticket
    ORDER BY Fecha DESC;
END;

-- 5) SP SELECT BY
GO
CREATE OR ALTER PROCEDURE spSelectTicketById
    @TicketId INT
AS
BEGIN
    SELECT 
        TicketId,
        Fecha,
        HoraEntrada,
        HoraSalida,
        Total,
        TarjetaId,
        CorteId,
        MultaId,
        UsuarioId,
        EstadoTicketId,
        EstadoPermanenciaId
    FROM Ticket
    WHERE TicketId = @TicketId;
END;