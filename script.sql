-- Crear la base de datos *
-- Crear las tablas que No tengan clave foranea *
-- Crear las tablas que tengan clave foranea *
-- Insertar datos
-- Realizar consultas


-- Tablas sin clave foranea
CREATE TABLE materia_prima( 
	id SERIAL PRIMARY KEY,
	nombre VARCHAR NOT NULL
);

CREATE TABLE fabrica(
	cuit VARCHAR NOT NULL PRIMARY KEY,
	calle VARCHAR(150) NOT NULL,
	numero INT NOT NULL,
	piso INT,
	departamento VARCHAR(30)
);

CREATE TABLE equipo_directivo(
	id SERIAL PRIMARY KEY,
	fecha_i TIME DEFAULT Now(),
	fecha_f TIME
);

CREATE TABLE localidad(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(150)
);

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
);
-- select * from especialidad;
-- INSERT INTO especialidad (nombre, grado_especialidad) VALUES ('tecnico', 3)
-- date para fechas
-- time para horas

CREATE DOMAIN tipo as VARCHAR	-- Dominio para tipo (Persona) {Persona, Cliente, Empleado}
CHECK(
	VALUE IN ('Persona', 'Empleado', 'Cliente')
);

CREATE TABLE persona(
	dni INT NOT NULL PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	apellido VARCHAR(100) NOT NULL,
	calle VARCHAR,
	numero INT,
	piso INT,
	departamento VARCHAR(10),
	tipo_persona tipo NOT NULL,
	id_localidad INT,	-- Localidad
	cuit_f VARCHAR,		-- Fabrica
	fecha_i DATE,
	decha_f DATE,

	CONSTRAINT fk_localidad
		FOREIGN KEY(id_localidad)
			REFERENCES localidad(id),
	CONSTRAINT fk_fabrica
		FOREIGN KEY(cuit_f)
			REFERENCES fabrica(cuit)
);

CREATE TABLE contratacion(
	dni INT NOT NULL,
	fecha_i DATE DEFAULT Now(),
	fecha_f DATE,
	motivo_baja VARCHAR(230),
	PRIMARY KEY(dni, fecha_i, fecha_f),

	CONSTRAINT fk_persona
		FOREIGN KEY(dni)
			REFERENCES persona(dni)
);

-- select * from contratacion;



-- Tablas con clave foranea
CREATE TABLE producto(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(120),
	precio FLOAT,
	presentacion VARCHAR(120),
	cuit_fabrica VARCHAR,
	
	CONSTRAINT  fk_cuit
		FOREIGN KEY(cuit_fabrica)
			REFERENCES fabrica(cuit)
);
-- select * from producto

CREATE TABLE equivale_a(
	id_prod_1 INT NOT NULL,
	id_prod_2 INT NOT NULL,
	
	CONSTRAINT fk_id_prod_1
		FOREIGN KEY(id_prod_1)
			REFERENCES producto(id),
			
	CONSTRAINT fk_id_prod_2
		FOREIGN KEY(id_prod_2)
			REFERENCES producto(id)
);
-- select * from equivale_a;

CREATE TABLE fabricado_con(
	id_prod INT NOT NULL,
	id_mat_prima INT NOT NULL,
	cantidad INT,

	CONSTRAINT fk_id_prod
		FOREIGN KEY(id_prod)
			REFERENCES producto(id),

	CONSTRAINT fk_id_mat_prima
		FOREIGN KEY(id_mat_prima)
			REFERENCES materia_prima(id)
);

CREATE TABLE proveedor(
	cuit VARCHAR(150) PRIMARY KEY,
	descripcion TEXT,
	telefono INT,
	calle VARCHAR(40),
	numero INT,
	piso INT,
	departamento VARCHAR(10),
	id_localidad INT NOT NULL,
	
	CONSTRAINT fk_localidad
		FOREIGN KEY(id_localidad)
			REFERENCES localidad(id)
);

CREATE TABLE pedido_proveedor(
	nro_pedido SERIAL PRIMARY KEY,
	fecha_e DATE,
	fecha_r DATE,
	hora_r TIME,
	cuit_f VARCHAR, --fabrica
	cuit_p VARCHAR, --proveedor
	
	CONSTRAINT fk_cuit_fabrica
		FOREIGN KEY(cuit_f)
			REFERENCES fabrica(cuit),
			
	CONSTRAINT fk_cuit_proveedor
		FOREIGN KEY(cuit_p)
			REFERENCES proveedor(cuit)
);


CREATE TABLE detalle_pedido_proveedor(
	renglon INT PRIMARY KEY,
	nro_pedido INT,
	cantidad INT NOT NULL,
	precio FLOAT NOT NULL,
	id_mat_prima INT, --materia prima
	
	CONSTRAINT fk_materia_prima
		FOREIGN KEY(id_mat_prima)
			REFERENCES materia_prima(id),

	CONSTRAINT fk_num_pedido
		FOREIGN KEY(nro_pedido)
			REFERENCES pedido_proveedor(nro_pedido)
);

CREATE TABLE efectua(
	cuit_f VARCHAR,
	cuit_p VARCHAR,
	nro_pedido INT,
	fecha DATE PRIMARY KEY,
	
	CONSTRAINT fk_cuit_fabrica
		FOREIGN KEY(cuit_f)
			REFERENCES fabrica(cuit),
	CONSTRAINT fk_cuit_proveedor
		FOREIGN KEY(cuit_p)
			REFERENCES proveedor(cuit),
	CONSTRAINT fk_numero_pedido
		FOREIGN KEY(nro_pedido)
			REFERENCES pedido_proveedor(nro_pedido)
);


CREATE TABLE produce(
	cuit VARCHAR NOT NULL,
	id_producto INT NOT NULL,

	CONSTRAINT fk_cuit
		FOREIGN KEY(cuit)
			REFERENCES fabrica(cuit),
	CONSTRAINT fk_producto
		FOREIGN KEY(id_producto)
			REFERENCES producto(id)
);


CREATE TABLE tiene(
	id_equipo INT NOT NULL,
	cuit VARCHAR NOT NULL,

	CONSTRAINT fk_equipo
		FOREIGN KEY(id_equipo)
			REFERENCES equipo_directivo(id),
	CONSTRAINT fk_cuit
		FOREIGN KEY(cuit)
			REFERENCES fabrica(cuit)
);




CREATE TABLE compuesto_por(
	id_equipo INT NOT NULL, --Equipo
	dni INT NOT NULL, -- Persona
	
	CONSTRAINT fk_equipo
		FOREIGN KEY(id_equipo)
			REFERENCES equipo_directivo(id),
	CONSTRAINT fk_persona
		FOREIGN KEY(dni)
			REFERENCES persona(dni)
);

CREATE TABLE pedido_cliente(
	nro_pedido SERIAL PRIMARY KEY,
	fecha_e DATE,
	dni INT NOT NULL,
	fecha_r DATE,
	hora_r TIME,
	
	CONSTRAINT fk_persona
		FOREIGN KEY(dni)
			REFERENCES persona(dni)
);
	

CREATE TABLE detalle_pedido_cliente(
	renglon INT PRIMARY KEY,
	nro_pedido INT NOT NULL, --peidod cliente
	cantidad INT,
	precio FLOAT,
	id_producto INT, --producto

	CONSTRAINT fk_pedido_cliente
		FOREIGN KEY(nro_pedido)
			REFERENCES pedido_cliente(nro_pedido),
	CONSTRAINT fk_producto
		FOREIGN KEY(id_producto)
			REFERENCES producto(id)
);

CREATE TABLE almacen(
	id SERIAL PRIMARY KEY,
	calle VARCHAR(150),
	numero INT,
	piso INT,
	departamento VARCHAR(10),
	id_localidad INT,
	
	CONSTRAINT fk_localidad
		FOREIGN KEY(id_localidad)
			REFERENCES localidad(id)
);


CREATE TABLE almacenado_en(
	id_producto INT, --producto
	id_almacen INT, --almacen
	cantidad INT NOT NULL,

	CONSTRAINT fk_producto
		FOREIGN KEY(id_producto)
			REFERENCES producto(id),
	CONSTRAINT fk_almacen
		FOREIGN KEY(id_almacen)
			REFERENCES almacen(id)
);

CREATE TABLE posee(
	id_especialidad INT NOT NULL, --especialdidad
	dni INT NOT NULL, --persona
	
	CONSTRAINT fk_especialidad
		FOREIGN KEY(id_especialidad)
			REFERENCES especialidad(id),
	CONSTRAINT fk_persona
		FOREIGN KEY(dni)
			REFERENCES persona(dni)
);


	