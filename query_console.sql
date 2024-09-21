#USE week5tuesday; # para usar esa database

# comando DDL CREATE
CREATE TABLE libros
(
    libroID     INT PRIMARY KEY, # columna1
    libroTitulo VARCHAR(255),    # ...
    libroPrecio DECIMAL(5, 2)    # NOT NULL DEFAULT 0
);

CREATE TABLE ventas
(
    ventaID       INT PRIMARY KEY,
    clienteNombre VARCHAR(255),
    libroID       INT,
    fechaVenta    VARCHAR(255)
    # ,FOREIGN KEY (libroID) REFERENCES libros (libroID)
);

# constraint - restricción
ALTER TABLE ventas
    ADD CONSTRAINT fk_libros FOREIGN KEY (libroID) REFERENCES libros (libroID);

# comando DDL ALTER - modifica la estructura
ALTER TABLE libros
    MODIFY libroPrecio INT;

# comando DML (Data Manipulation Language) INSERT
INSERT INTO libros (libroTitulo, libroID, libroPrecio)
VALUES ('Dune', 101, 19),
       ('1984', 102, 15),
       ('El Hobbit', 103, 25);

INSERT INTO ventas (ventaID, clienteNombre, libroID, fechaVenta)
VALUES (1, 'Juan Perez', 101, '2022-01-01'),
       (2, 'Ana Gómez', 102, '2022-01-02'),
       (3, 'Juan Perez', 101, '2022-01-03'),
       (4, 'Sara Lina', 103, '2022-01-01'),
       (5, 'Sara Lina', 101, '2022-01-02');

# comando DML UPDATE -  modifica los valores (los datos)
UPDATE libros
SET libroPrecio = 20
WHERE libroTitulo = 'Dune';

UPDATE libros
SET libroTitulo = 'nuevo',
    libroPrecio = 50
WHERE libroID = 101;

# comando DDL DROP - para borrar tablas, indices, columnas

DROP TABLE libros;

ALTER TABLE libros
    DROP COLUMN libroTitulo;


# comando DML DELETE

DELETE
FROM libros
WHERE libroID = 101;

# comando DML SELECT
SELECT *
FROM libros;

SELECT libroID, libroPrecio
FROM libros;

SELECT libroTitulo AS title, libroPrecio
FROM libros
WHERE libroPrecio >= 20;

# AND , OR


# Consultas - Queries - de agregación (DML)
SELECT COUNT(*) AS totalVentas
FROM ventas;

SELECT SUM(libroPrecio) AS totalPreciosLibros
FROM libros;

SELECT AVG(libroPrecio) AS promedioPreciosLibros
FROM libros;

SELECT MAX(libroPrecio) AS precioMaximo, MIN(libroPrecio) AS precioMinimo
FROM libros;

SELECT *
FROM libros
WHERE libroTitulo LIKE '%it';

SELECT *
FROM libros
WHERE libroTitulo LIKE '__n_';

SELECT librotitulo
FROM libros
WHERE librotitulo LIKE '%98%';

SELECT *
FROM libros
WHERE libroPrecio LIKE '%5';

SELECT *
FROM libros
WHERE libroPrecio LIKE '2%';

SELECT *
FROM libros
WHERE libroPrecio LIKE 25;

SELECT *
FROM libros
WHERE libroPrecio BETWEEN 15 AND 20;

SELECT libroID, COUNT(*) AS ventasTotales
FROM ventas
GROUP BY libroID;

SELECT libroID, COUNT(*) AS ventasTotales
FROM ventas
GROUP BY libroID
HAVING COUNT(*) > 1;

SELECT clienteNombre, COUNT(*) AS duplicateClienteNombre
FROM ventas
GROUP BY clienteNombre
HAVING COUNT(*) > 1;

SELECT libroTitulo, libroPrecio
FROM libros
ORDER BY libroPrecio DESC;

SELECT libroTitulo, libroPrecio
FROM libros
ORDER BY libroTitulo ASC;

SELECT DISTINCT clienteNombre
FROM ventas;

# ---------- Para que se vean los joins mejor metemos una venta sin libroID y un libro que no se haya vendido
INSERT INTO libros (libroTitulo, libroID, libroPrecio)
VALUES ('It', 104, 13);

INSERT INTO ventas (ventaID, clienteNombre, libroID, fechaVenta)
VALUES (8, 'Ana Gómez', null, '2022-01-03');

# INNER JOIN - coincidencias en las dos tablas
# SELECT *
SELECT clienteNombre, libros.libroTitulo, fechaVenta, libroPrecio
FROM ventas
         INNER JOIN libros ON ventas.libroID = libros.libroID;

# LEFT JOIN - todas las filas de la tabla izq y las coincidencias de la tabla derecha

SELECT libroTitulo, libroPrecio, clienteNombre, fechaVenta
FROM libros li
         LEFT JOIN ventas ve ON li.libroID = ve.libroID;

SELECT clienteNombre, fechaVenta, libroPrecio, libroTitulo
FROM ventas ve
         LEFT JOIN libros li ON ve.libroID = li.libroID;

# RIGHT JOIN - todas las filas de la tabla derecha y las coincidencias de la tabla izquierda

SELECT libroTitulo, clienteNombre
FROM libros li
         RIGHT JOIN ventas ve ON li.libroID = ve.libroID;

SELECT clienteNombre, libroTitulo
FROM ventas ve
         RIGHT JOIN libros li ON ve.libroID = li.libroID;


# FULL JOIN - todas las filas cuando hay coincidencias en cualquiera de las tablas

SELECT libroTitulo, ventaID
FROM libros
         LEFT JOIN ventas v on libros.libroID = v.libroID

UNION

SELECT libroTitulo, ventaID
FROM libros
         RIGHT JOIN ventas v on libros.libroID = v.libroID;

# SELECT libroTitulo, ventaID
# FROM libros li
# FULL JOIN ventas v on li.libroID = v.libroID;


# número total de ventas por libro
SELECT libroTitulo, COUNT(ventaID) AS numeroDeVentas
FROM ventas
         JOIN libros l on ventas.libroID = l.libroID
GROUP BY libroTitulo;

# ingreso total por cada libro vendido

SELECT libroTitulo, SUM(libroPrecio) AS ingresoTotal
FROM ventas
         INNER JOIN libros on ventas.libroID = libros.libroID
GROUP BY libroTitulo;

# libros que se han vendido más de una vez

SELECT libroTitulo, COUNT(*) AS numeroDeVentas
FROM ventas
         INNER JOIN libros on ventas.libroID = libros.libroID
GROUP BY libroTitulo
HAVING numeroDeVentas > 1;

