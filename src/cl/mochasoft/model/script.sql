CREATE DATABASE bd_mochasoft; -- DROP DATABASE bd_mochasoft;

USE bd_mochasoft;

CREATE TABLE compania_engine(
	id UNIQUEIDENTIFIER PRIMARY KEY,
	nombre NVARCHAR(200)
);

CREATE TABLE engine(
	id UNIQUEIDENTIFIER PRIMARY KEY,
	nombre NVARCHAR(200),
	fk_compania_engine UNIQUEIDENTIFIER REFERENCES compania_engine (id)
);

CREATE TABLE compania_plataforma(
	id UNIQUEIDENTIFIER PRIMARY KEY,
	nombre NVARCHAR(200)
);

CREATE TABLE plataforma(
	id UNIQUEIDENTIFIER PRIMARY KEY,
	nombre NVARCHAR(200),
	fk_compania_plataforma UNIQUEIDENTIFIER REFERENCES compania_plataforma (id),
);

CREATE TABLE genero(
	id UNIQUEIDENTIFIER PRIMARY KEY,
	nombre NVARCHAR(200)
);

CREATE TABLE juego(
	id UNIQUEIDENTIFIER PRIMARY KEY,
	titulo NVARCHAR(200),
	fk_genero UNIQUEIDENTIFIER REFERENCES genero (id),
	anio_release DATE,
	fk_plataforma UNIQUEIDENTIFIER REFERENCES plataforma (id),
	fk_engine UNIQUEIDENTIFIER REFERENCES engine (id)
);

CREATE TABLE staff(
	id UNIQUEIDENTIFIER PRIMARY KEY,
	nombre NVARCHAR(200)
);

CREATE TABLE juego_staff(
	id UNIQUEIDENTIFIER PRIMARY KEY,
	fk_juego UNIQUEIDENTIFIER REFERENCES juego (id),
	fk_staff UNIQUEIDENTIFIER REFERENCES staff (id),
	rol VARCHAR(100)
);
GO

CREATE FUNCTION juegos_py(@anio DATE) RETURNS INT AS -- DROP FUNCTION juegos_py;
BEGIN
	DECLARE @cantJuego INT = (SELECT COUNT(*) FROM juego WHERE anio_release = @anio);
	DECLARE @avgJuego INT = (AVG(@cantJuego));
	RETURN @avgJuego;
END
GO

CREATE PROCEDURE crearEngine(@nombreEngine NVARCHAR(200), @compania NVARCHAR(200))
AS
BEGIN
	DECLARE @existeEngine UNIQUEIDENTIFIER = (SELECT id FROM engine WHERE nombre = @nombreEngine);
	DECLARE @idCompania UNIQUEIDENTIFIER = (SELECT id FROM compania_engine WHERE nombre = @compania);

	IF @existeEngine IS NULL
	BEGIN
		IF @idCompania IS NULL
		BEGIN
			INSERT INTO compania_engine VALUES (NEWID(), @compania);
			SET @idCompania = (SELECT id FROM compania_engine WHERE nombre = @compania);
		END

		INSERT INTO engine VALUES (NEWID(), @nombreEngine, @idCompania);
	END

	ELSE
	BEGIN
		PRINT('El engine ya existe.');
	END
END;
GO

CREATE PROCEDURE crearPlataforma(@nombrePlataforma NVARCHAR(200), @compania NVARCHAR(200))
AS
BEGIN
	DECLARE @existePlataforma UNIQUEIDENTIFIER = (SELECT id FROM engine WHERE nombre = @nombrePlataforma);
	DECLARE @idCompania UNIQUEIDENTIFIER = (SELECT id FROM compania_plataforma WHERE nombre = @compania);

	IF @existePlataforma IS NULL
	BEGIN
		IF @idCompania IS NULL
		BEGIN
			INSERT INTO compania_plataforma VALUES (NEWID(), @compania);
			SET @idCompania = (SELECT id FROM compania_engine WHERE nombre = @compania);
		END

		INSERT INTO engine VALUES (NEWID(), @nombrePlataforma, @idCompania);
	END

	ELSE
	BEGIN
		PRINT('El engine ya existe.');
	END
END;
GO

CREATE PROCEDURE elminarStaff (@idStaff UNIQUEIDENTIFIER)
AS
BEGIN
	DELETE FROM juego_staff WHERE fk_staff = @idStaff;
	DELETE FROM staff WHERE id = @idStaff;
END;

INSERT INTO staff VALUES (NEWID(), 'FrostinoDev');
SELECT * FROM staff;
INSERT INTO genero VALUES (NEWID(), 'Simulador');
SELECT * FROM genero;
INSERT INTO juego VALUES (NEWID(), 'Frostino Simulator 2018', 'F46E9918-FD2E-4A8B-B524-FABD4D9E8467', '2018', '1E285159-9B1E-45A0-9E28-9745850ABAD2', 'FB74FBC3-FA34-4BEB-B15E-DB15FC0D1CD7');
SELECT * FROM juego;
INSERT INTO juego_staff VALUES (NEWID(), '5C2AA1EA-804E-4B78-AD86-71570557B640', '11DA3DB2-8A8D-4544-B663-FBBC6FFE70F4', 'Desarrollador Principal');
SELECT * FROM juego_staff;