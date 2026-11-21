# Prácticas de Data Analytics

Prácticas opcionales del curso **Data Analytics** de Coderhouse. Las entregas del proyecto integrador RetailPro están en el repositorio [ventas_tech_db](https://github.com/silvajd/ventas_tech_db).

## Contenido

| Archivo | Unidad | Qué hace |
|---|---|---|
| `modulo2_unidad1_diseno.sql` | Diseño de esquemas con DDL y tipos de datos | Crea las tablas `clientes` y `productos` con `CREATE TABLE`, con comentarios que justifican el tipo de dato de cada columna. |
| `modulo3_unidad5_bodegatech.sql` | Manipulación de datos con DML | Crea la tabla `inventario` de BodegaTech (DDL), carga 10 productos con `INSERT`, registra las ventas del día y una baja con `UPDATE ... WHERE` (DML) y valida el resultado con `SELECT`. |

## Cómo ejecutar

- **`modulo2_unidad1_diseno.sql`** usa solo tipos que existen en SQL Server y en PostgreSQL.
  - **SQL Server (SSMS):** abrí el archivo, elegí la base de datos donde querés crear las tablas y ejecutalo con F5.
  - **PostgreSQL:** `psql -d nombre_de_tu_base -f modulo2_unidad1_diseno.sql`
- **`modulo3_unidad5_bodegatech.sql`** está escrito para SQL Server: abrilo en SSMS, elegí la base de datos de trabajo y ejecutalo completo con F5. Se puede ejecutar varias veces, porque empieza borrando la tabla si ya existe.

## Autoría

Josefina Silva – Curso de Data Analytics, Coderhouse
