-- Consultas
-- CONSULTAS 1 Y 2 REALIZADAS. VER CONSULTA 1 TODO. 
-- INSERTAR MAS DATOS EN PEDIDOS Y DETALLE PEDIDO PARA CLIENTE Y PARA PROVEEDOR.


-- 1 
-- Listar los pedidos que realizo el cliente de "Trelew" y "Rawson" que incluyeron los productos 
--	  "Piletas de Lona 3,50 MT x 2,5 MT" O "Macetas 10 LTS",  durante el año 2019.
-- TODO: ver producto.nombre.
select * from pedido_cliente;
select * from persona;
select * from producto;
select * from detalle_pedido_cliente;
select * from localidad;

-- Consulta terminada
SELECT pc.nro_pedido, pc.fecha_e, pc.dni, pc.fecha_r, pc.hora_r from pedido_cliente as pc
	inner join detalle_pedido_cliente as dpc on pc.nro_pedido = dpc.nro_pedido
	inner join producto as p on p.id = dpc.id_producto
	inner join persona on pc.dni = persona.dni
	inner join localidad on persona.id_localidad = localidad.id
	WHERE (localidad.nombre = 'Trelew' or localidad.nombre = 'Rawson') and 
	(p.nombre = 'Pileta de Lona 3,50 MT x 2,5 MT' or p.nombre = 'Maceta 10 LTS') and
	EXTRACT(YEAR from pc.fecha_e) = 2019;

-- 2
-- Listar los primeros 5 Productos mas vendidos durante el invierno de 2019

SELECT  producto.nombre, SUM (dpc.cantidad) as cantidad from producto 
	inner join detalle_pedido_cliente as dpc on producto.id = dpc.id_producto
	inner join pedido_cliente as pedido on pedido.nro_pedido = dpc.nro_pedido 
	where pedido.fecha_e >= '2019-06-20' 
	and pedido.fecha_e <= '2019-09-21' 
	group by( producto.nombre )
	ORDER BY( cantidad ) DESC LIMIT 5; 
	
	

-- 3
-- Obtener la cantidad de compras realizadas al proveedor "Ramiro Inc" donde se incluyo materia prima "Carton corrugado x 20 KG"

-- Consulta terminada
SELECT COUNT(*) FROM pedido_proveedor as pp
	-- Uno el pedido con el detalle, utilizando el nro de pedido del detalle
	inner join detalle_pedido_proveedor as dpp on pp.nro_pedido = dpp.nro_pedido
	-- Uno el pedido con el proveedor, utilizando el cuit del prov. del pedido
	inner join proveedor on pp.cuit_p = proveedor.cuit
	-- Uno la materia prima con el pedido, utilizando el id del detalle
	inner join materia_prima as mp on dpp.id_mat_prima = mp.id
	where mp.nombre = 'Carton corrugado x 20 KG' and
	proveedor.descripcion = 'Ramiro Inc';
	
-- Opcional
-- Listar los 3 clientes que realizaron las mayores compras en "Trelew" y retiraron en el Almacen ubicado en
--  "25 de Mayo 5231". Durante el mes de Enero/2020
