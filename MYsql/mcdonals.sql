DROP DATABASE McDonalds;

-- Crear la base de datos si no existe
CREATE DATABASE IF NOT EXISTS McDonalds;
USE McDonalds;


-- Crear la tabla Cliente
CREATE TABLE
    Cliente (
        IdCliente INT (11) NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Identificador único del cliente, autoincrementable
        NombreCliente VARCHAR(50) NOT NULL, -- Nombre del cliente
        NumeroDocumentoCliente VARCHAR(20) NOT NULL UNIQUE, -- Documento de identidad, único para cada cliente
        EdadCliente INT (3) NOT NULL CHECK (EdadCliente >= 0), -- Edad del cliente, debe ser un número positivo
        CorreoElectronicoCliente VARCHAR(100) UNIQUE, -- Correo electrónico, único
        TelefonoCliente VARCHAR(15), -- Número de teléfono del cliente
        FechaRegistroCliente DATETIME DEFAULT CURRENT_TIMESTAMP, -- Fecha y hora de registro, por defecto la actual
        EsMiembroCliente BOOLEAN DEFAULT FALSE -- Indica si el cliente es miembro, por defecto falso
    );

-- Crear la tabla Venta
CREATE TABLE
    Venta (
        IdVenta INT (11) NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Identificador único de la venta, autoincrementable
        IdCliente INT (11) NOT NULL, -- Identificador del cliente que realizó la compra
        IdRestaurante INT (11) NOT NULL, -- Identificador del restaurante donde se realizó la venta
        FechaVenta DATETIME DEFAULT CURRENT_TIMESTAMP, -- Fecha y hora de la venta, por defecto la actual
        ValorTotalVenta DECIMAL(10, 2) NOT NULL -- Valor total de la venta, con dos decimales
    );

-- Crear la tabla ProductoVenta
CREATE TABLE
    ProductoVenta (
        IdProductoVenta INT (11) NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Identificador único de la venta de producto, autoincrementable
        IdVenta INT (11) NOT NULL, -- Identificador de la venta asociada
        IdProducto INT (11) NOT NULL, -- Identificador del producto vendido
        Cantidad INT (11) NOT NULL, -- Cantidad del producto vendido
        PrecioUnitario DECIMAL(10, 2) NOT NULL -- Precio por unidad del producto
    );

-- Crear la tabla Producto
CREATE TABLE
    Producto (
        IdProducto INT (11) NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Identificador único del producto, autoincrementable
        NombreProducto VARCHAR(100) NOT NULL, -- Nombre del producto
        Descripcion VARCHAR(255), -- Descripción del producto
        PrecioUnitario DECIMAL(10, 2) NOT NULL, -- Precio por unidad del producto
        FechaVencimiento DATE, -- Fecha de caducidad del producto (si aplica)
        UnidadesDisponibles INT (11) NOT NULL CHECK (UnidadesDisponibles >= 0), -- Unidades disponibles en inventario, debe ser positivo
        IdCategoria INT (11) NOT NULL, -- Identificador de la categoría a la que pertenece el producto
        Activo BOOLEAN DEFAULT TRUE -- Indica si el producto está activo (disponible para la venta)
    );

-- Crear la tabla Categoria
CREATE TABLE
    Categoria (
        IdCategoria INT (11) NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Identificador único de la categoría, autoincrementable
        NombreCategoria VARCHAR(100) NOT NULL -- Nombre de la categoría
    );

-- Crear la tabla ProductoRestaurante
CREATE TABLE
    ProductoRestaurante (
        IdProductoRestaurante INT (11) NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Identificador único del producto en el restaurante, autoincrementable
        IdRestaurante INT (11) NOT NULL, -- Identificador del restaurante al que pertenece el producto
        IdProducto INT (11) NOT NULL, -- Identificador del producto
        UnidadesDisponiblesRestaurante INT (11) NOT NULL CHECK (UnidadesDisponiblesRestaurante >= 0), -- Unidades disponibles en este restaurante
        Activo BOOLEAN DEFAULT TRUE -- Indica si el producto está disponible en el restaurante
    );

-- Crear la tabla Restaurante
CREATE TABLE
    Restaurante (
        IdRestaurante INT (11) NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Identificador único del restaurante, autoincrementable
        Nombre VARCHAR(100) NOT NULL, -- Nombre del restaurante
        Direccion VARCHAR(255) NOT NULL, -- Dirección del restaurante
        Telefono VARCHAR(15), -- Número de teléfono del restaurante
        HorarioApertura TIME, -- Hora de apertura del restaurante
        HorarioCierre TIME, -- Hora de cierre del restaurante
        Latitud DECIMAL(9, 6), -- Latitud para ubicación del restaurante
        Longitud DECIMAL(9, 6), -- Longitud para ubicación del restaurante
        Capacidad INT -- Capacidad de personas del restaurante
    );

-- Crear la tabla Proveedor
CREATE TABLE
    Proveedor (
        IdProveedor INT (11) NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Identificador único del proveedor, autoincrementable
        Nombre VARCHAR(100) NOT NULL, -- Nombre del proveedor
        Producto VARCHAR(100), -- Producto que proporciona
        Telefono VARCHAR(15), -- Número de teléfono del proveedor
        Direccion VARCHAR(255), -- Dirección del proveedor
        CorreoElectronico VARCHAR(100) UNIQUE, -- Correo electrónico del proveedor, único
        TipoProducto VARCHAR(50), -- Tipo de producto que suministra
        FechaRegistro DATETIME DEFAULT CURRENT_TIMESTAMP, -- Fecha y hora de registro del proveedor
        Estado BOOLEAN DEFAULT TRUE -- Indica si el proveedor está activo
    );

-- Crear la tabla ProveedorRestaurante
CREATE TABLE
    ProveedorRestaurante (
        IdProveedorRestaurante INT (11) NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Identificador único de la relación, autoincrementable
        IdRestaurante INT (11) NOT NULL, -- Identificador del restaurante asociado al proveedor
        IdProveedor INT (11) NOT NULL, -- Identificador del proveedor asociado
        FechaContrato DATETIME DEFAULT CURRENT_TIMESTAMP, -- Fecha de contrato con el proveedor
        CondicionesPago VARCHAR(255), -- Condiciones de pago acordadas con el proveedor
        Estado BOOLEAN DEFAULT TRUE -- Indica si la relación está activa
    );

-- Crear la tabla ProveedorProducto
CREATE TABLE
    ProveedorProducto (
        IdProveedorProducto INT (11) NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Identificador único de la relación, autoincrementable
        IdProveedor INT (11) NOT NULL, -- Identificador del proveedor que ofrece el producto
        IdProducto INT (11) NOT NULL, -- Identificador del producto que ofrece el proveedor
        PrecioProveedor DECIMAL(10, 2), -- Precio al que el proveedor ofrece el producto
        TiempoEntrega INT (3), -- Días estimados de entrega del producto
        Estado BOOLEAN DEFAULT TRUE -- Indica si el proveedor sigue suministrando el producto
    );

-- Crear la tabla Empleado
CREATE TABLE
    Empleado (
        IdEmpleado INT (11) NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Identificador único del empleado, autoincrementable
        Nombre VARCHAR(100) NOT NULL, -- Nombre del empleado
        NumeroDocumento VARCHAR(20) NOT NULL UNIQUE, -- Documento de identidad del empleado, único
        Correo VARCHAR(100) UNIQUE, -- Correo electrónico del empleado, único
        Telefono VARCHAR(15), -- Número de teléfono del empleado
        FechaRegistro DATETIME DEFAULT CURRENT_TIMESTAMP, -- Fecha y hora de registro del empleado
        Estado BOOLEAN DEFAULT TRUE -- Indica si el empleado está activo
    );

-- Crear la tabla EmpleadoRestaurante
CREATE TABLE
    EmpleadoRestaurante (
        IdEmpleadoRestaurante INT (11) NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Identificador único de la relación, autoincrementable
        IdEmpleado INT (11) NOT NULL, -- Identificador del empleado
        IdRestaurante INT (11) NOT NULL -- Identificador del restaurante donde trabaja el empleado
    );

CREATE TABLE
    Log (
        IdLog INT (11) NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Identificador único del log, autoincrementable
        Fecha DATETIME DEFAULT CURRENT_TIMESTAMP, -- Fecha y hora del log
        Detalle TEXT NOT NULL, -- Detalle del log, permite mensajes más largos
        IdEmpleado INT (11) -- Opcional: referencia al usuario que generó el log
    );

-- Establecer la relación entre la tabla Venta y la tabla Cliente
ALTER TABLE Venta ADD CONSTRAINT FK_Venta_Cliente FOREIGN KEY (IdCliente) REFERENCES Cliente (IdCliente);

-- Esta línea establece que el campo IdCliente en la tabla Venta debe coincidir con un IdCliente existente en la tabla Cliente.
-- Establecer la relación entre la tabla Venta y la tabla Restaurante
ALTER TABLE Venta ADD CONSTRAINT FK_Venta_Restaurante FOREIGN KEY (IdRestaurante) REFERENCES Restaurante (IdRestaurante);

-- Esta línea establece que el campo IdRestaurante en la tabla Venta debe coincidir con un IdRestaurante existente en la tabla Restaurante.
-- Establecer la relación entre la tabla ProductoVenta y la tabla Venta
ALTER TABLE ProductoVenta ADD CONSTRAINT FK_ProductoVenta_Venta FOREIGN KEY (IdVenta) REFERENCES Venta (IdVenta);

-- Esta línea establece que el campo IdVenta en la tabla ProductoVenta debe coincidir con un IdVenta existente en la tabla Venta.
-- Establecer la relación entre la tabla ProductoVenta y la tabla Producto
ALTER TABLE ProductoVenta ADD CONSTRAINT FK_ProductoVenta_Producto FOREIGN KEY (IdProducto) REFERENCES Producto (IdProducto);

-- Esta línea establece que el campo IdProducto en la tabla ProductoVenta debe coincidir con un IdProducto existente en la tabla Producto.
-- Establecer la relación entre la tabla ProductoRestaurante y la tabla Producto
ALTER TABLE ProductoRestaurante ADD CONSTRAINT FK_ProductoRestaurante_Producto FOREIGN KEY (IdProducto) REFERENCES Producto (IdProducto);

-- Esta línea establece que el campo IdProducto en la tabla ProductoRestaurante debe coincidir con un IdProducto existente en la tabla Producto.
-- Establecer la relación entre la tabla ProductoRestaurante y la tabla Restaurante
ALTER TABLE ProductoRestaurante ADD CONSTRAINT FK_ProductoRestaurante_Restaurante FOREIGN KEY (IdRestaurante) REFERENCES Restaurante (IdRestaurante);

-- Esta línea establece que el campo IdRestaurante en la tabla ProductoRestaurante debe coincidir con un IdRestaurante existente en la tabla Restaurante.
-- Establecer la relación entre la tabla ProveedorRestaurante y la tabla Proveedor
ALTER TABLE ProveedorRestaurante ADD CONSTRAINT FK_ProveedorRestaurante_Proveedor FOREIGN KEY (IdProveedor) REFERENCES Proveedor (IdProveedor);

-- Esta línea establece que el campo IdProveedor en la tabla ProveedorRestaurante debe coincidir con un IdProveedor existente en la tabla Proveedor.
-- Establecer la relación entre la tabla ProveedorRestaurante y la tabla Restaurante
ALTER TABLE ProveedorRestaurante ADD CONSTRAINT FK_ProveedorRestaurante_Restaurante FOREIGN KEY (IdRestaurante) REFERENCES Restaurante (IdRestaurante);

-- Esta línea establece que el campo IdRestaurante en la tabla ProveedorRestaurante debe coincidir con un IdRestaurante existente en la tabla Restaurante.
-- Establecer la relación entre la tabla ProveedorProducto y la tabla Proveedor
ALTER TABLE ProveedorProducto ADD CONSTRAINT FK_ProveedorProducto_Proveedor FOREIGN KEY (IdProveedor) REFERENCES Proveedor (IdProveedor);

-- Esta línea establece que el campo IdProveedor en la tabla ProveedorProducto debe coincidir con un IdProveedor existente en la tabla Proveedor.
-- Establecer la relación entre la tabla ProveedorProducto y la tabla Producto
ALTER TABLE ProveedorProducto ADD CONSTRAINT FK_ProveedorProducto_Producto FOREIGN KEY (IdProducto) REFERENCES Producto (IdProducto);

-- Esta línea establece que el campo IdProducto en la tabla ProveedorProducto debe coincidir con un IdProducto existente en la tabla Producto.
-- Establecer la relación entre la tabla EmpleadoRestaurante y la tabla Empleado
ALTER TABLE EmpleadoRestaurante ADD CONSTRAINT FK_EmpleadoRestaurante_Empleado FOREIGN KEY (IdEmpleado) REFERENCES Empleado (IdEmpleado);

-- Esta línea establece que el campo IdEmpleado en la tabla EmpleadoRestaurante debe coincidir con un IdEmpleado existente en la tabla Empleado.
-- Establecer la relación entre la tabla EmpleadoRestaurante y la tabla Restaurante
ALTER TABLE EmpleadoRestaurante ADD CONSTRAINT FK_EmpleadoRestaurante_Restaurante FOREIGN KEY (IdRestaurante) REFERENCES Restaurante (IdRestaurante);

-- Esta línea establece que el campo IdRestaurante en la tabla EmpleadoRestaurante debe coincidir con un IdRestaurante existente en la tabla Restaurante.

-- triggers cliente

DELIMITER //
CREATE TRIGGER Cliente_after_insert
AFTER INSERT ON Cliente
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se insertó un nuevo cliente: ',
                    'IdCliente: ', NEW.IdCliente,
                    ', NombreCliente: ', NEW.NombreCliente,
                    ', NumeroDocumentoCliente: ', NEW.NumeroDocumentoCliente,
                    ', EdadCliente: ', NEW.EdadCliente,
                    ', CorreoElectronicoCliente: ', NEW.CorreoElectronicoCliente,
                    ', TelefonoCliente: ', NEW.TelefonoCliente,
                    ', FechaRegistroCliente: ', NEW.FechaRegistroCliente,
                    ', EsMiembroCliente: ', NEW.EsMiembroCliente),1);
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER Cliente_after_update
AFTER UPDATE ON Cliente
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se actualizó el cliente IdCliente: ', OLD.IdCliente,
                    '. Valores anteriores: {NombreCliente: ', OLD.NombreCliente,
                    ', NumeroDocumentoCliente: ', OLD.NumeroDocumentoCliente,
                    ', EdadCliente: ', OLD.EdadCliente,
                    ', CorreoElectronicoCliente: ', OLD.CorreoElectronicoCliente,
                    ', TelefonoCliente: ', OLD.TelefonoCliente,
                    ', FechaRegistroCliente: ', OLD.FechaRegistroCliente,
                    ', EsMiembroCliente: ', OLD.EsMiembroCliente, '}. ',
                    'Nuevos valores: {NombreCliente: ', NEW.NombreCliente,
                    ', NumeroDocumentoCliente: ', NEW.NumeroDocumentoCliente,
                    ', EdadCliente: ', NEW.EdadCliente,
                    ', CorreoElectronicoCliente: ', NEW.CorreoElectronicoCliente,
                    ', TelefonoCliente: ', NEW.TelefonoCliente,
                    ', FechaRegistroCliente: ', NEW.FechaRegistroCliente,
                    ', EsMiembroCliente: ', NEW.EsMiembroCliente, '}.'),1);
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER Cliente_after_delete
AFTER DELETE ON Cliente
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se eliminó el cliente: ',
                    'IdCliente: ', OLD.IdCliente,
                    ', NombreCliente: ', OLD.NombreCliente,
                    ', NumeroDocumentoCliente: ', OLD.NumeroDocumentoCliente,
                    ', EdadCliente: ', OLD.EdadCliente,
                    ', CorreoElectronicoCliente: ', OLD.CorreoElectronicoCliente,
                    ', TelefonoCliente: ', OLD.TelefonoCliente,
                    ', FechaRegistroCliente: ', OLD.FechaRegistroCliente,
                    ', EsMiembroCliente: ', OLD.EsMiembroCliente),1);
END//
DELIMITER ;


-- triggers Venta

DELIMITER //
CREATE TRIGGER Venta_after_insert
AFTER INSERT ON Venta
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se insertó una nueva venta: ',
                    'IdVenta: ', NEW.IdVenta,
                    ', IdCliente: ', NEW.IdCliente,
                    ', IdRestaurante: ', NEW.IdRestaurante,
                    ', FechaVenta: ', NEW.FechaVenta,
                    ', ValorTotalVenta: ', NEW.ValorTotalVenta),1);
END//
DELIMITER ;


DELIMITER //
CREATE TRIGGER Venta_after_update
AFTER UPDATE ON Venta
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se actualizó la venta IdVenta: ', OLD.IdVenta,
                    '. Valores anteriores: {IdCliente: ', OLD.IdCliente,
                    ', IdRestaurante: ', OLD.IdRestaurante,
                    ', FechaVenta: ', OLD.FechaVenta,
                    ', ValorTotalVenta: ', OLD.ValorTotalVenta, '}. ',
                    'Nuevos valores: {IdCliente: ', NEW.IdCliente,
                    ', IdRestaurante: ', NEW.IdRestaurante,
                    ', FechaVenta: ', NEW.FechaVenta,
                    ', ValorTotalVenta: ', NEW.ValorTotalVenta, '}.'),1);
END//
DELIMITER ;


DELIMITER //
CREATE TRIGGER Venta_after_delete
AFTER DELETE ON Venta
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se eliminó la venta: ',
                    'IdVenta: ', OLD.IdVenta,
                    ', IdCliente: ', OLD.IdCliente,
                    ', IdRestaurante: ', OLD.IdRestaurante,
                    ', FechaVenta: ', OLD.FechaVenta,
                    ', ValorTotalVenta: ', OLD.ValorTotalVenta),1);
END//
DELIMITER ;

-- triggers ProductoVenta

DELIMITER //
CREATE TRIGGER ProductoVenta_after_insert
AFTER INSERT ON ProductoVenta
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se insertó un nuevo ProductoVenta: ',
                    'IdProductoVenta: ', NEW.IdProductoVenta,
                    ', IdVenta: ', NEW.IdVenta,
                    ', IdProducto: ', NEW.IdProducto,
                    ', Cantidad: ', NEW.Cantidad,
                    ', PrecioUnitario: ', NEW.PrecioUnitario),1);
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER ProductoVenta_after_update
AFTER UPDATE ON ProductoVenta
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se actualizó el ProductoVenta IdProductoVenta: ', OLD.IdProductoVenta,
                    '. Valores anteriores: {IdVenta: ', OLD.IdVenta,
                    ', IdProducto: ', OLD.IdProducto,
                    ', Cantidad: ', OLD.Cantidad,
                    ', PrecioUnitario: ', OLD.PrecioUnitario, '}. ',
                    'Nuevos valores: {IdVenta: ', NEW.IdVenta,
                    ', IdProducto: ', NEW.IdProducto,
                    ', Cantidad: ', NEW.Cantidad,
                    ', PrecioUnitario: ', NEW.PrecioUnitario, '}.'),1);
END//

DELIMITER ;

DELIMITER //
CREATE TRIGGER ProductoVenta_after_delete
AFTER DELETE ON ProductoVenta
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se eliminó el ProductoVenta: ',
                    'IdProductoVenta: ', OLD.IdProductoVenta,
                    ', IdVenta: ', OLD.IdVenta,
                    ', IdProducto: ', OLD.IdProducto,
                    ', Cantidad: ', OLD.Cantidad,
                    ', PrecioUnitario: ', OLD.PrecioUnitario),1);
END//
DELIMITER ;

-- triggers Producto

DELIMITER //
CREATE TRIGGER Producto_after_insert
AFTER INSERT ON Producto
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se insertó un nuevo producto: ',
                    'IdProducto: ', NEW.IdProducto,
                    ', NombreProducto: ', NEW.NombreProducto,
                    ', Descripcion: ', NEW.Descripcion,
                    ', PrecioUnitario: ', NEW.PrecioUnitario,
                    ', FechaVencimiento: ', NEW.FechaVencimiento,
                    ', UnidadesDisponibles: ', NEW.UnidadesDisponibles,
                    ', IdCategoria: ', NEW.IdCategoria,
                    ', Activo: ', NEW.Activo),1);
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER Producto_after_update
AFTER UPDATE ON Producto
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se actualizó el producto IdProducto: ', OLD.IdProducto,
                    '. Valores anteriores: {NombreProducto: ', OLD.NombreProducto,
                    ', Descripcion: ', OLD.Descripcion,
                    ', PrecioUnitario: ', OLD.PrecioUnitario,
                    ', FechaVencimiento: ', OLD.FechaVencimiento,
                    ', UnidadesDisponibles: ', OLD.UnidadesDisponibles,
                    ', IdCategoria: ', OLD.IdCategoria,
                    ', Activo: ', OLD.Activo, '}. ',
                    'Nuevos valores: {NombreProducto: ', NEW.NombreProducto,
                    ', Descripcion: ', NEW.Descripcion,
                    ', PrecioUnitario: ', NEW.PrecioUnitario,
                    ', FechaVencimiento: ', NEW.FechaVencimiento,
                    ', UnidadesDisponibles: ', NEW.UnidadesDisponibles,
                    ', IdCategoria: ', NEW.IdCategoria,
                    ', Activo: ', NEW.Activo, '}.'),1);
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER Producto_after_delete
AFTER DELETE ON Producto
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se eliminó el producto: ',
                    'IdProducto: ', OLD.IdProducto,
                    ', NombreProducto: ', OLD.NombreProducto,
                    ', Descripcion: ', OLD.Descripcion,
                    ', PrecioUnitario: ', OLD.PrecioUnitario,
                    ', FechaVencimiento: ', OLD.FechaVencimiento,
                    ', UnidadesDisponibles: ', OLD.UnidadesDisponibles,
                    ', IdCategoria: ', OLD.IdCategoria,
                    ', Activo: ', OLD.Activo),1);
END//
DELIMITER ;

-- triggers Categoria

DELIMITER //
CREATE TRIGGER Categoria_after_insert
AFTER INSERT ON Categoria
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se insertó una nueva categoría: ',
                    'IdCategoria: ', NEW.IdCategoria,
                    ', NombreCategoria: ', NEW.NombreCategoria),1);
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER Categoria_after_update
AFTER UPDATE ON Categoria
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se actualizó la categoría IdCategoria: ', OLD.IdCategoria,
                    '. Valor anterior: {NombreCategoria: ', OLD.NombreCategoria, '}. ',
                    'Nuevo valor: {NombreCategoria: ', NEW.NombreCategoria, '}.'),1);
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER Categoria_after_delete
AFTER DELETE ON Categoria
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se eliminó la categoría: ',
                    'IdCategoria: ', OLD.IdCategoria,
                    ', NombreCategoria: ', OLD.NombreCategoria),1);
END//
DELIMITER ;

-- triggers ProductoRestaurante

DELIMITER //
CREATE TRIGGER ProductoRestaurante_after_insert
AFTER INSERT ON ProductoRestaurante
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se asignó un producto a un restaurante: ',
                    'IdProductoRestaurante: ', NEW.IdProductoRestaurante,
                    ', IdRestaurante: ', NEW.IdRestaurante,
                    ', IdProducto: ', NEW.IdProducto,
                    ', UnidadesDisponiblesRestaurante: ', NEW.UnidadesDisponiblesRestaurante,
                    ', Activo: ', NEW.Activo),1);
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER ProductoRestaurante_after_update
AFTER UPDATE ON ProductoRestaurante
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se actualizó el ProductoRestaurante IdProductoRestaurante: ', OLD.IdProductoRestaurante,
                    '. Valores anteriores: {IdRestaurante: ', OLD.IdRestaurante,
                    ', IdProducto: ', OLD.IdProducto,
                    ', UnidadesDisponiblesRestaurante: ', OLD.UnidadesDisponiblesRestaurante,
                    ', Activo: ', OLD.Activo, '}. ',
                    'Nuevos valores: {IdRestaurante: ', NEW.IdRestaurante,
                    ', IdProducto: ', NEW.IdProducto,
                    ', UnidadesDisponiblesRestaurante: ', NEW.UnidadesDisponiblesRestaurante,
                    ', Activo: ', NEW.Activo, '}.'),1);
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER ProductoRestaurante_after_delete
AFTER DELETE ON ProductoRestaurante
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se eliminó la asignación de producto a restaurante: ',
                    'IdProductoRestaurante: ', OLD.IdProductoRestaurante,
                    ', IdRestaurante: ', OLD.IdRestaurante,
                    ', IdProducto: ', OLD.IdProducto,
                    ', UnidadesDisponiblesRestaurante: ', OLD.UnidadesDisponiblesRestaurante,
                    ', Activo: ', OLD.Activo),1);
END//
DELIMITER ;

-- triggers Restaurante

DELIMITER //
CREATE TRIGGER Restaurante_after_insert
AFTER INSERT ON Restaurante
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se insertó un nuevo restaurante: ',
                    'IdRestaurante: ', NEW.IdRestaurante,
                    ', Nombre: ', NEW.Nombre,
                    ', Direccion: ', NEW.Direccion,
                    ', Telefono: ', NEW.Telefono,
                    ', HorarioApertura: ', NEW.HorarioApertura,
                    ', HorarioCierre: ', NEW.HorarioCierre,
                    ', Latitud: ', NEW.Latitud,
                    ', Longitud: ', NEW.Longitud,
                    ', Capacidad: ', NEW.Capacidad),1);
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER Restaurante_after_update
AFTER UPDATE ON Restaurante
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se actualizó el restaurante IdRestaurante: ', OLD.IdRestaurante,
                    '. Valores anteriores: {Nombre: ', OLD.Nombre,
                    ', Direccion: ', OLD.Direccion,
                    ', Telefono: ', OLD.Telefono,
                    ', HorarioApertura: ', OLD.HorarioApertura,
                    ', HorarioCierre: ', OLD.HorarioCierre,
                    ', Latitud: ', OLD.Latitud,
                    ', Longitud: ', OLD.Longitud,
                    ', Capacidad: ', OLD.Capacidad, '}. ',
                    'Nuevos valores: {Nombre: ', NEW.Nombre,
                    ', Direccion: ', NEW.Direccion,
                    ', Telefono: ', NEW.Telefono,
                    ', HorarioApertura: ', NEW.HorarioApertura,
                    ', HorarioCierre: ', NEW.HorarioCierre,
                    ', Latitud: ', NEW.Latitud,
                    ', Longitud: ', NEW.Longitud,
                    ', Capacidad: ', NEW.Capacidad, '}.'),1);
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER Restaurante_after_delete
AFTER DELETE ON Restaurante
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se eliminó el restaurante: ',
                    'IdRestaurante: ', OLD.IdRestaurante,
                    ', Nombre: ', OLD.Nombre,
                    ', Direccion: ', OLD.Direccion,
                    ', Telefono: ', OLD.Telefono,
                    ', HorarioApertura: ', OLD.HorarioApertura,
                    ', HorarioCierre: ', OLD.HorarioCierre,
                    ', Latitud: ', OLD.Latitud,
                    ', Longitud: ', OLD.Longitud,
                    ', Capacidad: ', OLD.Capacidad),1);
END//

DELIMITER ;

-- triggers Proveedor

DELIMITER //
CREATE TRIGGER Proveedor_after_insert
AFTER INSERT ON Proveedor
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se insertó un nuevo proveedor: ',
                    'IdProveedor: ', NEW.IdProveedor,
                    ', Nombre: ', NEW.Nombre,
                    ', Producto: ', NEW.Producto,
                    ', Telefono: ', NEW.Telefono,
                    ', Direccion: ', NEW.Direccion,
                    ', CorreoElectronico: ', NEW.CorreoElectronico,
                    ', TipoProducto: ', NEW.TipoProducto,
                    ', FechaRegistro: ', NEW.FechaRegistro,
                    ', Estado: ', NEW.Estado),1);
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER Proveedor_after_update
AFTER UPDATE ON Proveedor
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se actualizó el proveedor IdProveedor: ', OLD.IdProveedor,
                    '. Valores anteriores: {Nombre: ', OLD.Nombre,
                    ', Producto: ', OLD.Producto,
                    ', Telefono: ', OLD.Telefono,
                    ', Direccion: ', OLD.Direccion,
                    ', CorreoElectronico: ', OLD.CorreoElectronico,
                    ', TipoProducto: ', OLD.TipoProducto,
                    ', FechaRegistro: ', OLD.FechaRegistro,
                    ', Estado: ', OLD.Estado, '}. ',
                    'Nuevos valores: {Nombre: ', NEW.Nombre,
                    ', Producto: ', NEW.Producto,
                    ', Telefono: ', NEW.Telefono,
                    ', Direccion: ', NEW.Direccion,
                    ', CorreoElectronico: ', NEW.CorreoElectronico,
                    ', TipoProducto: ', NEW.TipoProducto,
                    ', FechaRegistro: ', NEW.FechaRegistro,
                    ', Estado: ', NEW.Estado, '}.'),1);
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER Proveedor_after_delete
AFTER DELETE ON Proveedor
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se eliminó el proveedor: ',
                    'IdProveedor: ', OLD.IdProveedor,
                    ', Nombre: ', OLD.Nombre,
                    ', Producto: ', OLD.Producto,
                    ', Telefono: ', OLD.Telefono,
                    ', Direccion: ', OLD.Direccion,
                    ', CorreoElectronico: ', OLD.CorreoElectronico,
                    ', TipoProducto: ', OLD.TipoProducto,
                    ', FechaRegistro: ', OLD.FechaRegistro,
                    ', Estado: ', OLD.Estado),1);
END//
DELIMITER ;

-- triggers ProveedorRestaurante

DELIMITER //
CREATE TRIGGER ProveedorRestaurante_after_insert
AFTER INSERT ON ProveedorRestaurante
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se estableció una relación ProveedorRestaurante: ',
                    'IdProveedorRestaurante: ', NEW.IdProveedorRestaurante,
                    ', IdRestaurante: ', NEW.IdRestaurante,
                    ', IdProveedor: ', NEW.IdProveedor,
                    ', FechaContrato: ', NEW.FechaContrato,
                    ', CondicionesPago: ', NEW.CondicionesPago,
                    ', Estado: ', NEW.Estado),1);
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER ProveedorRestaurante_after_update
AFTER UPDATE ON ProveedorRestaurante
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se actualizó la relación ProveedorRestaurante IdProveedorRestaurante: ', OLD.IdProveedorRestaurante,
                    '. Valores anteriores: {IdRestaurante: ', OLD.IdRestaurante,
                    ', IdProveedor: ', OLD.IdProveedor,
                    ', FechaContrato: ', OLD.FechaContrato,
                    ', CondicionesPago: ', OLD.CondicionesPago,
                    ', Estado: ', OLD.Estado, '}. ',
                    'Nuevos valores: {IdRestaurante: ', NEW.IdRestaurante,
                    ', IdProveedor: ', NEW.IdProveedor,
                    ', FechaContrato: ', NEW.FechaContrato,
                    ', CondicionesPago: ', NEW.CondicionesPago,
                    ', Estado: ', NEW.Estado, '}.'),1);
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER ProveedorRestaurante_after_delete
AFTER DELETE ON ProveedorRestaurante
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se eliminó la relación ProveedorRestaurante: ',
                    'IdProveedorRestaurante: ', OLD.IdProveedorRestaurante,
                    ', IdRestaurante: ', OLD.IdRestaurante,
                    ', IdProveedor: ', OLD.IdProveedor,
                    ', FechaContrato: ', OLD.FechaContrato,
                    ', CondicionesPago: ', OLD.CondicionesPago,
                    ', Estado: ', OLD.Estado),1);
END//
DELIMITER ;

-- triggers ProveedorProducto

DELIMITER //
CREATE TRIGGER ProveedorProducto_after_insert
AFTER INSERT ON ProveedorProducto
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se asignó un producto a un proveedor: ',
                    'IdProveedorProducto: ', NEW.IdProveedorProducto,
                    ', IdProveedor: ', NEW.IdProveedor,
                    ', IdProducto: ', NEW.IdProducto,
                    ', PrecioProveedor: ', NEW.PrecioProveedor,
                    ', TiempoEntrega: ', NEW.TiempoEntrega,
                    ', Estado: ', NEW.Estado),1);
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER ProveedorProducto_after_update
AFTER UPDATE ON ProveedorProducto
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se actualizó la relación ProveedorProducto IdProveedorProducto: ', OLD.IdProveedorProducto,
                    '. Valores anteriores: {IdProveedor: ', OLD.IdProveedor,
                    ', IdProducto: ', OLD.IdProducto,
                    ', PrecioProveedor: ', OLD.PrecioProveedor,
                    ', TiempoEntrega: ', OLD.TiempoEntrega,
                    ', Estado: ', OLD.Estado, '}. ',
                    'Nuevos valores: {IdProveedor: ', NEW.IdProveedor,
                    ', IdProducto: ', NEW.IdProducto,
                    ', PrecioProveedor: ', NEW.PrecioProveedor,
                    ', TiempoEntrega: ', NEW.TiempoEntrega,
                    ', Estado: ', NEW.Estado, '}.'),1);
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER ProveedorProducto_after_delete
AFTER DELETE ON ProveedorProducto
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se eliminó la relación ProveedorProducto: ',
                    'IdProveedorProducto: ', OLD.IdProveedorProducto,
                    ', IdProveedor: ', OLD.IdProveedor,
                    ', IdProducto: ', OLD.IdProducto,
                    ', PrecioProveedor: ', OLD.PrecioProveedor,
                    ', TiempoEntrega: ', OLD.TiempoEntrega,
                    ', Estado: ', OLD.Estado),1);
END//
DELIMITER ;

-- triggers Empleado

DELIMITER //
CREATE TRIGGER Empleado_after_insert
AFTER INSERT ON Empleado
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se insertó un nuevo empleado: ',
                    'IdEmpleado: ', NEW.IdEmpleado,
                    ', Nombre: ', NEW.Nombre,
                    ', NumeroDocumento: ', NEW.NumeroDocumento,
                    ', Correo: ', NEW.Correo,
                    ', Telefono: ', NEW.Telefono,
                    ', FechaRegistro: ', NEW.FechaRegistro,
                    ', Estado: ', NEW.Estado),1);
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER Empleado_after_update
AFTER UPDATE ON Empleado
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se actualizó el empleado IdEmpleado: ', OLD.IdEmpleado,
                    '. Valores anteriores: {Nombre: ', OLD.Nombre,
                    ', NumeroDocumento: ', OLD.NumeroDocumento,
                    ', Correo: ', OLD.Correo,
                    ', Telefono: ', OLD.Telefono,
                    ', FechaRegistro: ', OLD.FechaRegistro,
                    ', Estado: ', OLD.Estado, '}. ',
                    'Nuevos valores: {Nombre: ', NEW.Nombre,
                    ', NumeroDocumento: ', NEW.NumeroDocumento,
                    ', Correo: ', NEW.Correo,
                    ', Telefono: ', NEW.Telefono,
                    ', FechaRegistro: ', NEW.FechaRegistro,
                    ', Estado: ', NEW.Estado, '}.'),1);
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER Empleado_after_delete
AFTER DELETE ON Empleado
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se eliminó el empleado: ',
                    'IdEmpleado: ', OLD.IdEmpleado,
                    ', Nombre: ', OLD.Nombre,
                    ', NumeroDocumento: ', OLD.NumeroDocumento,
                    ', Correo: ', OLD.Correo,
                    ', Telefono: ', OLD.Telefono,
                    ', FechaRegistro: ', OLD.FechaRegistro,
                    ', Estado: ', OLD.Estado),1);
END//
DELIMITER ;

-- triggers EmpleadoRestaurante

DELIMITER //
CREATE TRIGGER EmpleadoRestaurante_after_insert
AFTER INSERT ON EmpleadoRestaurante
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se asignó un empleado a un restaurante: ',
                    'IdEmpleadoRestaurante: ', NEW.IdEmpleadoRestaurante,
                    ', IdEmpleado: ', NEW.IdEmpleado,
                    ', IdRestaurante: ', NEW.IdRestaurante),1);
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER EmpleadoRestaurante_after_update
AFTER UPDATE ON EmpleadoRestaurante
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se actualizó la asignación EmpleadoRestaurante IdEmpleadoRestaurante: ', OLD.IdEmpleadoRestaurante,
                    '. Valores anteriores: {IdEmpleado: ', OLD.IdEmpleado,
                    ', IdRestaurante: ', OLD.IdRestaurante, '}. ',
                    'Nuevos valores: {IdEmpleado: ', NEW.IdEmpleado,
                    ', IdRestaurante: ', NEW.IdRestaurante, '}.'),1);
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER EmpleadoRestaurante_after_delete
AFTER DELETE ON EmpleadoRestaurante
FOR EACH ROW
BEGIN
    INSERT INTO Log (Detalle, IdEmpleado)
    VALUES (CONCAT( 'Se eliminó la asignación EmpleadoRestaurante: ',
                    'IdEmpleadoRestaurante: ', OLD.IdEmpleadoRestaurante,
                    ', IdEmpleado: ', OLD.IdEmpleado,
                    ', IdRestaurante: ', OLD.IdRestaurante),1);
END//
DELIMITER ;

--procedimientos almacenados 

-- 1. Procedimiento para la Tabla Cliente

DELIMITER //
CREATE PROCEDURE sp_ClienteManagement (
    IN p_IdCliente INT,
    IN p_NombreCliente VARCHAR(50),
    IN p_NumeroDocumentoCliente VARCHAR(20),
    IN p_EdadCliente INT,
    IN p_CorreoElectronicoCliente VARCHAR(100),
    IN p_TelefonoCliente VARCHAR(15),
    IN p_EsMiembroCliente BOOLEAN,
    IN p_Accion ENUM('INSERTAR', 'ACTUALIZAR', 'ELIMINAR')
)
BEGIN
    IF p_Accion = 'INSERTAR' THEN
        INSERT INTO Cliente (NombreCliente, NumeroDocumentoCliente, EdadCliente, CorreoElectronicoCliente, TelefonoCliente, EsMiembroCliente)
        VALUES (p_NombreCliente, p_NumeroDocumentoCliente, p_EdadCliente, p_CorreoElectronicoCliente, p_TelefonoCliente, p_EsMiembroCliente);
    ELSEIF p_Accion = 'ACTUALIZAR' THEN
        UPDATE Cliente
        SET NombreCliente = p_NombreCliente,
            NumeroDocumentoCliente = p_NumeroDocumentoCliente,
            EdadCliente = p_EdadCliente,
            CorreoElectronicoCliente = p_CorreoElectronicoCliente,
            TelefonoCliente = p_TelefonoCliente,
            EsMiembroCliente = p_EsMiembroCliente
        WHERE IdCliente = p_IdCliente;
    ELSEIF p_Accion = 'ELIMINAR' THEN
        DELETE FROM Cliente WHERE IdCliente = p_IdCliente;
    END IF;
END//
DELIMITER ;

-- 2. Procedimiento para la Tabla Venta

DELIMITER //
CREATE PROCEDURE sp_VentaManagement (
    IN p_IdVenta INT,
    IN p_IdCliente INT,
    IN p_IdRestaurante INT,
    IN p_ValorTotalVenta DECIMAL(10, 2),
    IN p_Accion ENUM('INSERTAR', 'ACTUALIZAR', 'ELIMINAR')
)
BEGIN
    IF p_Accion = 'INSERTAR' THEN
        INSERT INTO Venta (IdCliente, IdRestaurante, ValorTotalVenta)
        VALUES (p_IdCliente, p_IdRestaurante, p_ValorTotalVenta);
    
    ELSEIF p_Accion = 'ACTUALIZAR' THEN
        UPDATE Venta
        SET IdCliente = p_IdCliente,
            IdRestaurante = p_IdRestaurante,
            ValorTotalVenta = p_ValorTotalVenta
        WHERE IdVenta = p_IdVenta;

    ELSEIF p_Accion = 'ELIMINAR' THEN
        DELETE FROM Venta WHERE IdVenta = p_IdVenta;

    END IF;
END//
DELIMITER ;

-- 3. Procedimiento para la Tabla ProductoVenta

DELIMITER //
CREATE PROCEDURE sp_ProductoVentaManagement (
    IN p_IdProductoVenta INT,
    IN p_IdVenta INT,
    IN p_IdProducto INT,
    IN p_Cantidad INT,
    IN p_PrecioUnitario DECIMAL(10, 2),
    IN p_Accion ENUM('INSERTAR', 'ACTUALIZAR', 'ELIMINAR')
)
BEGIN
    IF p_Accion = 'INSERTAR' THEN
        INSERT INTO ProductoVenta (IdVenta, IdProducto, Cantidad, PrecioUnitario)
        VALUES (p_IdVenta, p_IdProducto, p_Cantidad, p_PrecioUnitario);
    
    ELSEIF p_Accion = 'ACTUALIZAR' THEN
        UPDATE ProductoVenta
        SET IdVenta = p_IdVenta,
            IdProducto = p_IdProducto,
            Cantidad = p_Cantidad,
            PrecioUnitario = p_PrecioUnitario
        WHERE IdProductoVenta = p_IdProductoVenta;

    ELSEIF p_Accion = 'ELIMINAR' THEN
        DELETE FROM ProductoVenta WHERE IdProductoVenta = p_IdProductoVenta;

    END IF;
END//
DELIMITER ;

-- 4. Procedimiento para la Tabla Producto

DELIMITER //
CREATE PROCEDURE sp_ProductoManagement (
    IN p_IdProducto INT,
    IN p_NombreProducto VARCHAR(100),
    IN p_Descripcion VARCHAR(255),
    IN p_PrecioUnitario DECIMAL(10, 2),
    IN p_FechaVencimiento DATE,
    IN p_UnidadesDisponibles INT,
    IN p_IdCategoria INT,
    IN p_Activo BOOLEAN,
    IN p_Accion ENUM('INSERTAR', 'ACTUALIZAR', 'ELIMINAR')
)
BEGIN
    IF p_Accion = 'INSERTAR' THEN
        INSERT INTO Producto (NombreProducto, Descripcion, PrecioUnitario, FechaVencimiento, UnidadesDisponibles, IdCategoria, Activo)
        VALUES (p_NombreProducto, p_Descripcion, p_PrecioUnitario, p_FechaVencimiento, p_UnidadesDisponibles, p_IdCategoria, p_Activo);
    
    ELSEIF p_Accion = 'ACTUALIZAR' THEN
        UPDATE Producto
        SET NombreProducto = p_NombreProducto,
            Descripcion = p_Descripcion,
            PrecioUnitario = p_PrecioUnitario,
            FechaVencimiento = p_FechaVencimiento,
            UnidadesDisponibles = p_UnidadesDisponibles,
            IdCategoria = p_IdCategoria,
            Activo = p_Activo
        WHERE IdProducto = p_IdProducto;

    ELSEIF p_Accion = 'ELIMINAR' THEN
        DELETE FROM Producto WHERE IdProducto = p_IdProducto;

    END IF;
END//
DELIMITER ;

-- 5. Procedimiento para la Tabla Categoria

DELIMITER //
CREATE PROCEDURE sp_CategoriaManagement (
    IN p_IdCategoria INT,
    IN p_NombreCategoria VARCHAR(100),
    IN p_Accion ENUM('INSERTAR', 'ACTUALIZAR', 'ELIMINAR')
)
BEGIN
    IF p_Accion = 'INSERTAR' THEN
        INSERT INTO Categoria (NombreCategoria)
        VALUES (p_NombreCategoria);
    
    ELSEIF p_Accion = 'ACTUALIZAR' THEN
        UPDATE Categoria
        SET NombreCategoria = p_NombreCategoria
        WHERE IdCategoria = p_IdCategoria;

    ELSEIF p_Accion = 'ELIMINAR' THEN
        DELETE FROM Categoria WHERE IdCategoria = p_IdCategoria;

    END IF;
END//
DELIMITER ;

-- 6. Procedimiento para la Tabla ProductoRestaurante

DELIMITER //
CREATE PROCEDURE sp_ProductoRestauranteManagement (
    IN p_IdProductoRestaurante INT,
    IN p_IdRestaurante INT,
    IN p_IdProducto INT,
    IN p_UnidadesDisponiblesRestaurante INT,
    IN p_Activo BOOLEAN,
    IN p_Accion ENUM('INSERTAR', 'ACTUALIZAR', 'ELIMINAR')
)
BEGIN
    IF p_Accion = 'INSERTAR' THEN
        INSERT INTO ProductoRestaurante (IdRestaurante, IdProducto, UnidadesDisponiblesRestaurante, Activo)
        VALUES (p_IdRestaurante, p_IdProducto, p_UnidadesDisponiblesRestaurante, p_Activo);
    
    ELSEIF p_Accion = 'ACTUALIZAR' THEN
        UPDATE ProductoRestaurante
        SET IdRestaurante = p_IdRestaurante,
            IdProducto = p_IdProducto,
            UnidadesDisponiblesRestaurante = p_UnidadesDisponiblesRestaurante,
            Activo = p_Activo
        WHERE IdProductoRestaurante = p_IdProductoRestaurante;

    ELSEIF p_Accion = 'ELIMINAR' THEN
        DELETE FROM ProductoRestaurante WHERE IdProductoRestaurante = p_IdProductoRestaurante;

    END IF;
END//
DELIMITER ;

-- 7. Procedimiento para la Tabla Restaurante

DELIMITER //
CREATE PROCEDURE sp_RestauranteManagement (
    IN p_IdRestaurante INT,
    IN p_Nombre VARCHAR(100),
    IN p_Direccion VARCHAR(255),
    IN p_Telefono VARCHAR(15),
    IN p_HorarioApertura TIME,
    IN p_HorarioCierre TIME,
    IN p_Latitud DECIMAL(9, 6),
    IN p_Longitud DECIMAL(9, 6),
    IN p_Capacidad INT,
    IN p_Accion ENUM('INSERTAR', 'ACTUALIZAR', 'ELIMINAR')
)
BEGIN
    IF p_Accion = 'INSERTAR' THEN
        INSERT INTO Restaurante (Nombre, Direccion, Telefono, HorarioApertura, HorarioCierre, Latitud, Longitud, Capacidad)
        VALUES (p_Nombre, p_Direccion, p_Telefono, p_HorarioApertura, p_HorarioCierre, p_Latitud, p_Longitud, p_Capacidad);
    
    ELSEIF p_Accion = 'ACTUALIZAR' THEN
        UPDATE Restaurante
        SET Nombre = p_Nombre,
            Direccion = p_Direccion,
            Telefono = p_Telefono,
            HorarioApertura = p_HorarioApertura,
            HorarioCierre = p_HorarioCierre,
            Latitud = p_Latitud,
            Longitud = p_Longitud,
            Capacidad = p_Capacidad
        WHERE IdRestaurante = p_IdRestaurante;

    ELSEIF p_Accion = 'ELIMINAR' THEN
        DELETE FROM Restaurante WHERE IdRestaurante = p_IdRestaurante;

    END IF;
END//
DELIMITER ;

-- 8. Procedimiento para la Tabla Proveedor

DELIMITER //
CREATE PROCEDURE sp_ProveedorManagement (
    IN p_IdProveedor INT,
    IN p_Nombre VARCHAR(100),
    IN p_Producto VARCHAR(100),
    IN p_Telefono VARCHAR(15),
    IN p_Direccion VARCHAR(255),
    IN p_CorreoElectronico VARCHAR(100),
    IN p_TipoProducto VARCHAR(50),
    IN p_Estado BOOLEAN,
    IN p_Accion ENUM('INSERTAR', 'ACTUALIZAR', 'ELIMINAR')
)
BEGIN
    IF p_Accion = 'INSERTAR' THEN
        INSERT INTO Proveedor (Nombre, Producto, Telefono, Direccion, CorreoElectronico, TipoProducto, Estado)
        VALUES (p_Nombre, p_Producto, p_Telefono, p_Direccion, p_CorreoElectronico, p_TipoProducto, p_Estado);
    
    ELSEIF p_Accion = 'ACTUALIZAR' THEN
        UPDATE Proveedor
        SET Nombre = p_Nombre,
            Producto = p_Producto,
            Telefono = p_Telefono,
            Direccion = p_Direccion,
            CorreoElectronico = p_CorreoElectronico,
            TipoProducto = p_TipoProducto,
            Estado = p_Estado
        WHERE IdProveedor = p_IdProveedor;

    ELSEIF p_Accion = 'ELIMINAR' THEN
        DELETE FROM Proveedor WHERE IdProveedor = p_IdProveedor;

    END IF;
END//
DELIMITER ;

-- 9. Procedimiento para la Tabla ProveedorRestaurante

DELIMITER //
CREATE PROCEDURE sp_ProveedorRestauranteManagement (
    IN p_IdProveedorRestaurante INT,
    IN p_IdRestaurante INT,
    IN p_IdProveedor INT,
    IN p_FechaContrato DATETIME,
    IN p_CondicionesPago VARCHAR(255),
    IN p_Estado BOOLEAN,
    IN p_Accion ENUM('INSERTAR', 'ACTUALIZAR', 'ELIMINAR')
)
BEGIN
    IF p_Accion = 'INSERTAR' THEN
        INSERT INTO ProveedorRestaurante (IdRestaurante, IdProveedor, FechaContrato, CondicionesPago, Estado)
        VALUES (p_IdRestaurante, p_IdProveedor, p_FechaContrato, p_CondicionesPago, p_Estado);
    
    ELSEIF p_Accion = 'ACTUALIZAR' THEN
        UPDATE ProveedorRestaurante
        SET IdRestaurante = p_IdRestaurante,
            IdProveedor = p_IdProveedor,
            FechaContrato = p_FechaContrato,
            CondicionesPago = p_CondicionesPago,
            Estado = p_Estado
        WHERE IdProveedorRestaurante = p_IdProveedorRestaurante;

    ELSEIF p_Accion = 'ELIMINAR' THEN
        DELETE FROM ProveedorRestaurante WHERE IdProveedorRestaurante = p_IdProveedorRestaurante;

    END IF;
END//
DELIMITER ;

-- 10. Procedimiento para la Tabla ProveedorProducto

DELIMITER //
CREATE PROCEDURE sp_ProveedorProductoManagement (
    IN p_IdProveedorProducto INT,
    IN p_IdProveedor INT,
    IN p_IdProducto INT,
    IN p_PrecioProveedor DECIMAL(10, 2),
    IN p_TiempoEntrega INT,
    IN p_Estado BOOLEAN,
    IN p_Accion ENUM('INSERTAR', 'ACTUALIZAR', 'ELIMINAR')
)
BEGIN
    IF p_Accion = 'INSERTAR' THEN
        INSERT INTO ProveedorProducto (IdProveedor, IdProducto, PrecioProveedor, TiempoEntrega, Estado)
        VALUES (p_IdProveedor, p_IdProducto, p_PrecioProveedor, p_TiempoEntrega, p_Estado);
    
    ELSEIF p_Accion = 'ACTUALIZAR' THEN
        UPDATE ProveedorProducto
        SET IdProveedor = p_IdProveedor,
            IdProducto = p_IdProducto,
            PrecioProveedor = p_PrecioProveedor,
            TiempoEntrega = p_TiempoEntrega,
            Estado = p_Estado
        WHERE IdProveedorProducto = p_IdProveedorProducto;

    ELSEIF p_Accion = 'ELIMINAR' THEN
        DELETE FROM ProveedorProducto WHERE IdProveedorProducto = p_IdProveedorProducto;

    END IF;
END//
DELIMITER ;

-- 11. Procedimiento para la Tabla Empleado

DELIMITER //
CREATE PROCEDURE sp_EmpleadoManagement (
    IN p_IdEmpleado INT,
    IN p_Nombre VARCHAR(100),
    IN p_NumeroDocumento VARCHAR(20),
    IN p_Correo VARCHAR(100),
    IN p_Telefono VARCHAR(15),
    IN p_Estado BOOLEAN,
    IN p_Accion ENUM('INSERTAR', 'ACTUALIZAR', 'ELIMINAR')
)
BEGIN
    IF p_Accion = 'INSERTAR' THEN
        INSERT INTO Empleado (Nombre, NumeroDocumento, Correo, Telefono, Estado)
        VALUES (p_Nombre, p_NumeroDocumento, p_Correo, p_Telefono, p_Estado);
    
    ELSEIF p_Accion = 'ACTUALIZAR' THEN
        UPDATE Empleado
        SET Nombre = p_Nombre,
            NumeroDocumento = p_NumeroDocumento,
            Correo = p_Correo,
            Telefono = p_Telefono,
            Estado = p_Estado
        WHERE IdEmpleado = p_IdEmpleado;

    ELSEIF p_Accion = 'ELIMINAR' THEN
        DELETE FROM Empleado WHERE IdEmpleado = p_IdEmpleado;

    END IF;
END//
DELIMITER ;

-- 12. Procedimiento para la Tabla EmpleadoRestaurante

DELIMITER //
CREATE PROCEDURE sp_EmpleadoRestauranteManagement (
    IN p_IdEmpleadoRestaurante INT,
    IN p_IdEmpleado INT,
    IN p_IdRestaurante INT,
    IN p_Accion ENUM('INSERTAR', 'ACTUALIZAR', 'ELIMINAR')
)
BEGIN
    IF p_Accion = 'INSERTAR' THEN
        INSERT INTO EmpleadoRestaurante (IdEmpleado, IdRestaurante)
        VALUES (p_IdEmpleado, p_IdRestaurante);
    
    ELSEIF p_Accion = 'ACTUALIZAR' THEN
        UPDATE EmpleadoRestaurante
        SET IdEmpleado = p_IdEmpleado,
            IdRestaurante = p_IdRestaurante
        WHERE IdEmpleadoRestaurante = p_IdEmpleadoRestaurante;

    ELSEIF p_Accion = 'ELIMINAR' THEN
        DELETE FROM EmpleadoRestaurante WHERE IdEmpleadoRestaurante = p_IdEmpleadoRestaurante;

    END IF;
END//
DELIMITER ;

-- inserciones 
CALL sp_CategoriaManagement(NULL, 'Comida Rápida', 'INSERTAR');
CALL sp_CategoriaManagement(NULL, 'Bebidas', 'INSERTAR');
CALL sp_CategoriaManagement(NULL, 'Postres', 'INSERTAR');
CALL sp_CategoriaManagement(NULL, 'Entrantes', 'INSERTAR');
CALL sp_CategoriaManagement(NULL, 'Platos Principales', 'INSERTAR');

-- 1. Insertar Registros en la Tabla Cliente
CALL sp_ClienteManagement(NULL, 'Juan Pérez', '12345678', 30, 'juan@example.com', '555123456', TRUE, 'INSERTAR');
CALL sp_ClienteManagement(NULL, 'María López', '87654321', 28, 'maria@example.com', '555654321', FALSE, 'INSERTAR');
CALL sp_ClienteManagement(NULL, 'Carlos Gómez', '11122334', 35, 'carlos@example.com', '555112233', TRUE, 'INSERTAR');
CALL sp_ClienteManagement(NULL, 'Laura Fernández', '44332211', 26, 'laura@example.com', '555998877', TRUE, 'INSERTAR');
CALL sp_ClienteManagement(NULL, 'Pedro Sánchez', '55667788', 40, 'pedro@example.com', '555334455', FALSE, 'INSERTAR');

-- 2. Insertar Registros en la Tabla Restaurante
CALL sp_RestauranteManagement(NULL, 'Restaurante La Playa', 'Av. del Mar 123', '555444332', '08:00:00', '22:00:00', -34.6091, -58.3735, 50, 'INSERTAR');
CALL sp_RestauranteManagement(NULL, 'Comida Rápida El Rey', 'Calle 10 #456', '555222111', '10:00:00', '21:00:00', -34.6092, -58.3736, 30, 'INSERTAR');
CALL sp_RestauranteManagement(NULL, 'Sushi House', 'Calle 20 #789', '555333222', '11:00:00', '23:00:00', -34.6093, -58.3737, 40, 'INSERTAR');
CALL sp_RestauranteManagement(NULL, 'Pizzeria La Italia', 'Calle 5 #234', '555888999', '09:00:00', '22:30:00', -34.6094, -58.3738, 60, 'INSERTAR');
CALL sp_RestauranteManagement(NULL, 'Cafetería Aroma', 'Calle 15 #345', '555666444', '07:00:00', '20:00:00', -34.6095, -58.3739, 20, 'INSERTAR');

-- 3. Insertar Registros en la Tabla Venta
CALL sp_VentaManagement(NULL, 1, 1, 150.50, 'INSERTAR');
CALL sp_VentaManagement(NULL, 2, 2, 200.75, 'INSERTAR');
CALL sp_VentaManagement(NULL, 3, 3, 320.00, 'INSERTAR');
CALL sp_VentaManagement(NULL, 4, 4, 450.30, 'INSERTAR');
CALL sp_VentaManagement(NULL, 5, 5, 560.45, 'INSERTAR');

-- 4. Insertar Registros en la Tabla Producto
CALL sp_ProductoManagement(NULL, 'Hamburguesa', 'Hamburguesa de res con queso', 10.00, '2024-12-31', 100, 1, TRUE, 'INSERTAR');
CALL sp_ProductoManagement(NULL, 'Sushi', 'Sushi variado', 15.00, '2024-12-31', 50, 2, TRUE, 'INSERTAR');
CALL sp_ProductoManagement(NULL, 'Pizza', 'Pizza margarita', 12.00, '2024-12-31', 30, 3, TRUE, 'INSERTAR');
CALL sp_ProductoManagement(NULL, 'Café', 'Café americano', 3.00, '2024-12-31', 200, 4, TRUE, 'INSERTAR');
CALL sp_ProductoManagement(NULL, 'Tacos', 'Tacos al pastor', 8.00, '2024-12-31', 150, 5, TRUE, 'INSERTAR');

-- 5. Insertar Registros en la Tabla ProductoVenta
CALL sp_ProductoVentaManagement(NULL, 1, 1, 2, 10.00, 'INSERTAR'); -- 2 Hamburguesas en la Venta 1
CALL sp_ProductoVentaManagement(NULL, 2, 2, 1, 15.00, 'INSERTAR'); -- 1 Sushi en la Venta 2
CALL sp_ProductoVentaManagement(NULL, 3, 3, 3, 12.00, 'INSERTAR'); -- 3 Pizzas en la Venta 3
CALL sp_ProductoVentaManagement(NULL, 4, 4, 5, 3.00, 'INSERTAR');  -- 5 Cafés en la Venta 4
CALL sp_ProductoVentaManagement(NULL, 5, 5, 4, 8.00, 'INSERTAR');  -- 4 Tacos en la Venta 5

-- 6. Insertar Registros en la Tabla ProductoRestaurante
CALL sp_ProductoRestauranteManagement(NULL, 1, 1, 100, TRUE, 'INSERTAR'); -- 100 Hamburguesas en Restaurante La Playa
CALL sp_ProductoRestauranteManagement(NULL, 2, 2, 50, TRUE, 'INSERTAR'); -- 50 Sushi en Comida Rápida El Rey
CALL sp_ProductoRestauranteManagement(NULL, 3, 3, 30, TRUE, 'INSERTAR'); -- 30 Pizzas en Sushi House
CALL sp_ProductoRestauranteManagement(NULL, 4, 4, 200, TRUE, 'INSERTAR'); -- 200 Cafés en Pizzeria La Italia
CALL sp_ProductoRestauranteManagement(NULL, 5, 5, 150, TRUE, 'INSERTAR'); -- 150 Tacos en Cafetería Aroma

-- 7. Insertar Registros en la Tabla Proveedor
CALL sp_ProveedorManagement(NULL, 'Proveedor 1', 'Hamburguesas', '555123456', 'Calle Falsa 123', 'proveedor1@example.com', 'Carnes', TRUE, 'INSERTAR');
CALL sp_ProveedorManagement(NULL, 'Proveedor 2', 'Sushi', '555654321', 'Calle Real 456', 'proveedor2@example.com', 'Mariscos', TRUE, 'INSERTAR');
CALL sp_ProveedorManagement(NULL, 'Proveedor 3', 'Pizza', '555789012', 'Calle Larga 789', 'proveedor3@example.com', 'Vegetales', TRUE, 'INSERTAR');
CALL sp_ProveedorManagement(NULL, 'Proveedor 4', 'Café', '555345678', 'Calle Cortada 159', 'proveedor4@example.com', 'Bebidas', TRUE, 'INSERTAR');
CALL sp_ProveedorManagement(NULL, 'Proveedor 5', 'Tacos', '555246801', 'Calle Principal 357', 'proveedor5@example.com', 'Carnes', TRUE, 'INSERTAR');

-- 8. Insertar Registros en la Tabla ProveedorRestaurante
CALL sp_ProveedorRestauranteManagement(NULL, 1, 1, '2024-10-01 10:00:00', 'Pago al contado', TRUE, 'INSERTAR'); -- Proveedor 1 para Restaurante La Playa
CALL sp_ProveedorRestauranteManagement(NULL, 2, 2, '2024-10-02 10:00:00', 'Pago al contado', TRUE, 'INSERTAR'); -- Proveedor 2 para Comida Rápida El Rey
CALL sp_ProveedorRestauranteManagement(NULL, 3, 3, '2024-10-03 10:00:00', 'Pago al contado', TRUE, 'INSERTAR'); -- Proveedor 3 para Sushi House
CALL sp_ProveedorRestauranteManagement(NULL, 4, 4, '2024-10-04 10:00:00', 'Pago al contado', TRUE, 'INSERTAR'); -- Proveedor 4 para Pizzeria La Italia
CALL sp_ProveedorRestauranteManagement(NULL, 5, 5, '2024-10-05 10:00:00', 'Pago al contado', TRUE, 'INSERTAR'); -- Proveedor 5 para Cafetería Aroma

-- 9. Insertar Registros en la Tabla ProveedorProducto
CALL sp_ProveedorProductoManagement(NULL, 1, 1, 9.00, 3, TRUE, 'INSERTAR'); -- Proveedor 1 para Hamburguesas
CALL sp_ProveedorProductoManagement(NULL, 2, 2, 14.00, 2, TRUE, 'INSERTAR'); -- Proveedor 2 para Sushi
CALL sp_ProveedorProductoManagement(NULL, 3, 3, 11.00, 1, TRUE, 'INSERTAR'); -- Proveedor 3 para Pizza
CALL sp_ProveedorProductoManagement(NULL, 4, 4, 2.50, 5, TRUE, 'INSERTAR'); -- Proveedor 4 para Café
CALL sp_ProveedorProductoManagement(NULL, 5, 5, 7.50, 4, TRUE, 'INSERTAR'); -- Proveedor 5 para Tacos

-- 10. Insertar Registros en la Tabla Empleado
CALL sp_EmpleadoManagement(NULL, 'José Martínez', '11122334', 'jose@example.com', '555111222', TRUE, 'INSERTAR');
CALL sp_EmpleadoManagement(NULL, 'Ana Gómez', '22233445', 'ana@example.com', '555222333', TRUE, 'INSERTAR');
CALL sp_EmpleadoManagement(NULL, 'Luis Herrera', '33344556', 'luis@example.com', '555333444', TRUE, 'INSERTAR');
CALL sp_EmpleadoManagement(NULL, 'Elena Ruiz', '44455667', 'elena@example.com', '555444555', TRUE, 'INSERTAR');
CALL sp_EmpleadoManagement(NULL, 'Diego Sánchez', '55566778', 'diego@example.com', '555555666', TRUE, 'INSERTAR');

-- 11. Insertar Registros en la Tabla EmpleadoRestaurante
CALL sp_EmpleadoRestauranteManagement(NULL, 1, 1, 'INSERTAR'); -- José en Restaurante La Playa
CALL sp_EmpleadoRestauranteManagement(NULL, 2, 2, 'INSERTAR'); -- Ana en Comida Rápida El Rey
CALL sp_EmpleadoRestauranteManagement(NULL, 3, 3, 'INSERTAR'); -- Luis en Sushi House
CALL sp_EmpleadoRestauranteManagement(NULL, 4, 4, 'INSERTAR'); -- Elena en Pizzeria La Italia
CALL sp_EmpleadoRestauranteManagement(NULL, 5, 5, 'INSERTAR'); -- Diego en Cafetería Aroma

-- vistas

-- 1. Vista de Ventas por Cliente

CREATE VIEW V_VentasPorCliente AS
SELECT 
    c.IdCliente,
    c.NombreCliente,
    v.IdVenta,
    v.FechaVenta,
    v.ValorTotalVenta
FROM 
    Cliente c
INNER JOIN 
    Venta v ON c.IdCliente = v.IdCliente;

-- 2. Vista de Productos en Restaurantes

CREATE VIEW V_ProductosPorRestaurante AS
SELECT 
    r.IdRestaurante,
    r.Nombre,
    p.IdProducto,
    p.NombreProducto,
    pr.UnidadesDisponiblesRestaurante
FROM 
    Restaurante r
INNER JOIN 
    ProductoRestaurante pr ON r.IdRestaurante = pr.IdRestaurante
INNER JOIN 
    Producto p ON pr.IdProducto = p.IdProducto;

-- 3. Vista de Empleados por Restaurante

CREATE VIEW V_EmpleadosPorRestaurante AS
SELECT 
    r.IdRestaurante,
    r.Nombre,
    e.IdEmpleado,
    e.Nombre AS NombreEmpleado
FROM 
    Restaurante r
INNER JOIN 
    EmpleadoRestaurante er ON r.IdRestaurante = er.IdRestaurante
INNER JOIN 
    Empleado e ON er.IdEmpleado = e.IdEmpleado;

--4. Vista de Productos Vendidos en Ventas

CREATE VIEW V_DetalleProductosVendidos AS
SELECT 
    v.IdVenta,
    v.FechaVenta,
    c.NombreCliente,
    r.Nombre AS NombreRestaurante,
    pv.IdProducto,
    pv.Cantidad,
    pv.PrecioUnitario
FROM 
    Venta v
INNER JOIN 
    ProductoVenta pv ON v.IdVenta = pv.IdVenta
INNER JOIN 
    Cliente c ON v.IdCliente = c.IdCliente
INNER JOIN 
    Restaurante r ON v.IdRestaurante = r.IdRestaurante;

-- 5. Vista de Proveedores por Restaurante

CREATE VIEW V_ProveedoresPorRestaurante AS
SELECT 
    r.IdRestaurante,
    r.Nombre AS NombreRestaurante,
    p.IdProveedor,
    p.Nombre AS NombreProveedor,
    p.Telefono
FROM 
    Restaurante r
INNER JOIN 
    ProveedorRestaurante pr ON r.IdRestaurante = pr.IdRestaurante
INNER JOIN 
    Proveedor p ON pr.IdProveedor = p.IdProveedor;


SELECT * FROM V_VentasPorCliente;
SELECT * FROM V_ProductosPorRestaurante;
SELECT * FROM V_EmpleadosPorRestaurante;
SELECT * FROM V_DetalleProductosVendidos;
SELECT * FROM V_ProveedoresPorRestaurante;

-- Mostrar todos los registros de la tabla Cliente
SELECT * FROM Cliente;

-- Mostrar todos los registros de la tabla Venta
SELECT * FROM Venta;

-- Mostrar todos los registros de la tabla ProductoVenta
SELECT * FROM ProductoVenta;

-- Mostrar todos los registros de la tabla Producto
SELECT * FROM Producto;

-- Mostrar todos los registros de la tabla Categoria
SELECT * FROM Categoria;

-- Mostrar todos los registros de la tabla ProductoRestaurante
SELECT * FROM ProductoRestaurante;

-- Mostrar todos los registros de la tabla Restaurante
SELECT * FROM Restaurante;

-- Mostrar todos los registros de la tabla Proveedor
SELECT * FROM Proveedor;

-- Mostrar todos los registros de la tabla ProveedorRestaurante
SELECT * FROM ProveedorRestaurante;

-- Mostrar todos los registros de la tabla ProveedorProducto
SELECT * FROM ProveedorProducto;

-- Mostrar todos los registros de la tabla Empleado
SELECT * FROM Empleado;

-- Mostrar todos los registros de la tabla EmpleadoRestaurante
SELECT * FROM EmpleadoRestaurante;

sudo su

Z0n4l0gT1**$

mysql -u root




SELECT 
    TRIGGER_NAME, 
    EVENT_MANIPULATION, 
    EVENT_OBJECT_TABLE, 
    ACTION_STATEMENT, 
    ACTION_TIMING 
FROM 
    information_schema.TRIGGERS 
WHERE 
    TRIGGER_SCHEMA = 'McDonalds';

SELECT 
    ROUTINE_NAME, 
    ROUTINE_TYPE, 
    DATA_TYPE, 
    CREATED, 
    LAST_ALTERED
FROM 
    information_schema.ROUTINES
WHERE 
    ROUTINE_SCHEMA = 'McDonalds'
    AND ROUTINE_TYPE = 'PROCEDURE';


SELECT 
    TABLE_NAME
FROM 
    information_schema.TABLES
WHERE SELECT 
    table_name, 
    column_name, 
    referenced_table_name, 
    referenced_column_name 
FROM 
    information_schema.key_column_usage 
WHERE 
    table_schema = 'McDonalds'
    AND referenced_table_name IS NOT NULL;

    TABLE_TYPE = 'VIEW'
    AND TABLE_SCHEMA = 'McDonalds';

