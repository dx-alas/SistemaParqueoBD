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
    INSERT INTO CorteCaja(Fecha, HoraInicio, MontoInicial, ObservacionInicial, UsuarioAperturaId)
    VALUES (@Fecha, @HoraInicio, @MontoInicial, @ObservacionInicial, @UsuarioAperturaId);

    PRINT 'Corte de caja abierto correctamente';
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
    -- Validar que no esté ya cerrado
    IF EXISTS (SELECT 1 FROM CorteCaja WHERE CorteId = @CorteId AND UsuarioCierreId IS NOT NULL)
        BEGIN
            PRINT 'El corte de caja ya fue cerrado';
            RETURN;
        END

    UPDATE CorteCaja
    SET HoraEntrega = @HoraEntrega,
        MontoTotal = @MontoTotal,
        ObservacionFinal = @ObservacionFinal,
        UsuarioCierreId = @UsuarioCierreId
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
        UsuarioCierreId
    FROM CorteCaja
    ORDER BY Fecha DESC;
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
        UsuarioCierreId
    FROM CorteCaja
    WHERE CorteId = @CorteId;
END;