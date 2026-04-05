-- TABLA: Rol

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertRol
    @Nombre VARCHAR(50),
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Rol WHERE Nombre = @Nombre)
        BEGIN
            SET @Mensaje = 'El Rol que intenta registrar ya existe en la base de datos';
        END
    ELSE
        BEGIN
            INSERT INTO Rol(Nombre)
            VALUES (@Nombre);
            SET @Mensaje = 'Registro insertado correctamente';
        END
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateRol
    @RolId INT,
    @Nombre VARCHAR(50),
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Rol WHERE Nombre = @Nombre AND RolId <> @RolId)
        BEGIN
            SET @Mensaje = 'El Rol ya existe en la base de datos';
        END
    ELSE
        BEGIN
            UPDATE Rol
            SET Nombre = @Nombre
            WHERE RolId = @RolId;

            SET @Mensaje = 'Registro actualizado correctamente';
        END
END;

-- 3) SP DELETE
GO
CREATE OR ALTER PROCEDURE spDeleteRol
    @RolId INT,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    DELETE FROM Rol
    WHERE RolId = @RolId;

    SET @Mensaje = 'Registro eliminado correctamente';
END;

-- 4) SP SELECT ALL
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

-- 5) SP SEARCH BY
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