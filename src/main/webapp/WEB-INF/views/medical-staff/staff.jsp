<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Staff Management - HMS</title>
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
        /* Staff Status Button Styles */
        .toggle-status-btn {
            transition: all 0.3s ease;
        }

        .toggle-status-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .btn-group .btn {
            border-radius: 6px !important;
            margin: 0 2px;
        }

        /* Modal specific styles */
        #statusConfirmationModal .modal-header {
            background: var(--primary-gradient);
            color: white;
        }

        #statusConfirmationModal .modal-header .btn-close {
            filter: invert(1);
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

        .alert-info::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 6px;
            height: 100%;
            background: var(--info-gradient);
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

        .form-check-input:checked {
            background-color: #6a11cb;
            border-color: #6a11cb;
        }

        /* Validation Styles */
        .is-invalid {
            border-color: #dc3545;
            box-shadow: 0 0 0 0.25rem rgba(220, 53, 69, 0.25);
        }

        .is-valid {
            border-color: #198754;
            box-shadow: 0 0 0 0.25rem rgba(25, 135, 84, 0.25);
        }

        .invalid-feedback {
            display: none;
            width: 100%;
            margin-top: 0.25rem;
            font-size: 0.875em;
            color: #dc3545;
        }

        .valid-feedback {
            display: none;
            width: 100%;
            margin-top: 0.25rem;
            font-size: 0.875em;
            color: #198754;
        }

        .was-validated .form-control:invalid ~ .invalid-feedback,
        .was-validated .form-select:invalid ~ .invalid-feedback,
        .form-control.is-invalid ~ .invalid-feedback,
        .form-select.is-invalid ~ .invalid-feedback {
            display: block;
        }

        .was-validated .form-control:valid ~ .valid-feedback,
        .form-control.is-valid ~ .valid-feedback {
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
                    <a class="nav-link" href="/medical-staff/departments">
                        <i class="fas fa-building"></i>Departments
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/medical-staff/doctors">
                        <i class="fas fa-user-md"></i>Doctors
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="/medical-staff/staff">
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
                <h1 class="mb-1"><i class="fas fa-users me-2"></i>Staff Management</h1>
                <p class="text-muted">Manage hospital staff members, assignments, and user accounts</p>
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

    <!-- Add Staff Form -->
    <div class="card mt-4">
        <div class="card-header">
            <h5 class="mb-0"><i class="fas fa-user-plus me-2"></i>Add New Staff Member</h5>
        </div>
        <div class="card-body">
            <form method="post" action="/medical-staff/staff/create-with-user" class="needs-validation" novalidate id="staffForm">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">First Name *</label>
                        <input type="text" name="firstName" class="form-control" placeholder="e.g., John" required
                               pattern="[A-Za-z\s]+" title="First name should contain only letters">
                        <div class="invalid-feedback">
                            Please provide a valid first name (letters only, no digits).
                        </div>
                        <div class="valid-feedback">
                            Looks good!
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Last Name *</label>
                        <input type="text" name="lastName" class="form-control" placeholder="e.g., Smith" required
                               pattern="[A-Za-z\s]+" title="Last name should contain only letters">
                        <div class="invalid-feedback">
                            Please provide a valid last name (letters only, no digits).
                        </div>
                        <div class="valid-feedback">
                            Looks good!
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Staff Type *</label>
                        <select name="staffType" class="form-select" required>
                            <option value="">Select Staff Type</option>
                            <option value="NURSE">Nurse</option>
                            <option value="RECEPTIONIST">Receptionist</option>
                            <option value="LAB_TECH">Lab Technician</option>
                            <option value="WARD_MANAGER">Ward Manager</option>
                            <option value="ADMIN">Administrative Staff</option>
                        </select>
                        <div class="invalid-feedback">
                            Please select a staff type.
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Department</label>
                        <select name="department" class="form-select">
                            <option value="">Select Department</option>
                            <c:forEach var="dept" items="${departments}">
                                <option value="${dept.id}">${dept.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Date of Birth *</label>
                        <input type="date" name="dateOfBirth" class="form-control" id="dateOfBirth" max="" required>
                        <div class="invalid-feedback" id="dobError">
                            Staff member must be at least 18 years old.
                        </div>
                        <div class="valid-feedback">
                            Valid date of birth.
                        </div>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Gender *</label>
                        <select name="gender" class="form-select" required>
                            <option value="">Select Gender</option>
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                            <option value="Other">Other</option>
                        </select>
                        <div class="invalid-feedback">
                            Please select a gender.
                        </div>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Contact Number *</label>
                        <input type="text" name="contactNumber" class="form-control" placeholder="e.g., 0771234567"
                               pattern="[0-9]{10}" title="Phone number must be exactly 10 digits" required>
                        <div class="invalid-feedback">
                            Please provide a valid 10-digit phone number.
                        </div>
                        <div class="valid-feedback">
                            Valid phone number.
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Email *</label>
                        <input type="email" name="email" class="form-control" placeholder="e.g., john.smith@hospital.com" required>
                        <div class="invalid-feedback">
                            Please provide a valid email address.
                        </div>
                        <div class="valid-feedback">
                            Valid email address.
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Qualification</label>
                        <input type="text" name="qualification" class="form-control" placeholder="e.g., RN, BSc Nursing">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Assigned Shift</label>
                        <select name="assignedShift" class="form-select">
                            <option value="">Select Shift</option>
                            <option value="MORNING">Morning Shift</option>
                            <option value="EVENING">Evening Shift</option>
                            <option value="NIGHT">Night Shift</option>
                            <option value="ROTATING">Rotating Shift</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Working Days</label>
                        <input type="text" name="workingDays" class="form-control" value="MON-FRI" placeholder="e.g., MON-FRI">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Status</label>
                        <select name="isActive" class="form-select">
                            <option value="true" selected>Active</option>
                            <option value="false">Inactive</option>
                        </select>
                    </div>
                </div>

                <!-- User Account Creation Section -->
                <div class="row mt-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h6 class="mb-0"><i class="fas fa-user-lock me-2"></i>User Account for Login</h6>
                            </div>
                            <div class="card-body">
                                <div class="form-check mb-3">
                                    <input type="checkbox" name="createUserAccount" id="createUserAccount" class="form-check-input">
                                    <label class="form-check-label" for="createUserAccount">
                                        <strong>Create User Account for System Login</strong>
                                    </label>
                                    <small class="form-text text-muted d-block">
                                        This will allow the staff member to log into the system with appropriate permissions.
                                    </small>
                                </div>

                                <!-- User account fields (initially hidden) -->
                                <div id="userAccountFields" style="display: none;">
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label class="form-label">Username *</label>
                                            <input type="text" name="username" class="form-control" placeholder="Choose a username for login"
                                                   pattern="[A-Za-z0-9]+" title="Username should contain only letters and numbers">
                                            <div class="invalid-feedback">
                                                Please provide a username for the user account (letters and numbers only).
                                            </div>
                                            <div class="valid-feedback">
                                                Valid username.
                                            </div>
                                            <small class="text-muted">Username will be used for system login</small>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Password *</label>
                                            <input type="password" name="password" class="form-control" placeholder="Enter password"
                                                   minlength="6" required>
                                            <div class="invalid-feedback">
                                                Password must be at least 6 characters long.
                                            </div>
                                            <div class="valid-feedback">
                                                Valid password.
                                            </div>
                                            <small class="text-muted">
                                                Default password will be generated based on staff type if left blank:<br>
                                                <span id="defaultPasswordHint"></span>
                                            </small>
                                        </div>
                                        <div class="col-12">
                                            <div class="alert alert-info">
                                                <small>
                                                    <strong>Role Mapping:</strong><br>
                                                    • Nurse → STAFF role<br>
                                                    • Receptionist → RECEPTIONIST role<br>
                                                    • Lab Technician → LAB_TECH role<br>
                                                    • Ward Manager → STAFF role<br>
                                                    • Administrative Staff → STAFF role
                                                </small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="mt-4">
                    <button type="submit" class="btn btn-info">
                        <i class="fas fa-save me-1"></i>Add Staff Member
                    </button>
                    <button type="reset" class="btn btn-secondary">
                        <i class="fas fa-undo me-1"></i>Reset Form
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Staff List -->
    <div class="card mt-4">
        <div class="card-header">
            <h5 class="mb-0"><i class="fas fa-list me-2"></i>All Staff Members (${staff.size()})</h5>
        </div>
        <div class="card-body">
            <!-- Staff Filter -->
            <div class="row mb-3">
                <div class="col-md-4">
                    <input type="text" id="searchInput" class="form-control" placeholder="Search staff...">
                </div>
                <div class="col-md-4">
                    <select id="departmentFilter" class="form-select">
                        <option value="">All Departments</option>
                        <c:forEach var="dept" items="${departments}">
                            <option value="${dept.name}">${dept.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-4">
                    <select id="typeFilter" class="form-select">
                        <option value="">All Types</option>
                        <option value="NURSE">Nurse</option>
                        <option value="RECEPTIONIST">Receptionist</option>
                        <option value="LAB_TECH">Lab Technician</option>
                        <option value="WARD_MANAGER">Ward Manager</option>
                    </select>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-striped" id="staffTable">
                    <thead>
                    <tr>
                        <th>Staff Name</th>
                        <th>Position</th>
                        <th>Department</th>
                        <th>Contact</th>
                        <th>Shift</th>
                        <th>Status</th>
                        <th>User Account</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="staffMember" items="${staff}">
                        <tr>
                            <td>
                                <strong>${staffMember.firstName} ${staffMember.lastName}</strong>
                                <br><small class="text-muted">${staffMember.qualification}</small>
                            </td>
                            <td>
                                    <span class="badge
                                        ${staffMember.staffType == 'NURSE' ? 'bg-info' :
                                          staffMember.staffType == 'RECEPTIONIST' ? 'bg-warning' :
                                          staffMember.staffType == 'LAB_TECH' ? 'bg-success' : 'bg-secondary'}">
                                            ${staffMember.staffType}
                                    </span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${staffMember.department != null}">
                                        <span class="badge bg-primary">${staffMember.department.name}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">No Department</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <small>${staffMember.contactNumber}</small><br>
                                <small>${staffMember.email}</small>
                            </td>
                            <td>
                                <c:if test="${not empty staffMember.assignedShift}">
                                    <span class="badge bg-dark">${staffMember.assignedShift}</span><br>
                                    <small>${staffMember.workingDays}</small>
                                </c:if>
                            </td>
                            <td>
                                    <span class="badge ${staffMember.isActive ? 'bg-success' : 'bg-danger'}">
                                            ${staffMember.isActive ? 'Active' : 'Inactive'}
                                    </span>
                            </td>
                            <td>
                                <c:set var="hasUserAccount" value="false" />
                                <c:forEach var="user" items="${users}">
                                    <c:if test="${user.profileId == staffMember.id}">
                                        <c:set var="hasUserAccount" value="true" />
                                        <span class="badge bg-success">Active</span><br>
                                        <small>${user.username}</small>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${not hasUserAccount}">
                                    <span class="badge bg-secondary">No Account</span>
                                </c:if>
                            </td>
                            <td>
                                <div class="btn-group btn-group-sm">
                                    <a href="/medical-staff/staff/view/${staffMember.id}" class="btn btn-primary" title="View Details">
                                        <i class="fas fa-eye"></i>
                                    </a>
<%--                                   --%>
                                    <c:if test="${not hasUserAccount}">
                                        <a href="/medical-staff/staff/create-user/${staffMember.id}" class="btn btn-success" title="Create User Account">
                                            <i class="fas fa-user-plus"></i>
                                        </a>
                                    </c:if>

                                    <!-- Active/Inactive Toggle with POST method -->
                                    <c:choose>
                                        <c:when test="${staffMember.isActive}">
                                            <form method="post" action="/medical-staff/staff/toggle-status/${staffMember.id}" style="display: inline;"
                                                  onsubmit="return confirm('Deactivate ${staffMember.firstName} ${staffMember.lastName}?')">
                                                <input type="hidden" name="isActive" value="false">
                                                <button type="submit" class="btn btn-danger" title="Deactivate Staff">
                                                    <i class="fas fa-user-slash"></i>
                                                </button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <form method="post" action="/medical-staff/staff/toggle-status/${staffMember.id}" style="display: inline;"
                                                  onsubmit="return confirm('Activate ${staffMember.firstName} ${staffMember.lastName}?')">
                                                <input type="hidden" name="isActive" value="true">
                                                <button type="submit" class="btn btn-success" title="Activate Staff">
                                                    <i class="fas fa-user-check"></i>
                                                </button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty staff}">
                        <tr>
                            <td colspan="8" class="text-center text-muted">
                                <i class="fas fa-users fa-3x mb-2"></i><br>
                                No staff members found. Add your first staff member above.
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<!-- Staff Status Confirmation Modal -->
<div class="modal fade" id="statusConfirmationModal" tabindex="-1" aria-labelledby="statusConfirmationModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="statusConfirmationModalLabel">
                    <i class="fas fa-user-cog me-2"></i>Confirm Status Change
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="alert alert-warning">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    <strong>Please Confirm:</strong> You are about to change the status of
                    <strong id="staffNameConfirm"></strong>.
                </div>
                <p id="statusChangeMessage"></p>
                <div class="alert alert-info">
                    <small>
                        <i class="fas fa-info-circle me-1"></i>
                        <span id="statusChangeInfo"></span>
                    </small>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times me-1"></i>Cancel
                </button>
                <form id="statusChangeForm" method="post" style="display: inline;">
                    <input type="hidden" name="isActive" id="newStatusValue">
                    <button type="submit" class="btn" id="confirmStatusBtn">
                        <i class="fas fa-check me-1"></i>
                        <span id="confirmButtonText"></span>
                    </button>
                </form>
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
    // Staff status toggle handling
    document.addEventListener('DOMContentLoaded', function() {
        const statusModal = new bootstrap.Modal(document.getElementById('statusConfirmationModal'));
        const toggleButtons = document.querySelectorAll('.toggle-status-btn');

        let currentStaffId = null;
        let currentStaffName = null;
        let currentStatus = null;

        toggleButtons.forEach(button => {
            button.addEventListener('click', function() {
                currentStaffId = this.getAttribute('data-staff-id');
                currentStaffName = this.getAttribute('data-staff-name');
                currentStatus = this.getAttribute('data-current-status') === 'true';

                const newStatus = !currentStatus;

                // Update modal content based on the action
                document.getElementById('staffNameConfirm').textContent = currentStaffName;

                if (newStatus) {
                    // Activating staff
                    document.getElementById('statusChangeMessage').textContent =
                        'This will activate the staff member and allow them to be assigned to shifts and departments.';
                    document.getElementById('statusChangeInfo').textContent =
                        'Active staff members can be assigned to shifts, departments, and will appear in staff lists.';
                    document.getElementById('confirmButtonText').textContent = 'Activate Staff';
                    document.getElementById('confirmStatusBtn').className = 'btn btn-success';
                    document.getElementById('newStatusValue').value = 'true';
                } else {
                    // Deactivating staff
                    document.getElementById('statusChangeMessage').textContent =
                        'This will deactivate the staff member. They will not be available for new shift assignments.';
                    document.getElementById('statusChangeInfo').textContent =
                        'Inactive staff members cannot be assigned to new shifts but their historical data will be preserved.';
                    document.getElementById('confirmButtonText').textContent = 'Deactivate Staff';
                    document.getElementById('confirmStatusBtn').className = 'btn btn-danger';
                    document.getElementById('newStatusValue').value = 'false';
                }

                // Update form action
                document.getElementById('statusChangeForm').action = '/medical-staff/staff/update-status/' + currentStaffId;

                statusModal.show();
            });
        });

        // Handle form submission
        document.getElementById('statusChangeForm').addEventListener('submit', function(e) {
            e.preventDefault();

            const submitBtn = this.querySelector('button[type="submit"]');
            const originalText = submitBtn.innerHTML;

            // Show loading state
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>Processing...';
            submitBtn.disabled = true;

            // Submit the form
            fetch(this.action, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: new URLSearchParams(new FormData(this))
            })
                .then(response => {
                    if (response.redirected) {
                        window.location.href = response.url;
                    } else {
                        return response.text();
                    }
                })
                .catch(error => {
                    console.error('Error updating staff status:', error);
                    submitBtn.innerHTML = originalText;
                    submitBtn.disabled = false;
                    statusModal.hide();
                    alert('Error updating staff status. Please try again.');
                });
        });
    });
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

    // Birthday validation - Set max date to today and validate age (18+)
    document.addEventListener('DOMContentLoaded', function() {
        const dobInput = document.getElementById('dateOfBirth');
        const today = new Date();
        const maxDate = new Date(today.getFullYear() - 18, today.getMonth(), today.getDate());

        // Format date for input max attribute (YYYY-MM-DD)
        const maxDateString = maxDate.toISOString().split('T')[0];
        dobInput.max = maxDateString;

        // Validate birthday on form submission
        const form = document.getElementById('staffForm');
        form.addEventListener('submit', function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }

            // Additional birthday validation
            if (dobInput.value) {
                const selectedDate = new Date(dobInput.value);
                if (selectedDate > maxDate) {
                    dobInput.classList.add('is-invalid');
                    event.preventDefault();
                    event.stopPropagation();
                } else {
                    dobInput.classList.remove('is-invalid');
                }
            }

            form.classList.add('was-validated');
        }, false);

        // Real-time birthday validation
        dobInput.addEventListener('change', function() {
            if (this.value) {
                const selectedDate = new Date(this.value);
                if (selectedDate > maxDate) {
                    this.classList.add('is-invalid');
                    this.classList.remove('is-valid');
                } else {
                    this.classList.remove('is-invalid');
                    this.classList.add('is-valid');
                }
            } else {
                this.classList.remove('is-invalid', 'is-valid');
            }
        });

        // Real-time validation for name fields (no digits)
        const nameInputs = document.querySelectorAll('input[name="firstName"], input[name="lastName"]');
        nameInputs.forEach(input => {
            input.addEventListener('input', function() {
                const namePattern = /^[A-Za-z\s]+$/;
                if (this.value && !namePattern.test(this.value)) {
                    this.classList.add('is-invalid');
                    this.classList.remove('is-valid');
                } else if (this.value && namePattern.test(this.value)) {
                    this.classList.remove('is-invalid');
                    this.classList.add('is-valid');
                } else {
                    this.classList.remove('is-invalid', 'is-valid');
                }
            });
        });

        // Real-time validation for phone number (exactly 10 digits)
        const phoneInput = document.querySelector('input[name="contactNumber"]');
        phoneInput.addEventListener('input', function() {
            const phonePattern = /^[0-9]{10}$/;
            if (this.value && !phonePattern.test(this.value)) {
                this.classList.add('is-invalid');
                this.classList.remove('is-valid');
            } else if (this.value && phonePattern.test(this.value)) {
                this.classList.remove('is-invalid');
                this.classList.add('is-valid');
            } else {
                this.classList.remove('is-invalid', 'is-valid');
            }
        });

        // Real-time validation for username (only letters and numbers)
        const usernameInput = document.querySelector('input[name="username"]');
        if (usernameInput) {
            usernameInput.addEventListener('input', function() {
                const usernamePattern = /^[A-Za-z0-9]+$/;
                if (this.value && !usernamePattern.test(this.value)) {
                    this.classList.add('is-invalid');
                    this.classList.remove('is-valid');
                } else if (this.value && usernamePattern.test(this.value)) {
                    this.classList.remove('is-invalid');
                    this.classList.add('is-valid');
                } else {
                    this.classList.remove('is-invalid', 'is-valid');
                }
            });
        }

        // Real-time validation for password (at least 6 characters)
        const passwordInput = document.querySelector('input[name="password"]');
        if (passwordInput) {
            passwordInput.addEventListener('input', function() {
                if (this.value && this.value.length < 6) {
                    this.classList.add('is-invalid');
                    this.classList.remove('is-valid');
                } else if (this.value && this.value.length >= 6) {
                    this.classList.remove('is-invalid');
                    this.classList.add('is-valid');
                } else {
                    this.classList.remove('is-invalid', 'is-valid');
                }
            });
        }
    });

    // Show/hide user account fields based on checkbox
    document.getElementById('createUserAccount').addEventListener('change', function() {
        const userAccountFields = document.getElementById('userAccountFields');
        const usernameInput = document.querySelector('input[name="username"]');
        const passwordInput = document.querySelector('input[name="password"]');

        if (this.checked) {
            userAccountFields.style.display = 'block';
            usernameInput.required = true;
            passwordInput.required = true;
            updateDefaultPasswordHint();
        } else {
            userAccountFields.style.display = 'none';
            usernameInput.required = false;
            passwordInput.required = false;
        }
    });

    // Auto-generate username suggestion based on name
    document.querySelector('input[name="firstName"]').addEventListener('blur', function() {
        const createAccountCheckbox = document.getElementById('createUserAccount');
        const usernameInput = document.querySelector('input[name="username"]');
        const lastNameInput = document.querySelector('input[name="lastName"]');

        if (createAccountCheckbox.checked && (!usernameInput.value || usernameInput.value.trim() === '')) {
            const firstName = this.value.toLowerCase();
            const lastName = lastNameInput.value.toLowerCase();
            if (firstName && lastName) {
                usernameInput.value = firstName.charAt(0) + lastName;
                // Trigger validation
                usernameInput.dispatchEvent(new Event('input'));
            }
        }
    });

    // Update default password hint based on staff type
    document.querySelector('select[name="staffType"]').addEventListener('change', function() {
        updateDefaultPasswordHint();
    });

    function updateDefaultPasswordHint() {
        const staffTypeSelect = document.querySelector('select[name="staffType"]');
        const defaultPasswordHint = document.getElementById('defaultPasswordHint');
        const selectedType = staffTypeSelect.value;

        const passwordMap = {
            'NURSE': 'nurse123',
            'RECEPTIONIST': 'receptionist123',
            'LAB_TECH': 'labtech123',
            'WARD_MANAGER': 'wardmanager123',
            'ADMIN': 'admin123'
        };

        if (selectedType && passwordMap[selectedType]) {
            defaultPasswordHint.textContent = passwordMap[selectedType];
            defaultPasswordHint.className = 'text-success';
        } else {
            defaultPasswordHint.textContent = 'staff123';
            defaultPasswordHint.className = 'text-muted';
        }
    }

    // Simple filtering functionality for staff table
    document.getElementById('searchInput').addEventListener('input', filterStaff);
    document.getElementById('departmentFilter').addEventListener('change', filterStaff);
    document.getElementById('typeFilter').addEventListener('change', filterStaff);

    function filterStaff() {
        const search = document.getElementById('searchInput').value.toLowerCase();
        const department = document.getElementById('departmentFilter').value;
        const type = document.getElementById('typeFilter').value;

        const rows = document.querySelectorAll('#staffTable tbody tr');

        rows.forEach(row => {
            const name = row.cells[0].textContent.toLowerCase();
            const position = row.cells[1].textContent;
            const dept = row.cells[2].textContent;

            const matchesSearch = name.includes(search);
            const matchesDept = department === '' || dept.includes(department);
            const matchesType = type === '' || position.includes(type);

            row.style.display = (matchesSearch && matchesDept && matchesType) ? '' : 'none';
        });
    }

    // Initialize default password hint on page load
    document.addEventListener('DOMContentLoaded', function() {
        updateDefaultPasswordHint();
    });
</script>
</body>
</html>