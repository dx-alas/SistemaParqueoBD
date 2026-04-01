--TABLA: Tarjeta 

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertTarjeta
	@Codigo VARCHAR(50),
	@EstadoTarjetaId INT
AS
BEGIN
	IF EXISTS (SELECT * FROM Tarjeta WHERE Codigo = @Codigo)
	BEGIN
		PRINT 'La tarjeta que intenta registrar ya existe en la base de datos';
	END
	ELSE
	BEGIN
		INSERT INTO Tarjeta(Codigo, EstadoTarjetaId)
		VALUES (@Codigo, @EstadoTarjetaId);
	END
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateTarjeta
	@Id INT,
	@Codigo VARCHAR(50),
	@EstadoTarjetaId INT
AS
BEGIN
	IF EXISTS (SELECT * FROM Tarjeta WHERE Codigo = @Codigo AND TarjetaId <> @Id)
	BEGIN
		PRINT 'El codigo de tarjeta ya existe en la base de datos';
	END
	ELSE
	BEGIN
		UPDATE Tarjeta
		SET Codigo = @Codigo,
			EstadoTarjetaId = @EstadoTarjetaId
		WHERE TarjetaId = @Id;
	END
END;

-- 3) SP DELETE (Eliminación lógica)
GO
CREATE OR ALTER PROCEDURE spDeleteTarjeta
	@Id INT
AS
BEGIN
	UPDATE Tarjeta
	SET EstadoTarjetaId = 2
	WHERE TarjetaId = @Id;
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllTarjeta
AS
BEGIN
	SELECT
		t.TarjetaId AS 'Codigo',
		t.Codigo,
		t.EstadoTarjetaId,  
		e.EstadoTarjeta
	FROM Tarjeta t
	INNER JOIN EstadoTarjeta e 
		ON t.EstadoTarjetaId = e.EstadoTarjetaId
	ORDER BY t.Codigo ASC;
END;

-- 5) SP SEARCH BY
GO
CREATE OR ALTER PROCEDURE spBusquedaTarjeta
	@busqueda VARCHAR(200)
AS
BEGIN
	SELECT
		t.TarjetaId AS 'Codigo',
		t.Codigo,
		t.EstadoTarjetaId,     
		e.EstadoTarjeta
	FROM Tarjeta t
	INNER JOIN EstadoTarjeta e 
		ON t.EstadoTarjetaId = e.EstadoTarjetaId
	WHERE t.Codigo LIKE '%' + @busqueda + '%'
	ORDER BY t.Codigo ASC;
END;