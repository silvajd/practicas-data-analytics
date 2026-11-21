-- =====================================================================
-- Módulo 3 · Unidad 5 · Manipulación de datos con DML
-- Práctica: DDL y DML en SQL, administrando el inventario de BodegaTech
-- Autora: Josefina Silva
--
-- Motor: SQL Server (SSMS). Antes de ejecutar, elegí la base de datos
-- de trabajo en el desplegable de SSMS y ejecutá el script completo (F5).
-- =====================================================================


-- =====================================================================
-- SECCIÓN DDL: definición de la estructura
-- =====================================================================

-- Paso 1: si la tabla ya existe, se elimina para poder re-ejecutar el
-- script sin errores.
DROP TABLE IF EXISTS inventario;

-- Paso 2: creación de la tabla inventario.
CREATE TABLE inventario (
    -- INT: identificador numérico entero. Es la clave primaria (PK), así
    -- que no puede repetirse ni quedar vacío.
    id_producto      INT            NOT NULL PRIMARY KEY,

    -- VARCHAR(100): el nombre es texto de largo variable; 100 caracteres
    -- alcanzan para nombres como "Hub USB-C 7 puertos" sin reservar
    -- espacio de más.
    nombre_producto  VARCHAR(100)   NOT NULL,

    -- VARCHAR(50): las categorías son palabras cortas (Audio,
    -- Accesorios, Computación), por eso alcanza con un límite menor.
    categoria        VARCHAR(50)    NOT NULL,

    -- DECIMAL(10,2): el precio es dinero. DECIMAL guarda el valor exacto
    -- con 2 decimales (hasta 99999999.99); FLOAT guarda aproximaciones y
    -- puede generar errores de redondeo al sumar o multiplicar precios.
    precio_unitario  DECIMAL(10,2)  NOT NULL,

    -- INT: el stock se cuenta en unidades enteras (no existe medio mouse)
    -- y hay que poder restarle las ventas.
    stock_actual     INT            NOT NULL,

    -- INT: el umbral de reposición también es una cantidad de unidades.
    stock_minimo     INT            NOT NULL,

    -- DATE: solo interesa el día de ingreso, no la hora. Como fecha (y no
    -- como texto) se puede filtrar y agrupar por períodos.
    fecha_ingreso    DATE           NOT NULL,

    -- TINYINT: 1 = disponible, 0 = descontinuado. La consigna sugiere
    -- TINYINT(1), que es la sintaxis de MySQL; en SQL Server TINYINT no
    -- lleva tamaño entre paréntesis (ocupa 1 byte, valores de 0 a 255).
    -- El CHECK limita los valores a 0 y 1.
    activo           TINYINT        NOT NULL CHECK (activo IN (0, 1))
);


-- =====================================================================
-- SECCIÓN DML: carga y actualización de los datos
-- =====================================================================

-- Paso 3: carga de los 10 productos actuales. Se nombran las columnas
-- para que cada valor vaya a la columna correcta. Texto y fechas van
-- entre comillas simples; los números, sin comillas.
INSERT INTO inventario
    (id_producto, nombre_producto, categoria, precio_unitario,
     stock_actual, stock_minimo, fecha_ingreso, activo)
VALUES
    (1,  'Laptop Pro 15',       'Computación',    1200.00, 15,  3, '2024-01-10', 1),
    (2,  'Mouse Inalámbrico',   'Accesorios',       28.00, 80, 10, '2024-01-10', 1),
    (3,  'Monitor 4K 27"',      'Computación',     450.00, 12,  2, '2024-01-15', 1),
    (4,  'Teclado Mecánico',    'Accesorios',       95.00, 40,  5, '2024-01-15', 1),
    (5,  'Laptop Basic 14',     'Computación',     650.00, 20,  3, '2024-02-01', 1),
    (6,  'Auriculares BT Pro',  'Audio',           120.00, 35,  5, '2024-02-01', 1),
    (7,  'Hub USB-C 7 puertos', 'Accesorios',       45.00, 60, 10, '2024-02-10', 1),
    (8,  'Webcam HD 1080p',     'Accesorios',       85.00, 25,  5, '2024-02-10', 1),
    (9,  'SSD Externo 1TB',     'Almacenamiento',  130.00, 18,  3, '2024-03-01', 1),
    (10, 'Parlante Bluetooth',  'Audio',            60.00, 45,  8, '2024-03-01', 1);

-- Paso 4: ventas del día. Cada UPDATE resta las unidades vendidas al
-- stock actual y tiene su WHERE, para modificar solo ese producto.

-- Laptop Pro 15: se vendieron 3 unidades (15 - 3 = 12).
UPDATE inventario
SET stock_actual = stock_actual - 3
WHERE id_producto = 1;

-- Mouse Inalámbrico: se vendieron 12 unidades (80 - 12 = 68).
UPDATE inventario
SET stock_actual = stock_actual - 12
WHERE id_producto = 2;

-- Auriculares BT Pro: se vendieron 5 unidades (35 - 5 = 30).
UPDATE inventario
SET stock_actual = stock_actual - 5
WHERE id_producto = 6;

-- Paso 5: la Webcam HD 1080p fue descontinuada por el proveedor.
-- No se borra la fila (se pierde su historial); se marca como inactiva.
UPDATE inventario
SET activo = 0
WHERE id_producto = 8;


-- =====================================================================
-- VALIDACIÓN
-- =====================================================================

-- Paso 6: se deben ver los 10 productos, con stock 12 en la Laptop Pro,
-- 68 en el Mouse, 30 en los Auriculares y activo = 0 en la Webcam.
SELECT * FROM inventario;
