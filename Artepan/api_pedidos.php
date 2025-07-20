<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

$host = "localhost";
$user = "root";
$password = "password"; // Cambia esto por tu contraseña real
$db = "proyecto";

// Conexión a la base de datos
$conexion = new mysqli($host, $user, $password, $db);
if ($conexion->connect_error) {
    echo json_encode([
        "success" => false,
        "error" => "Error de conexión: " . $conexion->connect_error
    ]);
    exit;
}

// Obtener el ID del cliente desde la petición
$cli_id = $_POST['cli_id'] ?? '';

if (empty($cli_id)) {
    echo json_encode([
        "success" => false,
        "error" => "ID de cliente no recibido"
    ]);
    exit;
}

// Consulta para obtener los pedidos del cliente con número consecutivo
$sql = "
SELECT 
    ped.ped_id,
    ROW_NUMBER() OVER (PARTITION BY ped.cli_id ORDER BY ped.ped_fecha_pedido DESC) AS numero_pedido,
    ped.ped_estado,
    ped.ped_fecha_pedido,
    ped.ped_fecha_entrega,
    ped.ped_metodo_pago,
    COALESCE(SUM(dp.pde_cantidad * dp.pde_precio_unitario), 0) AS total
FROM pedido ped
LEFT JOIN detalle_pedido dp ON ped.ped_id = dp.ped_id
WHERE ped.cli_id = ?
GROUP BY ped.ped_id
ORDER BY ped.ped_fecha_pedido DESC
";

$stmt = $conexion->prepare($sql);
$stmt->bind_param("i", $cli_id);
$stmt->execute();
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
