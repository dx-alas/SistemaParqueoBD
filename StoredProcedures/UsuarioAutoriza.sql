--TABLA: UsuarioAutoriza

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertUsuarioAutoriza
	@UsuarioId INT
AS
BEGIN
	INSERT INTO UsuarioAutoriza(UsuarioId)
	VALUES (@UsuarioId);
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateUsuarioAutoriza
	@Id INT,
	@UsuarioId INT
AS
BEGIN
	UPDATE UsuarioAutoriza
	SET UsuarioId = @UsuarioId
	WHERE UsuarioAutorizaId = @Id;
END;

-- 3) SP DELETE
GO
CREATE OR ALTER PROCEDURE spDeleteUsuarioAutoriza
	@Id INT
AS
BEGIN
	DELETE FROM UsuarioAutoriza
	WHERE UsuarioAutorizaId = @Id;
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllUsuarioAutoriza
AS
BEGIN
	SELECT
		ua.UsuarioAutorizaId AS 'Codigo',
		u.Nombre AS 'Usuario'
	FROM UsuarioAutoriza ua
	INNER JOIN Usuario u ON ua.UsuarioId = u.UsuarioId;
END;

-- 5) SP SEARCH BY
GO
CREATE OR ALTER PROCEDURE spBusquedaUsuarioAutoriza
	@busqueda VARCHAR(200)
AS
BEGIN
	SELECT
		ua.UsuarioAutorizaId AS 'Codigo',
		u.Nombre AS 'Usuario'
	FROM UsuarioAutoriza ua
	INNER JOIN Usuario u ON ua.UsuarioId = u.UsuarioId
	WHERE u.Nombre LIKE '%' + @busqueda + '%';
END;