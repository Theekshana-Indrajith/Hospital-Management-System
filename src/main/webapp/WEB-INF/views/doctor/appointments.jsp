<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${pageTitle} - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-success">
    <div class="container">
        <a class="navbar-brand">🏥 HMS</a>
        <div class="navbar-nav">
            <a class="nav-link" href="/doctor/dashboard">Dashboard</a>
            <a class="nav-link" href="/doctor/schedule">Schedule</a>
            <a class="nav-link" href="/doctor/patients">Patients</a>
            <a class="nav-link active" href="/doctor/appointments">Appointments</a>
        </div>
        <div class="navbar-nav ms-auto">
            <a class="nav-link" href="/logout">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <h1>${pageTitle}</h1>
    <div class="card mt-4">
        <div class="card-header">
            <h5 class="card-title">Appointment Management</h5>
        </div>
        <div class="card-body">
            <p class="card-text">Appointment management functionality will be implemented here.</p>
            <p>You will be able to:</p>
            <ul>
                <li>View today's appointments</li>
                <li>Manage appointment status</li>
                <li>View appointment details</li>
                <li>Add appointment notes</li>
                <li>Reschedule appointments</li>
                <li>View appointment history</li>
            </ul>
            <a href="/doctor/dashboard" class="btn btn-success">Back to Dashboard</a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>