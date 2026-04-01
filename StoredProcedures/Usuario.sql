--TABLA 7: Usuario

-- 1) SP INSERT Insert
GO
CREATE OR ALTER PROCEDURE spInsertUsuario
	@Nombre VARCHAR(50),
	@Apellido VARCHAR(50),
	@Correo VARCHAR(100),
	@Clave VARCHAR(100),
	@RolId INT,
	@EstadoUsuarioId INT
AS
BEGIN
	IF EXISTS (SELECT * FROM Usuario WHERE Correo = @Correo)
	BEGIN
		PRINT 'El usuario que intenta registrar ya existe en la base de datos';
	END
	ELSE
	BEGIN
		INSERT INTO Usuario(Nombre, Apellido, Correo, Clave, RolId, EstadoUsuarioId)
		VALUES (@Nombre, @Apellido, @Correo, @Clave, @RolId, @EstadoUsuarioId);
	END
END;

-- 2) SP UPDATE Update
GO
CREATE OR ALTER PROCEDURE spUpdateUsuario
	@Id INT,
	@Nombre VARCHAR(50),
	@Apellido VARCHAR(50),
	@Correo VARCHAR(100),
	@Clave VARCHAR(100),
	@RolId INT,
	@EstadoUsuarioId INT
AS
BEGIN
	IF EXISTS (SELECT * FROM Usuario WHERE Correo = @Correo AND UsuarioId <> @Id)
	BEGIN
		PRINT 'El correo ya existe en la base de datos';
	END
	ELSE
	BEGIN
		UPDATE Usuario
		SET Nombre = @Nombre,
			Apellido = @Apellido,
			Correo = @Correo,
			Clave = @Clave,
			RolId = @RolId,
			EstadoUsuarioId = @EstadoUsuarioId
		WHERE UsuarioId = @Id;
	END
END;

-- 3) SP DELETE Delete (Eliminación lógica)
GO
CREATE OR ALTER PROCEDURE spDeleteUsuario
	@Id INT
AS
BEGIN
	UPDATE Usuario
	SET EstadoUsuarioId = 2
	WHERE UsuarioId = @Id;
END;

-- 4) SP SELECT ALL Select All
GO
CREATE OR ALTER PROCEDURE spSelectAllUsuario
AS
BEGIN
	SELECT 
		u.UsuarioId AS 'Codigo',
		u.Nombre,
		u.Apellido,
		u.Correo,
		r.Rol,
		e.EstadoUsuario
	FROM Usuario u
	INNER JOIN Rol r ON u.RolId = r.RolId
	INNER JOIN EstadoUsuario e ON u.EstadoUsuarioId = e.EstadoUsuarioId
	ORDER BY u.Nombre ASC;
END;

-- 5) SP SEARCH BY Busqueda
GO
CREATE OR ALTER PROCEDURE spBusquedaUsuario
	@busqueda VARCHAR(200)
AS
BEGIN
	SELECT
		u.UsuarioId AS 'Codigo',
		u.Nombre,
		u.Apellido,
		u.Correo,
		r.Rol,
		e.EstadoUsuario
	FROM Usuario u
	INNER JOIN Rol r ON u.RolId = r.RolId
	INNER JOIN EstadoUsuario e ON u.EstadoUsuarioId = e.EstadoUsuarioId
	WHERE u.Nombre LIKE '%' + @busqueda + '%'
	ORDER BY u.Nombre ASC;
END;