<?php
require_once "../config/auth.php";
checkRole("doctor");
require_once "../config/db.php";

$doctor_id = $_SESSION["user_id"];

$query = "SELECT a.appointment_id, a.appointment_date, a.appointment_time, u.full_name AS patient_name
          FROM appointments a
          JOIN patients p ON a.patient_id = p.patient_id
          JOIN users u ON p.user_id = u.user_id
          WHERE a.doctor_id = ? AND a.status = 'scheduled'
          ORDER BY a.appointment_date, a.appointment_time";
$stmt = $conn->prepare($query);
$stmt->bind_param("i", $doctor_id);
$stmt->execute();
$result = $stmt->get_result();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Scheduled Appointments</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <?php include "navbar.php"; ?>

    <div class="container mt-5">
        <h2>Scheduled Appointments</h2>
        <?php if ($result->num_rows > 0): ?>
            <table class="table table-bordered">
                <thead class="table-primary">
                    <tr>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Patient</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($row = $result->fetch_assoc()): ?>
                        <tr>
                            <td><?= $row['appointment_date'] ?></td>
                            <td><?= $row['appointment_time'] ?></td>
                            <td><?= $row['patient_name'] ?></td>
                            <td>
                                <a href="add_medical_record.php?appointment_id=<?= $row['appointment_id'] ?>" class="btn btn-sm btn-primary">Add Record</a>
                            </td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        <?php else: ?>
            <p>No scheduled appointments found.</p>
        <?php endif; ?>
    </div>

    <?php include "../partials/footer.php"; ?>
</body>
</html>
