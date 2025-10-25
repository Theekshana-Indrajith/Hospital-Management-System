<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Department Management - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap');

        /* Define CSS variables for medical staff theme - Purple/Blue Theme */
        :root {
            --primary-gradient: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            --success-gradient: linear-gradient(135deg, #00b09b 0%, #96c93d 100%);
            --danger-gradient: linear-gradient(135deg, #ff6b6b 0%, #ff8e8e 100%);
            --warning-gradient: linear-gradient(135deg, #f7971e 0%, #ffd200 100%);
            --info-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --dark-gradient: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            --light-bg: rgba(255, 255, 255, 0.95);
            --shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }

        /* Global Reset and Base Styling */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            overflow-x: hidden;
            position: relative;
        }

        /* Enhanced Navigation - Medical Staff Theme */
        .navbar {
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.98) 0%, rgba(248, 249, 250, 0.98) 100%) !important;
            backdrop-filter: blur(15px);
            box-shadow: 0 4px 30px rgba(106, 17, 203, 0.1);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            padding: 15px 0;
            border-bottom: 1px solid rgba(106, 17, 203, 0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .navbar.scrolled {
            background: linear-gradient(135deg, rgba(255, 255, 255, 1) 0%, rgba(248, 249, 250, 1) 100%) !important;
            padding: 10px 0;
            box-shadow: 0 8px 40px rgba(106, 17, 203, 0.15);
            border-bottom: 2px solid rgba(106, 17, 203, 0.2);
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            transition: all 0.3s ease;
            letter-spacing: -0.5px;
            display: flex;
            align-items: center;
        }

        .navbar-brand:hover {
            transform: scale(1.05);
            filter: brightness(1.2);
        }

        .navbar-brand i {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: pulse 2s ease-in-out infinite;
            margin-right: 0.5rem;
            font-size: 1.4rem;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }

        .nav-link {
            position: relative;
            font-weight: 600;
            color: #2c3e50 !important;
            padding: 8px 20px !important;
            margin: 0 5px;
            transition: all 0.3s ease;
            border-radius: 8px;
            font-size: 0.95rem;
        }

        .nav-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(106, 17, 203, 0.1), rgba(37, 117, 252, 0.1));
            border-radius: 8px;
            opacity: 0;
            transition: opacity 0.3s ease;
            z-index: -1;
        }

        .nav-link::after {
            content: '';
            position: absolute;
            bottom: 5px;
            left: 50%;
            width: 0;
            height: 3px;
            background: linear-gradient(90deg, #6a11cb, #2575fc);
            border-radius: 2px;
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }

        .nav-link:hover,
        .nav-link.active {
            color: #6a11cb !important;
            transform: translateY(-2px);
        }

        .nav-link:hover::before,
        .nav-link.active::before {
            opacity: 1;
        }

        .nav-link:hover::after,
        .nav-link.active::after {
            width: 80%;
        }

        .nav-link i {
            margin-right: 0.5rem;
            transition: transform 0.3s ease;
        }

        .nav-link:hover i {
            transform: scale(1.1);
        }

        .navbar-text {
            font-weight: 600;
            color: #2c3e50 !important;
            padding: 8px 20px;
            margin: 0 5px;
            border-radius: 8px;
            background: linear-gradient(135deg, rgba(106, 17, 203, 0.1), rgba(37, 117, 252, 0.1));
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
        }

        .navbar-text:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(106, 17, 203, 0.2);
        }

        .navbar-text i {
            margin-right: 0.5rem;
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .nav-link[href="/logout"] {
            background: linear-gradient(135deg, #ff6b6b 0%, #ff8e8e 100%);
            color: #fff !important;
            box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3);
            padding: 10px 25px !important;
        }

        .nav-link[href="/logout"]::before {
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
        }

        .nav-link[href="/logout"]::after {
            display: none;
        }

        .nav-link[href="/logout"]:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 25px rgba(255, 107, 107, 0.4);
            color: #fff !important;
        }

        .navbar-toggler {
            border: 2px solid #6a11cb;
            padding: 8px 12px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .navbar-toggler:hover {
            background: rgba(106, 17, 203, 0.1);
            transform: scale(1.05);
        }

        .navbar-toggler:focus {
            box-shadow: 0 0 0 0.25rem rgba(106, 17, 203, 0.25);
        }

        .navbar-toggler-icon {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba(106, 17, 203, 1)' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
        }

        /* Page Header Background Image - Medical Staff Theme */
        .page-header {
            position: relative;
            background-image: url('https://images.unsplash.com/photo-1559757175-0eb30cd8c063?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            padding: 2rem 1rem;
            border-radius: 15px;
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(106, 17, 203, 0.7);
            z-index: 0;
        }

        .page-header > * {
            position: relative;
            z-index: 1;
            color: #fff;
        }

        .page-header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            color: #fff;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);
        }

        .page-header p {
            font-size: 1.1rem;
            opacity: 0.9;
            color: #fff;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.5);
        }

        /* Card Styling with Clear Gaps */
        .card {
            border: none;
            border-radius: 15px;
            background: var(--light-bg);
            backdrop-filter: blur(12px);
            box-shadow: var(--shadow);
            transition: transform 0.4s ease, box-shadow 0.4s ease;
            margin-bottom: 1.5rem;
        }

        .card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--success-gradient);
            transform: scaleX(0);
            transition: transform 0.4s ease;
        }

        .card:hover::before {
            transform: scaleX(1);
        }

        /* Statistics Cards */
        .card.bg-success {
            background: var(--success-gradient) !important;
            border: none;
        }

        .card.bg-info {
            background: var(--info-gradient) !important;
            border: none;
        }

        .card.bg-warning {
            background: var(--warning-gradient) !important;
            border: none;
        }

        .card.bg-secondary {
            background: linear-gradient(135deg, #6c757d 0%, #868e96 100%) !important;
            border: none;
        }

        /* Quick Action Cards */
        .card.text-center {
            border: none;
            border-radius: 15px;
            box-shadow: var(--shadow);
            transition: all 0.3s ease;
            height: 100%;
        }

        .card.text-center:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
        }

        /* Department Cards */
        .card .card {
            border: 1px solid rgba(0, 0, 0, 0.125);
            transition: all 0.3s ease;
        }

        .card .card:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        /* Button Styling */
        .btn-primary {
            background: var(--primary-gradient);
            border: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(106, 17, 203, 0.3);
        }

        .btn-success {
            background: var(--success-gradient);
            border: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-success:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 176, 155, 0.3);
        }

        .btn-info {
            background: var(--info-gradient);
            border: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-info:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(79, 172, 254, 0.3);
        }

        .btn-outline-primary {
            border-color: rgba(106, 17, 203, 0.5);
            color: #6a11cb;
        }

        .btn-outline-primary:hover {
            background: var(--primary-gradient);
            color: #fff;
            border-color: var(--primary-gradient);
        }

        /* Alert Styling */
        .alert {
            border-radius: 12px;
            box-shadow: var(--shadow);
            position: relative;
            overflow: hidden;
            background: var(--light-bg);
            backdrop-filter: blur(10px);
        }

        .alert-success::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 6px;
            height: 100%;
            background: var(--success-gradient);
        }

        .alert-danger::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 6px;
            height: 100%;
            background: var(--danger-gradient);
        }

        /* Table Styling */
        .table-responsive {
            border-radius: 15px;
            overflow: hidden;
        }

        .table {
            margin-bottom: 0;
        }

        .table thead th {
            background: var(--primary-gradient);
            color: white;
            font-weight: 600;
            border: none;
            padding: 1rem;
        }

        .table tbody td {
            padding: 1rem;
            vertical-align: middle;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        }

        .table tbody tr:hover {
            background-color: rgba(106, 17, 203, 0.05);
        }

        .badge {
            font-size: 0.75rem;
            padding: 0.4em 0.8em;
            border-radius: 20px;
        }

        /* Form Styling */
        .form-control, .form-select {
            border-radius: 10px;
            border: 1px solid rgba(106, 17, 203, 0.2);
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: #6a11cb;
            box-shadow: 0 0 0 0.25rem rgba(106, 17, 203, 0.25);
        }

        .form-label {
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 0.5rem;
        }

        /* Validation Styles */
        .is-invalid {
            border-color: #dc3545 !important;
            box-shadow: 0 0 0 0.25rem rgba(220, 53, 69, 0.25) !important;
        }

        .invalid-feedback {
            display: none;
            width: 100%;
            margin-top: 0.25rem;
            font-size: 0.875em;
            color: #dc3545;
        }

        .is-invalid ~ .invalid-feedback {
            display: block;
        }

        /* Footer Styling */
        footer {
            background: var(--dark-gradient) !important;
            color: #fff;
            position: relative;
            overflow: hidden;
            margin-top: 3rem;
        }

        footer::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"><path fill="rgba(255,255,255,0.05)" d="M0,96L48,112C96,128,192,160,288,160C384,160,480,128,576,112C672,96,768,96,864,112C960,128,1056,160,1152,160C1248,160,1344,128,1392,112L1440,96L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>');
            background-size: cover;
            animation: footerWave 10s ease-in-out infinite;
        }

        @keyframes footerWave {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-15px); }
        }

        /* Improved Spacing and Layout */
        .container {
            padding-bottom: 2rem;
        }

        .row {
            margin-bottom: 1.5rem;
        }

        .card-body .row {
            margin-bottom: 0;
        }

        /* Responsive Design */
        @media (max-width: 991px) {
            .navbar-collapse {
                background: rgba(255, 255, 255, 0.98);
                backdrop-filter: blur(20px);
                border-radius: 15px;
                margin-top: 1rem;
                padding: 1.5rem;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            }

            .nav-link {
                margin: 0.3rem 0;
                text-align: left;
            }

            .navbar-text {
                margin: 0.5rem 0;
            }
        }

        @media (max-width: 768px) {
            .navbar-brand {
                font-size: 1.3rem;
            }

            .nav-link {
                padding: 0.7rem 1.2rem !important;
                font-size: 0.9rem;
            }

            .page-header h1 {
                font-size: 2rem;
            }

            .card {
                margin-bottom: 1rem;
            }
        }
    </style>
</head>
<body>
<!-- Enhanced Navigation Bar -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center">
            <i class="fas fa-hospital-alt"></i>
            <span>Aurora Health Hospital</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="/medical-staff/dashboard">
                        <i class="fas fa-th-large"></i>Staff Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="/medical-staff/departments">
                        <i class="fas fa-building"></i>Departments
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/medical-staff/doctors">
                        <i class="fas fa-user-md"></i>Doctors
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/medical-staff/staff">
                        <i class="fas fa-users"></i>Staff
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/medical-staff/shifts">
                        <i class="fas fa-clock"></i>Shifts
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/admin/dashboard">
                        <i class="fas fa-cog"></i>Admin Dashboard
                    </a>
                </li>
            </ul>
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item">
                    <span class="navbar-text">
                        <i class="fas fa-user-circle"></i>Welcome, Administrator!
                    </span>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/logout">
                        <i class="fas fa-sign-out-alt"></i>Logout
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <!-- Updated Page Header with Background Image -->
    <div class="page-header mb-4">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h1 class="mb-1"><i class="fas fa-building me-2"></i>Department Management</h1>
                <p class="text-muted">Manage hospital departments, staff assignments, and shift schedules</p>
            </div>
        </div>
    </div>

    <!-- Success/Error Messages -->
    <c:if test="${not empty param.success}">
        <div class="alert alert-success alert-dismissible fade show">
            <i class="fas fa-check-circle me-2"></i><strong>Success!</strong> ${param.success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:if test="${not empty param.error}">
        <div class="alert alert-danger alert-dismissible fade show">
            <i class="fas fa-exclamation-circle me-2"></i><strong>Error!</strong> ${param.error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Add Department Form -->
    <div class="card mt-4">
        <div class="card-header">
            <h5 class="mb-0"><i class="fas fa-plus-circle me-2"></i>Add New Department</h5>
        </div>
        <div class="card-body">
            <form method="post" action="/medical-staff/departments/create" id="departmentForm" novalidate>
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Department Name *</label>
                        <input type="text" name="name" id="departmentName" class="form-control"
                               placeholder="e.g., Cardiology" required
                               pattern="^[A-Za-z\s\-&,]+$"
                               title="Department name should only contain letters, spaces, hyphens, ampersands, and commas">
                        <div class="invalid-feedback">
                            Please enter a valid department name (letters, spaces, hyphens, ampersands, and commas only).
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Head of Department *</label>
                        <input type="text" name="headOfDepartment" id="headOfDepartment" class="form-control"
                               placeholder="e.g., Dr. John Smith" required
                               pattern="^[A-Za-z\s\.\-',]+$"
                               title="Head of Department name should only contain letters, spaces, dots, hyphens, and apostrophes">
                        <div class="invalid-feedback">
                            Please enter a valid name for Head of Department (letters, spaces, dots, hyphens, and apostrophes only).
                        </div>
                    </div>
                    <div class="col-12">
                        <label class="form-label">Description</label>
                        <textarea name="description" class="form-control" rows="3" placeholder="Department description"></textarea>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Contact Number</label>
                        <input type="text" name="contactNumber" id="contactNumber" class="form-control"
                               placeholder="e.g., 0771234567"
                               pattern="^[\d\s\-\(\)\+]+$"
                               title="Contact number should only contain digits, spaces, hyphens, parentheses, and plus signs">
                        <div class="invalid-feedback">
                            Please enter a valid contact number (digits, spaces, hyphens, parentheses, and plus signs only).
                        </div>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-control" placeholder="e.g., cardiology@hospital.com">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Room Number</label>
                        <input type="text" name="roomNumber" class="form-control" placeholder="e.g., A-101">
                    </div>

                    <!-- Shift Timings -->
                    <div class="col-md-4">
                        <label class="form-label">Morning Shift Start</label>
                        <input type="time" name="morningShiftStart" class="form-control" value="08:00">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Morning Shift End</label>
                        <input type="time" name="morningShiftEnd" class="form-control" value="16:00">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Evening Shift Start</label>
                        <input type="time" name="eveningShiftStart" class="form-control" value="16:00">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Evening Shift End</label>
                        <input type="time" name="eveningShiftEnd" class="form-control" value="00:00">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Night Shift Start</label>
                        <input type="time" name="nightShiftStart" class="form-control" value="00:00">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Night Shift End</label>
                        <input type="time" name="nightShiftEnd" class="form-control" value="08:00">
                    </div>
                </div>
                <div class="mt-3">
                    <button type="submit" class="btn btn-success" id="submitBtn">
                        <i class="fas fa-save me-1"></i>Create Department
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Departments List -->
    <div class="card mt-4">
        <div class="card-header">
            <h5 class="mb-0"><i class="fas fa-list me-2"></i>All Departments (${departments.size()})</h5>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>Department Name</th>
                        <th>Head of Department</th>
                        <th>Doctors</th>
                        <th>Contact</th>
                        <th>Shift Hours</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="dept" items="${departments}">
                        <tr>
                            <td>
                                <strong>${dept.name}</strong>
                                <br><small class="text-muted">${dept.description}</small>
                            </td>
                            <td>${dept.headOfDepartment}</td>
                            <td>
                                <span class="badge bg-info">${dept.doctors.size()} Doctors</span>
                            </td>
                            <td>
                                <small>${dept.contactNumber}</small><br>
                                <small>${dept.email}</small><br>
                                <small>Room: ${dept.roomNumber}</small>
                            </td>
                            <td>
                                <small class="text-muted">
                                    Morning: ${dept.morningShiftStart} - ${dept.morningShiftEnd}<br>
                                    Evening: ${dept.eveningShiftStart} - ${dept.eveningShiftEnd}<br>
                                    Night: ${dept.nightShiftStart} - ${dept.nightShiftEnd}
                                </small>
                            </td>
                            <td>
                                <div class="btn-group btn-group-sm">
                                    <a href="/medical-staff/departments/edit/${dept.id}" class="btn btn-warning">
                                        <i class="fas fa-edit"></i>
                                    </a>
<%--                                    <button type="button" class="btn btn-danger delete-department-btn"--%>
<%--                                            data-dept-id="${dept.id}" data-dept-name="${dept.name}">--%>
<%--                                        <i class="fas fa-trash"></i>--%>
<%--                                    </button>--%>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty departments}">
                        <tr>
                            <td colspan="6" class="text-center text-muted">
                                <i class="fas fa-building fa-3x mb-2"></i><br>
                                No departments found. Create your first department above.
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="py-5 text-white">
    <div class="container position-relative">
        <div class="row">
            <div class="col-lg-4 mb-4">
                <h5 class="fw-bold mb-3">
                    <i class="fas fa-hospital me-2"></i>Aurora Health Hospital
                </h5>
                <p class="text-light-emphasis">
                    Providing exceptional healthcare services with compassion and excellence.
                    Your health is our priority.
                </p>
            </div>
            <!-- Our Services -->
            <div class="col-lg-4 mb-4">
                <h6 class="footer-section-title">Our Services</h6>
                <div class="footer-feature">
                    <i class="fas fa-user-md"></i>
                    <div class="footer-feature-text">
                        <strong>Expert Care</strong>
                        <small>Board-certified physicians</small>
                    </div>
                </div>
                <div class="footer-feature">
                    <i class="fas fa-calendar-check"></i>
                    <div class="footer-feature-text">
                        <strong>Easy Appointments</strong>
                        <small>24/7 online booking system</small>
                    </div>
                </div>
                <div class="footer-feature">
                    <i class="fas fa-flask"></i>
                    <div class="footer-feature-text">
                        <strong>Modern Lab</strong>
                        <small>Advanced diagnostic facilities</small>
                    </div>
                </div>
                <div class="footer-feature">
                    <i class="fas fa-ambulance"></i>
                    <div class="footer-feature-text">
                        <strong>Emergency Care</strong>
                        <small>Round-the-clock availability</small>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 mb-4">
                <h6 class="fw-bold">Contact Info</h6>
                <ul class="list-unstyled text-light-emphasis">
                    <li><i class="fas fa-phone me-2"></i>Emergency: 011-2224455</li>
                    <li><i class="fas fa-envelope me-2"></i>info@aurorahealth.com</li>
                    <li><i class="fas fa-map-marker-alt me-2"></i>Colombo, Srilanka</li>
                    <!-- Facebook Link -->
                    <li class="mt-3">
                        <a href="https://facebook.com/theekshana.indrajith.311798"
                           target="_blank"
                           class="text-decoration-none text-light-emphasis">
                            <i class="fab fa-facebook me-2"></i>
                            <span>Follow us on Facebook</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
        <hr class="my-4">
        <div class="text-center">
            <p class="mb-0 text-light-emphasis">
                &copy; 2025 Aurora Health Hospital. All rights reserved. |
                <span class="text-warning">Compassionate Care • Advanced Medicine</span>
            </p>
        </div>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Navbar scroll effect
    window.addEventListener('scroll', function() {
        const navbar = document.querySelector('.navbar');
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });

    // Auto-hide alerts after 5 seconds
    setTimeout(() => {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        });
    }, 5000);

    // Form validation
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.getElementById('departmentForm');
        const departmentName = document.getElementById('departmentName');
        const headOfDepartment = document.getElementById('headOfDepartment');
        const contactNumber = document.getElementById('contactNumber');

        // Real-time validation
        departmentName.addEventListener('input', function() {
            validateDepartmentName();
        });

        headOfDepartment.addEventListener('input', function() {
            validateHeadOfDepartment();
        });

        contactNumber.addEventListener('input', function() {
            validateContactNumber();
        });

        // Form submission validation
        form.addEventListener('submit', function(event) {
            if (!validateForm()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        });

        function validateForm() {
            return validateDepartmentName() &&
                validateHeadOfDepartment() &&
                validateContactNumber();
        }

        function validateDepartmentName() {
            const value = departmentName.value.trim();
            const regex = /^[A-Za-z\s\-&,]+$/;

            if (value === '') {
                setInvalid(departmentName, 'Department name is required.');
                return false;
            }

            if (!regex.test(value)) {
                setInvalid(departmentName, 'Department name should only contain letters, spaces, hyphens, ampersands, and commas.');
                return false;
            }

            if (/\d/.test(value)) {
                setInvalid(departmentName, 'Department name cannot contain numbers.');
                return false;
            }

            setValid(departmentName);
            return true;
        }

        function validateHeadOfDepartment() {
            const value = headOfDepartment.value.trim();
            const regex = /^[A-Za-z\s\.\-',]+$/;

            if (value === '') {
                setInvalid(headOfDepartment, 'Head of Department is required.');
                return false;
            }

            if (!regex.test(value)) {
                setInvalid(headOfDepartment, 'Head of Department name should only contain letters, spaces, dots, hyphens, and apostrophes.');
                return false;
            }

            if (/\d/.test(value)) {
                setInvalid(headOfDepartment, 'Head of Department name cannot contain numbers.');
                return false;
            }

            setValid(headOfDepartment);
            return true;
        }

        function validateContactNumber() {
            const value = contactNumber.value.trim();
            const regex = /^[\d\s\-\(\)\+]+$/;

            // Contact number is optional, so if empty, it's valid
            if (value === '') {
                setValid(contactNumber);
                return true;
            }

            if (!regex.test(value)) {
                setInvalid(contactNumber, 'Contact number should only contain digits, spaces, hyphens, parentheses, and plus signs.');
                return false;
            }

            // Remove all non-digit characters to check if there are enough digits
            const digitsOnly = value.replace(/\D/g, '');
            if (digitsOnly.length < 9) {
                setInvalid(contactNumber, 'Contact number should have at least 9 digits.');
                return false;
            }

            if (digitsOnly.length > 15) {
                setInvalid(contactNumber, 'Contact number is too long.');
                return false;
            }

            setValid(contactNumber);
            return true;
        }

        function setInvalid(element, message) {
            element.classList.add('is-invalid');
            element.classList.remove('is-valid');
            const feedback = element.nextElementSibling;
            if (feedback && feedback.classList.contains('invalid-feedback')) {
                feedback.textContent = message;
            }
        }

        function setValid(element) {
            element.classList.remove('is-invalid');
            element.classList.add('is-valid');
        }
    });
</script>
</body>
</html>