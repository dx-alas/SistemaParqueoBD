--TABLA 7: Usuario

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertUsuario
    @Nombre VARCHAR(50),
    @Clave VARCHAR(255),
    @EmpleadoId INT,
    @RolId INT,
    @EstadoUsuarioId INT,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
	-- validaciones de foraneas
    IF NOT EXISTS (SELECT 1 FROM Rol WHERE RolId = @RolId)
        BEGIN
            SET @Mensaje = 'El Rol seleccionado no existe';
            RETURN;
        END

    IF NOT EXISTS (SELECT 1 FROM EstadoUsuario WHERE EstadoUsuarioId = @EstadoUsuarioId)
        BEGIN
            SET @Mensaje = 'El estado de usuario seleccionado no existe';
            RETURN;
        END

    IF EXISTS (SELECT 1 FROM Usuario WHERE EmpleadoId = @EmpleadoId)
        BEGIN
            SET @Mensaje = 'El empleado ya tiene un usuario asignado';
            RETURN;
        END

    -- Validación duplicado de nombre
    IF EXISTS (SELECT 1 FROM Usuario WHERE Nombre = @Nombre)
        BEGIN
            SET @Mensaje = 'El usuario que intenta registrar ya existe en la base de datos';
        END
    ELSE
        BEGIN
            INSERT INTO Usuario(Nombre, Clave, EmpleadoId, RolId, EstadoUsuarioId)
            VALUES (@Nombre, @Clave, @EmpleadoId, @RolId, @EstadoUsuarioId);

            SET @Mensaje = 'Registro insertado correctamente';
        END
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateUsuario
    @Id INT,
    @Nombre VARCHAR(50),
    @Clave VARCHAR(255),
    @EmpleadoId INT,
    @RolId INT,
    @EstadoUsuarioId INT,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    -- Validaciones críticas
    IF NOT EXISTS (SELECT 1 FROM Usuario WHERE UsuarioId = @Id)
        BEGIN
            SET @Mensaje = 'El usuario que intenta actualizar no existe';
            RETURN;
        END

    IF NOT EXISTS (SELECT 1 FROM Rol WHERE RolId = @RolId)
        BEGIN
            SET @Mensaje = 'El Rol seleccionado no existe';
            RETURN;
        END

    IF NOT EXISTS (SELECT 1 FROM EstadoUsuario WHERE EstadoUsuarioId = @EstadoUsuarioId)
        BEGIN
            SET @Mensaje = 'El estado de usuario seleccionado no existe';
            RETURN;
        END

    IF EXISTS (SELECT 1 FROM Usuario WHERE EmpleadoId = @EmpleadoId AND UsuarioId <> @Id)
        BEGIN
            SET @Mensaje = 'El empleado ya tiene un usuario asignado';
            RETURN;
        END

    -- Validación original de duplicado de nombre
    IF EXISTS (SELECT 1 FROM Usuario WHERE Nombre = @Nombre AND UsuarioId <> @Id)
        BEGIN
            SET @Mensaje = 'El usuario con ese nombre ya existe en la base de datos';
        END
    ELSE
        BEGIN
            UPDATE Usuario
            SET Nombre = @Nombre,
                Clave = @Clave,
                EmpleadoId = @EmpleadoId,
                RolId = @RolId,
                EstadoUsuarioId = @EstadoUsuarioId
            WHERE UsuarioId = @Id;

            SET @Mensaje = 'Registro actualizado correctamente';
        END
END;

-- 3) SP DELETE (Eliminación lógica)
GO
CREATE OR ALTER PROCEDURE spDeleteUsuario
    @Id INT,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Usuario WHERE UsuarioId = @Id)
        BEGIN
            SET @Mensaje = 'El usuario que intenta eliminar no existe';
            RETURN;
        END

    UPDATE Usuario
    SET EstadoUsuarioId = 2
    WHERE UsuarioId = @Id;

    SET @Mensaje = 'Usuario eliminado correctamente';
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllUsuario
AS
BEGIN
    SELECT 
        u.UsuarioId AS 'Codigo',
        u.Nombre,
        u.Apellido,
        u.Correo,
        r.Nombre AS 'Rol',
        e.Nombre AS 'EstadoUsuario'
    FROM Usuario u
    INNER JOIN Rol r ON u.RolId = r.RolId
    INNER JOIN EstadoUsuario e ON u.EstadoUsuarioId = e.EstadoUsuarioId
    ORDER BY u.Nombre ASC;
END;

-- 5) SP SEARCH BY
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
        r.Nombre AS 'Rol',
        e.Nombre AS 'EstadoUsuario'
    FROM Usuario u
    INNER JOIN Rol r ON u.RolId = r.RolId
    INNER JOIN EstadoUsuario e ON u.EstadoUsuarioId = e.EstadoUsuarioId
    WHERE u.Nombre LIKE '%' + @busqueda + '%'
    ORDER BY u.Nombre ASC;
END;