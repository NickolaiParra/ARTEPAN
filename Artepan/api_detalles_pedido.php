<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

$host = "localhost";
$user = "root";
$password = "password"; // Cambia esto por tu contraseña real
$db = "proyecto";

// Conectar a la base de datos
$conexion = new mysqli($host, $user, $password, $db);

if ($conexion->connect_error) {
    echo json_encode([
        "success" => false,
        "error" => "Error de conexión: " . $conexion->connect_error
    ]);
    exit;
}

$ped_id = $_POST['ped_id'] ?? '';

if (empty($ped_id)) {
    echo json_encode([
        "success" => false,
        "error" => "ID del pedido no recibido"
    ]);
    exit;
}

$sql = "CALL detalles_pedido(?)";
$stmt = $conexion->prepare($sql);
$stmt->bind_param("i", $ped_id);
$stmt->execute();
$result = $stmt->get_result();

$detalles = [];
while ($row = $result->fetch_assoc()) {
    $detalles[] = $row;
}

echo json_encode([
    "success" => true,
    "detalles" => $detalles
]);

$stmt->close();
$conexion->close();
?>
