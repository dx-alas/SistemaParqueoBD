--TABLA: Ticket

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertTicket
    @Fecha DATE,
    @HoraEntrada TIME,
    @TarjetaId INT,
    @CorteId INT,
    @UsuarioId INT,
    @EstadoTicketId INT,
    @EstadoPermanenciaId INT,
    @TipoVehiculoId INT,
    @PrecioAplicado DECIMAL(10,2),
    @MultaId INT = NULL,
    @VehiculoId INT = NULL
AS
BEGIN
    INSERT INTO Ticket
        (Fecha, HoraEntrada, TarjetaId, CorteId, UsuarioId, EstadoTicketId,
         EstadoPermanenciaId, TipoVehiculoId, PrecioAplicado, MultaId, VehiculoId)
    VALUES 
        (@Fecha, @HoraEntrada, @TarjetaId, @CorteId, @UsuarioId, @EstadoTicketId,
         @EstadoPermanenciaId, @TipoVehiculoId, @PrecioAplicado, @MultaId, @VehiculoId);

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
        UsuarioId,
        EstadoTicketId,
        EstadoPermanenciaId,
        TipoVehiculoId,
        PrecioAplicado,
        MultaId,
        VehiculoId
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
        UsuarioId,
        EstadoTicketId,
        EstadoPermanenciaId,
        TipoVehiculoId,
        PrecioAplicado,
        MultaId,
        VehiculoId
    FROM Ticket
    WHERE TicketId = @TicketId;
END;

-- SP GET TICKET ACTIVO BY TARJETA
GO
CREATE OR ALTER PROCEDURE spGetTicketActivoByTarjeta
    @TarjetaId INT
AS
BEGIN
    SELECT TOP 1
        TicketId,
        Fecha,
        HoraEntrada,
        HoraSalida,
        Total,
        TarjetaId,
        CorteId,
        UsuarioId,
        EstadoTicketId,
        EstadoPermanenciaId,
        TipoVehiculoId,
        PrecioAplicado,
        MultaId,
        VehiculoId
    FROM Ticket
    WHERE TarjetaId = @TarjetaId
      AND HoraSalida IS NULL
      AND EstadoTicketId = 1
    ORDER BY TicketId DESC;
END;