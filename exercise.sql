USE tiendaDiscos;

CREATE TABLE discos
(
    discoID     INT PRIMARY KEY,
    nombreDisco VARCHAR(255),
    artista     VARCHAR(255),
    género      VARCHAR(100),
    precio      DECIMAL(10, 2)
);

CREATE TABLE ventas
(
    ventaID    INT PRIMARY KEY,
    discoID    INT,
    cantidad   INT,
    fechaVenta VARCHAR(255),
    FOREIGN KEY (discoID) REFERENCES discos (discoID)
);

INSERT INTO discos (discoID, nombreDisco, artista, género, precio)
VALUES (1, 'The Dark Side of the Moon', 'Pink Floyd', 'Rock', 20.00),
       (2, 'Thriller', 'Michael Jackson', 'Pop', 25.00),
       (3, 'Back in Black', 'AC/DC', 'Rock', 22.50),
       (4, 'Abbey Road', 'The Beatles', 'Rock', 18.00),
       (5, 'Born in the U.S.A.', 'Bruce Springsteen', 'Rock', 19.99);

INSERT INTO ventas (ventaID, discoID, cantidad, fechaVenta)
VALUES (1, 1, 2, '2023-09-01'),
       (2, 2, 1, '2023-09-02'),
       (3, 3, 1, '2023-09-03'),
       (4, 4, 3, '2023-09-04'),
       (5, 5, 2, '2023-09-05');

#### Seleccionar todos los discos:
SELECT *
FROM discos;

#### Seleccionar discos del género "Rock":
SELECT *
FROM discos
WHERE género = 'Rock';

#### Seleccionar ventas realizadas en una fecha específica:
SELECT *
FROM ventas
WHERE fechaVenta = '2023-09-03';

#### Modificar el precio de un disco :
UPDATE discos
SET precio = 27.00
WHERE nombreDisco = 'Thriller';

#### Eliminar un disco:

#Para poder borrarlo porque si borro de discos discoID 5 me da un error ya que aparece en la tabla ventas
UPDATE ventas
SET discoID = 4
WHERE discoID = 5;

DELETE
FROM discos
WHERE DiscoID = 5;

#### Añadir la columna `Stock` en la tabla `discos`:
ALTER TABLE discos
    ADD Stock INT DEFAULT 50;

#### Contar el número total de ventas registradas:
SELECT COUNT(*) AS totalventas
FROM ventas;

#### *Extra Challenge*: Calcular el total de ingresos generados por las ventas:
SELECT SUM(discos.precio * ventas.cantidad) AS ingresosTotales
FROM ventas
         JOIN discos ON ventas.discoID = discos.discoID;

#### Calcular el precio promedio de los discos:
SELECT AVG(precio) AS precioPromedio
FROM discos;

#### Obtener el precio mínimo y máximo de los discos:
SELECT MIN(precio) AS precioMinimo, MAX(precio) AS precioMaximo
FROM discos;

#### Buscar discos cuyo nombre contiene una palabra clave:
SELECT *
FROM discos
WHERE nombreDisco LIKE '%Back%';

#### Seleccionar discos cuyo precio esté entre 10 y 50:
SELECT *
FROM discos
WHERE precio BETWEEN 10 AND 50;

#### Ordena los discos por el precio, de mayor a menor
SELECT *
FROM discos
ORDER BY precio DESC;

#### Ordena las ventas por la fecha de venta
SELECT *
FROM ventas
ORDER BY fechaVenta ASC;

#### Agrupa las ventas por discoID y cuenta cuántas veces se ha vendido cada disco.
SELECT discoID, COUNT(*) AS ventasTotales
FROM ventas
GROUP BY discoID;

#### Agrupa las ventas por discoID y selecciona solo los discos que se han vendido más de 2 veces, utilizando HAVING
SELECT discoID, COUNT(*) AS ventasTotales
FROM ventas
GROUP BY discoID
HAVING COUNT(*) > 2;

#### Selecciona los diferentes géneros disponibles en la tienda (sin duplicados)
SELECT DISTINCT género
FROM discos;

#### Selecciona todas las ventas con el nombre del disco correspondiente, utilizando un INNER JOIN
SELECT ventas.ventaID, discos.nombreDisco, ventas.cantidad, ventas.fechaVenta
FROM ventas
         INNER JOIN discos ON ventas.discoID = discos.discoID;

#### Muestra todos los discos y sus ventas, incluyendo aquellos discos que no han sido vendidos, utilizando un LEFT JOIN
# Datos para mostrar el left join mejor
INSERT INTO discos (discoID, nombreDisco, artista, género, precio)
VALUES (5, 'Chinatown', 'Thin Lizzy', 'Rock', 33.00);

SELECT discos.nombreDisco, ventas.ventaID, ventas.fechaVenta
FROM discos
         LEFT JOIN ventas ON discos.discoID = ventas.discoID;

#### Muestra todas las ventas, incluyendo aquellos registros de ventas que no tienen un disco correspondiente, utilizando un RIGHT JOIN
# Datos para mostrar el right join mejor
INSERT INTO ventas (ventaID, discoID, cantidad, fechaVenta)
VALUES
       (6, null, 3, '2024-09-21');

SELECT discos.nombreDisco, ventas.ventaID, ventas.fechaVenta
FROM discos
         RIGHT JOIN ventas ON discos.discoID = ventas.discoID;

#### Elimina la tabla ventas
DROP TABLE ventas;
