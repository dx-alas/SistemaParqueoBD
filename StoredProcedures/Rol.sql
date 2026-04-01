-- TABLA ROL
-- 1) SP INSERT INSERT
GO
CREATE OR ALTER PROCEDURE spInsertRol
	@Nombre VARCHAR(50)
AS
BEGIN
	IF EXISTS (SELECT * FROM Rol WHERE Nombre = @Nombre)
	BEGIN
		PRINT 'El Rol que intenta registrar ya existe en la base de datos';
	END
	ELSE
	BEGIN
		INSERT INTO Rol(Nombre)
		VALUES (@Nombre);
	END
END;

-- 2) SP UPDATE UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateRol
	@RolId INT,
	@Nombre VARCHAR(50)
AS
BEGIN
	IF EXISTS (SELECT * FROM Rol WHERE Nombre = @Nombre AND RolId <> @RolId)
	BEGIN
		PRINT 'El Rol ya existe en la base de datos';
	END
	ELSE
	BEGIN
		UPDATE Rol
		SET Nombre = @Nombre
		WHERE RolId = @RolId;
	END
END;

-- 3) SP DELETE DELETE
GO
CREATE OR ALTER PROCEDURE spDeleteRol
	@RolId INT
AS
BEGIN
	DELETE FROM Rol
	WHERE RolId = @RolId;
END;

-- 4) SP SELECT ALL SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllRol
AS
BEGIN
	SELECT 
		RolId AS 'Codigo',
		Nombre AS 'Nombre'
	FROM Rol
	ORDER BY Nombre ASC;
END;

-- 5) SP SEARCH BY BÚSQUEDA
GO
CREATE OR ALTER PROCEDURE spBusquedaRol
	@Nombre VARCHAR(200)
AS
BEGIN
	SELECT
		RolId AS 'Codigo',
		Nombre AS 'Nombre'
	FROM Rol
	WHERE Nombre LIKE '%' + @Nombre + '%'
	ORDER BY Nombre ASC;
END;