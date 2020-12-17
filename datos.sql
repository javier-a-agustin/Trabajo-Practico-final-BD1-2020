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
	--('11-22211-9', 'Belgrano', 30),
	--('22-22-22', 'Perito Moreno',1590);
	('30-18273849-9', 'Colombia', 458),
	('30-18293004-9', 'Marconi', 899),
	('30-66736278-9', 'Pellegrini', 1706),
	('30-83748929-9', 'Belgrano', 1923);

INSERT INTO producto(nombre, precio, presentacion, cuit_fabrica) VALUES
--('Pileta de Lona 3,50 MT x 2,5 MT', 7000, 'En caja', '11-22211-9'),
--('Maceta 10 LTS', 1000, 'Suelto', '22-22-22');
--('Vasos descartables', 100, 'Pack x20', '30-18273849-9');
--('Resma A4', 300, 'Paquete x500 hojas', '30-18293004-9');
--('Taza de ceramica 330ml', 280, 'Suelto', '30-66736278-9');
('Papel burbuja', 450, 'Rollo 25 mts', '30-83748929-9');

select * from producto;

INSERT INTO proveedor (cuit, descripcion, telefono, calle, numero, id_localidad) VALUES
('30-83278492-9', 'Ramiro Inc', 154660860, 'Ceferino Namuncura', 1708, 1);

select * from proveedor;

INSERT INTO materia_prima (nombre) VALUES
('Carton corrugado x 20 KG');

-- Para consulta opcional
INSERT INTO almacen (calle, numero, id_localidad) VALUES
('25 de mayo', 5231, 1);
