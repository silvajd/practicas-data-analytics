-- =====================================================================
-- Módulo 2 · Unidad 1 · Diseño de esquemas con DDL y tipos de datos
-- Práctica: estructura de un sistema de gestión de ventas
-- Autora: Josefina Silva
--
-- El script crea dos tablas (clientes y productos) con CREATE TABLE.
-- Usa solo tipos que existen en SQL Server y en PostgreSQL, así que se
-- puede ejecutar completo en cualquiera de los dos motores.
-- =====================================================================

-- Si las tablas ya existen (por ejemplo, al ejecutar el script por
-- segunda vez), se eliminan antes de crearlas de nuevo.
-- DROP TABLE IF EXISTS funciona en SQL Server 2016 o superior y en PostgreSQL.
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS productos;


-- ---------------------------------------------------------------------
-- Tabla CLIENTES: una fila por cada cliente registrado
-- ---------------------------------------------------------------------
CREATE TABLE clientes (
    -- INT: el identificador es un número entero; no tiene decimales y
    -- ocupa poco espacio (4 bytes), lo que acelera las búsquedas y los
    -- cruces con otras tablas.
    id_cliente      INT,

    -- VARCHAR(100): el nombre es texto de longitud variable. Con 100
    -- caracteres alcanza para nombre y apellido completos, y VARCHAR solo
    -- usa el espacio de las letras que realmente se guardan.
    nombre          VARCHAR(100),

    -- TEXT: la biografía o las notas son un texto largo y de extensión
    -- impredecible, por eso no conviene ponerle un límite fijo.
    -- (En SQL Server moderno también se puede usar VARCHAR(MAX); elegí
    -- TEXT porque existe en ambos motores y es el tipo para textos largos
    -- que propone la unidad.)
    perfil_bio      TEXT,

    -- DATE: solo interesa el día del registro (año-mes-día), no la hora.
    -- Guardarla como fecha y no como texto permite filtrar por períodos
    -- y agrupar por mes en SQL o en Power BI.
    fecha_registro  DATE
);


-- ---------------------------------------------------------------------
-- Tabla PRODUCTOS: una fila por cada producto del catálogo
-- ---------------------------------------------------------------------
CREATE TABLE productos (
    -- INT: identificador numérico entero, igual que en clientes.
    id_producto     INT,

    -- VARCHAR(255): la descripción es más larga que un nombre, pero sigue
    -- siendo un texto acotado; 255 caracteres alcanzan para describir el
    -- producto sin reservar espacio de más.
    descripcion     VARCHAR(255),

    -- DECIMAL(10, 2): hasta 10 dígitos en total, 2 de ellos decimales
    -- (máximo 99999999.99). DECIMAL guarda el valor exacto, por eso es el
    -- tipo correcto para dinero. FLOAT guarda aproximaciones y puede
    -- generar errores de redondeo al sumar precios.
    precio          DECIMAL(10, 2),

    -- SMALLINT con CHECK: el producto está a la venta (1) o no (0).
    -- Un número pequeño ocupa solo 2 bytes y es fácil de sumar o filtrar
    -- (por ejemplo, contar productos activos con SUM). El CHECK impide
    -- que se cargue cualquier otro valor. Elegí SMALLINT porque existe en
    -- ambos motores; en SQL Server también serviría BIT y en PostgreSQL,
    -- BOOLEAN. Un texto como 'SI'/'NO' ocuparía más espacio y aceptaría
    -- variantes como 'si' o 'Sí', que complican el análisis.
    esta_activo     SMALLINT CHECK (esta_activo IN (0, 1))
);
