--TABLA: Cliente (NECESITA ELIMINACION LOGICA)

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertCliente
	@Nombre VARCHAR(50),
	@Apellido VARCHAR(50),
	@Telefono VARCHAR(20),
	@DUI VARCHAR(10),
	@TarjetaId INT,
	@TipoClienteId INT
AS
BEGIN
	IF EXISTS (SELECT * FROM Cliente WHERE DUI = @DUI)
	BEGIN
		PRINT 'El cliente que intenta registrar ya existe en la base de datos';
	END
	ELSE
	BEGIN
		INSERT INTO Cliente(Nombre, Apellido, Telefono, DUI, TarjetaId, TipoClienteId)
		VALUES (@Nombre, @Apellido, @Telefono, @DUI, @TarjetaId, @TipoClienteId);
	END
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateCliente
	@Id INT,
	@Nombre VARCHAR(50),
	@Apellido VARCHAR(50),
	@Telefono VARCHAR(20),
	@DUI VARCHAR(10),
	@TarjetaId INT,
	@TipoClienteId INT
AS
BEGIN
	IF EXISTS (SELECT * FROM Cliente WHERE DUI = @DUI AND ClienteId <> @Id)
	BEGIN
		PRINT 'El DUI ya existe en la base de datos';
	END
	ELSE
	BEGIN
		UPDATE Cliente
		SET Nombre = @Nombre,
			Apellido = @Apellido,
			Telefono = @Telefono,
			DUI = @DUI,
			TarjetaId = @TarjetaId,
			TipoClienteId = @TipoClienteId
		WHERE ClienteId = @Id;
	END
END;

-- 3) SP DELETE (física, no hay estado)
GO
CREATE OR ALTER PROCEDURE spDeleteCliente
	@Id INT
AS
BEGIN
	DELETE FROM Cliente
	WHERE ClienteId = @Id;
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
		c.DUI,
		t.TipoCliente,
		c.TarjetaId
	FROM Cliente c
	INNER JOIN TipoCliente t ON c.TipoClienteId = t.TipoClienteId
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
		c.DUI,
		t.TipoCliente,
		c.TarjetaId
	FROM Cliente c
	INNER JOIN TipoCliente t ON c.TipoClienteId = t.TipoClienteId
	WHERE c.Nombre LIKE '%' + @busqueda + '%'
	ORDER BY c.Nombre ASC;
END;