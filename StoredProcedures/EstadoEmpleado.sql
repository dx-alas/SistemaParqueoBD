-- TABLA: EstadoEmpleado

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertEstadoEmpleado
	@Nombre VARCHAR(50)
AS
BEGIN
	IF EXISTS (SELECT * FROM EstadoEmpleado WHERE Nombre = @Nombre)
	BEGIN
		PRINT 'El estado de empleado que intenta registrar ya existe en la base de datos';
	END
	ELSE
	BEGIN
		INSERT INTO EstadoEmpleado(Nombre)
		VALUES (@Nombre);
	END
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateEstadoEmpleado
	@EstadoEmpleadoId INT,
	@Nombre VARCHAR(50)
AS
BEGIN
	IF EXISTS (SELECT * FROM EstadoEmpleado WHERE Nombre = @Nombre AND EstadoEmpleadoId <> @EstadoEmpleadoId)
	BEGIN
		PRINT 'El estado de empleado ya existe en la base de datos';
	END
	ELSE
	BEGIN
		UPDATE EstadoEmpleado
		SET Nombre = @Nombre
		WHERE EstadoEmpleadoId = @EstadoEmpleadoId;
	END
END;

-- 3) SP DELETE
GO
CREATE OR ALTER PROCEDURE spDeleteEstadoEmpleado
	@EstadoEmpleadoId INT
AS
BEGIN
	DELETE FROM EstadoEmpleado
	WHERE EstadoEmpleadoId = @EstadoEmpleadoId;
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllEstadoEmpleado
AS
BEGIN
	SELECT 
		EstadoEmpleadoId AS 'Codigo',
		Nombre AS 'Nombre'
	FROM EstadoEmpleado
	ORDER BY Nombre ASC;
END;

-- 5) SP SEARCH BY
GO
CREATE OR ALTER PROCEDURE spBusquedaEstadoEmpleado
	@busqueda VARCHAR(200)
AS
BEGIN
	SELECT
		EstadoEmpleadoId AS 'Codigo',
		Nombre AS 'Nombre'
	FROM EstadoEmpleado
	WHERE Nombre LIKE '%' + @busqueda + '%'
	ORDER BY Nombre ASC;
END;