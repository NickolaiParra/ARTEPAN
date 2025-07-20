<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

$host = "localhost";
$user = "root";
$password = "password"; // Cambia esto por tu contraseña real
$db = "proyecto";

$conn = new mysqli($host, $user, $password, $db);
if ($conn->connect_error) {
    echo json_encode(["success" => false, "error" => "Error de conexión"]);
    exit;
}

// Recibir datos del pedido
$cli_id = $_POST['cli_id'] ?? '';
$productos = json_decode($_POST['productos'], true); // Array de productos: [{id, cantidad, precio}]
$total = $_POST['total'] ?? 0;
if (empty($cli_id)) {
    echo json_encode(["success" => false, "error" => "ID de cliente no recibido"]);
    exit;
}

if (empty($_POST['productos'])) {
    echo json_encode(["success" => false, "error" => "No llegaron productos en el POST"]);
    exit;
}

$productos = json_decode($_POST['productos'], true);

if ($productos === null) {
    echo json_encode(["success" => false, "error" => "Error al decodificar productos JSON"]);
    exit;
}

if (count($productos) === 0) {
    echo json_encode(["success" => false, "error" => "No se seleccionaron productos"]);
    exit;
}

if ($total <= 0) {
    echo json_encode(["success" => false, "error" => "Total no válido"]);
    exit;
}

if (empty($cli_id) || empty($productos) || $total <= 0) {
    echo json_encode(["success" => false, "error" => "Datos incompletos"]);
    exit;
}

// Calcular el próximo ped_id manualmente
$result = $conn->query("SELECT MAX(ped_id) AS max_id FROM Pedido");
$row = $result->fetch_assoc();
$pedido_id = ($row['max_id'] ?? 0) + 1; // Si no hay pedidos, empieza en 1

// Datos para la tabla Pedido
$fecha_pedido = date('Y-m-d');
$fecha_entrega = date('Y-m-d', strtotime('+5 days'));
$estado = "En camino"; // Estado inicial
$metodo_pago = "Efectivo"; // Default
$bodega_id = 1; // Default (ajustable)

// Insertar en la tabla Pedido con el ped_id manual
$stmt = $conn->prepare("
    INSERT INTO Pedido (ped_id, ped_fecha_pedido, ped_fecha_entrega, ped_estado, ped_metodo_pago, cli_id, bod_id)
    VALUES (?, ?, ?, ?, ?, ?, ?)
");
$stmt->bind_param("issssii", $pedido_id, $fecha_pedido, $fecha_entrega, $estado, $metodo_pago, $cli_id, $bodega_id);

if (!$stmt->execute()) {
    echo json_encode(["success" => false, "error" => "No se pudo crear el pedido"]);
    exit;
}

// Insertar en la tabla Detalle_Pedido
foreach ($productos as $producto) {
    $pro_id = $producto['id'];
    $cantidad = $producto['cantidad'];
    $precio_unitario = $producto['precio'];

    $stmt_detalle = $conn->prepare("
        INSERT INTO Detalle_Pedido (ped_id, pro_id, pde_cantidad, pde_precio_unitario)
        VALUES (?, ?, ?, ?)
    ");
    $stmt_detalle->bind_param("iiid", $pedido_id, $pro_id, $cantidad, $precio_unitario);
    $stmt_detalle->execute();
    $stmt_detalle->close();
}

echo json_encode([
    "success" => true,
    "pedido_id" => $pedido_id
]);

$stmt->close();
$conn->close();
?>
