-- TABLA: CorteCaja

-- 1) SP INSERT (APERTURA)
GO
CREATE OR ALTER PROCEDURE spInsertCorteCaja
    @Fecha DATE,
    @HoraInicio TIME,
    @MontoInicial DECIMAL(10,2),
    @ObservacionInicial VARCHAR(255),
    @UsuarioAperturaId INT
AS
BEGIN
    -- Validar que no exista un corte abierto
    IF EXISTS (SELECT 1 FROM CorteCaja WHERE EstadoCorteId = 1)
    BEGIN
        PRINT 'Ya existe un corte de caja abierto';
        RETURN;
    END

    INSERT INTO CorteCaja
        (Fecha, HoraInicio, MontoInicial, ObservacionInicial, UsuarioAperturaId, EstadoCorteId)
    VALUES 
        (@Fecha, @HoraInicio, @MontoInicial, @ObservacionInicial, @UsuarioAperturaId, 1);

    PRINT 'Corte de caja abierto correctamente';

    SELECT SCOPE_IDENTITY() AS CorteId;
END;

-- 2) SP UPDATE (CIERRE)
GO
CREATE OR ALTER PROCEDURE spUpdateCorteCaja
    @CorteId INT,
    @HoraEntrega TIME,
    @MontoTotal DECIMAL(10,2),
    @ObservacionFinal VARCHAR(255),
    @UsuarioCierreId INT
AS
BEGIN
    -- Validar que esté abierto
    IF NOT EXISTS (SELECT 1 FROM CorteCaja WHERE CorteId = @CorteId AND EstadoCorteId = 1)
    BEGIN
        PRINT 'El corte ya está cerrado o no existe';
        RETURN;
    END

    UPDATE CorteCaja
    SET 
        HoraEntrega = @HoraEntrega,
        MontoTotal = @MontoTotal,
        ObservacionFinal = @ObservacionFinal,
        UsuarioCierreId = @UsuarioCierreId,
        EstadoCorteId = 2
    WHERE CorteId = @CorteId;

    PRINT 'Corte de caja cerrado correctamente';
END;

-- 3) SP DELETE
GO
CREATE OR ALTER PROCEDURE spDeleteCorteCaja
    @CorteId INT
AS
BEGIN
    PRINT 'No se permite eliminar cortes de caja';
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllCorteCaja
AS
BEGIN
    SELECT
        CorteId,
        Fecha,
        HoraInicio,
        HoraEntrega,
        MontoInicial,
        MontoTotal,
        ObservacionInicial,
        ObservacionFinal,
        UsuarioAperturaId,
        UsuarioCierreId,
        EstadoCorteId
    FROM CorteCaja
    WHERE EstadoCorteId <> 3 -- opcional: excluir ANULADOS
    ORDER BY Fecha DESC, HoraInicio DESC;
END;

-- 5) SP SELECT BY ID
GO
CREATE OR ALTER PROCEDURE spSelectCorteCajaById
    @CorteId INT
AS
BEGIN
    SELECT
        CorteId,
        Fecha,
        HoraInicio,
        HoraEntrega,
        MontoInicial,
        MontoTotal,
        ObservacionInicial,
        ObservacionFinal,
        UsuarioAperturaId,
        UsuarioCierreId,
        EstadoCorteId
    FROM CorteCaja
    WHERE CorteId = @CorteId;
END;

GO
CREATE OR ALTER PROCEDURE spGetCorteCajaActivo
AS
BEGIN
    SELECT TOP 1
        CorteId,
        Fecha,
        HoraInicio,
        HoraEntrega,
        MontoInicial,
        MontoTotal,
        ObservacionInicial,
        ObservacionFinal,
        UsuarioAperturaId,
        UsuarioCierreId,
        EstadoCorteId
    FROM CorteCaja
    WHERE EstadoCorteId = 1;
END;