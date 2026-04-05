-- TABLA: CorteCaja

-- 1) SP INSERT (APERTURA)
GO
CREATE OR ALTER PROCEDURE spInsertCorteCaja
    @Fecha DATE,
    @HoraInicio TIME,
    @MontoInicial DECIMAL(10,2),
    @ObservacionInicial VARCHAR(255),
    @UsuarioAperturaId INT,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Usuario WHERE UsuarioId = @UsuarioAperturaId)
        BEGIN
            SET @Mensaje = 'El usuario de apertura no existe';
            RETURN;
        END

    INSERT INTO CorteCaja(Fecha, HoraInicio, MontoInicial, ObservacionInicial, UsuarioAperturaId)
    VALUES (@Fecha, @HoraInicio, @MontoInicial, @ObservacionInicial, @UsuarioAperturaId);

    SET @Mensaje = 'Corte de caja abierto correctamente';
END;

-- 2) SP UPDATE (CIERRE)
GO
CREATE OR ALTER PROCEDURE spUpdateCorteCaja
    @Id INT,
    @HoraEntrega TIME,
    @MontoTotal DECIMAL(10,2),
    @ObservacionFinal VARCHAR(255),
    @UsuarioCierreId INT,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM CorteCaja WHERE CorteId = @Id)
        BEGIN
            SET @Mensaje = 'El corte de caja no existe';
            RETURN;
        END

    IF NOT EXISTS (SELECT 1 FROM Usuario WHERE UsuarioId = @UsuarioCierreId)
        BEGIN
            SET @Mensaje = 'El usuario de cierre no existe';
            RETURN;
        END

    -- Validar que no esté ya cerrado
    IF EXISTS (SELECT 1 FROM CorteCaja WHERE CorteId = @Id AND UsuarioCierreId IS NOT NULL)
        BEGIN
            SET @Mensaje = 'El corte de caja ya fue cerrado';
            RETURN;
        END

    UPDATE CorteCaja
    SET HoraEntrega = @HoraEntrega,
        MontoTotal = @MontoTotal,
        ObservacionFinal = @ObservacionFinal,
        UsuarioCierreId = @UsuarioCierreId
    WHERE CorteId = @Id;

    SET @Mensaje = 'Corte de caja cerrado correctamente';
END;

-- 3) SP DELETE
GO
CREATE OR ALTER PROCEDURE spDeleteCorteCaja
    @Id INT,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    SET @Mensaje = 'No se permite eliminar cortes de caja';
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
        ua.Nombre AS 'UsuarioApertura',
        uc.Nombre AS 'UsuarioCierre'
    FROM CorteCaja c
    INNER JOIN Usuario ua ON c.UsuarioAperturaId = ua.UsuarioId
    LEFT JOIN Usuario uc ON c.UsuarioCierreId = uc.UsuarioId
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
        ua.Nombre AS 'UsuarioApertura',
        uc.Nombre AS 'UsuarioCierre'
    FROM CorteCaja c
    INNER JOIN Usuario ua ON c.UsuarioAperturaId = ua.UsuarioId
    LEFT JOIN Usuario uc ON c.UsuarioCierreId = uc.UsuarioId
    WHERE ua.Nombre LIKE '%' + @busqueda + '%'
    ORDER BY c.Fecha DESC;
END;