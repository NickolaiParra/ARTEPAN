<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

$host = "localhost";
$user = "root";
$password = "password"; // Cambia esto por tu contraseña real
$db = "proyecto";

// Conectar
$conexion = new mysqli($host, $user, $password, $db);
if ($conexion->connect_error) {
    die(json_encode([
        "success" => false,
        "error" => "Error de conexión: " . $conexion->connect_error
    ]));
}
file_put_contents('debug.txt', print_r($_POST, true));

$cli_id = $_POST['cli_id'] ?? '';

if (empty($cli_id)) {
    echo json_encode(["success" => false, "error" => "ID de cliente no recibido"]);
    exit;
}

// Llamar funciones
$pedidosEnCamino = $conexion->query("SELECT pedidos_en_camino($cli_id) AS total")->fetch_assoc()['total'];
$totalPedidos = $conexion->query("SELECT total_pedidos_cliente($cli_id) AS total")->fetch_assoc()['total'];
$fechaUltimoPedido = $conexion->query("SELECT fecha_ultimo_pedido($cli_id) AS fecha")->fetch_assoc()['fecha'];

echo json_encode([
    "success" => true,
    "pedidos_en_camino" => $pedidosEnCamino,
    "total_pedidos" => $totalPedidos,
    "fecha_ultimo_pedido" => $fechaUltimoPedido
]);

$conexion->close();
?>
