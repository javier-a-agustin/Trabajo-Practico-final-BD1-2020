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

-- producto, detalle, peidod, persona, localidad

select pc.nro_pedido, pc.fecha_e, pc.dni from producto inner join detalle_pedido_cliente as dpc on producto.id = dpc.id_producto
	inner join pedido_cliente as pc on pc.nro_pedido = dpc.nro_pedido 
	inner join persona on pc.dni = persona.dni 
	inner join localidad on persona.id_localidad = localidad.id
	where localidad.nombre = 'Trelew' or localidad.nombre = 'Rawson' and 
	producto.id = 1 or producto.id = 2 and
	 EXTRACT(YEAR from pc.fecha_e) = 2019


-- 2
-- Listar los primeros 5 Productos mas vendidos durante el invierno de 2019
producto detalle pedido
-- invierno: 21 marzo 21-03-2019 - 20 junio 20-06-2020

SELECT producto.nombre from producto inner join detalle_pedido_cliente as dpc on producto.id = dpc.id_producto
	inner join pedido_cliente as pedido on pedido.nro_pedido = dpc.nro_pedido 
	where pedido.fecha_e < '2019-06-20' and
	pedido.fecha_e >= '2019-03-21';
	
	

-- 3
-- Obtener la cantidad de compras realizadas al proveedor "Ramiro Inc" donde se incluyo materia prima "Carton corrugado x 20 KG"








-- Opcional
-- Listar los 3 clientes que realizaron las mayores compras en "Trelew" y retiraron en el Almacen ubicado en
--  "25 de Mayo 5231". Durante el mes de Enero/2020
