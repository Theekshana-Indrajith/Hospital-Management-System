<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Edit Department - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand">🏥 HMS</a>
        <div class="navbar-nav">
            <a class="nav-link" href="/medical-staff/dashboard">Dashboard</a>
            <a class="nav-link active" href="/medical-staff/departments">Departments</a>
            <a class="nav-link" href="/medical-staff/doctors">Doctors</a>
            <a class="nav-link" href="/medical-staff/staff">Staff</a>
            <a class="nav-link" href="/medical-staff/shifts">Shifts</a>
            <a class="nav-link" href="/admin/dashboard">Admin Dashboard</a>
        </div>
        <div class="navbar-nav ms-auto">
            <span class="navbar-text">Welcome, Administrator!</span>
            <a class="nav-link" href="/logout">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center">
        <h1><i class="fas fa-edit me-2"></i>Edit Department</h1>
        <a href="/medical-staff/departments" class="btn btn-secondary">
            <i class="fas fa-arrow-left me-1"></i>Back to Departments
        </a>
    </div>

    <!-- Edit Department Form -->
    <div class="card mt-4">
        <div class="card-header bg-warning text-white">
            <h5 class="mb-0"><i class="fas fa-building me-2"></i>Edit ${department.name}</h5>
        </div>
        <div class="card-body">
            <form method="post" action="/medical-staff/departments/update/${department.id}">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Department Name *</label>
                        <input type="text" name="name" class="form-control" value="${department.name}" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Head of Department</label>
                        <input type="text" name="headOfDepartment" class="form-control" value="${department.headOfDepartment}">
                    </div>
                    <div class="col-12">
                        <label class="form-label">Description</label>
                        <textarea name="description" class="form-control" rows="3">${department.description}</textarea>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Contact Number</label>
                        <input type="text" name="contactNumber" class="form-control" value="${department.contactNumber}">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-control" value="${department.email}">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Room Number</label>
                        <input type="text" name="roomNumber" class="form-control" value="${department.roomNumber}">
                    </div>

                    <!-- Shift Timings -->
                    <div class="col-md-4">
                        <label class="form-label">Morning Shift Start</label>
                        <input type="time" name="morningShiftStart" class="form-control" value="${department.morningShiftStart}">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Morning Shift End</label>
                        <input type="time" name="morningShiftEnd" class="form-control" value="${department.morningShiftEnd}">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Evening Shift Start</label>
                        <input type="time" name="eveningShiftStart" class="form-control" value="${department.eveningShiftStart}">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Evening Shift End</label>
                        <input type="time" name="eveningShiftEnd" class="form-control" value="${department.eveningShiftEnd}">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Night Shift Start</label>
                        <input type="time" name="nightShiftStart" class="form-control" value="${department.nightShiftStart}">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Night Shift End</label>
                        <input type="time" name="nightShiftEnd" class="form-control" value="${department.nightShiftEnd}">
                    </div>
                </div>
                <div class="mt-3">
                    <button type="submit" class="btn btn-warning">
                        <i class="fas fa-save me-1"></i>Update Department
                    </button>
                    <a href="/medical-staff/departments" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>



</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>