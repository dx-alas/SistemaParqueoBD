--TABLA: Empleado

-- 1) SP INSERT
GO
CREATE OR ALTER PROCEDURE spInsertEmpleado
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @DUI VARCHAR(9),
    @Correo VARCHAR(50),
    @Telefono VARCHAR(15),
    @EstadoEmpleadoId INT = 1  -- Por defecto Activo
AS
BEGIN
    IF EXISTS (SELECT * FROM Empleado WHERE DUI = @DUI)
    BEGIN
        PRINT 'El empleado con este DUI ya existe en la base de datos';
    END
    ELSE
    BEGIN
        INSERT INTO Empleado(Nombre, Apellido, DUI, Correo, Telefono, EstadoEmpleadoId)
        VALUES(@Nombre, @Apellido, @DUI, @Correo, @Telefono, @EstadoEmpleadoId);
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
    @EstadoEmpleadoId INT
AS
BEGIN
    IF EXISTS (SELECT * FROM Empleado WHERE DUI = @DUI AND EmpleadoId <> @EmpleadoId)
    BEGIN
        PRINT 'El DUI ingresado ya pertenece a otro empleado';
    END
    ELSE
    BEGIN
        UPDATE Empleado
        SET Nombre = @Nombre,
            Apellido = @Apellido,
            DUI = @DUI,
            Correo = @Correo,
            Telefono = @Telefono,
            EstadoEmpleadoId = @EstadoEmpleadoId
        WHERE EmpleadoId = @EmpleadoId;
    END
END;


-- 3) SP DELETE (lógica: cambia estado a Inactivo)
GO
CREATE OR ALTER PROCEDURE spDeleteEmpleado
    @EmpleadoId INT
AS
BEGIN
    UPDATE Empleado
    SET EstadoEmpleadoId = 2 -- Inactivo
    WHERE EmpleadoId = @EmpleadoId;
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
        EstadoEmpleadoId
    FROM Empleado
    WHERE EstadoEmpleadoId = 1
      AND (Nombre LIKE '%' + @busqueda + '%'
       OR Apellido LIKE '%' + @busqueda + '%'
       OR DUI LIKE '%' + @busqueda + '%')
    ORDER BY Nombre ASC;
END;