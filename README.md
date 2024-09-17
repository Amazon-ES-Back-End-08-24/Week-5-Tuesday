## Dónde encontrar la query console

Se encuentra en el archivo, en este proyecto, [query_console.sql](query_console.sql)

## Tabla Original

| ClienteNombre | LibroID | LibroTitulo | LibroPrecio | FechaVenta |
|---------------|---------|-------------|-------------|------------|
| Juan Perez    | 101     | Dune        | 20          | 2022-01-01 |
| Ana Gómez     | 102     | 1984        | 15          | 2022-01-02 |
| Juan Perez    | 101     | Dune        | 20          | 2022-01-03 |
| Sara Lina     | 103     | El Hobbit   | 25          | 2022-01-01 |
| Ana Gómez     | 102     | 1984        | 15          | 2022-01-02 |
| Sara Lina     | 101     | Dune        | 20          | 2022-01-02 |

## 1NF

- Columna valor indivisible: cada columna tiene un único valor
- Columna nombre único
- Columna único tipo de dato
- Filas no repetidos

| ClienteNombre | LibroID | LibroTitulo | LibroPrecio | FechaVenta |
|---------------|---------|-------------|-------------|------------|
| Juan Perez    | 101     | Dune        | 20          | 2022-01-01 |
| Ana Gómez     | 102     | 1984        | 15          | 2022-01-02 |
| Juan Perez    | 101     | Dune        | 20          | 2022-01-03 |
| Sara Lina     | 103     | El Hobbit   | 25          | 2022-01-01 |
| Sara Lina     | 101     | Dune        | 20          | 2022-01-02 |

## 2NF

- 1NF
- todos los atributos dependen de un ID, o clave primaria (PK - primary key)

| VentaId | ClienteNombre | LibroID | LibroTitulo | LibroPrecio | FechaVenta |
|---------|---------------|---------|-------------|-------------|------------|
| 1       | Juan Perez    | 101     | Dune        | 20          | 2022-01-01 |
| 2       | Ana Gómez     | 102     | 1984        | 15          | 2022-01-02 |
| 3       | Juan Perez    | 101     | Dune        | 20          | 2022-01-03 |
| 4       | Sara Lina     | 103     | El Hobbit   | 25          | 2022-01-01 |
| 5       | Sara Lina     | 101     | Dune        | 20          | 2022-01-02 |

## 3NF

- 2NF
- atributos NO clave (no IDs) no dependan de otros atributos NO clave
- FK (foreign key) - cláve foránea que hace referencia a la clave primaria de otra tabla: LibroID en la tabla de Ventas

| VentaId | ClienteNombre | LibroID | FechaVenta |
|---------|---------------|---------|------------|
| 1       | Juan Perez    | 101     | 2022-01-01 |
| 2       | Ana Gómez     | 102     | 2022-01-02 |
| 3       | Juan Perez    | 101     | 2022-01-03 |
| 4       | Sara Lina     | 103     | 2022-01-01 |
| 5       | Sara Lina     | 101     | 2022-01-02 |

| LibroID | LibroTitulo | LibroPrecio |
|---------|-------------|-------------|
| 101     | Dune        | 20          |
| 102     | 1984        | 15          |
| 103     | El Hobbit   | 25          |

## Data Definition Language (DDL)

El **DDL (Data Definition Language)** es un subconjunto del lenguaje SQL que se utiliza para definir y gestionar la *
*estructura** de los objetos de base de datos, como tablas, índices y vistas.

### **CREATE**

Este comando crea una nueva tabla en la base de datos.

```sql
CREATE TABLE Libros
(
    LibroID     INT PRIMARY KEY,
    LibroTitulo VARCHAR(255),
    LibroPrecio DECIMAL(5, 2)
);
```

Esto crea una tabla llamada `Libros` con tres columnas: `LibroID`, `LibroTitulo` y `LibroPrecio`. La columna `LibroID`
es la clave primaria (única).

### **ALTER**

El comando `ALTER` permite modificar la estructura de una tabla existente. Por ejemplo, si necesitamos modificar el tipo
de datos de una columna.

```sql
ALTER TABLE Libros
    MODIFY LibroPrecio DECIMAL(10, 2);
```

Este comando cambia la precisión del precio de los libros.

### **DROP**

El comando `DROP` elimina una tabla y todos los datos almacenados en ella.

```sql
DROP TABLE Ventas;
```

Este comando elimina la tabla `Ventas` completamente de la base de datos.

---

## Data Manipulation Language (DML)

El **DML (Data Manipulation Language)** es un subconjunto del lenguaje SQL que se utiliza para **manipular
y gestionar** los datos dentro de los objetos de base de datos, como tablas. A través de comandos DML, puedes insertar,
actualizar, eliminar y consultar los datos almacenados en las tablas, pero **sin alterar su estructura**.

- Ejemplos: SELECT, INSERT, UPDATE, DELETE, WHERE, COUNT, AVG, SUM, GROUP BY, HAVING, ORDER BY, DISTINCT, LIKE, BETWEEN,
  JOIN...

### **UPDATE**

El comando `UPDATE` permite actualizar una tabla existente.

```sql
UPDATE Libros
SET LibroPrecio = 22.00 -- Nuevo precio
WHERE LibroTitulo = 'Dune';
```

### Consultas SQL Básicas

#### **INSERT INTO** – Insertar datos en una tabla

Este comando agrega datos a una tabla.

```sql
INSERT INTO Libros (LibroID, LibroTitulo, LibroPrecio)
VALUES (101, 'Dune', 20.00);
```

#### **SELECT** – Consultar datos de una tabla

Este comando selecciona datos de una o varias tablas.

```sql
SELECT *
FROM Libros;
```

Esto selecciona todos los registros de la tabla `Libros`.

Si queremos filtrar los resultados, podemos agregar una cláusula `WHERE`:

```sql
SELECT LibroTitulo, LibroPrecio
FROM Libros
WHERE LibroPrecio = 15;
```

Esto selecciona solo los libros cuyo precio es 15.

---

### Consultas con Agregación

Las **funciones de agregación** en SQL nos permiten realizar cálculos en conjuntos de datos, devolviendo un solo valor
como resultado.

#### **COUNT** – Contar filas

```sql
SELECT COUNT(*) AS TotalVentas
FROM Ventas;
```

Cuenta el número total de ventas registradas.

#### **SUM** – Sumar valores

```sql
SELECT SUM(LibroPrecio) AS Precios
FROM Libros;
```

Calcula el total de ingresos generados por las ventas de libros.

#### **AVG** – Calcular promedio

```sql
SELECT AVG(LibroPrecio) AS PrecioPromedio
FROM Libros;
```

Calcula el precio promedio de todos los libros.

#### **MIN/MAX** – Valor mínimo y máximo

```sql
SELECT MIN(LibroPrecio) AS PrecioMinimo, MAX(LibroPrecio) AS PrecioMaximo
FROM Libros;
```

Devuelve el precio mínimo y máximo de los libros.

---

### Operadores Lógicos

#### **LIKE**

Busca patrones en cadenas de texto

Buscar libros cuyo título comienza con cualquier letra pero siempre termina con "el":

```sql
SELECT *
FROM Libros
WHERE LibroTitulo LIKE '%el';
```

Encontrar libros cuyo título tiene exactamente tres letras, siendo la segunda una 'u':

```sql
SELECT *
FROM Libros
WHERE LibroTitulo LIKE '_u_';
```

Buscar libros cuyo título contiene la palabra "man" en cualquier parte:

```sql
SELECT *
FROM Libros
WHERE LibroTitulo LIKE '%man%';
```

#### **BETWEEN:**

Selecciona valores dentro de un rango dado.

Selecciona los libros cuyo precio esté entre 15 y 25:

```sql
SELECT *
FROM Libros
WHERE LibroPrecio BETWEEN 15 AND 25;
```

---

## Ejercicio Práctico: Gestión de Inventario en una Tienda de Discos (45 min)

### Contexto:

Vas a crear una base de datos para gestionar el inventario y las ventas de una tienda de discos. El objetivo de este
ejercicio es que practiques la creación de tablas, manipulación de datos, y realización de consultas utilizando SQL.

### Tareas:

1. **Creación de Base de Datos y Data Source**:

- Configura la conexión en IntelliJ a MySQL.
- Crea una base de datos (schema) llamada `TiendaDiscos`.

2. **Creación de Tablas**:

- Crea una tabla llamada `Discos` con los siguientes campos:
    - `DiscoID` (entero, clave primaria)
    - `NombreDisco` (cadena de texto)
    - `Artista` (cadena de texto)
    - `Género` (cadena de texto)
    - `Precio` (número decimal)
- Crea una tabla llamada `Ventas` que registre las ventas de discos. Incluye los campos:
    - `VentaID` (entero, clave primaria)
    - `DiscoID` (entero, clave foránea que hace referencia a `DiscoID` en la tabla `Discos`)
    - `Cantidad` (entero)
    - `FechaVenta` (cadena de texto)

3. **Inserción de Datos**:

- Inserta al menos cinco discos en la tabla `Discos`.
- Inserta varias ventas en la tabla `Ventas`, asegurándote de que algunas ventas correspondan a varios discos.

4. **Consultas Básicas**:

- Realiza una consulta que seleccione todos los discos en la tabla `Discos`.
- Realiza una consulta que seleccione todos los discos de un género específico (por ejemplo, "Rock").
- Realiza una consulta que seleccione las ventas realizadas en una fecha específica.

5. **Actualizar Datos**:

- Modifica el precio de uno de los discos en la tabla `Discos`.

6. **Eliminar Datos**:

- Elimina uno de los discos de la tabla `Discos`.

7. **Modificar la Estructura de las Tablas**:

- Añade una nueva columna llamada `Stock` en la tabla `Discos` para registrar la cantidad de discos disponibles en el
  inventario.

8. **Consultas con Funciones de Agregación**:

- Cuenta el número total de ventas registradas.
- Calcula el total de ingresos generados por las ventas, sumando el precio de los discos vendidos. *EXTRA CHALLENGE*
- Calcula el precio promedio de los discos en la tabla `Discos`.
- Obtén el precio mínimo y máximo de los discos.

9. **Consultas con Operadores Lógicos**:

- Realiza una consulta para buscar discos cuyo nombre contenga una palabra clave específica (por ejemplo, "Hits").
- Realiza una consulta que seleccione los discos cuyo precio esté dentro de un rango específico (por ejemplo, entre 10 y
  50).

10. **Eliminar una Tabla**:

- Elimina la tabla `Ventas` al final del ejercicio.

---

### Entregables:

Al final del ejercicio, deberás haber realizado las siguientes acciones:

- Creado y modificado las tablas de una base de datos.
- Insertado y actualizado datos sobre discos y ventas.
- Realizado consultas con cláusulas básicas, operadores lógicos, y funciones de agregación.
- Practicado el uso de DDL y DML en SQL para gestionar datos y la estructura de una base de datos de una tienda de
  discos.