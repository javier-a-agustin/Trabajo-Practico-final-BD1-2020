-- Crear la base de datos *
-- Crear las tablas que No tengan clave foranea *
-- Crear las tablas que tengan clave foranea
-- Insertar datos
-- Realizar consultas


-- Tablas sin clave foranea
CREATE TABLE materia_prima( 
	id SERIAL PRIMARY KEY,
	nombre VARCHAR NOT NULL
)

CREATE TABLE fabrica(
	cuit VARCHAR NOT NULL PRIMARY KEY,
	calle VARCHAR(150) NOT NULL,
	numero INT NOT NULL,
	piso INT,
	departamento VARCHAR(30)
)

CREATE TABLE equipo_directivo(
	id SERIAL PRIMARY KEY,

)

CREATE TABLE localidad(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(150)
)

CREATE DOMAIN grado as INT	-- Dominio para grado {1, 2, 3, 4, 5}
CHECK(
	VALUE=1 
	or VALUE=2
	or VALUE=3
	or VALUE=4
	or VALUE=5
);

CREATE TABLE especialidad(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(150) NOT NULL,
	grado_especialidad grado NOT NULL
)
-- select * from especialidad;
-- INSERT INTO especialidad (nombre, grado_especialidad) VALUES ('tecnico', 3)
-- date para fechas
-- time para horas

CREATE TABLE contratacion(
	dni INT NOT NULL,
	fecha_i TIME DEFAULT Now(),
	fecha_f TIME,
	motivo_baja VARCHAR(230),
	PRIMARY KEY(dni, fecha_i, fecha_f)
)


-- Tablas con clave foranea
CREATE TABLE producto(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(120),
	precio FLOAT,
	presentacion VARCHAR(120),
	
	CONSTRAINT  fk_cuit
		FOREIGN KEY(nombre)
			REFERENCES fabrica(cuit)
)
-- select * from producto










 