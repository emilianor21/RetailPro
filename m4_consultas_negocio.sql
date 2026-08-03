
USE Ventas_Tech_DB

SELECT * FROM Ventas

--Insercion de mas filas para que el trabajo tenga mayor datos por mes--

INSERT INTO Ventas
(id_venta, id_cliente, id_producto, cantidad, precio_unitario, fecha_venta, canal)

VALUES 

(11, 1, 1, 2, 1200.00, '2024-04-05', 'online'),
(12, 4, 4, 4, 120.00, '2024-04-06', 'presencial'),
(13, 5, 1, 3, 120.00, '2024-04-06', 'presencial'),
(14, 3, 2, 9, 28.00, '2024-04-07', 'presencial'),
(15, 2, 6, 3, 95.00, '2024-05-09', 'online'),
(16, 2, 1, 4, 1200.00, '2024-06-05', 'presencial'),
(17, 4, 3, 3, 450.00, '2024-06-05', 'presencial'),
(18, 1, 4, 3, 120.00, '2024-06-10', 'online'),
(19, 3, 1, 1, 1200.00, '2024-04-12', 'presencial'),
(20, 5, 3, 2, 28.00, '2024-04-21', 'online');


--Consulta 1 — Resumen ejecutivo mensual--

SELECT

MONTH(fecha_venta) AS mes,
SUM(cantidad * precio_unitario) AS total_facturado,
COUNT(*) AS cantidad_pedidos,
AVG(cantidad * precio_unitario) AS ticket_promedio

FROM Ventas

GROUP BY MONTH(fecha_venta)

ORDER BY mes DESC;

--Consulta 2 — Ranking de productos--

SELECT TOP 5

id_producto,
SUM(cantidad) AS unidades_vendidas,
SUM(cantidad*precio_unitario) AS total_generado

FROM Ventas

GROUP BY id_producto

ORDER BY total_generado DESC;

--Consulta 3 — Clientes recurrentes--

SELECT 

id_cliente,
COUNT(*) AS cantidad_pedidos,
SUM(cantidad*precio_unitario) AS total_gastado

FROM Ventas

GROUP BY id_cliente

HAVING COUNT (*) > 1;

--Consulta 4 — Meses por encima/por debajo del promedio--

SELECT 

MONTH(fecha_venta) AS mes,
SUM(cantidad*precio_unitario) AS total_facturado,

CASE
WHEN(SUM(cantidad*precio_unitario)>
(SELECT AVG(total_facturado)
FROM(
SELECT SUM(cantidad*precio_unitario) AS total_facturado
FROM Ventas
GROUP BY MONTH(fecha_venta))
AS promedio))
THEN 'por encima'
ELSE 'por debajo'
END AS comparacion
FROM Ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

--HALLAZGOS:--

-- 1. El mes 3 registró la mayor facturación del período, con un total de $6.444,00, superando el promedio mensual.

-- 2. El producto con ID 1 fue el de mejor desempeño, generando una facturación de $12.360,00 con 13 unidades vendidas.

-- 3. Los meses 3, 4 y 6 estuvieron por encima del promedio de facturación mensual, mientras que el mes 5 quedó por debajo.


