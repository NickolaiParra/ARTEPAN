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

$cli_id = $_POST['cli_id'] ?? '';

if (empty($cli_id)) {
    echo json_encode(["success" => false, "error" => "ID de cliente no recibido"]);
    exit;
}

// Contar los pedidos de este cliente
$sql = "SELECT COUNT(*) AS total_pedidos FROM pedido WHERE cli_id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $cli_id);
$stmt->execute();
$result = $stmt->get_result()->fetch_assoc();

// Siguiente número para este cliente
$siguiente_pedido = ($result['total_pedidos'] ?? 0) + 1;

echo json_encode([
    "success" => true,
    "siguiente_pedido" => $siguiente_pedido
]);

$stmt->close();
$conn->close();
?>
