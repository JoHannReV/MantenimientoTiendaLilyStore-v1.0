create  DATABASE LilyStore;
USE LilyStore;

-- TABLA DE CARGOS
CREATE TABLE Cargos (
    cargoID INT AUTO_INCREMENT PRIMARY KEY,
    nombreCargo VARCHAR(50) NOT NULL
);


-- TABLA ACCESO EMPLEADO 

CREATE TABLE UsuariosAcceso (
    usuarioID INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50)   UNIQUE,
    password VARCHAR(100)  
);

-- TABLA EMPLEADO 
CREATE TABLE Empleados (
    codigo_emp INT AUTO_INCREMENT PRIMARY KEY,
    nombre_emp VARCHAR(255) ,
    apellido_emp VARCHAR(255) ,
    email_emp VARCHAR(255)  UNIQUE,
    numero_emp VARCHAR(20) ,
    tipo_documento varchar(20),
    documento_emp VARCHAR(50) ,
    provincia_emp VARCHAR(255) ,
    distrito_emp VARCHAR(255) ,
    direccion_emp VARCHAR(255) ,
    sueldo_bruto_emp DECIMAL(10,2) ,
    sueldo_neto_emp DECIMAL(10,2) ,
    tipo_pension_emp VARCHAR(20) ,
    descuento_pension_emp DECIMAL(10,2) ,
    tipo_seguro_emp VARCHAR(20) ,
    descuento_seguro_emp DECIMAL(10,2) ,
    cargoID INT,
    usuarioID INT,
    FOREIGN KEY (cargoID) REFERENCES Cargos(cargoID),
    FOREIGN KEY (usuarioID) REFERENCES UsuariosAcceso(usuarioID)
);

-- TABLE CLIENTE--
CREATE TABLE CLIENTES(
    CODIGO_CLIE INT AUTO_INCREMENT PRIMARY KEY,
    NOMBRE_CLIE VARCHAR(255)  ,
    APELLIDO_CLIE VARCHAR(255)  ,
    TIPO_DOCUMENTO VARCHAR(255)  ,
	DOCUMENTO_CLIE VARCHAR(255),
    EMAIL_CLIE VARCHAR(255)   UNIQUE,
    PROVINCIA_CLIE VARCHAR(255) ,
    DISTRITO_CLIE VARCHAR(255)  ,
    DIRECCION_CLIE VARCHAR(255) ,
    NUMERO_CLIE VARCHAR(20)
    );

-- TABLA PROOVEDORES 
CREATE TABLE PROVEEDORES(
PROVEEDORID INT AUTO_INCREMENT PRIMARY KEY,
NOMBRE_PROVE VARCHAR(244)  ,
PAIS_PROVE VARCHAR(255)  ,
NUMERO_PROVE VARCHAR(30) ,
DIRECCION_PROVE VARCHAR(255),
EMAIL_PROVE VARCHAR(255) ,  
TELEFONO_PROVE VARCHAR(30)    
)

-- TABLA PRODUCTOS 

create TABLE PRODUCTOS (
    CODIGO_PROD INT AUTO_INCREMENT PRIMARY KEY,
    MARCA_ID INT,                               -- Como marca Supreme, Exios, etc.
    PRENDA_PROD VARCHAR(255),                   -- Como polo, casaca, etc.
    NOMBRE_PROD VARCHAR(255),                   -- Classic Logo Tee
    CATEGORIA_PROD VARCHAR(255),                 -- Hombre, mujer, niño, etc.
    DESCRIPCION_PROD TEXT,
    TALLA_PROD VARCHAR(255),                    -- Tallas disponibles: XL, L, M, S
    NUMERO_LOTE_PROD VARCHAR(50),               -- Lote del producto
    PRECIO_INGRESO_PROD DECIMAL(10, 2),        -- Precio bruto
    GANANCIA_PROD DECIMAL(5, 2) DEFAULT 0.20,  -- Ganancia del 20%
    DESCUENTO DECIMAL(5, 2) DEFAULT 0.00,      -- Descuento por oferta
    PRECIO_FINAL DECIMAL(10, 2),                -- Precio final calculado en el trigger
    STOCK INT,                                   -- Cantidad en stock
    FECHA_INGRESO DATETIME DEFAULT CURRENT_TIMESTAMP, -- Fecha de ingreso
    FECHA_MODIFICACION DATETIME DEFAULT NULL,   -- Fecha de modificación por defecto NULL
    FOREIGN KEY (MARCA_ID) REFERENCES PROVEEDORES(PROVEEDORID) -- Referencia a la tabla PROVEEDORES
);


CREATE TABLE VENTAS (
    ID_VENTA INT AUTO_INCREMENT PRIMARY KEY,          -- código de venta
    DOCUMENTO VARCHAR(20),                            -- buscaré mediante DNI
    TIPO_DOCUMENTO VARCHAR(20),                       -- saldrá por la búsqueda
    CODIGO_CLIE INT,                                  -- saldrá por la búsqueda
    NOMBRE_CLIE VARCHAR(100),                         -- saldrá por la búsqueda
    APELLIDO_CLIE VARCHAR(100),                       -- saldrá por la búsqueda
    NOMBRE_EMPLEADO VARCHAR(100),                     -- automáticamente por el login
    CODIGO_PROD INT,                                  -- código del producto
    PRENDA_PROD VARCHAR(100),                         -- auto, prenda según el ID
    NOMBRE_PROD VARCHAR(100),                         -- auto, nombre del producto
    CATEGORIA_PROD VARCHAR(100),                      -- auto, sexo del producto
    TALLA_PROD VARCHAR(50),                           -- auto, talla del producto seleccionado
    CANTIDAD INT,                                     -- a elegir en la caja de texto
    DESCUENTO DECIMAL(10, 2) DEFAULT 0,               -- automáticamente de productos, descuento
    PRECIO_PROD DECIMAL(10, 2) DEFAULT 0,             -- automáticamente de productos, precio final
    TOTAL DECIMAL(10, 2) DEFAULT 0,                   -- Total calculado
    FECHA_VENTA DATETIME DEFAULT CURRENT_TIMESTAMP,   -- se generará automáticamente en la BD
    FECHA_MODIFICACION DATETIME DEFAULT NULL,         -- Fecha de modificación por defecto NULL
    FOREIGN KEY (CODIGO_CLIE) REFERENCES CLIENTES(CODIGO_CLIE),
    FOREIGN KEY (CODIGO_PROD) REFERENCES PRODUCTOS(CODIGO_PROD)
);
DELIMITER //

CREATE PROCEDURE insertarVenta(
    IN p_documento VARCHAR(20),
    IN p_tipo_documento VARCHAR(20),
    IN p_codigo_clie INT,
    IN p_nombre_clie VARCHAR(100),
    IN p_apellido_clie VARCHAR(100),
    IN p_nombre_empleado VARCHAR(100),
    IN p_codigo_prod INT,
    IN p_prenda_prod VARCHAR(100),
    IN p_nombre_prod VARCHAR(100),
    IN p_categoria_prod VARCHAR(100),
    IN p_talla_prod VARCHAR(50),
    IN p_cantidad INT,
    IN p_descuento DECIMAL(10, 2),
    IN p_precio_prod DECIMAL(10, 2)
)
BEGIN
    DECLARE total DECIMAL(10, 2);
    
    -- Calcular el total
    SET total = p_precio_prod * p_cantidad;

    -- Insertar la venta
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            -- Manejo de error
            ROLLBACK;  -- Revertir cualquier cambio
            SELECT 'Error al insertar la venta';
        END;

        INSERT INTO VENTAS (
            DOCUMENTO,
            TIPO_DOCUMENTO,
            CODIGO_CLIE,
            NOMBRE_CLIE,
            APELLIDO_CLIE,
            NOMBRE_EMPLEADO,
            CODIGO_PROD,
            PRENDA_PROD,
            NOMBRE_PROD,
            CATEGORIA_PROD,
            TALLA_PROD,
            CANTIDAD,
            DESCUENTO,
            TOTAL
        ) VALUES (
            p_documento,
            p_tipo_documento,
            p_codigo_clie,
            p_nombre_clie,
            p_apellido_clie,
            p_nombre_empleado,
            p_codigo_prod,
            p_prenda_prod,
            p_nombre_prod,
            p_categoria_prod,
            p_talla_prod,
            p_cantidad,
            p_descuento,
            total  -- Usar el total calculado
        );
    END;
END //

DELIMITER ;


-- procedimientos ALMACENADOS PRODUCTO 
DELIMITER //
CREATE PROCEDURE insertar_producto (
    IN p_MARCA_ID INT,
    IN p_PRENDA_PROD VARCHAR(255),
    IN p_NOMBRE_PROD VARCHAR(255),
    IN p_CATEGORIA_PROD VARCHAR(255),
    IN p_DESCRIPCION_PROD TEXT,
    IN p_TALLA_PROD VARCHAR(255),
    IN p_NUMERO_LOTE_PROD VARCHAR(50),
    IN p_PRECIO_INGRESO_PROD DECIMAL(10, 2),
    IN p_STOCK INT
)
BEGIN
    INSERT INTO PRODUCTOS (
        MARCA_ID,
        PRENDA_PROD,
        NOMBRE_PROD,
        CATEGORIA_PROD,
        DESCRIPCION_PROD,
        TALLA_PROD,
        NUMERO_LOTE_PROD,
        PRECIO_INGRESO_PROD,
        STOCK,
        FECHA_INGRESO
    ) VALUES (
        p_MARCA_ID,
        p_PRENDA_PROD,
        p_NOMBRE_PROD,
        p_CATEGORIA_PROD,
        p_DESCRIPCION_PROD,
        p_TALLA_PROD,
        p_NUMERO_LOTE_PROD,
        p_PRECIO_INGRESO_PROD,
        p_STOCK,
        CURRENT_TIMESTAMP
    );
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE EDITAR_PRODUCTO (
    IN p_CODIGO_PROD INT,
    IN p_MARCA_ID INT,
    IN p_PRENDA_PROD VARCHAR(255),
    IN p_NOMBRE_PROD VARCHAR(255),
    IN p_CATEGORIA_PROD VARCHAR(255),
    IN p_DESCRIPCION_PROD TEXT,
    IN p_TALLA_PROD VARCHAR(255),
    IN p_NUMERO_LOTE_PROD VARCHAR(50),
    IN p_PRECIO_INGRESO_PROD DECIMAL(10, 2),
    IN p_DESCUENTO DECIMAL(5, 2),
    IN p_STOCK INT
)
BEGIN
    -- Verificar si el producto existe
    IF EXISTS (SELECT 1 FROM PRODUCTOS WHERE CODIGO_PROD = p_CODIGO_PROD) THEN
        UPDATE PRODUCTOS
        SET MARCA_ID = p_MARCA_ID,
            PRENDA_PROD = p_PRENDA_PROD,
            NOMBRE_PROD = p_NOMBRE_PROD,
            CATEGORIA_PROD = p_CATEGORIA_PROD,
            DESCRIPCION_PROD = p_DESCRIPCION_PROD,
            TALLA_PROD = p_TALLA_PROD,
            NUMERO_LOTE_PROD = p_NUMERO_LOTE_PROD,
            PRECIO_INGRESO_PROD = p_PRECIO_INGRESO_PROD,
            DESCUENTO = p_DESCUENTO,
            STOCK = p_STOCK,
            FECHA_MODIFICACION = CURRENT_TIMESTAMP
        WHERE CODIGO_PROD = p_CODIGO_PROD;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El producto no existe.';
    END IF;
END; //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE ELIMINAR_PRODUCTO (
    IN p_CODIGO_PROD INT
)
BEGIN
    DELETE FROM PRODUCTOS
    WHERE CODIGO_PROD = p_CODIGO_PROD;
END; //

DELIMITER ;
-- PROCEDIMIENTOS ALMACENADOS CLIENTE 

-- INSERTAR CLIENTE

DELIMITER //

CREATE PROCEDURE INSERTARCLIENTE(
    IN p_nombre_clie VARCHAR(255),
    IN p_apellido_clie VARCHAR(255),
    IN p_email_clie VARCHAR(255),
    IN p_numero_clie VARCHAR(20),
    IN p_tipo_documento VARCHAR(20),
    IN p_documento_clie VARCHAR(50),
    IN p_provincia_clie VARCHAR(255),
    IN p_distrito_clie VARCHAR(255),
    IN p_direccion_clie VARCHAR(255)
)
BEGIN
    INSERT INTO CLIENTES (
        NOMBRE_CLIE, 
        APELLIDO_CLIE, 
        EMAIL_CLIE, 
        NUMERO_CLIE, 
        TIPO_DOCUMENTO, 
        DOCUMENTO_CLIE, 
        PROVINCIA_CLIE, 
        DISTRITO_CLIE, 
        DIRECCION_CLIE
    ) 
    VALUES (
        p_nombre_clie, 
        p_apellido_clie, 
        p_email_clie, 
        p_numero_clie, 
        p_tipo_documento, 
        p_documento_clie, 
        p_provincia_clie, 
        p_distrito_clie, 
        p_direccion_clie
    );
END //

DELIMITER ;

-- MODIFICAR CLIENTE

DELIMITER //

CREATE PROCEDURE MODIFICARCLIENTE(
    IN p_codigo_clie INT,
    IN p_nombre_clie VARCHAR(255),
    IN p_apellido_clie VARCHAR(255),
    IN p_email_clie VARCHAR(255),
    IN p_numero_clie VARCHAR(20),
    IN p_tipo_documento VARCHAR(20),
    IN p_documento_clie VARCHAR(50),
    IN p_provincia_clie VARCHAR(255),
    IN p_distrito_clie VARCHAR(255),
    IN p_direccion_clie VARCHAR(255)
)
BEGIN
    UPDATE CLIENTES
    SET 
        NOMBRE_CLIE = p_nombre_clie,
        APELLIDO_CLIE = p_apellido_clie,
        EMAIL_CLIE = p_email_clie,
        NUMERO_CLIE = p_numero_clie,
        TIPO_DOCUMENTO = p_tipo_documento,
        DOCUMENTO_CLIE = p_documento_clie,
        PROVINCIA_CLIE = p_provincia_clie,
        DISTRITO_CLIE = p_distrito_clie,
        DIRECCION_CLIE = p_direccion_clie
    WHERE 
        CODIGO_CLIE = p_codigo_clie;
END //

DELIMITER ;

-- ELIMINAR CLIENTE 

DELIMITER //

CREATE PROCEDURE ELIMINARCLIENTE(
    IN p_codigo_clie INT
)
BEGIN
    DELETE FROM CLIENTES
    WHERE CODIGO_CLIE = p_codigo_clie;
END //

DELIMITER ;

-- PROCESO ALMACENADOS EMPELADOS 

-- ACCESO AL SISTEMA EMPLEADO 

DELIMITER //
CREATE PROCEDURE SP_ACCESO_ADMINISTRADOR(
    IN login VARCHAR(15),
    IN clave VARCHAR(15)
)
BEGIN
    SELECT * FROM UsuariosAcceso WHERE username = login AND password = clave;
END //
DELIMITER ;



-- OBTENER EMPLEADO POR USUARIO 
DELIMITER //
CREATE PROCEDURE ObtenerEmpleadoPorUsuario(
    IN username_param VARCHAR(255)
)
BEGIN
    SELECT 
        e.nombre_emp,
        e.apellido_emp,
        c.nombreCargo
    FROM Empleados e
    JOIN UsuariosAcceso ua ON e.usuarioID = ua.usuarioID
    JOIN Cargos c ON e.cargoID = c.cargoID
    WHERE ua.username = username_param;
END //
DELIMITER ;



DELIMITER // 
-- ELIMINAR EMPLEADO 
CREATE PROCEDURE eliminarEmpleado(IN p_codigo_emp INT)
BEGIN
    DECLARE v_usuarioID INT;

    -- Obtener el usuarioID del empleado a eliminar
    SELECT usuarioID INTO v_usuarioID
    FROM Empleados
    WHERE codigo_emp = p_codigo_emp;

    -- Verificar si se encontró un usuarioID
    IF v_usuarioID IS NOT NULL THEN
        -- Primero eliminar el empleado
        DELETE FROM Empleados
        WHERE codigo_emp = p_codigo_emp;

        -- Luego eliminar de UsuariosAcceso
        DELETE FROM UsuariosAcceso
        WHERE usuarioID = v_usuarioID;
    END IF;
END //
DELIMITER ;

-- INSERTAR EMPLEADOS
DELIMITER //

CREATE  PROCEDURE insertarEmpleado(
    IN p_nombre_emp VARCHAR(255),
    IN p_apellido_emp VARCHAR(255),
    IN p_email_emp VARCHAR(255),
    IN p_numero_emp VARCHAR(20),
    IN p_tipo_documento VARCHAR(20),
    IN p_documento_emp VARCHAR(50),
    IN p_provincia_emp VARCHAR(255),
    IN p_distrito_emp VARCHAR(255),
    IN p_direccion_emp VARCHAR(255),
    IN p_sueldo_bruto_emp DECIMAL(10,2),
    IN p_tipo_pension_emp VARCHAR(20),
    IN p_tipo_seguro_emp VARCHAR(20),
    IN p_cargoID INT,
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(100)
)
BEGIN
    DECLARE p_usuarioID INT;

    -- Insertar en la tabla UsuariosAcceso
    INSERT INTO UsuariosAcceso (username, password) 
    VALUES (p_username, p_password);

    -- Obtener el usuarioID generado
    SET p_usuarioID = LAST_INSERT_ID();

    -- Insertar en la tabla Empleados
    INSERT INTO Empleados (
        nombre_emp, 
        apellido_emp, 
        email_emp, 
        numero_emp, 
        tipo_documento, 
        documento_emp, 
        provincia_emp, 
        distrito_emp, 
        direccion_emp, 
        sueldo_bruto_emp, 
        tipo_pension_emp, 
        tipo_seguro_emp, 
        cargoID, 
        usuarioID
    ) 
    VALUES (
        p_nombre_emp, 
        p_apellido_emp, 
        p_email_emp, 
        p_numero_emp, 
        p_tipo_documento, 
        p_documento_emp, 
        p_provincia_emp, 
        p_distrito_emp, 
        p_direccion_emp, 
        p_sueldo_bruto_emp, 
        p_tipo_pension_emp, 
        p_tipo_seguro_emp, 
        p_cargoID, 
        p_usuarioID  
    );
END //

DELIMITER ;

-- EDITAR EMPLEADO 
DELIMITER //

CREATE PROCEDURE editarEmpleado(
    IN p_codigo_emp INT,
    IN p_nombre_emp VARCHAR(255),
    IN p_apellido_emp VARCHAR(255),
    IN p_email_emp VARCHAR(255),
    IN p_numero_emp VARCHAR(20),
    IN p_tipo_documento VARCHAR(20),
    IN p_documento_emp VARCHAR(50),
    IN p_provincia_emp VARCHAR(255),
    IN p_distrito_emp VARCHAR(255),
    IN p_direccion_emp VARCHAR(255),
    IN p_sueldo_bruto_emp DECIMAL(10,2),
    IN p_tipo_pension_emp VARCHAR(20),
    IN p_tipo_seguro_emp VARCHAR(20),
    IN p_cargoID INT,
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(100)
)
BEGIN
    -- Actualizar la tabla UsuariosAcceso
    UPDATE UsuariosAcceso
    SET username = p_username, password = p_password
    WHERE usuarioID = (SELECT usuarioID FROM Empleados WHERE codigo_emp = p_codigo_emp);

    -- Actualizar la tabla Empleados
    UPDATE Empleados
    SET 
        nombre_emp = p_nombre_emp,
        apellido_emp = p_apellido_emp,
        email_emp = p_email_emp,
        numero_emp = p_numero_emp,
        tipo_documento = p_tipo_documento,
        documento_emp = p_documento_emp,
        provincia_emp = p_provincia_emp,
        distrito_emp = p_distrito_emp,
        direccion_emp = p_direccion_emp,
        sueldo_bruto_emp = p_sueldo_bruto_emp,
        tipo_pension_emp = p_tipo_pension_emp,
        tipo_seguro_emp = p_tipo_seguro_emp,
        cargoID = p_cargoID
    WHERE codigo_emp = p_codigo_emp;
END //

DELIMITER ;

DELIMITER //
CREATE PROCEDURE ListarEmpleadoPorCodigo(
    IN codigo_emp_param INT
)
BEGIN
    SELECT 
        e.codigo_emp, 
        e.nombre_emp, 
        e.apellido_emp, 
        e.email_emp,
        e.numero_emp,
        e.tipo_documento, 
        e.documento_emp, 
        e.provincia_emp,
        e.distrito_emp,
        e.direccion_emp,
        e.sueldo_bruto_emp,
        e.sueldo_neto_emp,
        e.tipo_pension_emp,
        e.descuento_pension_emp,
        e.tipo_seguro_emp,
        e.descuento_seguro_emp,
        c.nombreCargo,  -- Cargo del empleado
        ua.username,    -- Nombre de usuario
        ua.password     -- Contraseña
    FROM Empleados e
    LEFT JOIN Cargos c ON e.cargoID = c.cargoID
    LEFT JOIN UsuariosAcceso ua ON e.usuarioID = ua.usuarioID
    WHERE e.codigo_emp = codigo_emp_param;
END //
DELIMITER ;

-- TRIGGERS

-- CALCULAR IGV, PENSION Y SEGURO
DELIMITER //
CREATE TRIGGER before_insert_empleados
BEFORE INSERT ON Empleados
FOR EACH ROW
BEGIN
    -- Inicializar descuentos a 0
    SET NEW.descuento_pension_emp = 0.00;
    SET NEW.descuento_seguro_emp = 0.00;

    -- Calcular el descuento de pensión según el tipo de pensión
    IF NEW.tipo_pension_emp = 'ONP' THEN
        SET NEW.descuento_pension_emp = NEW.sueldo_bruto_emp * 0.10;
    ELSEIF NEW.tipo_pension_emp = 'AFP' THEN
        SET NEW.descuento_pension_emp = NEW.sueldo_bruto_emp * 0.12;
    ELSE
        -- Establecer un porcentaje predeterminado si no se cumple ninguna condición
        SET NEW.descuento_pension_emp = NEW.sueldo_bruto_emp * 0.05; -- Porcentaje predeterminado para pensión
    END IF;

    -- Calcular el descuento de seguro según el tipo de seguro
    IF NEW.tipo_seguro_emp = 'RIMAC' THEN
        SET NEW.descuento_seguro_emp = NEW.sueldo_bruto_emp * 0.09;
    ELSEIF NEW.tipo_seguro_emp = 'PACIFICO' THEN
        SET NEW.descuento_seguro_emp = NEW.sueldo_bruto_emp * 0.08;
    ELSE
        -- Establecer un porcentaje predeterminado si no se cumple ninguna condición
        SET NEW.descuento_seguro_emp = NEW.sueldo_bruto_emp * 0.03; -- Porcentaje predeterminado para seguro
    END IF;

    -- Calcular el sueldo neto
    SET NEW.sueldo_neto_emp = NEW.sueldo_bruto_emp - NEW.descuento_pension_emp - NEW.descuento_seguro_emp;
END//
DELIMITER ;


-- DESPUES DE LA ACTUALIZACION DE EMPLEADO 

DELIMITER //
CREATE TRIGGER before_update_empleados
BEFORE UPDATE ON Empleados
FOR EACH ROW
BEGIN
    -- Inicializar descuentos a 0
    SET NEW.descuento_pension_emp = 0.00;
    SET NEW.descuento_seguro_emp = 0.00;

    -- Calcular el descuento de pensión según el tipo de pensión
    IF NEW.tipo_pension_emp = 'ONP' THEN
        SET NEW.descuento_pension_emp = NEW.sueldo_bruto_emp * 0.10;
    ELSEIF NEW.tipo_pension_emp = 'AFP' THEN
        SET NEW.descuento_pension_emp = NEW.sueldo_bruto_emp * 0.12;
    ELSE
        -- Establecer un porcentaje predeterminado si no se cumple ninguna condición
        SET NEW.descuento_pension_emp = NEW.sueldo_bruto_emp * 0.05; -- Porcentaje predeterminado para pensión
    END IF;

    -- Calcular el descuento de seguro según el tipo de seguro
    IF NEW.tipo_seguro_emp = 'RIMAC' THEN
        SET NEW.descuento_seguro_emp = NEW.sueldo_bruto_emp * 0.09;
    ELSEIF NEW.tipo_seguro_emp = 'PACIFICO' THEN
        SET NEW.descuento_seguro_emp = NEW.sueldo_bruto_emp * 0.08;
    ELSE
        -- Establecer un porcentaje predeterminado si no se cumple ninguna condición
        SET NEW.descuento_seguro_emp = NEW.sueldo_bruto_emp * 0.03; -- Porcentaje predeterminado para seguro
    END IF;

    -- Calcular el sueldo neto
    SET NEW.sueldo_neto_emp = NEW.sueldo_bruto_emp - NEW.descuento_pension_emp - NEW.descuento_seguro_emp;
END //
DELIMITER ;


-- DESPUES DE LA INSERCION DE PRODUCTO 

DELIMITER //
CREATE TRIGGER calcular_precio_final
BEFORE INSERT ON PRODUCTOS
FOR EACH ROW
BEGIN
    SET NEW.PRECIO_FINAL = NEW.PRECIO_INGRESO_PROD * (1 + NEW.GANANCIA_PROD) * 1.18 * (1 - (NEW.DESCUENTO / 100));
END; //
DELIMITER ;


-- DESPUES DE LA ACTUALIZACION DE PRODUCTO 

DELIMITER //
CREATE TRIGGER recalcular_precio_final
BEFORE UPDATE ON PRODUCTOS
FOR EACH ROW
BEGIN
    SET NEW.PRECIO_FINAL = NEW.PRECIO_INGRESO_PROD * (1 + NEW.GANANCIA_PROD) * 1.18 * (1 - (NEW.DESCUENTO / 100));
END; //
DELIMITER ;





-- INSERCIONES 

 INSERT INTO Cargos (nombreCargo) VALUES 
('Vendedor'), 
('Supervisor'), 
('Almacenero'), 
('Administrador');

INSERT INTO PROVEEDORES (NOMBRE_PROVE, PAIS_PROVE, NUMERO_PROVE, DIRECCION_PROVE, EMAIL_PROVE, TELEFONO_PROVE)
VALUES
('Supreme', 'Estados Unidos', '123456789', 'Av. Principal 100, Nueva York', 'contact@supreme.com', '555-1234'),
('Off-White', 'Italia', '987654321', 'Calle Central 200, Milán', 'info@offwhite.com', '555-5678'),
('Stüssy', 'Estados Unidos', '654321987', 'Av. Sunset 300, Los Ángeles', 'contact@stussy.com', '555-9101'),
('A Bathing Ape (BAPE)', 'Japón', '321654987', 'Calle Harajuku 400, Tokio', 'info@bape.com', '555-1213'),
('Palace', 'Reino Unido', '456123789', 'Jr. Oxford 500, Londres', 'contact@palaceskateboards.com', '555-1415'),
('Kith', 'Estados Unidos', '789456123', 'Calle Broadway 600, Nueva York', 'info@kith.com', '555-1617'),
('Fear of God', 'Estados Unidos', '123789456', 'Av. Beverly 700, Los Ángeles', 'contact@fearofgod.com', '555-1819'),
('Anti Social Social Club', 'Estados Unidos', '456789123', 'Av. Melrose 800, Los Ángeles', 'info@assc.com', '555-2021');

-- AGREGAR CLIENTE 
CALL INSERTARCLIENTE('Gandhi', 'Belesbia', 'gandhi.gomez@example.com', '935391731', 'DNI', '72525478', 'Lima', 'Lima', 'Calle 1');
CALL INSERTARCLIENTE('Carlos', 'Gómez', 'carlos.gomez@example.com', '123456789', 'DNI', '11111111', 'Lima', 'Lima', 'Calle 1');
CALL INSERTARCLIENTE('Ana', 'Martínez', 'ana.martinez@example.com', '987654321', 'DNI', '22222222', 'Lima', 'Lima', 'Calle 2');
CALL INSERTARCLIENTE('Luis', 'Rodríguez', 'luis.rodriguez@example.com', '345678901', 'DNI', '33333333', 'Lima', 'Lima', 'Calle 3');
CALL INSERTARCLIENTE('María', 'Hernández', 'maria.hernandez@example.com', '456789012', 'DNI', '44444444', 'Lima', 'Lima', 'Calle 4');
CALL INSERTARCLIENTE('José', 'López', 'jose.lopez@example.com', '567890123', 'DNI', '55555555', 'Lima', 'Lima', 'Calle 5');
CALL INSERTARCLIENTE('Elena', 'Pérez', 'elena.perez@example.com', '678901234', 'DNI', '66666666', 'Lima', 'Lima', 'Calle 6');
CALL INSERTARCLIENTE('Andrés', 'Sánchez', 'andres.sanchez@example.com', '789012345', 'DNI', '77777777', 'Lima', 'Lima', 'Calle 7');
CALL INSERTARCLIENTE('Laura', 'Jiménez', 'laura.jimenez@example.com', '890123456', 'DNI', '88888888', 'Lima', 'Lima', 'Calle 8');
CALL INSERTARCLIENTE('Ricardo', 'Torres', 'ricardo.torres@example.com', '901234567', 'DNI', '99999999', 'Lima', 'Lima', 'Calle 9');
CALL INSERTARCLIENTE('Sofía', 'Ramírez', 'sofia.ramirez@example.com', '123123123', 'DNI', '10101010', 'Lima', 'Lima', 'Calle 10');
CALL INSERTARCLIENTE('Fernando', 'Flores', 'fernando.flores@example.com', '234234234', 'DNI', '20202020', 'Lima', 'Lima', 'Calle 11');
CALL INSERTARCLIENTE('Patricia', 'Vásquez', 'patricia.vasquez@example.com', '345345345', 'DNI', '30303030', 'Lima', 'Lima', 'Calle 12');
CALL INSERTARCLIENTE('Javier', 'Gutiérrez', 'javier.gutierrez@example.com', '456456456', 'DNI', '40404040', 'Lima', 'Lima', 'Calle 13');
CALL INSERTARCLIENTE('Gabriela', 'Castillo', 'gabriela.castillo@example.com', '567567567', 'DNI', '50505050', 'Lima', 'Lima', 'Calle 14');
CALL INSERTARCLIENTE('Felipe', 'Maldonado', 'felipe.maldonado@example.com', '678678678', 'DNI', '60606060', 'Lima', 'Lima', 'Calle 15');
CALL INSERTARCLIENTE('Angela', 'Córdova', 'angela.cordova@example.com', '789789789', 'DNI', '70707070', 'Lima', 'Lima', 'Calle 16');
CALL INSERTARCLIENTE('Eduardo', 'Pineda', 'eduardo.pineda@example.com', '890890890', 'DNI', '80808080', 'Lima', 'Lima', 'Calle 17');
CALL INSERTARCLIENTE('Claudia', 'Mora', 'claudia.mora@example.com', '901901901', 'DNI', '90909090', 'Lima', 'Lima', 'Calle 18');
CALL INSERTARCLIENTE('Raúl', 'Salinas', 'raul.salinas@example.com', '012012012', 'DNI', '11111112', 'Lima', 'Lima', 'Calle 19');
CALL INSERTARCLIENTE('Tatiana', 'Cruz', 'tatiana.cruz@example.com', '123456780', 'DNI', '22222223', 'Lima', 'Lima', 'Calle 20');
CALL INSERTARCLIENTE('Miguel', 'Olivares', 'miguel.olivares@example.com', '234567891', 'DNI', '33333334', 'Lima', 'Lima', 'Calle 21');
CALL INSERTARCLIENTE('Vanessa', 'Pacheco', 'vanessa.pacheco@example.com', '345678902', 'DNI', '44444445', 'Lima', 'Lima', 'Calle 22');
CALL INSERTARCLIENTE('Hugo', 'Guerrero', 'hugo.guerrero@example.com', '456789013', 'DNI', '55555556', 'Lima', 'Lima', 'Calle 23');
CALL INSERTARCLIENTE('Verónica', 'Núñez', 'veronica.nunez@example.com', '567890124', 'DNI', '66666667', 'Lima', 'Lima', 'Calle 24');
CALL INSERTARCLIENTE('Omar', 'Solano', 'omar.solano@example.com', '678901235', 'DNI', '77777778', 'Lima', 'Lima', 'Calle 25');
CALL INSERTARCLIENTE('Patricio', 'Cáceres', 'patricio.caceres@example.com', '789012346', 'DNI', '88888889', 'Lima', 'Lima', 'Calle 26');
CALL INSERTARCLIENTE('Diana', 'Pizarro', 'diana.pizarro@example.com', '890123457', 'DNI', '99999990', 'Lima', 'Lima', 'Calle 27');
CALL INSERTARCLIENTE('Nicolás', 'Díaz', 'nicolas.diaz@example.com', '901234568', 'DNI', '10101011', 'Lima', 'Lima', 'Calle 28');
CALL INSERTARCLIENTE('Alicia', 'Martinez', 'alicia.martinez@example.com', '012345679', 'DNI', '11111113', 'Lima', 'Lima', 'Calle 29');
CALL INSERTARCLIENTE('Esteban', 'Salas', 'esteban.salas@example.com', '123456791', 'DNI', '22222224', 'Lima', 'Lima', 'Calle 30');

-- AGREGAR EMPLEADOS

-- 2 Vendedores
CALL insertarEmpleado('Juan', 'Perez', 'juan.perez@example.com', '123456789', 'DNI', '12345678', 'Lima', 'Lima', 'Av. Los Alamos 123', 2000.00, 'ONP', 'RIMAC', 1, 'vendedor', 'vendedor');
CALL insertarEmpleado('Maria', 'Gomez', 'maria.gomez@example.com', '987654321', 'DNI', '87654321', 'Lima', 'Lima', 'Av. Las Rosas 456', 2100.00, 'AFP', 'PACIFICO', 1, 'mariag', 'password456');

-- 2 Almaceneros
CALL insertarEmpleado('Carlos', 'Lopez', 'carlos.lopez@example.com', '123123123', 'DNI', '11223344', 'Lima', 'Lima', 'Calle Lima 789', 1800.00, 'ONP', 'RIMAC', 3, 'almacenero', 'almacenero');
CALL insertarEmpleado('Ana', 'Torres', 'ana.torres@example.com', '321321321', 'DNI', '22334455', 'Lima', 'Lima', 'Calle Callao 101', 1900.00, 'AFP', 'PACIFICO', 3, 'anat', 'password101');

-- 1 Supervisor
CALL insertarEmpleado('Luis', 'Diaz', 'luis.diaz@example.com', '555666777', 'DNI', '33445566', 'Lima', 'Lima', 'Av. San Juan 202', 2500.00, 'ONP', 'RIMAC', 2, 'supervisor', 'supervisor');

-- 1 Administrador
CALL insertarEmpleado('Pedro', 'Ramirez', 'pedro.ramirez@example.com', '444333222', 'DNI', '44556677', 'Lima', 'Lima', 'Av. Arequipa 303', 3000.00, 'AFP', 'PACIFICO', 4, 'pedror', 'password303');

CALL insertarEmpleado('Belesbia', 'gandhi', 'juancito.ramirez@example.com', '72525478', 'DNI', '89877687', 'Lima', 'Lima', 'Av. Arequipa 303', 3000.00, 'AFP', 'PACIFICO', 4, 'admin', 'admin123');

-- Proveedor: Supreme (ID 1)
CALL INSERTAR_PRODUCTO(1, 'Camiseta', 'Camiseta Supreme Hombre S', 'Hombre', 'Camiseta Supreme de estilo urbano', 'S', 'Lote001', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(1, 'Camiseta', 'Camiseta Supreme Hombre M', 'Hombre', 'Camiseta Supreme de estilo urbano', 'M', 'Lote002', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(1, 'Camiseta', 'Camiseta Supreme Hombre L', 'Hombre', 'Camiseta Supreme de estilo urbano', 'L', 'Lote003', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(1, 'Camiseta', 'Camiseta Supreme Hombre XL', 'Hombre', 'Camiseta Supreme de estilo urbano', 'XL', 'Lote004', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(1, 'Camiseta', 'Camiseta Supreme Mujer S', 'Mujer', 'Camiseta Supreme de estilo urbano', 'S', 'Lote005', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(1, 'Camiseta', 'Camiseta Supreme Mujer M', 'Mujer', 'Camiseta Supreme de estilo urbano', 'M', 'Lote006', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(1, 'Camiseta', 'Camiseta Supreme Mujer L', 'Mujer', 'Camiseta Supreme de estilo urbano', 'L', 'Lote007', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(1, 'Camiseta', 'Camiseta Supreme Mujer XL', 'Mujer', 'Camiseta Supreme de estilo urbano', 'XL', 'Lote008', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(1, 'Camiseta', 'Camiseta Supreme Niño S', 'Niño', 'Camiseta Supreme divertida', 'S', 'Lote009', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(1, 'Camiseta', 'Camiseta Supreme Niño M', 'Niño', 'Camiseta Supreme divertida', 'M', 'Lote010', ROUND(RAND() * 50 + 40, 2), 45);

-- Proveedor: Off-White (ID 2)
CALL INSERTAR_PRODUCTO(2, 'Camiseta', 'Camiseta Off-White Hombre S', 'Hombre', 'Camiseta Off-White de estilo urbano', 'S', 'Lote011', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(2, 'Camiseta', 'Camiseta Off-White Hombre M', 'Hombre', 'Camiseta Off-White de estilo urbano', 'M', 'Lote012', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(2, 'Camiseta', 'Camiseta Off-White Hombre L', 'Hombre', 'Camiseta Off-White de estilo urbano', 'L', 'Lote013', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(2, 'Camiseta', 'Camiseta Off-White Hombre XL', 'Hombre', 'Camiseta Off-White de estilo urbano', 'XL', 'Lote014', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(2, 'Camiseta', 'Camiseta Off-White Mujer S', 'Mujer', 'Camiseta Off-White de estilo urbano', 'S', 'Lote015', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(2, 'Camiseta', 'Camiseta Off-White Mujer M', 'Mujer', 'Camiseta Off-White de estilo urbano', 'M', 'Lote016', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(2, 'Camiseta', 'Camiseta Off-White Mujer L', 'Mujer', 'Camiseta Off-White de estilo urbano', 'L', 'Lote017', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(2, 'Camiseta', 'Camiseta Off-White Mujer XL', 'Mujer', 'Camiseta Off-White de estilo urbano', 'XL', 'Lote018', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(2, 'Camiseta', 'Camiseta Off-White Niño S', 'Niño', 'Camiseta Off-White divertida', 'S', 'Lote019', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(2, 'Camiseta', 'Camiseta Off-White Niño M', 'Niño', 'Camiseta Off-White divertida', 'M', 'Lote020', ROUND(RAND() * 50 + 40, 2), 45);

-- Proveedor: Stüssy (ID 3)
CALL INSERTAR_PRODUCTO(3, 'Camiseta', 'Camiseta Stüssy Hombre S', 'Hombre', 'Camiseta Stüssy de estilo urbano', 'S', 'Lote021', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(3, 'Camiseta', 'Camiseta Stüssy Hombre M', 'Hombre', 'Camiseta Stüssy de estilo urbano', 'M', 'Lote022', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(3, 'Camiseta', 'Camiseta Stüssy Hombre L', 'Hombre', 'Camiseta Stüssy de estilo urbano', 'L', 'Lote023', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(3, 'Camiseta', 'Camiseta Stüssy Hombre XL', 'Hombre', 'Camiseta Stüssy de estilo urbano', 'XL', 'Lote024', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(3, 'Camiseta', 'Camiseta Stüssy Mujer S', 'Mujer', 'Camiseta Stüssy de estilo urbano', 'S', 'Lote025', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(3, 'Camiseta', 'Camiseta Stüssy Mujer M', 'Mujer', 'Camiseta Stüssy de estilo urbano', 'M', 'Lote026', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(3, 'Camiseta', 'Camiseta Stüssy Mujer L', 'Mujer', 'Camiseta Stüssy de estilo urbano', 'L', 'Lote027', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(3, 'Camiseta', 'Camiseta Stüssy Mujer XL', 'Mujer', 'Camiseta Stüssy de estilo urbano', 'XL', 'Lote028', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(3, 'Camiseta', 'Camiseta Stüssy Niño S', 'Niño', 'Camiseta Stüssy divertida', 'S', 'Lote029', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(3, 'Camiseta', 'Camiseta Stüssy Niño M', 'Niño', 'Camiseta Stüssy divertida', 'M', 'Lote030', ROUND(RAND() * 50 + 40, 2), 45);

-- Proveedor: A Bathing Ape (BAPE) (ID 4)
CALL INSERTAR_PRODUCTO(4, 'Camiseta', 'Camiseta BAPE Hombre S', 'Hombre', 'Camiseta BAPE de estilo urbano', 'S', 'Lote031', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(4, 'Camiseta', 'Camiseta BAPE Hombre M', 'Hombre', 'Camiseta BAPE de estilo urbano', 'M', 'Lote032', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(4, 'Camiseta', 'Camiseta BAPE Hombre L', 'Hombre', 'Camiseta BAPE de estilo urbano', 'L', 'Lote033', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(4, 'Camiseta', 'Camiseta BAPE Hombre XL', 'Hombre', 'Camiseta BAPE de estilo urbano', 'XL', 'Lote034', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(4, 'Camiseta', 'Camiseta BAPE Mujer S', 'Mujer', 'Camiseta BAPE de estilo urbano', 'S', 'Lote035', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(4, 'Camiseta', 'Camiseta BAPE Mujer M', 'Mujer', 'Camiseta BAPE de estilo urbano', 'M', 'Lote036', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(4, 'Camiseta', 'Camiseta BAPE Mujer L', 'Mujer', 'Camiseta BAPE de estilo urbano', 'L', 'Lote037', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(4, 'Camiseta', 'Camiseta BAPE Mujer XL', 'Mujer', 'Camiseta BAPE de estilo urbano', 'XL', 'Lote038', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(4, 'Camiseta', 'Camiseta BAPE Niño S', 'Niño', 'Camiseta BAPE divertida', 'S', 'Lote039', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(4, 'Camiseta', 'Camiseta BAPE Niño M', 'Niño', 'Camiseta BAPE divertida', 'M', 'Lote040', ROUND(RAND() * 50 + 40, 2), 45);

-- Proveedor: Palace (ID 5)
CALL INSERTAR_PRODUCTO(5, 'Camiseta', 'Camiseta Palace Hombre S', 'Hombre', 'Camiseta Palace de estilo urbano', 'S', 'Lote041', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(5, 'Camiseta', 'Camiseta Palace Hombre M', 'Hombre', 'Camiseta Palace de estilo urbano', 'M', 'Lote042', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(5, 'Camiseta', 'Camiseta Palace Hombre L', 'Hombre', 'Camiseta Palace de estilo urbano', 'L', 'Lote043', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(5, 'Camiseta', 'Camiseta Palace Hombre XL', 'Hombre', 'Camiseta Palace de estilo urbano', 'XL', 'Lote044', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(5, 'Camiseta', 'Camiseta Palace Mujer S', 'Mujer', 'Camiseta Palace de estilo urbano', 'S', 'Lote045', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(5, 'Camiseta', 'Camiseta Palace Mujer M', 'Mujer', 'Camiseta Palace de estilo urbano', 'M', 'Lote046', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(5, 'Camiseta', 'Camiseta Palace Mujer L', 'Mujer', 'Camiseta Palace de estilo urbano', 'L', 'Lote047', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(5, 'Camiseta', 'Camiseta Palace Mujer XL', 'Mujer', 'Camiseta Palace de estilo urbano', 'XL', 'Lote048', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(5, 'Camiseta', 'Camiseta Palace Niño S', 'Niño', 'Camiseta Palace divertida', 'S', 'Lote049', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(5, 'Camiseta', 'Camiseta Palace Niño M', 'Niño', 'Camiseta Palace divertida', 'M', 'Lote050', ROUND(RAND() * 50 + 40, 2), 45);

-- Proveedor: Kith (ID 6)
CALL INSERTAR_PRODUCTO(6, 'Camiseta', 'Camiseta Kith Hombre S', 'Hombre', 'Camiseta Kith de estilo urbano', 'S', 'Lote051', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(6, 'Camiseta', 'Camiseta Kith Hombre M', 'Hombre', 'Camiseta Kith de estilo urbano', 'M', 'Lote052', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(6, 'Camiseta', 'Camiseta Kith Hombre L', 'Hombre', 'Camiseta Kith de estilo urbano', 'L', 'Lote053', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(6, 'Camiseta', 'Camiseta Kith Hombre XL', 'Hombre', 'Camiseta Kith de estilo urbano', 'XL', 'Lote054', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(6, 'Camiseta', 'Camiseta Kith Mujer S', 'Mujer', 'Camiseta Kith de estilo urbano', 'S', 'Lote055', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(6, 'Camiseta', 'Camiseta Kith Mujer M', 'Mujer', 'Camiseta Kith de estilo urbano', 'M', 'Lote056', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(6, 'Camiseta', 'Camiseta Kith Mujer L', 'Mujer', 'Camiseta Kith de estilo urbano', 'L', 'Lote057', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(6, 'Camiseta', 'Camiseta Kith Mujer XL', 'Mujer', 'Camiseta Kith de estilo urbano', 'XL', 'Lote058', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(6, 'Camiseta', 'Camiseta Kith Niño S', 'Niño', 'Camiseta Kith divertida', 'S', 'Lote059', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(6, 'Camiseta', 'Camiseta Kith Niño M', 'Niño', 'Camiseta Kith divertida', 'M', 'Lote060', ROUND(RAND() * 50 + 40, 2), 45);

-- Proveedor: Fear of God (ID 7)
CALL INSERTAR_PRODUCTO(7, 'Camiseta', 'Camiseta Fear of God Hombre S', 'Hombre', 'Camiseta Fear of God de estilo urbano', 'S', 'Lote061', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(7, 'Camiseta', 'Camiseta Fear of God Hombre M', 'Hombre', 'Camiseta Fear of God de estilo urbano', 'M', 'Lote062', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(7, 'Camiseta', 'Camiseta Fear of God Hombre L', 'Hombre', 'Camiseta Fear of God de estilo urbano', 'L', 'Lote063', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(7, 'Camiseta', 'Camiseta Fear of God Hombre XL', 'Hombre', 'Camiseta Fear of God de estilo urbano', 'XL', 'Lote064', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(7, 'Camiseta', 'Camiseta Fear of God Mujer S', 'Mujer', 'Camiseta Fear of God de estilo urbano', 'S', 'Lote065', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(7, 'Camiseta', 'Camiseta Fear of God Mujer M', 'Mujer', 'Camiseta Fear of God de estilo urbano', 'M', 'Lote066', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(7, 'Camiseta', 'Camiseta Fear of God Mujer L', 'Mujer', 'Camiseta Fear of God de estilo urbano', 'L', 'Lote067', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(7, 'Camiseta', 'Camiseta Fear of God Mujer XL', 'Mujer', 'Camiseta Fear of God de estilo urbano', 'XL', 'Lote068', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(7, 'Camiseta', 'Camiseta Fear of God Niño S', 'Niño', 'Camiseta Fear of God divertida', 'S', 'Lote069', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(7, 'Camiseta', 'Camiseta Fear of God Niño M', 'Niño', 'Camiseta Fear of God divertida', 'M', 'Lote070', ROUND(RAND() * 50 + 40, 2), 45);

-- Proveedor: Anti Social Social Club (ID 8)
CALL INSERTAR_PRODUCTO(8, 'Camiseta', 'Camiseta Anti Social Social Club Hombre S', 'Hombre', 'Camiseta Anti Social Social Club de estilo urbano', 'S', 'Lote071', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(8, 'Camiseta', 'Camiseta Anti Social Social Club Hombre M', 'Hombre', 'Camiseta Anti Social Social Club de estilo urbano', 'M', 'Lote072', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(8, 'Camiseta', 'Camiseta Anti Social Social Club Hombre L', 'Hombre', 'Camiseta Anti Social Social Club de estilo urbano', 'L', 'Lote073', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(8, 'Camiseta', 'Camiseta Anti Social Social Club Hombre XL', 'Hombre', 'Camiseta Anti Social Social Club de estilo urbano', 'XL', 'Lote074', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(8, 'Camiseta', 'Camiseta Anti Social Social Club Mujer S', 'Mujer', 'Camiseta Anti Social Social Club de estilo urbano', 'S', 'Lote075', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(8, 'Camiseta', 'Camiseta Anti Social Social Club Mujer M', 'Mujer', 'Camiseta Anti Social Social Club de estilo urbano', 'M', 'Lote076', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(8, 'Camiseta', 'Camiseta Anti Social Social Club Mujer L', 'Mujer', 'Camiseta Anti Social Social Club de estilo urbano', 'L', 'Lote077', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(8, 'Camiseta', 'Camiseta Anti Social Social Club Mujer XL', 'Mujer', 'Camiseta Anti Social Social Club de estilo urbano', 'XL', 'Lote078', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(8, 'Camiseta', 'Camiseta Anti Social Social Club Niño S', 'Niño', 'Camiseta Anti Social Social Club divertida', 'S', 'Lote079', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(8, 'Camiseta', 'Camiseta Anti Social Social Club Niño M', 'Niño', 'Camiseta Anti Social Social Club divertida', 'M', 'Lote080', ROUND(RAND() * 50 + 40, 2), 45);

-- Proveedor: Fear of God (ID 7)
-- Buzos
CALL INSERTAR_PRODUCTO(7, 'Buzo', 'Buzo Fear of God Hombre S', 'Hombre', 'Buzo Fear of God de estilo urbano', 'S', 'Lote091', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(7, 'Buzo', 'Buzo Fear of God Hombre M', 'Hombre', 'Buzo Fear of God de estilo urbano', 'M', 'Lote092', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(7, 'Buzo', 'Buzo Fear of God Hombre L', 'Hombre', 'Buzo Fear of God de estilo urbano', 'L', 'Lote093', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(7, 'Buzo', 'Buzo Fear of God Hombre XL', 'Hombre', 'Buzo Fear of God de estilo urbano', 'XL', 'Lote094', ROUND(RAND() * 50 + 40, 2), 45);

-- Gorras
CALL INSERTAR_PRODUCTO(7, 'Gorra', 'Gorra Fear of God Hombre', 'Hombre', 'Gorra Fear of God de estilo urbano', NULL, 'Lote095', ROUND(RAND() * 50 + 40, 2), 45);

-- Pantalones
CALL INSERTAR_PRODUCTO(7, 'Pantalón', 'Pantalón Fear of God Hombre S', 'Hombre', 'Pantalón Fear of God de estilo urbano', 'S', 'Lote096', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(7, 'Pantalón', 'Pantalón Fear of God Hombre M', 'Hombre', 'Pantalón Fear of God de estilo urbano', 'M', 'Lote097', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(7, 'Pantalón', 'Pantalón Fear of God Hombre L', 'Hombre', 'Pantalón Fear of God de estilo urbano', 'L', 'Lote098', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(7, 'Pantalón', 'Pantalón Fear of God Hombre XL', 'Hombre', 'Pantalón Fear of God de estilo urbano', 'XL', 'Lote099', ROUND(RAND() * 50 + 40, 2), 45);

-- Camisas
CALL INSERTAR_PRODUCTO(7, 'Camisa', 'Camisa Fear of God Hombre S', 'Hombre', 'Camisa Fear of God de estilo urbano', 'S', 'Lote100', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(7, 'Camisa', 'Camisa Fear of God Hombre M', 'Hombre', 'Camisa Fear of God de estilo urbano', 'M', 'Lote101', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(7, 'Camisa', 'Camisa Fear of God Hombre L', 'Hombre', 'Camisa Fear of God de estilo urbano', 'L', 'Lote102', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(7, 'Camisa', 'Camisa Fear of God Hombre XL', 'Hombre', 'Camisa Fear of God de estilo urbano', 'XL', 'Lote103', ROUND(RAND() * 50 + 40, 2), 45);

-- Proveedor: Anti Social Social Club (ID 8)
-- Buzos
CALL INSERTAR_PRODUCTO(8, 'Buzo', 'Buzo Anti Social Social Club Hombre S', 'Hombre', 'Buzo Anti Social Social Club de estilo urbano', 'S', 'Lote104', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(8, 'Buzo', 'Buzo Anti Social Social Club Hombre M', 'Hombre', 'Buzo Anti Social Social Club de estilo urbano', 'M', 'Lote105', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(8, 'Buzo', 'Buzo Anti Social Social Club Hombre L', 'Hombre', 'Buzo Anti Social Social Club de estilo urbano', 'L', 'Lote106', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(8, 'Buzo', 'Buzo Anti Social Social Club Hombre XL', 'Hombre', 'Buzo Anti Social Social Club de estilo urbano', 'XL', 'Lote107', ROUND(RAND() * 50 + 40, 2), 45);

-- Gorras
CALL INSERTAR_PRODUCTO(8, 'Gorra', 'Gorra Anti Social Social Club Hombre', 'Hombre', 'Gorra Anti Social Social Club de estilo urbano', NULL, 'Lote108', ROUND(RAND() * 50 + 40, 2), 45);

-- Pantalones
CALL INSERTAR_PRODUCTO(8, 'Pantalón', 'Pantalón Anti Social Social Club Hombre S', 'Hombre', 'Pantalón Anti Social Social Club de estilo urbano', 'S', 'Lote109', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(8, 'Pantalón', 'Pantalón Anti Social Social Club Hombre M', 'Hombre', 'Pantalón Anti Social Social Club de estilo urbano', 'M', 'Lote110', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(8, 'Pantalón', 'Pantalón Anti Social Social Club Hombre L', 'Hombre', 'Pantalón Anti Social Social Club de estilo urbano', 'L', 'Lote111', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(8, 'Pantalón', 'Pantalón Anti Social Social Club Hombre XL', 'Hombre', 'Pantalón Anti Social Social Club de estilo urbano', 'XL', 'Lote112', ROUND(RAND() * 50 + 40, 2), 45);

-- Camisas
CALL INSERTAR_PRODUCTO(8, 'Camisa', 'Camisa Anti Social Social Club Hombre S', 'Hombre', 'Camisa Anti Social Social Club de estilo urbano', 'S', 'Lote113', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(8, 'Camisa', 'Camisa Anti Social Social Club Hombre M', 'Hombre', 'Camisa Anti Social Social Club de estilo urbano', 'M', 'Lote114', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(8, 'Camisa', 'Camisa Anti Social Social Club Hombre L', 'Hombre', 'Camisa Anti Social Social Club de estilo urbano', 'L', 'Lote115', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(8, 'Camisa', 'Camisa Anti Social Social Club Hombre XL', 'Hombre', 'Camisa Anti Social Social Club de estilo urbano', 'XL', 'Lote116', ROUND(RAND() * 50 + 40, 2), 45);

-- Proveedor: Fear of God (ID 7)
-- Sudaderas
CALL INSERTAR_PRODUCTO(7, 'Sudadera', 'Sudadera Fear of God Hombre S', 'Hombre', 'Sudadera Fear of God de estilo urbano', 'S', 'Lote117', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(7, 'Sudadera', 'Sudadera Fear of God Hombre M', 'Hombre', 'Sudadera Fear of God de estilo urbano', 'M', 'Lote118', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(7, 'Sudadera', 'Sudadera Fear of God Hombre L', 'Hombre', 'Sudadera Fear of God de estilo urbano', 'L', 'Lote119', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(7, 'Sudadera', 'Sudadera Fear of God Hombre XL', 'Hombre', 'Sudadera Fear of God de estilo urbano', 'XL', 'Lote120', ROUND(RAND() * 50 + 40, 2), 45);

-- Proveedor: Anti Social Social Club (ID 8)
-- Sudaderas
CALL INSERTAR_PRODUCTO(8, 'Sudadera', 'Sudadera Anti Social Social Club Hombre S', 'Hombre', 'Sudadera Anti Social Social Club de estilo urbano', 'S', 'Lote121', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(8, 'Sudadera', 'Sudadera Anti Social Social Club Hombre M', 'Hombre', 'Sudadera Anti Social Social Club de estilo urbano', 'M', 'Lote122', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(8, 'Sudadera', 'Sudadera Anti Social Social Club Hombre L', 'Hombre', 'Sudadera Anti Social Social Club de estilo urbano', 'L', 'Lote123', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(8, 'Sudadera', 'Sudadera Anti Social Social Club Hombre XL', 'Hombre', 'Sudadera Anti Social Social Club de estilo urbano', 'XL', 'Lote124', ROUND(RAND() * 50 + 40, 2), 45);

-- Proveedor: A Bathing Ape (BAPE) (ID 4)
-- Casacas
CALL INSERTAR_PRODUCTO(4, 'Casaca', 'Casaca BAPE Hombre S', 'Hombre', 'Casaca BAPE de estilo urbano', 'S', 'Lote125', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(4, 'Casaca', 'Casaca BAPE Hombre M', 'Hombre', 'Casaca BAPE de estilo urbano', 'M', 'Lote126', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(4, 'Casaca', 'Casaca BAPE Hombre L', 'Hombre', 'Casaca BAPE de estilo urbano', 'L', 'Lote127', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(4, 'Casaca', 'Casaca BAPE Hombre XL', 'Hombre', 'Casaca BAPE de estilo urbano', 'XL', 'Lote128', ROUND(RAND() * 50 + 40, 2), 45);

-- Proveedor: Palace (ID 5)
-- Casacas
CALL INSERTAR_PRODUCTO(5, 'Casaca', 'Casaca Palace Hombre S', 'Hombre', 'Casaca Palace de estilo urbano', 'S', 'Lote129', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(5, 'Casaca', 'Casaca Palace Hombre M', 'Hombre', 'Casaca Palace de estilo urbano', 'M', 'Lote130', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(5, 'Casaca', 'Casaca Palace Hombre L', 'Hombre', 'Casaca Palace de estilo urbano', 'L', 'Lote131', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(5, 'Casaca', 'Casaca Palace Hombre XL', 'Hombre', 'Casaca Palace de estilo urbano', 'XL', 'Lote132', ROUND(RAND() * 50 + 40, 2), 45);

-- Proveedor: Kith (ID 6)
-- Casacas
CALL INSERTAR_PRODUCTO(6, 'Casaca', 'Casaca Kith Hombre S', 'Hombre', 'Casaca Kith de estilo urbano', 'S', 'Lote133', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(6, 'Casaca', 'Casaca Kith Hombre M', 'Hombre', 'Casaca Kith de estilo urbano', 'M', 'Lote134', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(6, 'Casaca', 'Casaca Kith Hombre L', 'Hombre', 'Casaca Kith de estilo urbano', 'L', 'Lote135', ROUND(RAND() * 50 + 40, 2), 45);
CALL INSERTAR_PRODUCTO(6, 'Casaca', 'Casaca Kith Hombre XL', 'Hombre', 'Casaca Kith de estilo urbano', 'XL', 'Lote136', ROUND(RAND() * 50 + 40, 2), 45);






