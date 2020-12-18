

-- 1. Listar los pedidos que realizo el cliente de "Trelew" y "Rawson" que incluyeron los productos 
--	  "Piletas de Lona 3,50 MT x 2,5 MT" O "Macetas 10 LTS",  durante el año 2019.

SELECT pc.nro_pedido, pc.fecha_e, pc.dni, pc.fecha_r, pc.hora_r from pedido_cliente as pc
	inner join detalle_pedido_cliente as dpc on pc.nro_pedido = dpc.nro_pedido
	inner join producto as p on p.id = dpc.id_producto
	inner join persona on pc.dni = persona.dni
	inner join localidad on persona.id_localidad = localidad.id
	WHERE (localidad.nombre = 'Trelew' or localidad.nombre = 'Rawson') and 
	(p.nombre = 'Pileta de Lona 3,50 MT x 2,5 MT' or p.nombre = 'Maceta 10 LTS') and
	EXTRACT(YEAR from pc.fecha_e) = 2019;

-- 2. Listar los primeros 5 Productos mas vendidos durante el invierno de 2019

SELECT  producto.nombre, SUM (dpc.cantidad) as cantidad from producto 
	inner join detalle_pedido_cliente as dpc on producto.id = dpc.id_producto
	inner join pedido_cliente as pedido on pedido.nro_pedido = dpc.nro_pedido 
	where pedido.fecha_e >= '2019-06-20' 
	and pedido.fecha_e <= '2019-09-21' 
	group by( producto.nombre )
	ORDER BY( cantidad ) DESC LIMIT 5; 
	
-- 3. Obtener la cantidad de compras realizadas al proveedor "Ramiro Inc" donde se incluyo materia prima "Carton corrugado x 20 KG"

SELECT COUNT(*) FROM pedido_proveedor as pp
	inner join detalle_pedido_proveedor as dpp on pp.nro_pedido = dpp.nro_pedido
	inner join proveedor on pp.cuit_p = proveedor.cuit
	inner join materia_prima as mp on dpp.id_mat_prima = mp.id
	where mp.nombre = 'Carton corrugado x 20 KG' and
	proveedor.descripcion = 'Ramiro Inc';

