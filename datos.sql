INSERT INTO Localidad(nombre) VALUES 
	('Trelew'), 
	('Rawson'), 
	('Puerto Madryn'), 
	('Comodoro');

INSERT INTO persona(dni, nombre, apellido, calle, numero, tipo_persona, id_localidad) VALUES
	('54845123', 'Fernando', 'Peperson', 'Mitre', '4322', 'Empleado', 2),
	('54884512', 'Monica', 'Perez', 'Maipu', '643', 'Persona', 4),
	('98456225', 'Aquiles', 'Paredes', 'Rawson', '443', 'Cliente', 2),
	('54884522', 'Caroline', 'Catson', 'Rivadavia', '909', 'Cliente', 3),
	('12225699', 'Javier', 'Fernandez', 'Pellegrini', '105', 'Cliente', 1),
	('54878965', 'Ramiro', 'Canario', 'Ceferino', '1708', 'Cliente', 1);

INSERT INTO fabrica(cuit, calle, numero) VALUES 
	('11-22211-9', 'Belgrano', 30),
	('22-22-22', 'Perito Moreno',1590),
	('30-18273849-9', 'Colombia', 458),
	('30-18293004-9', 'Marconi', 899),
	('30-66736278-9', 'Pellegrini', 1706),
	('30-83748929-9', 'Belgrano', 1923);

INSERT INTO producto(nombre, precio, presentacion, cuit_fabrica) VALUES
	('Pileta de Lona 3,50 MT x 2,5 MT', 7000, 'En caja', '11-22211-9'),
	('Maceta 10 LTS', 1000, 'Suelto', '22-22-22'),
	('Vasos descartables', 100, 'Pack x20', '30-18273849-9'),
	('Resma A4', 300, 'Paquete x500 hojas', '30-18293004-9'),
	('Taza de ceramica 330ml', 280, 'Suelto', '30-66736278-9'),
	('Papel burbuja', 450, 'Rollo 25 mts', '30-83748929-9');

INSERT INTO proveedor (cuit, descripcion, telefono, calle, numero, id_localidad) VALUES
	('30-83278492-9', 'Ramiro Inc', 154660860, 'Ceferino Namuncura', 1708, 1),
	('20-123456-8', 'Javier Inc', 15412345, 'Gregorio mayo', 830, 1);

INSERT INTO materia_prima (nombre) VALUES
	('Carton corrugado x 20 KG'),
	('Carton no corrugado x 10 KG'),
	('Plastico x 1 KG'),
	('Alambre x 15mtrs');

-- Datos para primer consulta
INSERT INTO pedido_cliente (fecha_e, dni) VALUES
	('2020-12-10 15:23:02', '98456225'), -- Rawson
	('2020-12-11 16:04:34', '54884522'), -- Madryn
	('2019-12-10 12:43:01', '12225699'), -- Trelew
	('2019-12-10 13:55:23', '54878965'), -- Trelew
	('2019-12-10 20:55:23', '54878965'); -- Trelew

INSERT INTO detalle_pedido_cliente (renglon, nro_pedido, cantidad, precio, id_producto) VALUES
	(1, 1, 1, 5000, 1), -- No debe listarse (Rawson, Pileta, 2020)
	(2, 1, 2, 400, 2),
	(1, 2, 1, 5000, 1), -- No debe listarse (Madryn, 2020)
	(1, 3, 1, 200, 2),  -- Debe listarse (Trelew, 2019, Pileta)
	(1, 4, 1, 280, 5),  -- No debe listarse (Trelew, 2019, Taza)
	(1, 5, 2, 380, 2),  -- Debe listarse (Trelew, 2019, maceta)
	-- nuevos
	(1, 7, 1, 5000, 1), 
	(2, 7, 2, 400, 2),
	(1, 8, 1, 5000, 1), 
	(1, 9, 1, 200, 2),  
	(1, 10, 1, 280, 5),  
	(1, 11, 2, 380, 2),
	(2, 8, 10, 300, 4),
	(2, 10, 15, 300, 3),
	(3, 10, 30, 400, 6),
	(2, 11, 16, 500, 3);

-- Datos para la tercer consulta
INSERT INTO pedido_proveedor(fecha_e, cuit_f, cuit_p) VALUES
	('2019-07-14 19:11:25-07', '30-18273849-9', '30-83278492-9'),	-- Pedido a Ramiro Inc
	('2019-07-15 19:14:25-07', '30-18273849-9', '30-83278492-9'),	-- Pedido a Ramiro Inc
	('2019-07-18 19:11:25-07', '30-66736278-9', '30-83278492-9'),	-- Pedido a Ramiro Inc
	('2019-07-20 19:11:25-07', '30-66736278-9', '30-83278492-9'),	-- Pedido a Ramiro Inc
	('2019-07-20 19:11:25-07', '30-66736278-9', '20-123456-8'),	-- Pedido a Javier Inc
	('2019-08-2 20:11:25-07', '30-18273849-9', '30-83278492-9');	-- Pedido a Ramiro Inc

INSERT INTO detalle_pedido_proveedor(renglon, nro_pedido, cantidad, precio, id_mat_prima) VALUES
	(1, 1, 100, 5000, 1),	-- Cartón corrugado a Ramiro Inc (cuenta para la consulta)
	(2, 1, 50, 2000, 2),
	(1, 2, 10, 400, 3),
	(2, 2, 20, 400, 4),
	(1, 3, 80, 4000, 1),	-- Cartón corrugado a Ramiro Inc (cuenta para la consulta)
	(1, 4, 50, 1900, 2),
	(1, 5, 100, 5500, 1),	-- Cartón corrugado a Javier Inc (no cuenta para la consulta)
	(2, 5, 20, 700, 2),
	(3, 5, 3, 80, 4); 


-- Para consulta opcional
INSERT INTO almacen (calle, numero, id_localidad) VALUES
('25 de mayo', 5231, 1);

INSERT INTO pedido_cliente(fecha_e, dni, fecha_r) VALUES 
('2019-05-03 10:10:00-07', '54845123', '2019-09-15 09:0:30-10'),
('2019-07-14 19:11:25-07', '98456225', '2019-08-01 08:0:30-00'),
('2010-07-14 11:04:00-00', '54878965', '2011-12-01 10:0:30-00'),
('2019-08-20 09:00:00-07', '12225699', '2019-09-01 09:0:30-10'),
('2019-09-03 10:10:00-07', '12225699', '2019-09-15 09:0:30-10'),
('2019-11-13 10:10:00-07', '12225699', '2019-12-15 09:0:30-00'),
('2019-12-01 10:10:00-07', '12225699', '2019-12-15 09:0:30-10'),
('2019-06-22 19:10:25-07', '98456225', '2020-06-24 19:10:25-07');



















