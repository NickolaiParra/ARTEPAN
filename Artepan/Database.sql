DROP SCHEMA IF EXISTS Proyecto;
CREATE SCHEMA Proyecto;
USE Proyecto;

-- Creación de tablas e inserción
DROP TABLE IF EXISTS producto_planta;
DROP TABLE IF EXISTS detalle_formulacion;
DROP TABLE IF EXISTS detalle_pedido;
DROP TABLE IF EXISTS planta_de_fabricacion;
DROP TABLE IF EXISTS control_de_calidad;
DROP TABLE IF EXISTS formulacion;
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS materia_prima;
DROP TABLE IF EXISTS proveedor;
DROP TABLE IF EXISTS envio;
DROP TABLE IF EXISTS vehiculo;
DROP TABLE IF EXISTS pedido;
DROP TABLE IF EXISTS bodega;
DROP TABLE IF EXISTS cliente;

CREATE TABLE Cliente (
    cli_id INT NOT NULL PRIMARY KEY,               
    cli_nombre_comercial VARCHAR(45) NOT NULL,     
    cli_nombre_contacto VARCHAR(45),               
    cli_tipo_negocio VARCHAR(45) NOT NULL,         
    cli_direccion VARCHAR(45),                     
    cli_telefono VARCHAR(45),                      
    cli_sector VARCHAR(45) NOT NULL                
);

CREATE TABLE Bodega (
    bod_id INT NOT NULL PRIMARY KEY,
    bod_direccion VARCHAR(45),
    bod_capacidad_almacenamiento INT,
    bod_responsable VARCHAR(45)
);

CREATE TABLE Pedido (
    ped_id INT NOT NULL PRIMARY KEY ,
    ped_fecha_pedido DATE ,
    ped_fecha_entrega DATE NOT NULL ,
    ped_estado VARCHAR(45) ,
    ped_metodo_pago VARCHAR(45) ,
    cli_id INT NOT NULL ,
    bod_id INT NOT NULL ,
    
    FOREIGN KEY (cli_id) REFERENCES Cliente(cli_id),
    FOREIGN KEY (bod_id) REFERENCES Bodega(bod_id)
);

CREATE TABLE Vehiculo (
    veh_id INT NOT NULL PRIMARY KEY,
    veh_placa VARCHAR(45),
    veh_tipo VARCHAR(45),
    veh_capacidad_carga INT,
    veh_conductor VARCHAR(45),
    veh_empresa VARCHAR(45)
);

CREATE TABLE Envio (
    env_id INT NOT NULL PRIMARY KEY,
    env_fecha DATE,
    env_destino VARCHAR(45),
    env_ruta VARCHAR(45),
    env_responsable VARCHAR(45),
    ped_id INT,
    veh_id INT,
    FOREIGN KEY (veh_id) REFERENCES Vehiculo(veh_id),
	FOREIGN KEY (ped_id) REFERENCES Pedido(ped_id)
);

CREATE TABLE Proveedor (
    prv_id INT NOT NULL PRIMARY KEY,
    prv_nombre VARCHAR(45),
    prv_tipo VARCHAR(45),
    prv_telefono VARCHAR(45),
    prv_correo VARCHAR(45),
    prv_direccion VARCHAR(45)
);

CREATE TABLE Materia_Prima (
    mat_id INT NOT NULL PRIMARY KEY,
    mat_nombre VARCHAR(45),
    mat_tipo VARCHAR(45),
    mat_unidad_medida VARCHAR(45),
    mat_cantidad_disponible INT DEFAULT 0,
    prv_id INT,
    bod_id INT,
    FOREIGN KEY (prv_id) REFERENCES Proveedor(prv_id),
    FOREIGN KEY (bod_id) REFERENCES Bodega(bod_id)
);

CREATE TABLE Producto (
    pro_id INT NOT NULL PRIMARY KEY, 
    pro_nombre VARCHAR(45),          
    pro_tipo VARCHAR(45),            
    pro_descripcion VARCHAR(60) NOT NULL, 
    pro_precio_unitario INT,         
    pro_unidad_medida VARCHAR(45),   
    pro_cantidad_disponible INT DEFAULT 0 
);

CREATE TABLE Formulacion (
    for_id INT NOT NULL PRIMARY KEY,        
    for_descripcion_proceso MEDIUMTEXT,     
    for_version VARCHAR(45),                
    for_fecha_actualizacion DATE,           
    pro_id INT,                             
    FOREIGN KEY (pro_id) REFERENCES Producto(pro_id)
);

CREATE TABLE Control_de_Calidad (
    con_id INT NOT NULL PRIMARY KEY,
    con_tipo VARCHAR(45),
    con_fecha DATE,
    con_resultados VARCHAR(45) NOT NULL,
    con_responsable VARCHAR(45),
    ped_id INT,                             
    FOREIGN KEY (ped_id) REFERENCES Pedido(ped_id)
);

CREATE TABLE Planta_de_Fabricacion (
    pla_id INT NOT NULL PRIMARY KEY,
    pla_nombre VARCHAR(45),
    pla_direccion VARCHAR(45),
    pla_responsable VARCHAR(45),
    pla_capacidad_produccion INT
);

CREATE TABLE Detalle_Pedido (
    ped_id INT NOT NULL,
    pro_id INT NOT NULL,
    pde_cantidad INT,
    pde_precio_unitario INT,
    PRIMARY KEY (ped_id, pro_id),
    FOREIGN KEY (ped_id) REFERENCES Pedido(ped_id),
    FOREIGN KEY (pro_id) REFERENCES Producto(pro_id)
);

CREATE TABLE Detalle_Formulacion (
    for_id INT NOT NULL,
    mat_id INT NOT NULL,
    fde_cantidad INT,
    PRIMARY KEY (for_id, mat_id),
    FOREIGN KEY (for_id) REFERENCES Formulacion(for_id),
    FOREIGN KEY (mat_id) REFERENCES Materia_Prima(mat_id)
);

CREATE TABLE Producto_Planta (
    pla_id INT NOT NULL,
    pro_id INT NOT NULL,
    PRIMARY KEY (pla_id, pro_id),
    FOREIGN KEY (pla_id) REFERENCES Planta_de_Fabricacion(pla_id),
    FOREIGN KEY (pro_id) REFERENCES Producto(pro_id)
);

SELECT COUNT(*) AS table_count
FROM information_schema.tables
WHERE table_schema = 'proyecto';

-- cliente
insert into cliente values 
(1, 'comercial luna', 'ana pérez', 'restaurante', 'calle 12 #45', '3001234567', 'alimentos'),
(2, 'supermercado sol', 'carlos ruiz', 'retail', 'avenida central 89', '3019876543', 'consumo'),
(3, 'distribuciones andina', 'beatriz jaramillo', 'distribuidor', 'calle 90 #10', '3045567788', 'industrial'),
(4, 'tienda el bosque', 'mario torres', 'tienda', 'carrera 45 #67', '3023344556', 'minorista');

-- bodega
insert into bodega values 
(1, 'zona industrial 4', 1000, 'luis gómez'),
(2, 'parque logístico 7', 800, 'maría torres'),
(3, 'centro logístico norte', 1500, 'carlos méndez');

-- pedido
insert into pedido values 
(1, '2022-06-01', '2022-06-05', 'enviado', 'transferencia', 1, 1),
(2, '2022-08-12', '2022-08-16', 'enviado', 'efectivo', 2, 2),
(3, '2023-01-15', '2023-01-20', 'cancelado', 'tarjeta', 3, 3),
(4, '2023-03-10', '2023-03-14', 'recibido', 'transferencia', 4, 1),
(5, '2023-07-25', '2023-07-30', 'enviado', 'efectivo', 1, 2),
(6, '2023-09-05', '2023-09-09', 'recibido', 'tarjeta', 2, 3),
(7, '2023-11-18', '2023-11-22', 'cancelado', 'transferencia', 3, 1),
(8, '2024-02-03', '2024-02-07', 'enviado', 'efectivo', 4, 2),
(9, '2024-04-12', '2024-04-16', 'en camino', 'tarjeta', 1, 3),
(10, '2024-06-20', '2024-06-24', 'recibido', 'transferencia', 2, 1),
(11, '2024-08-15', '2024-08-19', 'cancelado', 'efectivo', 3, 2),
(12, '2024-10-10', '2024-10-14', 'en camino', 'tarjeta', 4, 3),
(13, '2025-01-05', '2025-01-09', 'enviado', 'transferencia', 1, 1),
(14, '2025-03-17', '2025-03-21', 'recibido', 'efectivo', 2, 2),
(15, '2025-05-25', '2025-05-29', 'enviado', 'tarjeta', 3, 3),
(16, '2025-08-14', '2025-08-18', 'en camino', 'efectivo', 4, 1),
(17, '2025-09-01', '2025-09-05', 'en camino', 'transferencia', 1, 1),
(18, '2025-09-02', '2025-09-06', 'en camino', 'efectivo', 2, 2),
(19, '2025-09-03', '2025-09-07', 'en camino', 'tarjeta', 3, 3);


-- vehiculo
insert into vehiculo values 
(1, 'abc123', 'camión', 2000, 'juan díaz', 'logitrans'),
(2, 'xyz789', 'furgoneta', 1000, 'laura herrera', 'transexpress'),
(3, 'jkl456', 'camioneta', 1500, 'ricardo salas', 'fastmove');

-- envio
insert into envio values 
(1, '2025-06-05', 'sucursal norte', 'ruta 1', 'pedro sánchez', 1, 1),
(2, '2025-06-06', 'sucursal sur', 'ruta 2', 'sofía ramírez', 2, 2),
(3, '2025-06-07', 'sucursal centro', 'ruta 3', 'felipe mora', 3, 3);

-- proveedor
insert into proveedor values 
(1, 'proveeduría alfa', 'local', '3021122334', 'contacto@alfa.com', 'carrera 45 #67'),
(2, 'importaciones beta', 'internacional', '3035566778', 'ventas@beta.com', 'calle 78 #12'),
(3, 'suministros delta', 'local', '3057788990', 'info@delta.com', 'avenida las palmas');

-- materia_prima
insert into materia_prima values 
(1, 'harina', 'ingrediente', 'kg', 500, 1, 1),
(2, 'aceite', 'ingrediente', 'l', 300, 2, 2),
(3, 'azúcar', 'ingrediente', 'kg', 200, 3, 3),
(4, 'sal', 'ingrediente', 'kg', 150, 1, 1);

-- producto
insert into producto values 
(1, 'pan integral', 'alimento', 'pan de trigo integral artesanal', 2000, 'unidad', 100),
(2, 'galleta avena', 'alimento', 'galleta con avena y miel', 1500, 'paquete', 200),
(3, 'pan blanco', 'alimento', 'pan blanco clásico', 1800, 'unidad', 120),
(4, 'torta chocolate', 'alimento', 'torta con cobertura de chocolate', 8000, 'unidad', 50),
(5, 'croissant', 'alimento', 'croissant mantequilla clásico', 2500, 'unidad', 80),
(6, 'pan de queso', 'alimento', 'panecillo con relleno de queso', 2200, 'unidad', 150),
(7, 'brownie', 'alimento', 'brownie de chocolate con nueces', 3500, 'unidad', 60),
(8, 'donut glaseada', 'alimento', 'donut con glaseado de vainilla', 1800, 'unidad', 90),
(9, 'arte helado', 'alimento', 'helado artesanal arte', 187000, 'kg', 50),
(10, 'aceite sólido fri’sano', 'ingrediente', 'aceite sólido para fritura', 119000, 'lb', 80),
(11, 'artepan aliñado graso', 'alimento', 'pan aliñado con grasas vegetales', 130000, 'kg', 60);


-- formulacion
insert into formulacion values 
(1, 'mezclar harina y agua, hornear 30 min', 'v1.0', '2025-05-20', 1),
(2, 'combinar avena, miel y hornear 20 min', 'v1.1', '2025-05-25', 2),
(3, 'mezclar harina, azúcar y hornear 25 min', 'v1.2', '2025-06-01', 3),
(4, 'batir mezcla de torta, hornear y decorar', 'v2.0', '2025-06-05', 4),
(5, 'preparar masa con mantequilla, plegar y hornear 15 min', 'v1.0', '2025-06-10', 5),
(6, 'hacer masa con queso rallado y hornear 12 min', 'v1.0', '2025-06-12', 6),
(7, 'mezclar chocolate y nueces, hornear 20 min', 'v1.1', '2025-06-15', 7),
(8, 'freír donut y cubrir con glaseado', 'v1.0', '2025-06-18', 8),
(9, 'batir mezcla y congelar 2 horas', 'v1.0', '2025-07-20', 9),
(10, 'fundir y moldear aceite sólido', 'v1.0', '2025-07-21', 10),
(11, 'preparar masa aliñada y hornear', 'v1.0', '2025-07-22', 11);

-- control_de_calidad
insert into control_de_calidad values 
(1, 'visual', '2025-06-03', 'aprobado', 'daniel lópez', 1),
(2, 'sensorial', '2025-06-04', 'requiere ajuste', 'camila vargas', 2),
(3, 'microbiológico', '2025-06-05', 'aprobado', 'samuel giraldo', 1);

-- planta_de_fabricacion
insert into planta_de_fabricacion values 
(1, 'planta norte', 'km 15 vía medellín', 'andrés ríos', 500),
(2, 'planta sur', 'av. sur 123', 'paula salazar', 700),
(3, 'planta centro', 'carrera 33 #21', 'josé romero', 600);

-- detalle_pedido 
insert into detalle_pedido values 
(1, 1, 10, 2000),
(2, 2, 15, 1500),
(3, 3, 5, 1800),
(4, 4, 3, 8000),
(5, 5, 8, 2500),
(6, 6, 12, 2200),
(7, 7, 4, 3500),
(8, 8, 10, 1800),
(9, 1, 6, 2000),
(10, 2, 9, 1500),
(11, 3, 3, 1800),
(12, 4, 2, 8000),
(13, 5, 7, 2500),
(14, 6, 5, 2200),
(15, 7, 8, 3500),
(16, 8, 6, 1800),
(17, 9, 2, 187000), 
(18, 10, 5, 119000), 
(19, 11, 3, 130000);

-- detalle_formulacion
insert into detalle_formulacion values 
(1, 1, 100),
(2, 2, 50),
(3, 3, 70),
(4, 4, 20);

-- producto_planta
insert into producto_planta values 
(1, 1),
(2, 2),
(2, 3),
(3, 4),
(1, 5),
(2, 6),
(3, 7),
(1, 8),
(2, 9), 
(3, 10), 
(1, 11); 

select count(*) as table_count
from information_schema.tables
where table_schema = 'proyecto';

-- consultas
-- pedidos del cliente con estado y fecha de entrega
select ped.ped_id, ped.ped_estado, ped.ped_fecha_entrega
from cliente cli
join pedido ped on cli.cli_id = ped.cli_id
where cli.cli_id = 1;

-- vistas
-- vista: datos del cliente
drop table if exists vista_datos_cliente;
create view vista_datos_cliente as
select cli_id, cli_nombre_comercial, cli_nombre_contacto, cli_direccion, cli_telefono
from cliente;

-- vista: pedidos del cliente
drop table if exists vista_pedidos_cliente;
create view vista_pedidos_cliente as
select ped_id, cli_id, ped_estado, ped_fecha_entrega
from pedido;

-- pefiles
-- cliente (solo lectura sobre vistas propias)
drop user if exists 'cliente1'@'%';
create user 'cliente1'@'%' identified by 'cliente123';
grant select on vista_datos_cliente to 'cliente1'@'%';
grant select on vista_pedidos_cliente to 'cliente1'@'%';
drop user if exists 'cliente2'@'%';
create user 'cliente2'@'%' identified by 'cliente321';
grant select on vista_datos_cliente to 'cliente2'@'%';
grant select on vista_pedidos_cliente to 'cliente2'@'%';

-- página web
DROP TABLE IF EXISTS usuarios_web;
create table usuarios_web (
    id int auto_increment primary key,
    nombre_usuario varchar(50) unique not null,
    contrasena varchar(255) not null,
    cli_id int not null,
    foreign key (cli_id) references cliente(cli_id)
);

-- insertar datos de ejemplo
insert into usuarios_web (nombre_usuario, contrasena, cli_id)
values 
('cliente1', 'cliente1-123', 1),
('cliente2', 'cliente2-123', 2),
('cliente3', 'cliente3-123', 3),
('cliente4', 'cliente4-123', 4);

-- índices
-- índice para optimizar búsqueda de pedidos por cliente
create index idx_pedido_cliente on pedido(cli_id);
-- justificación: permite mejorar la velocidad de consultas filtradas por cliente (join o where).

-- pefiles

-- procedimientos
-- ==============================
-- página de inicio
-- ------ 

-- procedimiento: obtener los 3 productos más pedidos por un cliente
delimiter //
create procedure top_3_productos_cliente(in p_cli_id int)
begin
    select 
        dp.pro_id, 
        p.pro_nombre, 
        p.pro_precio_unitario,  
        count(*) as total_pedidos
    from pedido ped
    join detalle_pedido dp on ped.ped_id = dp.ped_id
    join producto p on dp.pro_id = p.pro_id
    where ped.cli_id = p_cli_id
    group by dp.pro_id
    order by total_pedidos desc
    limit 3;
end;
//
delimiter ;


-- procedimiento: obtener los últimos 5 pedidos realizados por un cliente
delimiter //
create procedure ultimos_5_pedidos_cliente(in p_cli_id int)
begin
    select ped_id, ped_estado, ped_fecha_pedido, ped_fecha_entrega
    from pedido
    where cli_id = p_cli_id
    order by ped_fecha_entrega desc
    limit 5;
end;
//
delimiter ;


-- procedimiento: cantidad de pedidos por año de un cliente
delimiter //
create procedure cantidad_pedidos_por_año(in p_cli_id int)
begin
    select year(ped_fecha_entrega) as año, count(*) as total
    from pedido
    where cli_id = p_cli_id
    group by año
    order by año;
end;
//
delimiter ;

-- función: cantidad de pedidos en camino de un cliente
delimiter //
create function pedidos_en_camino(p_cli_id int)
returns int
deterministic
begin
    declare total int;
    select count(*) into total
    from pedido
    where cli_id = p_cli_id and ped_estado = 'en tránsito';
    return total;
end;
//
delimiter ;

-- función: cantidad total de pedidos de un cliente
delimiter //
create function total_pedidos_cliente(p_cli_id int)
returns int
deterministic
begin
    declare total int;
    select count(*) into total
    from pedido
    where cli_id = p_cli_id;
    return total;
end;
//
delimiter ;

-- función: fecha del último pedido realizado
delimiter //
create function fecha_ultimo_pedido(p_cli_id int)
returns date
deterministic
begin
    declare fecha date;
    select max(ped_fecha_entrega) into fecha
    from pedido
    where cli_id = p_cli_id;
    return fecha;
end;
//
delimiter ;

-- ==============================
-- página de 'mis pedidos'
-- ------

-- procedimiento: obtener todos los pedidos de un cliente
delimiter //
create procedure obtener_pedidos_cliente(in p_cli_id int)
begin
    select * from pedido where cli_id = p_cli_id;
end;
//
delimiter ;

-- procedimiento: obtener detalles de un pedido
delimiter //
create procedure detalles_pedido(in p_ped_id int)
begin
    select dp.*, p.pro_nombre, p.pro_precio_unitario,
           (dp.pde_cantidad * p.pro_precio_unitario) as subtotal
    from detalle_pedido dp
    join producto p on dp.pro_id = p.pro_id
    where dp.ped_id = p_ped_id;
end;
//
delimiter ;

-- procedimiento: crear nuevo pedido
delimiter //
create procedure crear_pedido(in p_cli_id int, in p_bod_id int, in p_estado varchar(50), in p_fecha date)
begin
    insert into pedido (cli_id, bod_id, ped_estado, ped_fecha_entrega)
    values (p_cli_id, p_bod_id, p_estado, p_fecha);
end;
//
delimiter ;

-- procedimiento: agregar o actualizar producto en un pedido
delimiter //
create procedure agregar_producto_a_pedido(in p_ped_id int, in p_pro_id int, in p_cantidad int)
begin
    if exists (
        select * from detalle_pedido
        where ped_id = p_ped_id and pro_id = p_pro_id
    ) then
        update detalle_pedido
        set pde_cantidad = pde_cantidad + p_cantidad
        where ped_id = p_ped_id and pro_id = p_pro_id;
    else
        insert into detalle_pedido (ped_id, pro_id, pde_cantidad)
        values (p_ped_id, p_pro_id, p_cantidad);
    end if;
end;
//
delimiter ;

-- procedimiento: cambiar estado de un pedido
delimiter //
create procedure actualizar_estado_pedido(in p_ped_id int, in p_estado varchar(50))
begin
    update pedido
    set ped_estado = p_estado
    where ped_id = p_ped_id;
end;
//
delimiter ;

-- función: calcular total de un pedido
delimiter //
create function total_costo_pedido(p_ped_id int)
returns decimal(10,2)
deterministic
begin
    declare total decimal(10,2);
    select sum(dp.pde_cantidad * p.pro_precio_unitario) into total
    from detalle_pedido dp
    join producto p on dp.pro_id = p.pro_id
    where dp.ped_id = p_ped_id;
    return ifnull(total, 0);
end;
//
delimiter ;

-- ==============================
-- página de 'mi perfil'
-- ------ 

-- procedimiento: obtener información del cliente
delimiter //
create procedure obtener_info_cliente(in p_cli_id int)
begin
    select cli_nombre_comercial, cli_nombre_contacto, cli_direccion, cli_telefono
    from cliente
    where cli_id = p_cli_id;
end;
//
delimiter ;

-- procedimiento: actualizar datos del cliente
delimiter //
create procedure actualizar_info_cliente(
    in p_cli_id int,
    in p_nombre_comercial varchar(100),
    in p_nombre_contacto varchar(100),
    in p_direccion varchar(200),
    in p_telefono varchar(20)
)
begin
    update cliente
    set 
        cli_nombre_comercial = ifnull(p_nombre_comercial, cli_nombre_comercial),
        cli_nombre_contacto = ifnull(p_nombre_contacto, cli_nombre_contacto),
        cli_direccion = ifnull(p_direccion, cli_direccion),
        cli_telefono = ifnull(p_telefono, cli_telefono)
    where cli_id = p_cli_id;
end;
//
delimiter ;

-- crear usuario
-- drop user 'web_user'@'localhost';
create user 'web_user'@'localhost' identified by 'web_password';
-- dar permisos de solo lectura y ejecución
grant select, execute on proyecto.* to 'web_user'@'localhost';
-- aplicar los permisos
flush privileges;
show tables;
select * from usuarios_web;
show function status where db = 'proyecto';
select database();


