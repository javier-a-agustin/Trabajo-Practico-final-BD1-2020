-- Consultas

-- Listar los pedidos que realizo el cliente de "Trelew" y "Rawson" que incluyeron los productos 
--	  "Piletas de Lona 3,50 MT x 2,5 MT" O "Macetas 10 LTS",  durante el año 2019.
-- TODO: ver producto.nombre.
select * from pedido_cliente;
select * from persona;
select * from producto;
select * from detalle_pedido_cliente;
select * from localidad;

producto, detalle, peidod, persona, localidad

select pc.nro_pedido, pc.fecha_e, pc.dni from producto inner join detalle_pedido_cliente as dpc on producto.id = dpc.id_producto
	inner join pedido_cliente as pc on pc.nro_pedido = dpc.nro_pedido 
	inner join persona on pc.dni = persona.dni 
	inner join localidad on persona.id_localidad = localidad.id
	where localidad.nombre = 'Trelew' or localidad.nombre = 'Rawson' and 
	producto.id = 1 or producto.id = 2 and
	 EXTRACT(YEAR from pc.fecha_e) = 2019
	extract YEAR from pc.fecha_e = 2019;
