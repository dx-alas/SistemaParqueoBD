-- TABLA: Cliente (NECESITA ELIMINACION LOGICA)

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertCliente
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Telefono VARCHAR(20),
    @TipoDocumento VARCHAR(20),
    @DUI VARCHAR(10),
    @CarnetExtranjero VARCHAR(20),
    @TarjetaId INT,
    @TipoClienteId INT,
    @EstadoClienteId INT = 1
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Cliente WHERE DUI = @DUI)
        BEGIN
            PRINT 'El cliente que intenta registrar ya existe en la base de datos';
        END
    ELSE
        BEGIN
            INSERT INTO Cliente(Nombre, Apellido, Telefono, TipoDocumento, DUI, CarnetExtranjero, TarjetaId, TipoClienteId, EstadoClienteId)
            VALUES (@Nombre, @Apellido, @Telefono, @TipoDocumento, @DUI, @CarnetExtranjero, @TarjetaId, @TipoClienteId, @EstadoClienteId);

            PRINT 'Registro insertado correctamente';
        END
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateCliente
    @ClienteId INT,
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Telefono VARCHAR(20),
    @TipoDocumento VARCHAR(20),
    @DUI VARCHAR(10),
    @CarnetExtranjero VARCHAR(20),
    @TarjetaId INT,
    @TipoClienteId INT,
    @EstadoClienteId INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Cliente WHERE DUI = @DUI AND ClienteId <> @ClienteId)
        BEGIN
            PRINT 'El DUI ya existe en la base de datos';
        END
    ELSE
        BEGIN
            UPDATE Cliente
            SET Nombre = @Nombre,
                Apellido = @Apellido,
                Telefono = @Telefono,
                TipoDocumento = @TipoDocumento,
                DUI = @DUI,
                CarnetExtranjero = @CarnetExtranjero,
                TarjetaId = @TarjetaId,
                TipoClienteId = @TipoClienteId,
                EstadoClienteId = @EstadoClienteId
            WHERE ClienteId = @ClienteId;

            PRINT 'Registro actualizado correctamente';
        END
END;

-- 3) SP DELETE (lógica)
GO
CREATE OR ALTER PROCEDURE spDeleteCliente
    @ClienteId INT
AS
BEGIN
    UPDATE Cliente
    SET EstadoClienteId = 2
    WHERE ClienteId = @ClienteId;

    PRINT 'Cliente eliminado correctamente';
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllCliente
AS
BEGIN
    SELECT 
        ClienteId,
        Nombre,
        Apellido,
        Telefono,
        TipoDocumento,
        DUI,
        CarnetExtranjero,
        TarjetaId,
        TipoClienteId,
        EstadoClienteId
    FROM Cliente
    ORDER BY ClienteId DESC
END;

-- 5) SP SELECT BY
GO
CREATE OR ALTER PROCEDURE spSelectClienteById
    @ClienteId INT
AS
BEGIN
    SELECT 
        ClienteId,
        Nombre,
        Apellido,
        Telefono,
        TipoDocumento,
        DUI,
        CarnetExtranjero,
        TarjetaId,
        TipoClienteId,
        EstadoClienteId
    FROM Cliente
    WHERE ClienteId = @ClienteId;
END;