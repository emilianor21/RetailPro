Para el desarrollo de esta entrega se realizaron algunas adaptaciones sobre la base de datos utilizada en módulos anteriores, con el fin de cumplir los requerimientos de la consigna y 
contar con información suficiente para el análisis.

Se incorporaron algunos campos y registros adicionales para enriquecer el modelo de datos y facilitar la resolución de las consultas solicitadas. A partir de estas modificaciones se implementaron consultas utilizando `INNER JOIN`, `LEFT JOIN`, `UNION ALL` y funciones de agregación para responder distintos escenarios de negocio.

Adaptaciones realizadas al modelo de datos:

La base de datos original no contenía toda la información necesaria para resolver las consultas solicitadas. Por este motivo se realizaron las siguientes modificaciones:

Se incorporó el campo Segmento a la tabla Clientes, permitiendo clasificar los clientes por tipo.
Se agregó el campo Canal a la tabla Ventas para diferenciar las ventas Online y Presencial.
Se creó la tabla Territorios, incorporando la información de Región y estableciendo su relación con la tabla Clientes.
Se agregaron nuevos registros a la tabla Ventas con el objetivo de ampliar el volumen de información y obtener resultados más representativos para los análisis mensuales.

Estas modificaciones permitieron construir un modelo de datos más cercano a un escenario real de análisis comercial.
