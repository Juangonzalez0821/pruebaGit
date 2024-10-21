juangonzalez@zl2102:~$ sudo mysql -u root
[sudo] contraseña para juangonzalez: 
Lo siento, pruebe otra vez.
[sudo] contraseña para juangonzalez: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 14
Server version: 8.0.39-0ubuntu0.22.04.1 (Ubuntu)

Copyright (c) 2000, 2024, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> DROP DATABASE McDonalds;
        Telefono VARCHAR(Query OK, 13 rows affected (0,08 sec)

mysql> 
mysql> -- Crear la base de datos si no existe
mysql> CREATE DATABASE IF NOT EXISTS McDonalds;
Query OK, 1 row affected (0,00 sec)

mysql> USE McDonalds;
Database changed
mysql> 
mysql> 
lmysql> -- Crear la tabla Cliente
mysql> CREATE TABLE
    ->     Cliente (
    ->         IdCliente INT (11) NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Identificador único del cliente, autoincrementable
    ->         NombreCliente VARCHAR(50) NOT NULL, -- Nombre del cliente
    ->         NumeroDocumentoCliente VARCHAR(20) NOT NULL UNIQUE, -- Documento de identidad, único para cada cliente
    ->         EdadCliente INT (3) NOT NULL CHECK (EdadCliente >= 0), -- Edad del cliente, debe ser un número positivo
    ->         CorreoElectronicoCliente VARCHAR(100) UNIQUE, -- Correo electrónico, único
r    ->         TelefonoCliente VARCHAR(15), -- Número de teléfono del cliente
    ->         FechaRegistroCliente DATETIME DEFAULT CURRENT_TIMESTAMP, -- Fecha y hora de registro, por defecto la actual
    ->         EsMiembroCliente BOOLEAN DEFAULT FALSE -- Indica si el cliente es miembro, por defecto falso
    ->     );
RQuery OK, 0 rows affected, 2 warnings (0,01 sec)

mysql> 
mysql> -- Crear la tabla Venta
(50), -- Tipo de productomysql> CREATE TABLE
    ->     Venta (
    ->         IdVenta INT (11) NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Identificador único de la venta, autoincrementable
    ->         IdCliente INT (11) NOT NULL, -- Identificador del cliente que realizó la compra
    ->         IdRestaurante INT (11) NOT NULL, -- Identificador del restaurante donde se realizó la venta
    ->         FechaVenta DATETIME DEFAULT CURRENT_TIMESTAMP, -- Fecha y hora de la venta, por defecto la actual
    ->         ValorTotalVenta DECIMAL(10, 2) NOT NULL -- Valor total de la venta, con dos decimales
    ->     );
Query OK, 0 rows affected, 3 warnings (0,02 sec)

mysql> 
Nmysql> -- Crear la tabla ProductoVenta
mysql> CREATE TABLE
    ->     ProductoVenta (
    ->         IdProductoVenta INT (11) NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Identificador único de la venta de producto, autoincrementable
    ->         IdVenta INT (11) NOT NULL, -- Identificador de la venta asociada
    ->         IdProducto INT (11) NOT NULL, -- Identificador del producto vendido
    ->         Cantidad INT (11) NOT NULL, -- Cantidad del producto vendido
    ->         PrecioUnitario DECIMAL(10, 2) NOT NULL -- Precio por unidad del producto
    ->     );
Query OK, 0 rows affected, 4 warnings (0,01 sec)

mysql> 
mysql> -- Crear la tabla Producto
mysql> CREATE TABLE
    ->     Producto (
     ->         IdProducto INT (11) NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Identificador único del producto, autoincrementable
    ->         NombreProducto VARCHAR(100) NOT NULL, -- Nombre del producto
    ->         Descripcion VARCHAR(255), -- Descripción del producto
    ->         PrecioUnitario DECIMAL(10, 2) NOT NULL, -- Precio por unidad del producto
    ->         FechaVencimiento DATE, -- Fecha de caducidad del producto (si aplica)
    ->         UnidadesDisponibles INT (11) NOT NULL CHECK (UnidadesDisponibles >= 0), -- Unidades disponibles en inventario, debe ser positivo
    ->         IdCategoria INT (11) NOT NULL, -- Identificador de la categoría a la que pertenece el producto
    ->         Activo BOOLEAN DEFAULT TRUE -- Indica si el producto está activo (disponible para la venta)
    ->     );
Query OK, 0 rows affected, 3 warnings (0,01 sec)

mysql> 
mysql> -- Crear la tabla Categoria
mysql> CREATE TABLE
    ->     Categoria (
    ->         IdCategoria INT (11) NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Identificador único de la categoría, autoincrementable
    ->         NombreCategoria VARCHAR(100) NOT NULL -- Nombre de la categoría
    ->     );
Query OK, 0 rows affected, 1 warning (0,01 sec)

mysql> 
mysql> -- Crear la tabla ProductoRestaurante
mysql> CREATE TABLE
    ->     ProductoRestaurante (
ear la tabla EmpleadoResta    ->         IdProductoRestaurante INT (11) NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Identificador único del producto en el restaurante, autoincrementable
    ->         IdRestaurante INT (11) NOT NULL, -- Identificador del restaurante al que pertenece el producto
    ->         IdProducto INT (11) NOT NULL, -- Identificador del producto
    ->         UnidadesDisponiblesRestaurante INT (11) NOT NULL CHECK (UnidadesDisponiblesRestaurante >= 0), -- Unidades disponibles en este restaurante
    ->         Activo BOOLEAN DEFAULT TRUE -- Indica si el producto está disponible en el restaurante
    ->     );
Query OK, 0 rows affected, 4 warnings (0,02 sec)

mysql> 
mysql> -- Crear la tabla Restaurante
mysql> CREATE TABLE
    ->     Restaurante (
sajes     ->         IdRestaurante INT (11) NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Identificador único del restaurante, autoincrementable
    ->         Nombre VARCHAR(100) NOT NULL, -- Nombre del restaurante
    ->         Direccion VARCHAR(255) NOT NULL, -- Dirección del restaurante
    ->         Telefono VARCHAR(15), -- Número de teléfono del restaurante
    ->         HorarioApertura TIME, -- Hora de apertura del restaurante
    ->         HorarioCierre TIME, -- Hora de cierre del restaurante
    ->         Latitud DECIMAL(9, 6), -- Latitud para ubicación del restaurante
    ->         Longitud DECIMAL(9, 6), -- Longitud para ubicación del restaurante
    ->         Capacidad INT -- Capacidad de personas del restaurante
    ->     );
Query OK, 0 rows affected, 1 warning (0,01 sec)

mysql> 
mysql> -- Crear la tabla Proveedor
mysql> CREATE TABLE
    ->     Proveedor (
    ->         IdProveedor INT (11) NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Identificador único del proveedor, autoincrementable
    ->         Nombre VARCHAR(100) NOT NULL, -- Nombre del proveedor
    ->         Producto VARCHAR(100), -- Producto que proporciona
    ->         Telefono VARCHAR(15), -- Número de teléfono del proveedor
    ->         Direccion VARCHAR(255), -- Dirección del proveedor
    ->         CorreoElectronico VARCHAR(100) UNIQUE, -- Correo electrónico del proveedor, único
    ->         TipoProducto VARCHAR(50), -- Tipo de producto que suministra
    ->         FechaRegistro DATETIME DEFAULT CURRENT_TIMESTAMP, -- Fecha y hora de registro del proveedor
    ->         Estado BOOLEAN DEFAULT TRUE -- Indica si el proveedor está activo
    ->     );
Query OK, 0 rows affected, 1 warning (0,02 sec)

mysql> 
mysql> -- Crear la tabla ProveedorRestaurante
mysql> CREATE TABLE
    ->     ProveedorRestaurante (
staurante ADD CONSTRAINT FK    ->         IdProveedorRestaurante INT (11) NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Identificador único de la relación, autoincrementable
    ->         IdRestaurante INT (11) NOT NULL, -- Identificador del restaurante asociado al proveedor
    ->         IdProveedor INT (11) NOT NULL, -- Identificador del proveedor asociado
    ->         FechaContrato DATETIME DEFAULT CURRENT_TIMESTAMP, -- Fecha de contrato con el proveedor
    ->         CondicionesPago VARCHAR(255), -- Condiciones de pago acordadas con el proveedor
ec    ->         Estado BOOLEAN DEFAULT TRUE -- Indica si la relación está activa
    ->     );
Query OK, 0 rows affected, 3 warnings (0,02 sec)

mysql> 
 mysql> -- Crear la tabla ProveedorProducto
mysql> CREATE TABLE
    ->     ProveedorProducto (
    ->         IdProveedorProducto INT (11) NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Identificador único de la relación, autoincrementable
    ->         IdProveedor INT (11) NOT NULL, -- Identificador del proveedor que ofrece el producto
    ->         IdProducto INT (11) NOT NULL, -- Identificador del producto que ofrece el proveedor
    ->         PrecioProveedor DECIMAL(10, 2), -- Precio al que el proveedor ofrece el producto
    ->         TiempoEntrega INT (3), -- Días estimados de entrega del producto
    ->         Estado BOOLEAN DEFAULT TRUE -- Indica si el proveedor sigue suministrando el producto
    ->     );
Query OK, 0 rows affected, 4 warnings (0,01 sec)

mysql> 
tmysql> -- Crear la tabla Empleado
mysql> CREATE TABLE
    ->     Empleado (
    ->         IdEmpleado INT (11) NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Identificador único del empleado, autoincrementable
    ->         Nombre VARCHAR(100) NOT NULL, -- Nombre del empleado
    ->         NumeroDocumento VARCHAR(20) NOT NULL UNIQUE, -- Documento de identidad del empleado, único
    ->         Correo VARCHAR(100) UNIQUE, -- Correo electrónico del empleado, único
    ->         Telefono VARCHAR(15), -- Número de teléfono del empleado
    ->         FechaRegistro DATETIME DEFAULT CURRENT_TIMESTAMP, -- Fecha y hora de registro del empleado
    ->         Estado BOOLEAN DEFAULT TRUE -- Indica si el empleado está activo
    ->     );
Query OK, 0 rows affected, 1 warning (0,01 sec)

mysql> 
mysql> -- Crear la tabla EmpleadoRestaurante
mysql> CREATE TABLE
    ->     EmpleadoRestaurante (
    ->         IdEmpleadoRestaurante INT (11) NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Identificador único de la relación, autoincrementable
    ->         IdEmpleado INT (11) NOT NULL, -- Identificador del empleado
    ->         IdRestaurante INT (11) NOT NULL -- Identificador del restaurante donde trabaja el empleado
    ->     );
Query OK, 0 rows affected, 3 warnings (0,01 sec)

mysql> 
dmysql> CREATE TABLE
    ->     Log (
    ->         IdLog INT (11) NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Identificador único del log, autoincrementable
    ->         Fecha DATETIME DEFAULT CURRENT_TIMESTAMP, -- Fecha y hora del log
    ->         Detalle TEXT NOT NULL, -- Detalle del log, permite mensajes más largos
    ->         IdEmpleado INT (11) -- Opcional: referencia al usuario que generó el log
    ->     );
Query OK, 0 rows affected, 2 warnings (0,01 sec)

mysql> 
mysql> -- Establecer la relación entre la tabla Venta y la tabla Cliente
mysql> ALTER TABLE Venta ADD CONSTRAINT FK_Venta_Cliente FOREIGN KEY (IdCliente) REFERENCES Cliente (IdCliente);
Query OK, 0 rows affected (0,03 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> 
dmysql> -- Esta línea establece que el campo IdCliente en la tabla Venta debe coincidir con un IdCliente existente en la tabla Cliente.
mysql> -- Establecer la relación entre la tabla Venta y la tabla Restaurante
mysql> ALTER TABLE Venta ADD CONSTRAINT FK_Venta_Restaurante FOREIGN KEY (IdRestaurante) REFERENCES Restaurante (IdRestaurante);
Query OK, 0 rows affected (0,04 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> 
 mysql> -- Esta línea establece que el campo IdRestaurante en la tabla Venta debe coincidir con un IdRestaurante existente en la tabla Restaurante.
mysql> -- Establecer la relación entre la tabla ProductoVenta y la tabla Venta
mysql> ALTER TABLE ProductoVenta ADD CONSTRAINT FK_ProductoVenta_Venta FOREIGN KEY (IdVenta) REFERENCES Venta (IdVenta);
Query OK, 0 rows affected (0,03 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> 
mysql> -- Esta línea establece que el campo IdVenta en la tabla ProductoVenta debe coincidir con un IdVenta existente en la tabla Venta.
mysql> -- Establecer la relación entre la tabla ProductoVenta y la tabla Producto
mysql> ALTER TABLE ProductoVenta ADD CONSTRAINT FK_ProductoVenta_Producto FOREIGN KEY (IdProducto) REFERENCES Producto (IdProducto);
Query OK, 0 rows affected (0,04 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> 
emysql> -- Esta línea establece que el campo IdProducto en la tabla ProductoVenta debe coincidir con un IdProducto existente en la tabla Producto.
mysql> -- Establecer la relación entre la tabla ProductoRestaurante y la tabla Producto
mysql> ALTER TABLE ProductoRestaurante ADD CONSTRAINT FK_ProductoRestaurante_Producto FOREIGN KEY (IdProducto) REFERENCES Producto (IdProducto);
Query OK, 0 rows affected (0,03 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> 
omysql> -- Esta línea establece que el campo IdProducto en la tabla ProductoRestaurante debe coincidir con un IdProducto existente en la tabla Producto.
mysql> -- Establecer la relación entre la tabla ProductoRestaurante y la tabla Restaurante
mysql> ALTER TABLE ProductoRestaurante ADD CONSTRAINT FK_ProductoRestaurante_Restaurante FOREIGN KEY (IdRestaurante) REFERENCES Restaurante (IdRestaurante);
Query OK, 0 rows affected (0,03 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> 
mysql> -- Esta línea establece que el campo IdRestaurante en la tabla ProductoRestaurante debe coincidir con un IdRestaurante existente en la tabla Restaurante.
mysql> -- Establecer la relación entre la tabla ProveedorRestaurante y la tabla Proveedor
mysql> ALTER TABLE ProveedorRestaurante ADD CONSTRAINT FK_ProveedorRestaurante_Proveedor FOREIGN KEY (IdProveedor) REFERENCES Proveedor (IdProveedor);
Query OK, 0 rows affected (0,03 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> 
mysql> -- Esta línea establece que el campo IdProveedor en la tabla ProveedorRestaurante debe coincidir con un IdProveedor existente en la tabla Proveedor.
mysql> -- Establecer la relación entre la tabla ProveedorRestaurante y la tabla Restaurante
mysql> ALTER TABLE ProveedorRestaurante ADD CONSTRAINT FK_ProveedorRestaurante_Restaurante FOREIGN KEY (IdRestaurante) REFERENCES Restaurante (IdRestaurante);
Query OK, 0 rows affected (0,04 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> 
mysql> -- Esta línea establece que el campo IdRestaurante en la tabla ProveedorRestaurante debe coincidir con un IdRestaurante existente en la tabla Restaurante.
mysql> -- Establecer la relación entre la tabla ProveedorProducto y la tabla Proveedor
mysql> ALTER TABLE ProveedorProducto ADD CONSTRAINT FK_ProveedorProducto_Proveedor FOREIGN KEY (IdProveedor) REFERENCES Proveedor (IdProveedor);
Query OK, 0 rows affected (0,04 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> 
mysql> -- Esta línea establece que el campo IdProveedor en la tabla ProveedorProducto debe coincidir con un IdProveedor existente en la tabla Proveedor.
mysql> -- Establecer la relación entre la tabla ProveedorProducto y la tabla Producto
mysql> ALTER TABLE ProveedorProducto ADD CONSTRAINT FK_ProveedorProducto_Producto FOREIGN KEY (IdProducto) REFERENCES Producto (IdProducto);
Query OK, 0 rows affected (0,04 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> 
mysql> -- Esta línea establece que el campo IdProducto en la tabla ProveedorProducto debe coincidir con un IdProducto existente en la tabla Producto.
mysql> -- Establecer la relación entre la tabla EmpleadoRestaurante y la tabla Empleado
mysql> ALTER TABLE EmpleadoRestaurante ADD CONSTRAINT FK_EmpleadoRestaurante_Empleado FOREIGN KEY (IdEmpleado) REFERENCES Empleado (IdEmpleado);
Query OK, 0 rows affected (0,03 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> 
mysql> -- Esta línea establece que el campo IdEmpleado en la tabla EmpleadoRestaurante debe coincidir con un IdEmpleado existente en la tabla Empleado.
mysql> -- Establecer la relación entre la tabla EmpleadoRestaurante y la tabla Restaurante
mysql> ALTER TABLE EmpleadoRestaurante ADD CONSTRAINT FK_EmpleadoRestaurante_Restaurante FOREIGN KEY (IdRestaurante) REFERENCES Restaurante (IdRestaurante);
Query OK, 0 rows affected (0,04 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> 
mysql> -- Esta línea establece que el campo IdRestaurante en la tabla EmpleadoRestaurante debe coincidir con un IdRestaurante existente en la tabla Restaurante.
mysql> 
mysql> -- triggers cliente
mysql> 
mysql> DELIMITER //
mysql> CREATE TRIGGER Cliente_after_insert
    -> AFTER INSERT ON Cliente
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se insertó un nuevo cliente: ',
    ->                     'IdCliente: ', NEW.IdCliente,
    ->                     ', NombreCliente: ', NEW.NombreCliente,
    ->                     ', NumeroDocumentoCliente: ', NEW.NumeroDocumentoCliente,
EA    ->                     ', EdadCliente: ', NEW.EdadCliente,
    ->                     ', CorreoElectronicoCliente: ', NEW.CorreoElectronicoCliente,
    ->                     ', TelefonoCliente: ', NEW.TelefonoCliente,
    ->                     ', FechaRegistroCliente: ', NEW.FechaRegistroCliente,
    ->                     ', EsMiembroCliente: ', NEW.EsMiembroCliente),1);
    -> END//
Query OK, 0 rows affected (0,01 sec)

mysql> DELIMITER ;
mysql> 
mysql> DELIMITER //
         ', Camysql> CREATE TRIGGER Cliente_after_update
    -> AFTER UPDATE ON Cliente
    -> FOR EACH ROW
    -> BEGIN
n    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se actualizó el cliente IdCliente: ', OLD.IdCliente,
    ->                     '. Valores anteriores: {NombreCliente: ', OLD.NombreCliente,
    ->                     ', NumeroDocumentoCliente: ', OLD.NumeroDocumentoCliente,
    ->                     ', EdadCliente: ', OLD.EdadCliente,
    ->                     ', CorreoElectronicoCliente: ', OLD.CorreoElectronicoCliente,
    ->                     ', TelefonoCliente: ', OLD.TelefonoCliente,
    ->                     ', FechaRegistroCliente: ', OLD.FechaRegistroCliente,
    ->                     ', EsMiembroCliente: ', OLD.EsMiembroCliente, '}. ',
    ->                     'Nuevos valores: {NombreCliente: ', NEW.NombreCliente,
    ->                     ', NumeroDocumentoCliente: ', NEW.NumeroDocumentoCliente,
    ->                     ', EdadCliente: ', NEW.EdadCliente,
    ->                     ', CorreoElectronicoCliente: ', NEW.CorreoElectronicoCliente,
    ->                     ', TelefonoCliente: ', NEW.TelefonoCliente,
    ->                     ', FechaRegistroCliente: ', NEW.FechaRegistroCliente,
    ->                     ', EsMiembroCliente: ', NEW.EsMiembroCliente, '}.'),1);
    -> END//
Query OK, 0 rows affected (0,00 sec)

mysql> DELIMITER ;
mysql> 
mysql> DELIMITER //
       ', Cantmysql> CREATE TRIGGER Cliente_after_delete
    -> AFTER DELETE ON Cliente
o    -> FOR EACH ROW
: ', OLD.Prec    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se eliminó el cliente: ',
    ->                     'IdCliente: ', OLD.IdCliente,
    ->                     ', NombreCliente: ', OLD.NombreCliente,
    ->                     ', NumeroDocumentoCliente: ', OLD.NumeroDocumentoCliente,
    ->                     ', EdadCliente: ', OLD.EdadCliente,
    ->                     ', CorreoElectronicoCliente: ', OLD.CorreoElectronicoCliente,
    ->                     ', TelefonoCliente: ', OLD.TelefonoCliente,
    ->                     ', FechaRegistroCliente: ', OLD.FechaRegistroCliente,
    ->                     ', EsMiembroCliente: ', OLD.EsMiembroCliente),1);
    -> END//
Query OK, 0 rows affected (0,00 sec)

mysql> DELIMITER ;
mysql> 
mysql> 
mysql> -- triggers Venta
mysql> 
omysql> DELIMITER //
mysql> CREATE TRIGGER Venta_after_insert
    -> AFTER INSERT ON Venta
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se insertó una nueva venta: ',
    ->                     'IdVenta: ', NEW.IdVenta,
    ->                     ', IdCliente: ', NEW.IdCliente,
    ->                     ', IdRestaurante: ', NEW.IdRestaurante,
    ->                     ', FechaVenta: ', NEW.FechaVenta,
    ->                     ', ValorTotalVenta: ', NEW.ValorTotalVenta),1);
    -> END//
Query OK, 0 rows affected (0,01 sec)

mysql> DELIMITER ;
mysql> 
mysql> 
mysql> DELIMITER //
itario,
       mysql> CREATE TRIGGER Venta_after_update
    -> AFTER UPDATE ON Venta
', OLD.FechaVencimient    -> FOR EACH ROW
    -> BEGIN
    ->           INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se actualizó la venta IdVenta: ', OLD.IdVenta,
    ->                     '. Valores anteriores: {IdCliente: ', OLD.IdCliente,
    ->                     ', IdRestaurante: ', OLD.IdRestaurante,
    ->                     ', FechaVenta: ', OLD.FechaVenta,
    ->                     ', ValorTotalVenta: ', OLD.ValorTotalVenta, '}. ',
    ->                     'Nuevos valores: {IdCliente: ', NEW.IdCliente,
    ->                     ', IdRestaurante: ', NEW.IdRestaurante,
    ->                     ', FechaVenta: ', NEW.FechaVenta,
    ->                     ', ValorTotalVenta: ', NEW.ValorTotalVenta, '}.'),1);
    -> END//
Query OK, 0 rows affected (0,00 sec)

mysql> DELIMITER ;
mysql> 
mysql> 
mysql> DELIMITER //
mysql> CREATE TRIGGER Venta_after_delete
    -> AFTER DELETE ON Venta
    -> FOR EACH ROW
     -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se eliminó la venta: ',
    ->                     'IdVenta: ', OLD.IdVenta,
    ->                     ', IdCliente: ', OLD.IdCliente,
    ->                     ', IdRestaurante: ', OLD.IdRestaurante,
    ->                     ', FechaVenta: ', OLD.FechaVenta,
    ->                     ', ValorTotalVenta: ', OLD.ValorTotalVenta),1);
    -> END//
Query OK, 0 rows affected (0,00 sec)

mysql> DELIMITER ;
mysql> 
mysql> -- triggers ProductoVenta
mysql> 
mysql> DELIMITER //
mysql> CREATE TRIGGER ProductoVenta_after_insert
    -> AFTER INSERT ON ProductoVenta
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se insertó un nuevo ProductoVenta: ',
    ->                     'IdProductoVenta: ', NEW.IdProductoVenta,
    ->                     ', IdVenta: ', NEW.IdVenta,
    ->                     ', IdProducto: ', NEW.IdProducto,
    ->                     ', Cantidad: ', NEW.Cantidad,
    ->                     ', PrecioUnitario: ', NEW.PrecioUnitario),1);
    -> END//
Query OK, 0 rows affected (0,00 sec)

mysql> DELIMITER ;
egoria),1);
mysql> 
mysql> DELIMITER //
mysql> CREATE TRIGGER ProductoVenta_after_update
    -> AFTER UPDATE ON ProductoVenta
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se actualizó el ProductoVenta IdProductoVenta: ', OLD.IdProductoVenta,
    ->                     '. Valores anteriores: {IdVenta: ', OLD.IdVenta,
    ->                     ', IdProducto: ', OLD.IdProducto,
    ->                     ', Cantidad: ', OLD.Cantidad,
    ->                     ', PrecioUnitario: ', OLD.PrecioUnitario, '}. ',
    ->                     'Nuevos valores: {IdVenta: ', NEW.IdVenta,
    ->                     ', IdProducto: ', NEW.IdProducto,
    ->                     ', Cantidad: ', NEW.Cantidad,
g    ->                     ', PrecioUnitario: ', NEW.PrecioUnitario, '}.'),1);
    -> END//
rQuery OK, 0 rows affected (0,00 sec)

mysql> 
emysql> DELIMITER ;
mysql> 
mysql> DELIMITER //
mysql> CREATE TRIGGER ProductoVenta_after_delete
    -> AFTER DELETE ON ProductoVenta
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se eliminó el ProductoVenta: ',
    ->                     'IdProductoVenta: ', OLD.IdProductoVenta,
    ->                     ', IdVenta: ', OLD.IdVenta,
    ->                     ', IdProducto: ', OLD.IdProducto,
    ->                     ', Cantidad: ', OLD.Cantidad,
    ->                     ', PrecioUnitario: ', OLD.PrecioUnitario),1);
         -> END//
Query OK, 0 rows affected (0,01 sec)

mysql> DELIMITER ;
mysql> 
mysql> -- triggers Producto
mysql> 
mysql> DELIMITER //
mysql> CREATE TRIGGER Producto_after_insert
    -> AFTER INSERT ON Producto
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se insertó un nuevo producto: ',
    ->                     'IdProducto: ', NEW.IdProducto,
    ->                     ', NombreProducto: ', NEW.NombreProducto,
    ->                     ', Descripcion: ', NEW.Descripcion,
    ->                     ', PrecioUnitario: ', NEW.PrecioUnitario,
    ->                     ', FechaVencimiento: ', NEW.FechaVencimiento,
    ->                     ', UnidadesDisponibles: ', NEW.UnidadesDisponibles,
    ->                     ', IdCategoria: ', NEW.IdCategoria,
    ->                     ', Activo: ', NEW.Activo),1);
    -> END//
Query OK, 0 rows affected (0,01 sec)

mysql> DELIMITER ;
smysql> 
mysql> DELIMITER //
mysql> CREATE TRIGGER Producto_after_update
    -> AFTER UPDATE ON Producto
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se actualizó el producto IdProducto: ', OLD.IdProducto,
    ->                     '. Valores anteriores: {NombreProducto: ', OLD.NombreProducto,
    ->                     ', Descripcion: ', OLD.Descripcion,
    ->                     ', PrecioUnitario: ', OLD.PrecioUnitario,
    ->                     ', FechaVencimiento: ', OLD.FechaVencimiento,
r    ->                     ', UnidadesDisponibles: ', OLD.UnidadesDisponibles,
    ->                     ', IdCategoria: ', OLD.IdCategoria,
    ->                     ', Activo: ', OLD.Activo, '}. ',
    ->                     'Nuevos valores: {NombreProducto: ', NEW.NombreProducto,
    ->                     ', Descripcion: ', NEW.Descripcion,
    ->                     ', PrecioUnitario: ', NEW.PrecioUnitario,
    ->                     ', FechaVencimiento: ', NEW.FechaVencimiento,
    ->                     ', UnidadesDisponibles: ', NEW.UnidadesDisponibles,
    ->                     ', IdCategoria: ', NEW.IdCategoria,
    ->                     ', Activo: ', NEW.Activo, '}.'),1);
    -> END//
Query OK, 0 rows affected (0,01 sec)

mysql> DELIMITER ;
mysql> 
mysql> DELIMITER //
mysql> CREATE TRIGGER Producto_after_delete
    -> AFTER DELETE ON Producto
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se eliminó el producto: ',
    ->                     'IdProducto: ', OLD.IdProducto,
     ->                     ', NombreProducto: ', OLD.NombreProducto,
    ->                     ', Descripcion: ', OLD.Descripcion,
    ->                     ', PrecioUnitario: ', OLD.PrecioUnitario,
    ->                     ', FechaVencimiento: ', OLD.FechaVencimiento,
G    ->                     ', UnidadesDisponibles: ', OLD.UnidadesDisponibles,
    ->                     ', IdCategoria: ', OLD.IdCategoria,
    ->                     ', Activo: ', OLD.Activo),1);
    -> END//
Query OK, 0 rows affected (0,00 sec)

mysql> DELIMITER ;
mysql> 
amysql> -- triggers Categoria
mysql> 
mysql> DELIMITER //
      '. Valormysql> CREATE TRIGGER Categoria_after_insert
    -> AFTER INSERT ON Categoria
    -> FOR EACH ROW
    -> BEGIN
r    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se insertó una nueva categoría: ',
    ->                     'IdCategoria: ', NEW.IdCategoria,
    ->                     ', NombreCategoria: ', NEW.NombreCategoria),1);
    -> END//
Query OK, 0 rows affected (0,01 sec)

mysql> DELIMITER ;
mysql> 
mysql> DELIMITER //
 Lmysql> CREATE TRIGGER Categoria_after_update
    -> AFTER UPDATE ON Categoria
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se actualizó la categoría IdCategoria: ', OLD.IdCategoria,
    ->                     '. Valor anterior: {NombreCategoria: ', OLD.NombreCategoria, '}. ',
.    ->                     'Nuevo valor: {NombreCategoria: ', NEW.NombreCategoria, '}.'),1);
    -> END//
Query OK, 0 rows affected (0,01 sec)

mysql> DELIMITER ;
mysql> 
tmysql> DELIMITER //
mysql> CREATE TRIGGER Categoria_after_delete
    -> AFTER DELETE ON Categoria
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se eliminó la categoría: ',
    ->                     'IdCategoria: ', OLD.IdCategoria,
    ->                     ', NombreCategoria: ', OLD.NombreCategoria),1);
    -> END//
Query OK, 0 rows affected (0,01 sec)

mysql> DELIMITER ;
mysql> 
mysql> -- triggers ProductoRestaurante
mysql> 
mysql> DELIMITER //
mysql> CREATE TRIGGER ProductoRestaurante_after_insert
    -> AFTER INSERT ON ProductoRestaurante
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se asignó un producto a un restaurante: ',
    ->                     'IdProductoRestaurante: ', NEW.IdProductoRestaurante,
    ->                     ', IdRestaurante: ', NEW.IdRestaurante,
    ->                     ', IdProducto: ', NEW.IdProducto,
    ->                     ', UnidadesDisponiblesRestaurante: ', NEW.UnidadesDisponiblesRestaurante,
    ->                     ', Activo: ', NEW.Activo),1);
    -> END//
Query OK, 0 rows affected (0,00 sec)

mysql> DELIMITER ;
mysql> 
mysql> DELIMITER //
ON Proveedor
Fmysql> CREATE TRIGGER ProductoRestaurante_after_update
    -> AFTER UPDATE ON ProductoRestaurante
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se actualizó el ProductoRestaurante IdProductoRestaurante: ', OLD.IdProductoRestaurante,
    ->                     '. Valores anteriores: {IdRestaurante: ', OLD.IdRestaurante,
    ->                     ', IdProducto: ', OLD.IdProducto,
    ->                     ', UnidadesDisponiblesRestaurante: ', OLD.UnidadesDisponiblesRestaurante,
    ->                     ', Activo: ', OLD.Activo, '}. ',
    ->                     'Nuevos valores: {IdRestaurante: ', NEW.IdRestaurante,
    ->                     ', IdProducto: ', NEW.IdProducto,
    ->                     ', UnidadesDisponiblesRestaurante: ', NEW.UnidadesDisponiblesRestaurante,
    ->                     ', Activo: ', NEW.Activo, '}.'),1);
    -> END//
Query OK, 0 rows affected (0,00 sec)

mysql> DELIMITER ;
, OLD.IdProvmysql> 
mysql> DELIMITER //
 mysql> CREATE TRIGGER ProductoRestaurante_after_delete
    -> AFTER DELETE ON ProductoRestaurante
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se eliminó la asignación de producto a restaurante: ',
    ->                     'IdProductoRestaurante: ', OLD.IdProductoRestaurante,
    ->                     ', IdRestaurante: ', OLD.IdRestaurante,
    ->                     ', IdProducto: ', OLD.IdProducto,
    ->                     ', UnidadesDisponiblesRestaurante: ', OLD.UnidadesDisponiblesRestaurante,
    ->                     ', Activo: ', OLD.Activo),1);
    -> END//
Query OK, 0 rows affected (0,01 sec)

mysql> DELIMITER ;
mysql> 
mysql> -- triggers Restaurante
mysql> 
mysql> DELIMITER //
mysql> CREATE TRIGGER Restaurante_after_insert
    -> AFTER INSERT ON Restaurante
    -> FOR EACH ROW
o    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se insertó un nuevo restaurante: ',
    ->                     'IdRestaurante: ', NEW.IdRestaurante,
     ->                     ', Nombre: ', NEW.Nombre,
    ->                     ', Direccion: ', NEW.Direccion,
    ->                     ', Telefono: ', NEW.Telefono,
    ->                     ', HorarioApertura: ', NEW.HorarioApertura,
    ->                     ', HorarioCierre: ', NEW.HorarioCierre,
    ->                     ', Latitud: ', NEW.Latitud,
    ->                     ', Longitud: ', NEW.Longitud,
    ->                     ', Capacidad: ', NEW.Capacidad),1);
     -> END//
Query OK, 0 rows affected (0,01 sec)

mysql> DELIMITER ;
mysql> 
mysql> DELIMITER //
mysql> CREATE TRIGGER Restaurante_after_update
    -> AFTER UPDATE ON Restaurante
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se actualizó el restaurante IdRestaurante: ', OLD.IdRestaurante,
    ->                     '. Valores anteriores: {Nombre: ', OLD.Nombre,
    ->                     ', Direccion: ', OLD.Direccion,
    ->                     ', Telefono: ', OLD.Telefono,
    ->                     ', HorarioApertura: ', OLD.HorarioApertura,
O    ->                     ', HorarioCierre: ', OLD.HorarioCierre,
    ->                     ', Latitud: ', OLD.Latitud,
    ->                     ', Longitud: ', OLD.Longitud,
    ->                     ', Capacidad: ', OLD.Capacidad, '}. ',
    ->                     'Nuevos valores: {Nombre: ', NEW.Nombre,
    ->                     ', Direccion: ', NEW.Direccion,
    ->                     ', Telefono: ', NEW.Telefono,
    ->                     ', HorarioApertura: ', NEW.HorarioApertura,
    ->                     ', HorarioCierre: ', NEW.HorarioCierre,
    ->                     ', Latitud: ', NEW.Latitud,
    ->                     ', Longitud: ', NEW.Longitud,
    ->                     ', Capacidad: ', NEW.Capacidad, '}.'),1);
    -> END//
Query OK, 0 rows affected (0,01 sec)

mysql> DELIMITER ;
mysql> 
mysql> DELIMITER //
mysql> CREATE TRIGGER Restaurante_after_delete
    -> AFTER DELETE ON Restaurante
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se eliminó el restaurante: ',
    ->                     'IdRestaurante: ', OLD.IdRestaurante,
    ->                     ', Nombre: ', OLD.Nombre,
    ->                     ', Direccion: ', OLD.Direccion,
    ->                     ', Telefono: ', OLD.Telefono,
    ->                     ', HorarioApertura: ', OLD.HorarioApertura,
    ->                     ', HorarioCierre: ', OLD.HorarioCierre,
    ->                     ', Latitud: ', OLD.Latitud,
    ->                     ', Longitud: ', OLD.Longitud,
    ->                     ', Capacidad: ', OLD.Capacidad),1);
    -> END//
Query OK, 0 rows affected (0,01 sec)

mysql> 
mysql> DELIMITER ;
mysql> 
mysql> -- triggers Proveedor
mysql> 
mysql> DELIMITER //
mysql> CREATE TRIGGER Proveedor_after_insert
    -> AFTER INSERT ON Proveedor
TE TRIGGER ProveedorRestau    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se insertó un nuevo proveedor: ',
    ->                     'IdProveedor: ', NEW.IdProveedor,
    ->                     ', Nombre: ', NEW.Nombre,
    ->                     ', Producto: ', NEW.Producto,
    ->                     ', Telefono: ', NEW.Telefono,
    ->                     ', Direccion: ', NEW.Direccion,
    ->                     ', CorreoElectronico: ', NEW.CorreoElectronico,
    ->                     ', TipoProducto: ', NEW.TipoProducto,
    ->                     ', FechaRegistro: ', NEW.FechaRegistro,
    ->                     ', Estado: ', NEW.Estado),1);
    -> END//
Query OK, 0 rows affected (0,00 sec)

mysql> DELIMITER ;
mysql> 
 mysql> DELIMITER //
mysql> CREATE TRIGGER Proveedor_after_update
    -> AFTER UPDATE ON Proveedor
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se actualizó el proveedor IdProveedor: ', OLD.IdProveedor,
    ->                     '. Valores anteriores: {Nombre: ', OLD.Nombre,
    ->                     ', Producto: ', OLD.Producto,
    ->                     ', Telefono: ', OLD.Telefono,
    ->                     ', Direccion: ', OLD.Direccion,
    ->                     ', CorreoElectronico: ', OLD.CorreoElectronico,
    ->                     ', TipoProducto: ', OLD.TipoProducto,
    ->                     ', FechaRegistro: ', OLD.FechaRegistro,
    ->                     ', Estado: ', OLD.Estado, '}. ',
    ->                     'Nuevos valores: {Nombre: ', NEW.Nombre,
    ->                     ', Producto: ', NEW.Producto,
    ->                     ', Telefono: ', NEW.Telefono,
    ->                     ', Direccion: ', NEW.Direccion,
    ->                     ', CorreoElectronico: ', NEW.CorreoElectronico,
    ->                     ', TipoProducto: ', NEW.TipoProducto,
    ->                     ', FechaRegistro: ', NEW.FechaRegistro,
    ->                     ', Estado: ', NEW.Estado, '}.'),1);
    -> END//
Query OK, 0 rows affected (0,00 sec)

mysql> DELIMITER ;
, '}. ',
   mysql> 
 mysql> DELIMITER //
mysql> CREATE TRIGGER Proveedor_after_delete
    -> AFTER DELETE ON Proveedor
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se eliminó el proveedor: ',
      ->                     'IdProveedor: ', OLD.IdProveedor,
    ->                     ', Nombre: ', OLD.Nombre,
    ->                     ', Producto: ', OLD.Producto,
    ->                     ', Telefono: ', OLD.Telefono,
L    ->                     ', Direccion: ', OLD.Direccion,
    ->                     ', CorreoElectronico: ', OLD.CorreoElectronico,
    ->                     ', TipoProducto: ', OLD.TipoProducto,
    ->                     ', FechaRegistro: ', OLD.FechaRegistro,
    ->                     ', Estado: ', OLD.Estado),1);
    -> END//
Query OK, 0 rows affected (0,00 sec)

mysql> DELIMITER ;
mysql> 
mysql> -- triggers ProveedorRestaurante
mysql> 
mysql> DELIMITER //
 mysql> CREATE TRIGGER ProveedorRestaurante_after_insert
    -> AFTER INSERT ON ProveedorRestaurante
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se estableció una relación ProveedorRestaurante: ',
    ->                     'IdProveedorRestaurante: ', NEW.IdProveedorRestaurante,
    ->                     ', IdRestaurante: ', NEW.IdRestaurante,
    ->                     ', IdProveedor: ', NEW.IdProveedor,
    ->                     ', FechaContrato: ', NEW.FechaContrato,
E    ->                     ', CondicionesPago: ', NEW.CondicionesPago,
    ->                     ', Estado: ', NEW.Estado),1);
    -> END//
Query OK, 0 rows affected (0,01 sec)

mysql> DELIMITER ;
mysql> 
mysql> DELIMITER //
mysql> CREATE TRIGGER ProveedorRestaurante_after_update
    -> AFTER UPDATE ON ProveedorRestaurante
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se actualizó la relación ProveedorRestaurante IdProveedorRestaurante: ', OLD.IdProveedorRestaurante,
    ->                     '. Valores anteriores: {IdRestaurante: ', OLD.IdRestaurante,
    ->                     ', IdProveedor: ', OLD.IdProveedor,
    ->                     ', FechaContrato: ', OLD.FechaContrato,
    ->                     ', CondicionesPago: ', OLD.CondicionesPago,
    ->                     ', Estado: ', OLD.Estado, '}. ',
    ->                     'Nuevos valores: {IdRestaurante: ', NEW.IdRestaurante,
    ->                     ', IdProveedor: ', NEW.IdProveedor,
    ->                     ', FechaContrato: ', NEW.FechaContrato,
    ->                     ', CondicionesPago: ', NEW.CondicionesPago,
    ->                     ', Estado: ', NEW.Estado, '}.'),1);
    -> END//
Query OK, 0 rows affected (0,00 sec)

mysql> DELIMITER ;
elefono: ', mysql> 
Nmysql> DELIMITER //
mysql> CREATE TRIGGER ProveedorRestaurante_after_delete
    -> AFTER DELETE ON ProveedorRestaurante
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se eliminó la relación ProveedorRestaurante: ',
    ->                     'IdProveedorRestaurante: ', OLD.IdProveedorRestaurante,
    ->                     ', IdRestaurante: ', OLD.IdRestaurante,
    ->                     ', IdProveedor: ', OLD.IdProveedor,
    ->                     ', FechaContrato: ', OLD.FechaContrato,
    ->                     ', CondicionesPago: ', OLD.CondicionesPago,
    ->                     ', Estado: ', OLD.Estado),1);
    -> END//
', OLD.NumeroDocumento,
                    ', Correo: ', OLD.Correo,
                    ', Telefono: ', OLD.Telefono,
            Query OK, 0 rows affected (0,01 sec)

mysql> DELIMITER ;
        ', Fmysql> 
mysql> -- triggers ProveedorProducto
mysql> 
mysql> DELIMITER //
mysql> CREATE TRIGGER ProveedorProducto_after_insert
    -> AFTER INSERT ON ProveedorProducto
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se asignó un producto a un proveedor: ',
    ->                     'IdProveedorProducto: ', NEW.IdProveedorProducto,
    ->                     ', IdProveedor: ', NEW.IdProveedor,
    ->                     ', IdProducto: ', NEW.IdProducto,
    ->                     ', PrecioProveedor: ', NEW.PrecioProveedor,
    ->                     ', TiempoEntrega: ', NEW.TiempoEntrega,
    ->                     ', Estado: ', NEW.Estado),1);
    -> END//
Query OK, 0 rows affected (0,00 sec)

mysql> DELIMITER ;
mysql> 
fmysql> DELIMITER //
mysql> CREATE TRIGGER ProveedorProducto_after_update
    -> AFTER UPDATE ON ProveedorProducto
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se actualizó la relación ProveedorProducto IdProveedorProducto: ', OLD.IdProveedorProducto,
    ->                     '. Valores anteriores: {IdProveedor: ', OLD.IdProveedor,
    ->                     ', IdProducto: ', OLD.IdProducto,
    ->                     ', PrecioProveedor: ', OLD.PrecioProveedor,
    ->                     ', TiempoEntrega: ', OLD.TiempoEntrega,
    ->                     ', Estado: ', OLD.Estado, '}. ',
    ->                     'Nuevos valores: {IdProveedor: ', NEW.IdProveedor,
    ->                     ', IdProducto: ', NEW.IdProducto,
    ->                     ', PrecioProveedor: ', NEW.PrecioProveedor,
     ->                     ', TiempoEntrega: ', NEW.TiempoEntrega,
    ->                     ', Estado: ', NEW.Estado, '}.'),1);
    -> END//
Query OK, 0 rows affected (0,00 sec)

mysql> DELIMITER ;
mysql> 
mysql> DELIMITER //
        ', Idmysql> CREATE TRIGGER ProveedorProducto_after_delete
    -> AFTER DELETE ON ProveedorProducto
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se eliminó la relación ProveedorProducto: ',
    ->                     'IdProveedorProducto: ', OLD.IdProveedorProducto,
    ->                     ', IdProveedor: ', OLD.IdProveedor,
    ->                     ', IdProducto: ', OLD.IdProducto,
    ->                     ', PrecioProveedor: ', OLD.PrecioProveedor,
    ->                     ', TiempoEntrega: ', OLD.TiempoEntrega,
    ->                     ', Estado: ', OLD.Estado),1);
    -> END//
Query OK, 0 rows affected (0,01 sec)

mysql> DELIMITER ;
mysql> 
mysql> -- triggers Empleado
mysql> 
mysql> DELIMITER //
mysql> CREATE TRIGGER Empleado_after_insert
    -> AFTER INSERT ON Empleado
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se insertó un nuevo empleado: ',
    ->                     'IdEmpleado: ', NEW.IdEmpleado,
    ->                     ', Nombre: ', NEW.Nombre,
    ->                     ', NumeroDocumento: ', NEW.NumeroDocumento,
    ->                     ', Correo: ', NEW.Correo,
    ->                     ', Telefono: ', NEW.Telefono,
    ->                     ', FechaRegistro: ', NEW.FechaRegistro,
    ->                     ', Estado: ', NEW.Estado),1);
    -> END//
Query OK, 0 rows affected (0,00 sec)

mysql> DELIMITER ;
mysql> 
mysql> DELIMITER //
mysql> CREATE TRIGGER Empleado_after_update
    -> AFTER UPDATE ON Empleado
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se actualizó el empleado IdEmpleado: ', OLD.IdEmpleado,
    ->                     '. Valores anteriores: {Nombre: ', OLD.Nombre,
    ->                     ', NumeroDocumento: ', OLD.NumeroDocumento,
    ->                     ', Correo: ', OLD.Correo,
    ->                     ', Telefono: ', OLD.Telefono,
    ->                     ', FechaRegistro: ', OLD.FechaRegistro,
    ->                     ', Estado: ', OLD.Estado, '}. ',
    ->                     'Nuevos valores: {Nombre: ', NEW.Nombre,
    ->                     ', NumeroDocumento: ', NEW.NumeroDocumento,
    ->                     ', Correo: ', NEW.Correo,
    ->                     ', Telefono: ', NEW.Telefono,
    ->                     ', FechaRegistro: ', NEW.FechaRegistro,
    ->                     ', Estado: ', NEW.Estado, '}.'),1);
    -> END//
Query OK, 0 rows affected (0,00 sec)

mysql> DELIMITER ;
mysql> 
mysql> DELIMITER //
mysql> CREATE TRIGGER Empleado_after_delete
    -> AFTER DELETE ON Empleado
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se eliminó el empleado: ',
    ->                     'IdEmpleado: ', OLD.IdEmpleado,
    ->                     ', Nombre: ', OLD.Nombre,
    ->                     ', NumeroDocumento: ', OLD.NumeroDocumento,
    ->                     ', Correo: ', OLD.Correo,
    ->                     ', Telefono: ', OLD.Telefono,
    ->                     ', FechaRegistro: ', OLD.FechaRegistro,
    ->                     ', Estado: ', OLD.Estado),1);
    -> END//
Query OK, 0 rows affected (0,01 sec)

mysql> DELIMITER ;
mysql> 
mysql> -- triggers EmpleadoRestaurante
mysql> 
mysql> DELIMITER //
mysql> CREATE TRIGGER EmpleadoRestaurante_after_insert
    -> AFTER INSERT ON EmpleadoRestaurante
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se asignó un empleado a un restaurante: ',
    ->                     'IdEmpleadoRestaurante: ', NEW.IdEmpleadoRestaurante,
    ->                     ', IdEmpleado: ', NEW.IdEmpleado,
    ->                     ', IdRestaurante: ', NEW.IdRestaurante),1);
    -> END//
Query OK, 0 rows affected (0,00 sec)

mysql> DELIMITER ;
mysql> 
mysql> DELIMITER //
mysql> CREATE TRIGGER EmpleadoRestaurante_after_update
    -> AFTER UPDATE ON EmpleadoRestaurante
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se actualizó la asignación EmpleadoRestaurante IdEmpleadoRestaurante: ', OLD.IdEmpleadoRestaurante,
    ->                     '. Valores anteriores: {IdEmpleado: ', OLD.IdEmpleado,
    ->                     ', IdRestaurante: ', OLD.IdRestaurante, '}. ',
    ->                     'Nuevos valores: {IdEmpleado: ', NEW.IdEmpleado,
    ->                     ', IdRestaurante: ', NEW.IdRestaurante, '}.'),1);
    -> END//
Query OK, 0 rows affected (0,01 sec)

mysql> DELIMITER ;
mysql> 
mysql> DELIMITER //
mysql> CREATE TRIGGER EmpleadoRestaurante_after_delete
    -> AFTER DELETE ON EmpleadoRestaurante
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO Log (Detalle, IdEmpleado)
    ->     VALUES (CONCAT( 'Se eliminó la asignación EmpleadoRestaurante: ',
    ->                     'IdEmpleadoRestaurante: ', OLD.IdEmpleadoRestaurante,
    ->                     ', IdEmpleado: ', OLD.IdEmpleado,
    ->                     ', IdRestaurante: ', OLD.IdRestaurante),1);
    -> END//
Query OK, 0 rows affected (0,00 sec)

mysql> DELIMITER ;
