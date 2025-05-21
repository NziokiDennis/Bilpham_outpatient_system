<?php
$env = parse_ini_file(__DIR__ . '/.env'); // correct path to .env inside config/

if ($env === false) {
    die(".env file not found or unreadable");
}

$host = $env['DB_HOST'];
$port = (int)$env['DB_PORT'];
$user = $env['DB_USER'];
$password = $env['DB_PASS'];  // match key name in .env
$database = $env['DB_NAME'];
$ssl_ca = __DIR__ . "/ca.pem"; // add slash between dir and filename

$conn = mysqli_init();
mysqli_ssl_set($conn, NULL, NULL, $ssl_ca, NULL, NULL);

if (!mysqli_real_connect($conn, $host, $user, $password, $database, $port, NULL, MYSQLI_CLIENT_SSL)) {
    die("Connection failed: " . mysqli_connect_error());
}

// echo "Connection successful!";
