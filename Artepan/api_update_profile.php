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
        "error" => "Error de conexión a la base de datos: " . $conexion->connect_error
    ]);
    exit;
}

// Recibir datos
$cli_id = $_POST['cli_id'] ?? '';
$nombre = $_POST['nombre'] ?? '';
$telefono = $_POST['telefono'] ?? '';
$direccion = $_POST['direccion'] ?? '';
$password = $_POST['password'] ?? ''; // Puede venir vacío

if (empty($cli_id)) {
    echo json_encode([
        "success" => false,
        "error" => "El ID de cliente es obligatorio"
    ]);
    exit;
}

try {
    // Primero actualizar Cliente
    $sqlCliente = "UPDATE Cliente SET cli_nombre_comercial = ?, cli_telefono = ?, cli_direccion = ? WHERE cli_id = ?";
    $stmtCliente = $conexion->prepare($sqlCliente);
    $stmtCliente->bind_param("sssi", $nombre, $telefono, $direccion, $cli_id);

    if (!$stmtCliente->execute()) {
        throw new Exception("Error al actualizar Cliente: " . $stmtCliente->error);
    }

    // Si el password NO está vacío, actualizar en usuarios_web
    if (!empty($password)) {
        $sqlUser = "UPDATE usuarios_web SET contrasena = ? WHERE cli_id = ?";
        $stmtUser = $conexion->prepare($sqlUser);
        $stmtUser->bind_param("si", $password, $cli_id);

        if (!$stmtUser->execute()) {
            throw new Exception("Error al actualizar contraseña: " . $stmtUser->error);
        }
        $stmtUser->close();
    }

    echo json_encode(["success" => true]);
} catch (Exception $e) {
    echo json_encode([
        "success" => false,
        "error" => "Excepción: " . $e->getMessage()
    ]);
}

$stmtCliente->close();
$conexion->close();
