<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

// Activar errores para depuración (desactívalo en producción)
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Conexión a la base de datos
$host = "localhost";
$user = "root";
$password = "password"; // Cambia esto por tu contraseña real
$db = "proyecto";

$conexion = new mysqli($host, $user, $password, $db);
if ($conexion->connect_error) {
    echo json_encode([
        "success" => false,
        "error" => "Error de conexión: " . $conexion->connect_error
    ]);
    exit;
}

// Obtener ID de cliente desde POST
$cli_id = $_POST['cli_id'] ?? '';

if (empty($cli_id)) {
    echo json_encode([
        "success" => false,
        "error" => "ID de cliente no recibido"
    ]);
    exit;
}

// Ejecutar procedimiento almacenado
$sql = "CALL ultimos_5_pedidos_cliente(?)";
$stmt = $conexion->prepare($sql);
if (!$stmt) {
    echo json_encode([
        "success" => false,
        "error" => "Error al preparar la consulta: " . $conexion->error
    ]);
    exit;
}

$stmt->bind_param("i", $cli_id);

if (!$stmt->execute()) {
    echo json_encode([
        "success" => false,
        "error" => "Error al ejecutar la consulta: " . $stmt->error
    ]);
    exit;
}

$result = $stmt->get_result();
$pedidos = [];

while ($row = $result->fetch_assoc()) {
    $pedidos[] = $row;
}

echo json_encode([
    "success" => true,
    "pedidos" => $pedidos
]);

$stmt->close();
$conexion->close();
?>
