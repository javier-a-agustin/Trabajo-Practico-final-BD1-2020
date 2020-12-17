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

