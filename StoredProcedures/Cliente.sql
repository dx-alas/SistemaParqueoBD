-- TABLA: Cliente (NECESITA ELIMINACION LOGICA)

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertCliente
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Telefono VARCHAR(20),
    @TipoDocumento VARCHAR(20),
    @DUI VARCHAR(9),
    @CarnetExtranjero VARCHAR(20),
    @TarjetaId INT,
    @TipoClienteId INT,
    @EstadoClienteId INT = 1,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    -- Validaciones críticas
    IF NOT EXISTS (SELECT 1 FROM Tarjeta WHERE TarjetaId = @TarjetaId)
        BEGIN
            SET @Mensaje = 'La tarjeta seleccionada no existe';
            RETURN;
        END

    IF NOT EXISTS (SELECT 1 FROM TipoCliente WHERE TipoClienteId = @TipoClienteId)
        BEGIN
            SET @Mensaje = 'El tipo de cliente no existe';
            RETURN;
        END

    IF NOT EXISTS (SELECT 1 FROM EstadoCliente WHERE EstadoClienteId = @EstadoClienteId)
        BEGIN
            SET @Mensaje = 'El estado de cliente no existe';
            RETURN;
        END

    -- Validación tipo documento
    IF @TipoDocumento = 'DUI' AND @DUI IS NULL
        BEGIN
            SET @Mensaje = 'Debe ingresar un DUI';
            RETURN;
        END

    IF @TipoDocumento = 'CR' AND @CarnetExtranjero IS NULL
        BEGIN
            SET @Mensaje = 'Debe ingresar un carnet de residente';
            RETURN;
        END

    -- Validación original
    IF EXISTS (SELECT 1 FROM Cliente WHERE DUI = @DUI)
        BEGIN
            SET @Mensaje = 'El cliente que intenta registrar ya existe en la base de datos';
        END
    ELSE
        BEGIN
            INSERT INTO Cliente(Nombre, Apellido, Telefono, TipoDocumento, DUI, CarnetExtranjero, TarjetaId, TipoClienteId, EstadoClienteId)
            VALUES (@Nombre, @Apellido, @Telefono, @TipoDocumento, @DUI, @CarnetExtranjero, @TarjetaId, @TipoClienteId, @EstadoClienteId);

            SET @Mensaje = 'Registro insertado correctamente';
        END
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateCliente
    @Id INT,
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Telefono VARCHAR(20),
    @TipoDocumento VARCHAR(20),
    @DUI VARCHAR(9),
    @CarnetExtranjero VARCHAR(20),
    @TarjetaId INT,
    @TipoClienteId INT,
    @EstadoClienteId INT,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    -- Validaciones críticas
    IF NOT EXISTS (SELECT 1 FROM Cliente WHERE ClienteId = @Id)
        BEGIN
            SET @Mensaje = 'El cliente que intenta actualizar no existe';
            RETURN;
        END

    IF NOT EXISTS (SELECT 1 FROM Tarjeta WHERE TarjetaId = @TarjetaId)
        BEGIN
            SET @Mensaje = 'La tarjeta seleccionada no existe';
            RETURN;
        END

    IF NOT EXISTS (SELECT 1 FROM TipoCliente WHERE TipoClienteId = @TipoClienteId)
        BEGIN
            SET @Mensaje = 'El tipo de cliente no existe';
            RETURN;
        END

    IF NOT EXISTS (SELECT 1 FROM EstadoCliente WHERE EstadoClienteId = @EstadoClienteId)
        BEGIN
            SET @Mensaje = 'El estado de cliente no existe';
            RETURN;
        END

    -- Validación original
    IF EXISTS (SELECT 1 FROM Cliente WHERE DUI = @DUI AND ClienteId <> @Id)
        BEGIN
            SET @Mensaje = 'El DUI ya existe en la base de datos';
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
            WHERE ClienteId = @Id;

            SET @Mensaje = 'Registro actualizado correctamente';
        END
END;

-- 3) SP DELETE (lógica)
GO
CREATE OR ALTER PROCEDURE spDeleteCliente
    @Id INT,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Cliente WHERE ClienteId = @Id)
        BEGIN
            SET @Mensaje = 'El cliente que intenta eliminar no existe';
            RETURN;
        END

    UPDATE Cliente
    SET EstadoClienteId = 2
    WHERE ClienteId = @Id;

    SET @Mensaje = 'Cliente eliminado correctamente';
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllCliente
AS
BEGIN
    SELECT 
        c.ClienteId AS 'Codigo',
        c.Nombre,
        c.Apellido,
        c.Telefono,
        c.TipoDocumento,
        c.DUI,
        c.CarnetExtranjero,
        t.Nombre AS 'TipoCliente',
        c.TarjetaId,
        e.Nombre AS 'EstadoCliente'
    FROM Cliente c
    INNER JOIN TipoCliente t ON c.TipoClienteId = t.TipoClienteId
    INNER JOIN EstadoCliente e ON c.EstadoClienteId = e.EstadoClienteId
    WHERE c.EstadoClienteId = 1
    ORDER BY c.Nombre ASC;
END;

-- 5) SP SEARCH BY
GO
CREATE OR ALTER PROCEDURE spBusquedaCliente
    @busqueda VARCHAR(200)
AS
BEGIN
    SELECT
        c.ClienteId AS 'Codigo',
        c.Nombre,
        c.Apellido,
        c.Telefono,
        c.TipoDocumento,
        c.DUI,
        c.CarnetExtranjero,
        t.Nombre AS 'TipoCliente',
        c.TarjetaId,
        e.Nombre AS 'EstadoCliente'
    FROM Cliente c
    INNER JOIN TipoCliente t ON c.TipoClienteId = t.TipoClienteId
    INNER JOIN EstadoCliente e ON c.EstadoClienteId = e.EstadoClienteId
    WHERE c.EstadoClienteId = 1
      AND (c.Nombre LIKE '%' + @busqueda + '%'
       OR c.Apellido LIKE '%' + @busqueda + '%'
       OR c.DUI LIKE '%' + @busqueda + '%')
    ORDER BY c.Nombre ASC;
END;