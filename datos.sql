INSERT INTO Localidad(nombre) VALUES ('Rawson'), ('Puerto Madryn'), ('Comodoro');
select * from localidad;


INSERT INTO persona(dni, nombre, apellido, tipo_persona, id_localidad) VALUES
(123123, 'Pepe', 'Peperson', 'Empleado', 2),
(222222, 'Pepe', 'Junior', 'Persona', 4),
(99999, 'Aquiles', 'Aquilerson', 'Cliente', 2),
(010101, 'Caroline', 'Catson', 'Cliente', 3);
--(111222333, 'Javier', 'Fernandez', 'Cliente', 1),
--(222111333, 'Ramiro', 'Canario', 'Cliente', 1);

select * from persona;


INSERT INTO fabrica(cuit, calle, numero) VALUES 
	('11-22211-9', 'Belgrano', 30),
	('22-22-22', 'Perito Moreno',1590);

INSERT INTO producto(nombre, precio, presentacion, cuit_fabrica) VALUES
('Pileta de Lona 3,50 MT x 2,5 MT', 7000, 'En caja', '11-22211-9'),
('Maceta 10 LTS', 1000, 'Suelto', '22-22-22');

select * from producto;

INSERT INTO proveedor (cuit, descripcion, telefono, calle, numero, id_localidad) VALUES
('30-83278492-9', 'Ramiro Inc', 154660860, 'Ceferino Namuncura', 1708, 1);

select * from proveedor;

INSERT INTO materia_prima (nombre) VALUES
('Carton corrugado x 20 KG');

-- Para consulta opcional
INSERT INTO almacen (calle, numero, id_localidad) VALUES
('25 de mayo', 5231, 1);
