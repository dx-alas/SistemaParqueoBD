-- TABLA: Empleado

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertEmpleado
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @DUI VARCHAR(9),
    @Correo VARCHAR(50),
    @Telefono VARCHAR(15),
    @Direccion VARCHAR(255),
    @EstadoEmpleadoId INT = 1,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM EstadoEmpleado WHERE EstadoEmpleadoId = @EstadoEmpleadoId)
        BEGIN
            SET @Mensaje = 'El estado de empleado no existe';
            RETURN;
        END

    IF EXISTS (SELECT 1 FROM Empleado WHERE DUI = @DUI)
        BEGIN
            SET @Mensaje = 'El empleado con este DUI ya existe en la base de datos';
        END
    ELSE
        BEGIN
            INSERT INTO Empleado(Nombre, Apellido, DUI, Correo, Telefono, Direccion, EstadoEmpleadoId)
            VALUES(@Nombre, @Apellido, @DUI, @Correo, @Telefono, @Direccion, @EstadoEmpleadoId);

            SET @Mensaje = 'Registro insertado correctamente';
        END
END;

-- 2) SP UPDATE
GO
CREATE OR ALTER PROCEDURE spUpdateEmpleado
    @EmpleadoId INT,
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @DUI VARCHAR(9),
    @Correo VARCHAR(50),
    @Telefono VARCHAR(15),
    @Direccion VARCHAR(255),
    @EstadoEmpleadoId INT,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Empleado WHERE EmpleadoId = @EmpleadoId)
        BEGIN
            SET @Mensaje = 'El empleado no existe';
            RETURN;
        END

    IF NOT EXISTS (SELECT 1 FROM EstadoEmpleado WHERE EstadoEmpleadoId = @EstadoEmpleadoId)
        BEGIN
            SET @Mensaje = 'El estado de empleado no existe';
            RETURN;
        END

    IF EXISTS (SELECT 1 FROM Empleado WHERE DUI = @DUI AND EmpleadoId <> @EmpleadoId)
        BEGIN
            SET @Mensaje = 'El DUI ingresado ya pertenece a otro empleado';
        END
    ELSE
        BEGIN
            UPDATE Empleado
            SET Nombre = @Nombre,
                Apellido = @Apellido,
                DUI = @DUI,
                Correo = @Correo,
                Telefono = @Telefono,
                Direccion = @Direccion,
                EstadoEmpleadoId = @EstadoEmpleadoId
            WHERE EmpleadoId = @EmpleadoId;

            SET @Mensaje = 'Registro actualizado correctamente';
        END
END;

-- 3) SP DELETE (lógica: cambia estado a Inactivo)
GO
CREATE OR ALTER PROCEDURE spDeleteEmpleado
    @EmpleadoId INT,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Empleado WHERE EmpleadoId = @EmpleadoId)
        BEGIN
            SET @Mensaje = 'El empleado no existe';
            RETURN;
        END

    UPDATE Empleado
    SET EstadoEmpleadoId = 2
    WHERE EmpleadoId = @EmpleadoId;

    SET @Mensaje = 'Empleado cambiado a estado Inactivo';
END;

-- 4) SP SELECT ALL
GO
CREATE OR ALTER PROCEDURE spSelectAllEmpleado
AS
BEGIN
    SELECT
        EmpleadoId AS 'Codigo',
        Nombre,
        Apellido,
        DUI,
        Correo,
        Telefono,
        Direccion,
        EstadoEmpleadoId
    FROM Empleado
    WHERE EstadoEmpleadoId = 1 -- Solo activos
    ORDER BY Nombre ASC;
END;

-- 5) SP SEARCH BY
GO
CREATE OR ALTER PROCEDURE spBusquedaEmpleado
    @busqueda VARCHAR(200)
AS
BEGIN
    SELECT
        EmpleadoId AS 'Codigo',
        Nombre,
        Apellido,
        DUI,
        Correo,
        Telefono,
        Direccion,
        EstadoEmpleadoId
    FROM Empleado
    WHERE EstadoEmpleadoId = 1
      AND (Nombre LIKE '%' + @busqueda + '%'
       OR Apellido LIKE '%' + @busqueda + '%'
       OR DUI LIKE '%' + @busqueda + '%')
    ORDER BY Nombre ASC;
END;