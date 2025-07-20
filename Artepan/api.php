<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
$host = "localhost";
$user = "root";
$password = "password"; // Cambia esto por tu contraseña real
$db = "proyecto";

// Conexión
$conexion = new mysqli($host, $user, $password, $db);
if ($conexion->connect_error) {
    die(json_encode(["success" => false, "error" => "Error de conexión"]));
}

// Recibe el nombre de usuario por POST
$usuario = $_POST['usuario'] ?? '';
$contrasena = $_POST['password'] ?? '';

// Consulta datos del cliente
$query = $conexion->prepare("SELECT * FROM usuarios_web WHERE nombre_usuario = ? AND contrasena = ?");
$query->bind_param("ss", $usuario, $contrasena);
$query->execute();
$resultado = $query->get_result();

if ($resultado->num_rows > 0) {
    $row = $resultado->fetch_assoc();
    $cli_id = $row['cli_id'];

    // Traer datos del cliente
    $datosCliente = $conexion->query("SELECT * FROM vista_datos_cliente WHERE cli_id = $cli_id")->fetch_assoc();

    echo json_encode([
        "success" => true,
        "cliente" => $datosCliente
    ]);
} else {
    echo json_encode([
        "success" => false,
        "error" => "Usuario o contraseña incorrectos"
    ]);
}
?>
