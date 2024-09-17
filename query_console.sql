# USE DATABASENAME; --> para usar esa database

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

SELECT MAX(libroPrecio) AS precioMaximo , MIN(libroPrecio) AS precioMinimo
FROM libros;

SELECT * FROM libros
WHERE libroTitulo LIKE '%it';

SELECT * FROM libros
WHERE libroTitulo LIKE '__n_';

SELECT librotitulo FROM libros
WHERE librotitulo LIKE '%98%';

SELECT * FROM libros
WHERE libroPrecio LIKE '%5';

SELECT * FROM libros
WHERE libroPrecio LIKE '2%';

SELECT * FROM libros
WHERE libroPrecio LIKE 25;

SELECT * FROM libros
WHERE libroPrecio BETWEEN 15 AND 20;
