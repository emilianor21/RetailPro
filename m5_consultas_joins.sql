USE Ventas_Tech_DB

-- Para desarrollar la entrega del Módulo 5 fue necesario realizar algunas adaptaciones sobre la base de datos RetailPro,
-- ya que el modelo original no incluía información sobre el canal de venta ni sobre la región geográfica.
--
-- Como base de trabajo utilicé las entregas de los módulos 3 y 4. En la base del Módulo 4 incorporé nuevos registros
-- en la tabla Ventas para contar con un mayor volumen de información y permitir un análisis más representativo por mes.
--
-- Además, realicé las siguientes modificaciones al modelo de datos:
-- • Se agregó el campo Segmento a la tabla Clientes.
-- • Se agregó el campo Canal a la tabla Ventas.
-- • Se creó la tabla Territorios para incorporar la información de región y establecer su relación con los clientes.
--
-- Estas modificaciones permiten cumplir con los requerimientos de la consigna y generar consultas más completas para su
-- posterior análisis en Power BI.


SELECT * FROM Categorias
SELECT * FROM Clientes
SELECT * FROM Productos
SELECT * FROM Ventas
SELECT * FROM territorios

--Consulta 1 — Vista base del proyecto (INNER JOIN) Combiná ventas, clientes, productos y territorios para obtener en una sola fila: 
--fecha, nombre del cliente, segmento, región, nombre del producto, categoría, cantidad, precio unitario, total de venta y canal. 
--Esta consulta será la fuente de datos principal en Power BI.

SELECT
v.fecha_Venta, 
c.nombre,
c.segmento,
t.region, 
p.nombre_producto,
ct.nombre_categoria,
v.cantidad,
v.precio_unitario,
(v.precio_unitario * v.cantidad) AS Venta_Total,
v.canal

FROM ventas AS v

JOIN clientes AS c
ON v.id_cliente = c.id_cliente

JOIN productos as p
ON v.id_producto = p.id_producto

JOIN categorias as ct
ON p.id_categoria = ct.id_categoria

JOIN territorios AS t
ON c.id_territorios = t.id_territorios


--Consulta 2 — Clientes sin ventas (LEFT JOIN) Identificá clientes registrados que aún no han realizado ninguna compra. 
--Mostrá su nombre, email y fecha de registro. Usá WHERE ... IS NULL para aislar los casos.

SELECT
c.nombre,
c.email,
c.fecha_registro

FROM Clientes AS c
LEFT JOIN Ventas AS v
ON c.id_cliente = v.id_Cliente
WHERE v.id_venta IS NULL


--Consulta 3 — Productos sin ventas (LEFT JOIN) Identificá productos del catálogo que no tienen ninguna venta registrada.
--Mostrá nombre del producto, categoría y precio. Usá WHERE ... IS NULL.

SELECT
p.nombre_producto,
ct.nombre_categoria,
p.precio

FROM productos AS p
JOIN categorias AS ct
ON p.id_categoria = ct.id_categoria

LEFT JOIN ventas AS v
ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL


--Consulta 4 — Consolidado por canal (UNION ALL) Usá UNION ALL para combinar en un solo resultado las ventas Online y Presencial, 
--agregando una columna canal que identifique el origen de cada fila. Al final calculá el total por canal con un GROUP BY.

SELECT
canal,
SUM(total_venta) AS total_facturado

FROM(
SELECT
'Online' AS canal,
cantidad * precio_unitario AS total_venta

FROM Ventas
WHERE canal = 'online'

UNION ALL

SELECT
'Presencial' AS canal,
cantidad * precio_unitario AS total_venta

FROM Ventas
WHERE canal = 'presencial'
) AS Consolidado

GROUP BY canal;