﻿
CREATE TABLE materia_prima( 
	id SERIAL PRIMARY KEY,
	nombre VARCHAR NOT NULL
);

CREATE TABLE fabrica(
	cuit VARCHAR(13) NOT NULL PRIMARY KEY,
	calle VARCHAR(150) NOT NULL,
	numero INT NOT NULL,
	piso INT,
	departamento VARCHAR(30)
);

CREATE TABLE equipo_directivo(
	id SERIAL PRIMARY KEY,
	fecha_i TIMESTAMP NOT NULL,
	fecha_f TIMESTAMP
);

CREATE TABLE localidad(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(150) NOT NULL 
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

CREATE DOMAIN tipo as VARCHAR	-- Dominio para tipo (Persona) {Persona, Cliente, Empleado}
CHECK(
	VALUE IN ('Persona', 'Empleado', 'Cliente')
);

CREATE TABLE persona(
	dni VARCHAR(8) NOT NULL PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	apellido VARCHAR(100) NOT NULL,
	calle VARCHAR NOT NULL, 
	numero INT NOT NULL, 
	piso INT,
	departamento VARCHAR(10),
	tipo_persona tipo NOT NULL,
	id_localidad INT NOT NULL,	
	cuit_f VARCHAR(13),		
	fecha_i TIMESTAMP,
	fecha_f TIMESTAMP,

	CONSTRAINT fk_localidad
		FOREIGN KEY(id_localidad)
			REFERENCES localidad(id),
	CONSTRAINT fk_fabrica
		FOREIGN KEY(cuit_f)
			REFERENCES fabrica(cuit)
);

CREATE TABLE contratacion(
	dni VARCHAR(8) NOT NULL,
	fecha_i TIMESTAMP NOT NULL,
	fecha_f TIMESTAMP,
	motivo_baja VARCHAR(230),
	PRIMARY KEY(dni, fecha_i, fecha_f),

	CONSTRAINT fk_persona
		FOREIGN KEY(dni)
			REFERENCES persona(dni)
);


-- Tablas con clave foranea
CREATE TABLE producto(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(120) NOT NULL,
	precio FLOAT NOT NULL,
	presentacion VARCHAR(120) NOT NULL,
	cuit_fabrica VARCHAR(13) NOT NULL,
	
	CONSTRAINT  fk_cuit
		FOREIGN KEY(cuit_fabrica)
			REFERENCES fabrica(cuit)
);

CREATE TABLE equivale_a(
	id_prod_1 INT,
	id_prod_2 INT,
	PRIMARY KEY(id_prod_1, id_prod_2),
		
	CONSTRAINT fk_id_prod_1
		FOREIGN KEY(id_prod_1)
			REFERENCES producto(id),
			
	CONSTRAINT fk_id_prod_2
		FOREIGN KEY(id_prod_2)
			REFERENCES producto(id)
);



CREATE TABLE fabricado_con(
	id SERIAL PRIMARY KEY, 
	id_prod INT NOT NULL,
	id_mat_prima INT NOT NULL,
	cantidad INT NOT NULL,

	CONSTRAINT fk_id_prod
		FOREIGN KEY(id_prod)
			REFERENCES producto(id),

	CONSTRAINT fk_id_mat_prima
		FOREIGN KEY(id_mat_prima)
			REFERENCES materia_prima(id)
);

CREATE TABLE proveedor(
	cuit VARCHAR(13) PRIMARY KEY,
	descripcion TEXT NOT NULL,
	telefono INT NOT NULL,
	calle VARCHAR(40) NOT NULL,
	numero INT NOT NULL,
	piso INT,
	departamento VARCHAR(10),
	id_localidad INT NOT NULL,
	
	CONSTRAINT fk_localidad
		FOREIGN KEY(id_localidad)
			REFERENCES localidad(id)
);

CREATE TABLE pedido_proveedor(
	nro_pedido SERIAL PRIMARY KEY,
	fecha_e TIMESTAMP NOT NULL,
	fecha_r TIMESTAMP,
	hora_r TIMESTAMP,
	cuit_f VARCHAR(13) NOT NULL,
	cuit_p VARCHAR(13) NOT NULL,
	
	CONSTRAINT fk_cuit_fabrica
		FOREIGN KEY(cuit_f)
			REFERENCES fabrica(cuit),
			
	CONSTRAINT fk_cuit_proveedor
		FOREIGN KEY(cuit_p)
			REFERENCES proveedor(cuit)
);


CREATE TABLE detalle_pedido_proveedor(
	renglon INT NOT NULL,
	nro_pedido INT NOT NULL,
	cantidad INT NOT NULL,
	precio FLOAT NOT NULL,
	id_mat_prima INT NOT NULL,
	
	CONSTRAINT fk_materia_prima
		FOREIGN KEY(id_mat_prima)
			REFERENCES materia_prima(id),

	CONSTRAINT fk_num_pedido
		FOREIGN KEY(nro_pedido)
			REFERENCES pedido_proveedor(nro_pedido),

	PRIMARY KEY(renglon, nro_pedido)
);




CREATE TABLE efectua(
	cuit_f VARCHAR(13) NOT NULL,
	cuit_p VARCHAR(13) NOT NULL,
	nro_pedido INT, 
	fecha TIMESTAMP,
	
	PRIMARY KEY(nro_pedido, fecha),
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
	cuit VARCHAR(13),
	id_producto INT,
	PRIMARY KEY(cuit, id_producto),
	CONSTRAINT fk_cuit
		FOREIGN KEY(cuit)
			REFERENCES fabrica(cuit),
	CONSTRAINT fk_producto
		FOREIGN KEY(id_producto)
			REFERENCES producto(id)
);



CREATE TABLE tiene(
	id_equipo INT,
	cuit VARCHAR(13),
	
	PRIMARY KEY(id_equipo, cuit),
	CONSTRAINT fk_equipo
		FOREIGN KEY(id_equipo)
			REFERENCES equipo_directivo(id),
	CONSTRAINT fk_cuit
		FOREIGN KEY(cuit)
			REFERENCES fabrica(cuit)
);




CREATE TABLE compuesto_por(
	id_equipo INT,
	dni VARCHAR(8), 
	
	PRIMARY KEY(id_equipo, dni),
	CONSTRAINT fk_equipo
		FOREIGN KEY(id_equipo)
			REFERENCES equipo_directivo(id),
	CONSTRAINT fk_persona
		FOREIGN KEY(dni)
			REFERENCES persona(dni)
);

CREATE TABLE pedido_cliente(
	nro_pedido SERIAL PRIMARY KEY,
	fecha_e TIMESTAMP NOT NULL,
	dni VARCHAR(8) NOT NULL,
	fecha_r TIMESTAMP,
	hora_r TIMESTAMP,
	
	CONSTRAINT fk_persona
		FOREIGN KEY(dni)
			REFERENCES persona(dni)
);
	

CREATE TABLE detalle_pedido_cliente(
	renglon INT,
	nro_pedido INT, 
	cantidad INT NOT NULL,
	precio FLOAT NOT NULL,
	id_producto INT NOT NULL, 

	PRIMARY KEY(nro_pedido, renglon),
	CONSTRAINT fk_pedido_cliente
		FOREIGN KEY(nro_pedido)
			REFERENCES pedido_cliente(nro_pedido),
	CONSTRAINT fk_producto
		FOREIGN KEY(id_producto)
			REFERENCES producto(id)
);

CREATE TABLE almacen(
	id SERIAL PRIMARY KEY,
	calle VARCHAR(150) NOT NULL,
	numero INT NOT NULL,
	piso INT,
	departamento VARCHAR(10),
	id_localidad INT NOT NULL,
	
	CONSTRAINT fk_localidad
		FOREIGN KEY(id_localidad)
			REFERENCES localidad(id)
);




CREATE TABLE almacenado_en(
	id_producto INT, 
	id_almacen INT, 
	cantidad INT,

	PRIMARY KEY(id_producto, id_almacen, cantidad),	
	CONSTRAINT fk_producto
		FOREIGN KEY(id_producto)
			REFERENCES producto(id),
	CONSTRAINT fk_almacen
		FOREIGN KEY(id_almacen)
			REFERENCES almacen(id)
);

CREATE TABLE posee(
	id_especialidad INT, 
	dni VARCHAR(8), 
	
	PRIMARY KEY(dni, id_especialidad),
	CONSTRAINT fk_especialidad
		FOREIGN KEY(id_especialidad)
			REFERENCES especialidad(id),
	CONSTRAINT fk_persona
		FOREIGN KEY(dni)
			REFERENCES persona(dni)
);




	