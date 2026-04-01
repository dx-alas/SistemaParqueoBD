--TABLA: Vehiculo

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertVehiculo
	@ClienteId INT,
	@Placa VARCHAR(20),
	@TipoVehiculoId INT
AS
BEGIN
	IF EXISTS (SELECT * FROM Vehiculo WHERE Placa = @Placa)
	BEGIN
		PRINT 'El vehiculo que intenta registrar ya existe en la base de datos';
	END
	ELSE
	BEGIN
		INSERT INTO Vehiculo(ClienteId, Placa, TipoVehiculoId)
		VALUES (@ClienteId, @Placa, @TipoVehiculoId);
	END
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateVehiculo
	@Id INT,
	@ClienteId INT,
	@Placa VARCHAR(20),
	@TipoVehiculoId INT
AS
BEGIN
	IF EXISTS (SELECT * FROM Vehiculo WHERE Placa = @Placa AND VehiculoId <> @Id)
	BEGIN
		PRINT 'La placa ya existe en la base de datos';
	END
	ELSE
	BEGIN
		UPDATE Vehiculo
		SET ClienteId = @ClienteId,
			Placa = @Placa,
			TipoVehiculoId = @TipoVehiculoId
		WHERE VehiculoId = @Id;
	END
END;

-- 3) SP DELETE
GO
CREATE OR ALTER PROCEDURE spDeleteVehiculo
	@Id INT
AS
BEGIN
	DELETE FROM Vehiculo
	WHERE VehiculoId = @Id;
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllVehiculo
AS
BEGIN
	SELECT
		v.VehiculoId AS 'Codigo',
		c.Nombre AS 'Cliente',
		v.Placa,
		t.Tipo
	FROM Vehiculo v
	INNER JOIN Cliente c ON v.ClienteId = c.ClienteId
	INNER JOIN TipoVehiculo t ON v.TipoVehiculoId = t.TipoVehiculoId
	ORDER BY v.Placa ASC;
END;

-- 5) SP SEARCH BY
GO
CREATE OR ALTER PROCEDURE spBusquedaVehiculo
	@busqueda VARCHAR(200)
AS
BEGIN
	SELECT
		v.VehiculoId AS 'Codigo',
		c.Nombre AS 'Cliente',
		v.Placa,
		t.Tipo
	FROM Vehiculo v
	INNER JOIN Cliente c ON v.ClienteId = c.ClienteId
	INNER JOIN TipoVehiculo t ON v.TipoVehiculoId = t.TipoVehiculoId
	WHERE v.Placa LIKE '%' + @busqueda + '%'
	ORDER BY v.Placa ASC;
END;