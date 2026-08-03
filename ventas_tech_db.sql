--CREACION DE BASE DE DATOS--

CREATE DATABASE Ventas_Tech_DB;

--ELIMINACION DE TABLAS--


DROP TABLE IF EXISTS Productos;
DROP TABLE IF EXISTS Clientes;
DROP TABLE IF EXISTS Ventas;
DROP TABLE IF EXISTS Territorios;
DROP TABLE IF EXISTS Categorias;


--UTILIZACION DE LA DATABASE--

USE Ventas_Tech_DB

--CREACION DE TABLA CATEGORIAS--

CREATE TABLE Territorios (
    id_territorios INT NOT NULL PRIMARY KEY,
    ciudad        VARCHAR(50)   NOT NULL UNIQUE,
    pais          VARCHAR(50)   NOT NULL,
    region        VARCHAR(50)   NULL
);


CREATE TABLE Categorias(
id_categoria int NOT NULL PRIMARY KEY, --SE PODRIA ASIGNAR IDENTITY PARA QUE ID SE GENERE AUTOMATICAMENTE, PERO EL EJERCICIO NO LO PIDIO--
nombre_categoria varchar(200) NOT NULL,
descripcion varchar(200)
);

--CREACION DE TABLA CLIENTES--

CREATE TABLE Clientes(
id_cliente int NOT NULL PRIMARY KEY, --SE PODRIA ASIGNAR IDENTITY PARA QUE ID SE GENERE AUTOMATICAMENTE, PERO EL EJERCICIO NO LO PIDIO--
nombre varchar(100) NOT NULL,
email varchar(100) NOT NULL unique,
fecha_registro date NOT NULL,
id_territorios int NOT NULL FOREIGN KEY REFERENCES Territorios (id_territorios),
segmento varchar(50) NOT NULL
);

--CREACION DE TABLA PRODUCTOS--

CREATE TABLE Productos(
id_producto int NOT NULL PRIMARY KEY, --SE PODRIA ASIGNAR IDENTITY PARA QUE ID SE GENERE AUTOMATICAMENTE, PERO EL EJERCICIO NO LO PIDIO--
nombre_producto varchar(100) NOT NULL,
id_categoria int FOREIGN KEY REFERENCES Categorias(id_categoria),
precio decimal(10,2) NOT NULL,
stock int DEFAULT(0),
activo tinyint DEFAULT(1)
);

--CREACION DE TABLA VENTAS--

CREATE TABLE Ventas(
id_venta int NOT NULL PRIMARY KEY, --SE PODRIA ASIGNAR IDENTITY PARA QUE ID SE GENERE AUTOMATICAMENTE, PERO EL EJERCICIO NO LO PIDIO--
id_cliente int FOREIGN KEY REFERENCES Clientes(id_cliente),
id_producto int FOREIGN KEY REFERENCES Productos(id_producto),
cantidad int NOT NULL,
precio_unitario decimal(10,2) NOT NULL,
fecha_venta date NOT NULL,
canal varchar(20)
);

--INSERCION DE DATOS A LA TABLA TERRITORIOS)

INSERT INTO Territorios 
(id_territorios, ciudad, pais, region) 
VALUES
(1, 'Buenos Aires', 'Argentina', 'Cono Sur'),
(2, 'Córdoba',       'Argentina', 'Cono Sur'),
(3, 'Santiago',      'Chile',     'Cono Sur'),
(4, 'Montevideo',    'Uruguay',   'Cono Sur'),
(5, 'Rosario',       'Argentina', 'Cono Sur'),
(6, 'Lima',          'Perú',      'Región Andina'),
(7, 'Bogotá',        'Colombia',  'Región Andina'),
(8, 'Mendoza',       'Argentina', 'Cono Sur'),
(9, 'Asunción',      'Paraguay',  'Cono Sur');

--INSERCION DE DATOS A LA TABLA CATEGORIAS--

INSERT INTO Categorias
(id_categoria, nombre_categoria, descripcion)
VALUES
(1, 'Computación', 'Laptops, PCs y monitores'),
(2, 'Accesorios', 'Periféricos y complementos'),
(3, 'Audio', 'Auriculares y parlantes'),
(4, 'Almacenamiento', 'Discos y memorias');

--INSERCION DE DATOS A LA TABLA CLIENTES--

INSERT INTO Clientes
(id_Cliente, nombre, email, fecha_registro, id_territorios, segmento)
VALUES 
(1, 'María López', 'maria@mail.com', '2024-01-05', 1, 'Retail'),
(2, 'Carlos Ruiz', 'carlos@mail.com', '2024-01-10', 3, 'Retail'),
(3, 'Ana Gómez', 'ana@mail.com', '2024-02-01', 5, 'Mayorista'),
(4, 'Pedro Sanz', 'pedro@mail.com', '2024-02-15', 1, 'Retail'),
(5, 'Laura Torres', 'laura@mail.com', '2024-03-01', 4, 'Corporativo');

--INSERCIÓN DE CLIENTES QUE AUN NO HAN REALIZADO COMPRAS--

INSERT INTO Clientes
(id_Cliente, nombre, email, fecha_registro, id_territorios, segmento)
VALUES 
(6, 'Antonella Fazzio', 'amfazzio@mail.com', '2024-05-07', 8, 'Retail'),
(7, 'Cala Estrada', 'calaest@mail.com', '2024-05-10', 4, 'Corporativo'),
(8, 'Leon Rodriguez', 'leorod@mail.com', '2024-06-23', 7, 'Mayorista');

--INSERCION DE DATOS A LA TABLA PRODUCTOS--

INSERT INTO Productos
(id_producto, nombre_producto, id_categoria, precio, stock, activo)
VALUES 
(1, 'Laptop Pro 15', 1, 1200.00, 15, 1),
(2, 'Mouse Inalámbrico', 2, 28.00, 80, 1),
(3, 'Monitor 4K 27"', 1, 450.00, 12, 1),
(4, 'Auriculares BT Pro', 3, 120.00, 35, 1),
(5, 'SSD Externo 1TB', 4, 130.00, 18, 1),
(6, 'Teclado Mecánico', 2, 95.00, 40, 1);

--INSERCION DE DATOS A LA TABLA PRODUCTOS, PARA GENERAR PRODUCTOS SIN VENTAS--


INSERT INTO Productos
(id_producto, nombre_producto, id_categoria, precio, stock, activo)
VALUES 
(7, 'Laptop Pro 16', 1, 1600.00, 8, 1),
(8, 'Monitor 5K 30"', 1, 1900.00, 10, 1),
(9, 'Mouse Mecanico"', 2, 300.00, 10, 1);


--INSERCION DE DATOS A LA TABLA VENTAS--

INSERT INTO Ventas
(id_venta, id_cliente, id_producto, cantidad, precio_unitario, fecha_venta, canal)
VALUES 
(1, 1, 1, 2, 1200.00, '2024-03-05', 'presencial'),
(2, 2, 2, 5,   28.00, '2024-03-06', 'presencial'),
(3, 3, 3, 1,  450.00, '2024-03-07', 'online'),
(4, 1, 4, 2,  120.00, '2024-03-08', 'presencial'),
(5, 4, 5, 3,  130.00, '2024-03-10', 'presencial'),
(6, 2, 6, 4,   95.00, '2024-03-11', 'presencial'),
(7, 5, 1, 1, 1200.00, '2024-03-12', 'online'),
(8, 3, 2, 8,   28.00, '2024-03-13', 'presencial'),
(9, 4, 4, 1,  120.00, '2024-03-14', 'online'),
(10, 5, 3, 2,  450.00, '2024-03-15', 'online');

--COMPROBACION DE LA CORRECTA CARGA DE DATOS--

SELECT * FROM Categorias
SELECT * FROM Clientes
SELECT * FROM Productos
SELECT * FROM Ventas