<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

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

$cli_id = $_POST['cli_id'] ?? '';

if (empty($cli_id)) {
    echo json_encode([
        "success" => false,
        "error" => "ID de cliente no recibido"
    ]);
    exit;
}

$stmt = $conexion->prepare("CALL cantidad_pedidos_por_año(?)");
$stmt->bind_param("i", $cli_id);
$stmt->execute();
$result = $stmt->get_result();

$data = [];
while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}

echo json_encode([
    "success" => true,
    "datos" => $data
]);

$stmt->close();
$conexion->close();
?>
