<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Patient Management - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap');

        /* Define CSS variables for enhanced blue/purple theme */
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --danger-gradient: linear-gradient(135deg, #ff6b6b 0%, #ff8e8e 100%);
            --warning-gradient: linear-gradient(135deg, #ffd93d 0%, #ff9a3d 100%);
            --info-gradient: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            --dark-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --light-bg: rgba(255, 255, 255, 0.95);
            --shadow: 0 8px 32px rgba(0, 0, 0, 0.1);

            /* New color variables for better consistency */
            --primary-color: #667eea;
            --primary-dark: #5a6fd8;
            --success-color: #4facfe;
            --danger-color: #ff6b6b;
            --warning-color: #ffd93d;
            --info-color: #6a11cb;
            --light-color: #f8f9fa;
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

        /* Enhanced Navigation - Matching Homepage Style */
        .navbar {
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.98) 0%, rgba(248, 249, 250, 0.98) 100%) !important;
            backdrop-filter: blur(15px);
            box-shadow: 0 4px 30px rgba(0, 123, 255, 0.1);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            padding: 15px 0;
            border-bottom: 1px solid rgba(102, 126, 234, 0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .navbar.scrolled {
            background: linear-gradient(135deg, rgba(255, 255, 255, 1) 0%, rgba(248, 249, 250, 1) 100%) !important;
            padding: 10px 0;
            box-shadow: 0 8px 40px rgba(102, 126, 234, 0.15);
            border-bottom: 2px solid rgba(102, 126, 234, 0.2);
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
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
            background: linear-gradient(90deg, #667eea, #764ba2);
            border-radius: 2px;
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }

        .nav-link:hover,
        .nav-link.active {
            color: #667eea !important;
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
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
        }

        .navbar-text:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.2);
        }

        .navbar-text i {
            margin-right: 0.5rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            border: 2px solid #667eea;
            padding: 8px 12px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .navbar-toggler:hover {
            background: rgba(102, 126, 234, 0.1);
            transform: scale(1.05);
        }

        .navbar-toggler:focus {
            box-shadow: 0 0 0 0.25rem rgba(102, 126, 234, 0.25);
        }

        .navbar-toggler-icon {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba(102, 126, 234, 1)' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
        }

        /* Welcome Header Background Image */
        .welcome-header {
            position: relative;
            background-image: url('https://images.unsplash.com/photo-1559757148-5c350d0d3c56?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            padding: 2rem 1rem;
            border-radius: 15px;
            overflow: hidden;
            margin-bottom: 1.5rem;
        }

        .welcome-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(102, 126, 234, 0.7);
            z-index: 0;
        }

        .welcome-header > * {
            position: relative;
            z-index: 1;
            color: #fff;
        }

        .welcome-header h2 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            color: #fff;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);
        }

        .welcome-header p {
            font-size: 1.1rem;
            opacity: 0.9;
            color: #fff;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.5);
        }

        /* Card Styling */
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
            background: var(--primary-gradient);
            transform: scaleX(0);
            transition: transform 0.4s ease;
        }

        .card:hover::before {
            transform: scaleX(1);
        }

        .card.border-primary::before { background: var(--primary-gradient); }
        .card.border-success::before { background: var(--success-gradient); }
        .card.border-warning::before { background: var(--warning-gradient); }
        .card.border-danger::before { background: var(--danger-gradient); }
        .card.border-info::before { background: var(--info-gradient); }

        .card-header {
            border-radius: 15px 15px 0 0 !important;
            border: none;
            padding: 1.25rem 1.5rem;
        }

        .card-header.bg-primary {
            background: var(--primary-gradient) !important;
        }

        .card-header.bg-success {
            background: var(--success-gradient) !important;
        }

        .card-header.bg-info {
            background: var(--info-gradient) !important;
        }

        .card-header.bg-warning {
            background: var(--warning-gradient) !important;
        }

        .card-header.bg-danger {
            background: var(--danger-gradient) !important;
        }

        .card-header.bg-light {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%) !important;
            color: #495057 !important;
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
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
            background: linear-gradient(135deg, #5a6fd8 0%, #6a4190 100%);
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
            box-shadow: 0 8px 20px rgba(79, 172, 254, 0.3);
            background: linear-gradient(135deg, #45a0e6 0%, #00d9e6 100%);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
            border: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(108, 117, 125, 0.3);
        }

        .btn-outline-primary {
            border-color: rgba(102, 126, 234, 0.5);
            color: #667eea;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-outline-primary:hover {
            background: var(--primary-gradient);
            color: #fff;
            border-color: var(--primary-color);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
        }

        .btn-outline-success {
            border-color: rgba(79, 172, 254, 0.5);
            color: #4facfe;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-outline-success:hover {
            background: var(--success-gradient);
            color: #fff;
            border-color: var(--success-color);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(79, 172, 254, 0.3);
        }

        .btn-outline-info {
            border-color: rgba(106, 17, 203, 0.5);
            color: #6a11cb;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-outline-info:hover {
            background: var(--info-gradient);
            color: #fff;
            border-color: var(--info-color);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(106, 17, 203, 0.3);
        }

        .btn-outline-warning {
            border-color: rgba(255, 217, 61, 0.5);
            color: #ffd93d;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-outline-warning:hover {
            background: var(--warning-gradient);
            color: #fff;
            border-color: var(--warning-color);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(255, 217, 61, 0.3);
        }

        .btn-outline-danger {
            border-color: rgba(255, 107, 107, 0.5);
            color: #ff6b6b;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-outline-danger:hover {
            background: var(--danger-gradient);
            color: #fff;
            border-color: var(--danger-color);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(255, 107, 107, 0.3);
        }

        .btn-light {
            background: rgba(255, 255, 255, 0.9);
            border: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            color: #495057;
        }

        .btn-light:hover {
            background: rgba(255, 255, 255, 1);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            color: #495057;
        }

        .btn-outline-light {
            border-color: rgba(255, 255, 255, 0.5);
            color: #fff;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-outline-light:hover {
            background: rgba(255, 255, 255, 0.9);
            color: #667eea;
            border-color: rgba(255, 255, 255, 0.8);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(255, 255, 255, 0.2);
        }

        /* Alert Styling */
        .alert {
            border-radius: 12px;
            box-shadow: var(--shadow);
            position: relative;
            overflow: hidden;
            background: var(--light-bg);
            backdrop-filter: blur(10px);
            border: none;
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

        .alert-warning::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 6px;
            height: 100%;
            background: var(--warning-gradient);
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

        /* Quick Actions */
        .quick-action-btn {
            transition: all 0.3s ease;
            border-radius: 15px;
            border: 2px solid transparent;
        }

        .quick-action-btn:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        /* Status Badge */
        .status-badge {
            font-size: 0.75em;
        }

        .bg-primary { background: var(--primary-color) !important; }
        .bg-success { background: var(--success-color) !important; }
        .bg-danger { background: var(--danger-color) !important; }
        .bg-warning { background: var(--warning-color) !important; }
        .bg-info { background: var(--info-color) !important; }

        /* Table Styling */
        .table {
            border-radius: 10px;
            overflow: hidden;
        }

        .table thead th {
            border: none;
            background: var(--dark-gradient);
            color: white;
            font-weight: 600;
        }

        /* Form Styling */
        .form-control, .form-select {
            border-radius: 10px;
            border: 1px solid #dee2e6;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            transform: translateY(-2px);
        }

        /* Modal Styling */
        .modal-header {
            border-radius: 15px 15px 0 0 !important;
        }

        .modal-header.bg-primary {
            background: var(--primary-gradient) !important;
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

        .text-primary { color: var(--primary-color) !important; }
        .text-success { color: var(--success-color) !important; }
        .text-danger { color: var(--danger-color) !important; }
        .text-warning { color: var(--warning-color) !important; }
        .text-info { color: var(--info-color) !important; }

        .border-primary { border-color: var(--primary-color) !important; }
        .border-success { border-color: var(--success-color) !important; }
        .border-warning { border-color: var(--warning-color) !important; }
        .border-danger { border-color: var(--danger-color) !important; }
        .border-info { border-color: var(--info-color) !important; }

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

            .welcome-header h2 {
                font-size: 2rem;
            }
        }

        /* Patient-specific styles */
        .patient-card:hover {
            transform: translateY(-5px);
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .required-field::after {
            content: " *";
            color: red;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="">
            <i class="fas fa-hospital-alt"></i>
            <span>Aurora Health Hospital</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="/receptionist/dashboard">
                        <i class="fas fa-th-large"></i>Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/receptionist/appointments">
                        <i class="fas fa-calendar-check"></i>Appointments
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="/receptionist/patients">
                        <i class="fas fa-users"></i>Patients
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/receptionist/admissions">
                        <i class="fas fa-procedures"></i>Admissions
                    </a>
                </li>
            </ul>
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item">
                    <span class="navbar-text">
                        <i class="fas fa-user-circle"></i>Welcome, ${username}!
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

<div class="container-fluid mt-4">
    <!-- Welcome Header with Background Image -->
    <div class="welcome-header">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h2 class="mb-1">
                    <i class="fas fa-users me-2"></i>Patient Management
                </h2>
                <p class="text-muted mb-0">Register and manage patient information</p>
            </div>
            <div class="col-md-4 text-end">
                <button class="btn btn-light" data-bs-toggle="modal" data-bs-target="#newPatientModal">
                    <i class="fas fa-user-plus me-2"></i>Register New Patient
                </button>
            </div>
        </div>
    </div>
    <!-- Success/Error Messages -->
    <c:if test="${not empty param.success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fas fa-check-circle me-2"></i>${param.success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:if test="${not empty param.error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fas fa-exclamation-circle me-2"></i>${param.error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Search and Filter -->
    <div class="card mb-4">
        <div class="card-body">
            <div class="row g-3">
                <div class="col-md-6">
                    <div class="input-group">
                    <span class="input-group-text">
                        <i class="fas fa-search"></i>
                    </span>
                        <input type="text" class="form-control" id="searchInput" placeholder="Search patients by name, phone, or email..." onkeyup="filterPatients()">
                    </div>
                </div>
                <div class="col-md-3">
                    <select class="form-select" id="genderFilter" onchange="filterPatients()">
                        <option value="">All Genders</option>
                        <option value="Male">Male</option>
                        <option value="Female">Female</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
<%--               --%>
            </div>
        </div>
    </div>

    <!-- Patients Grid -->
    <div class="row">
        <c:forEach var="patient" items="${patients}">
            <div class="col-xl-4 col-lg-6 col-md-6 mb-4">
                <div class="card patient-card h-100">
                    <div class="card-header bg-primary text-white">
                        <h6 class="mb-0">
                            <i class="fas fa-user me-2"></i>Patient #${patient.id}
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="text-center mb-3">
                            <div class="bg-primary rounded-circle d-inline-flex align-items-center justify-content-center"
                                 style="width: 80px; height: 80px;">
                                <i class="fas fa-user fa-2x text-white"></i>
                            </div>
                        </div>

                        <h5 class="card-title text-center">${patient.firstName} ${patient.lastName}</h5>

                        <div class="patient-info">
                            <div class="mb-2">
                                <strong><i class="fas fa-phone me-2 text-muted"></i></strong>
                                <span>${patient.contactNumber}</span>
                            </div>
                            <div class="mb-2">
                                <strong><i class="fas fa-envelope me-2 text-muted"></i></strong>
                                <span>${patient.email}</span>
                            </div>
                            <div class="mb-2">
                                <strong><i class="fas fa-venus-mars me-2 text-muted"></i></strong>
                                <span>${patient.gender}</span>
                            </div>
                            <div class="mb-2">
                                <strong><i class="fas fa-birthday-cake me-2 text-muted"></i></strong>
                                <span>${patient.dateOfBirth}</span>
                            </div>
                            <div>
                                <strong><i class="fas fa-map-marker-alt me-2 text-muted"></i></strong>
                                <small class="text-muted">${patient.address}</small>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer bg-transparent">
                        <div class="btn-group w-100">
                            <a href="/receptionist/patients/${patient.id}" class="btn btn-outline-primary btn-sm">
                                <i class="fas fa-eye me-1"></i>View
                            </a>
                            <a href="/receptionist/patients/edit/${patient.id}" class="btn btn-outline-success btn-sm">
                                <i class="fas fa-edit me-1"></i>Edit
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

        <c:if test="${empty patients}">
            <div class="col-12">
                <div class="card text-center py-5">
                    <div class="card-body">
                        <i class="fas fa-users fa-4x text-muted mb-4"></i>
                        <h4 class="text-muted">No Patients Registered</h4>
                        <p class="text-muted mb-4">Start by registering your first patient.</p>
                        <button class="btn btn-primary btn-lg" data-bs-toggle="modal" data-bs-target="#newPatientModal">
                            <i class="fas fa-user-plus me-2"></i>Register First Patient
                        </button>
                    </div>
                </div>
            </div>
        </c:if>
    </div>

    <!-- Pagination -->
    <c:if test="${not empty patients}">
        <div class="row mt-4">
            <div class="col-12">
                <nav>
                    <ul class="pagination justify-content-center">
                        <li class="page-item disabled">
                            <a class="page-link" href="#">Previous</a>
                        </li>
                        <li class="page-item active">
                            <a class="page-link" href="#">1</a>
                        </li>
                        <li class="page-item">
                            <a class="page-link" href="#">2</a>
                        </li>
                        <li class="page-item">
                            <a class="page-link" href="#">3</a>
                        </li>
                        <li class="page-item">
                            <a class="page-link" href="#">Next</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </c:if>
</div>

<!-- New Patient Modal -->
<div class="modal fade" id="newPatientModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title">
                    <i class="fas fa-user-plus me-2"></i>Register New Patient
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="/receptionist/patients/create" method="post" onsubmit="return validatePatientForm()">
                <div class="modal-body">
                    <div class="row g-3">
                        <!-- Personal Information -->
                        <div class="col-12">
                            <h6 class="border-bottom pb-2 text-primary">
                                <i class="fas fa-user me-2"></i>Personal Information
                            </h6>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label required-field">First Name</label>
                            <input type="text" class="form-control" name="firstName" required
                                   placeholder="Enter first name">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label required-field">Last Name</label>
                            <input type="text" class="form-control" name="lastName" required
                                   placeholder="Enter last name">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Date of Birth</label>
                            <input type="date" class="form-control" name="dateOfBirth">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Gender</label>
                            <select class="form-select" name="gender">
                                <option value="">Select Gender</option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>

                        <!-- Login Credentials -->
                        <div class="col-12 mt-3">
                            <h6 class="border-bottom pb-2 text-primary">
                                <i class="fas fa-key me-2"></i>Login Credentials
                            </h6>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label required-field">Username</label>
                            <input type="text" class="form-control" name="loginUsername" required
                                   placeholder="Choose unique username" id="usernameInput">
                            <div class="form-text">This will be used for patient login</div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label required-field">Password</label>
                            <input type="password" class="form-control" name="loginPassword" required
                                   placeholder="Set login password" id="passwordInput">
                            <div class="form-text">Minimum 6 characters</div>
                        </div>

                        <!-- Contact Information -->
                        <div class="col-12 mt-3">
                            <h6 class="border-bottom pb-2 text-primary">
                                <i class="fas fa-address-card me-2"></i>Contact Information
                            </h6>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label required-field">Contact Number</label>
                            <input type="tel" class="form-control" name="contactNumber" required
                                   placeholder="Phone number">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Email Address</label>
                            <input type="email" class="form-control" name="email"
                                   placeholder="patient@example.com">
                        </div>
                        <div class="col-12">
                            <label class="form-label">Address</label>
                            <textarea class="form-control" name="address" rows="3"
                                      placeholder="Enter full address"></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save me-2"></i>Register Patient
                    </button>
                </div>
            </form>
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
    // Store original patients data
    let originalPatients = [];

    // Initialize patients data when page loads
    document.addEventListener('DOMContentLoaded', function() {
        // Extract patient data from the current page
        const patientCards = document.querySelectorAll('.patient-card');
        originalPatients = Array.from(patientCards).map(card => {
            const title = card.querySelector('.card-title').textContent.trim();
            const contact = card.querySelector('.patient-info div:nth-child(1) span').textContent.trim();
            const email = card.querySelector('.patient-info div:nth-child(2) span').textContent.trim();
            const gender = card.querySelector('.patient-info div:nth-child(3) span').textContent.trim();

            return {
                element: card.parentElement,
                name: title,
                contact: contact,
                email: email,
                gender: gender
            };
        });
    });

    function filterPatients() {
        const searchTerm = document.getElementById('searchInput').value.toLowerCase();
        const genderFilter = document.getElementById('genderFilter').value;

        originalPatients.forEach(patient => {
            const matchesSearch = searchTerm === '' ||
                patient.name.toLowerCase().includes(searchTerm) ||
                patient.contact.includes(searchTerm) ||
                patient.email.toLowerCase().includes(searchTerm);

            const matchesGender = genderFilter === '' || patient.gender === genderFilter;

            if (matchesSearch && matchesGender) {
                patient.element.style.display = 'block';
            } else {
                patient.element.style.display = 'none';
            }
        });

        // Show/hide no results message
        const visiblePatients = document.querySelectorAll('.patient-card:not([style*="display: none"])');
        const noResultsDiv = document.querySelector('.no-results-message');

        if (visiblePatients.length === 0) {
            if (!noResultsDiv) {
                const noResultsHtml = `
                    <div class="col-12 no-results-message">
                        <div class="card text-center py-5">
                            <div class="card-body">
                                <i class="fas fa-search fa-4x text-muted mb-4"></i>
                                <h4 class="text-muted">No Patients Found</h4>
                                <p class="text-muted mb-4">Try adjusting your search criteria.</p>
                                <button class="btn btn-primary" onclick="clearFilters()">
                                    <i class="fas fa-times me-2"></i>Clear Filters
                                </button>
                            </div>
                        </div>
                    </div>
                `;
                document.querySelector('.row').insertAdjacentHTML('beforeend', noResultsHtml);
            }
        } else if (noResultsDiv) {
            noResultsDiv.remove();
        }
    }

    function sortPatients() {
        const sortValue = document.getElementById('sortFilter').value;
        const patientsContainer = document.querySelector('.row');
        const patientElements = Array.from(document.querySelectorAll('.col-xl-4.col-lg-6.col-md-6.mb-4'));

        if (sortValue === 'name') {
            patientElements.sort((a, b) => {
                const nameA = a.querySelector('.card-title').textContent.trim().toLowerCase();
                const nameB = b.querySelector('.card-title').textContent.trim().toLowerCase();
                return nameA.localeCompare(nameB);
            });
        } else if (sortValue === 'name_desc') {
            patientElements.sort((a, b) => {
                const nameA = a.querySelector('.card-title').textContent.trim().toLowerCase();
                const nameB = b.querySelector('.card-title').textContent.trim().toLowerCase();
                return nameB.localeCompare(nameA);
            });
        } else if (sortValue === 'recent') {
            // For "Most Recent", we'll assume newer patients have higher IDs
            // In a real implementation, you would sort by creation date
            patientElements.sort((a, b) => {
                const idA = parseInt(a.querySelector('.card-header h6').textContent.match(/\d+/)[0]);
                const idB = parseInt(b.querySelector('.card-header h6').textContent.match(/\d+/)[0]);
                return idB - idA;
            });
        }

        // Re-append sorted elements
        patientElements.forEach(element => {
            patientsContainer.appendChild(element);
        });
    }

    function clearFilters() {
        document.getElementById('searchInput').value = '';
        document.getElementById('genderFilter').value = '';
        document.getElementById('sortFilter').value = '';

        originalPatients.forEach(patient => {
            patient.element.style.display = 'block';
        });

        const noResultsDiv = document.querySelector('.no-results-message');
        if (noResultsDiv) {
            noResultsDiv.remove();
        }
    }

    // Enhanced Patient Form Validation
    function validatePatientForm() {
        const firstName = document.querySelector('input[name="firstName"]').value.trim();
        const lastName = document.querySelector('input[name="lastName"]').value.trim();
        const dateOfBirth = document.querySelector('input[name="dateOfBirth"]').value;
        const username = document.getElementById('usernameInput').value.trim();
        const password = document.getElementById('passwordInput').value;
        const contactNumber = document.querySelector('input[name="contactNumber"]').value.trim();

        let isValid = true;
        let errorMessage = '';

        // Name validation - only letters, spaces, and hyphens allowed
        const nameRegex = /^[A-Za-z\s\-']+$/;
        if (!nameRegex.test(firstName)) {
            isValid = false;
            errorMessage = 'First name can only contain letters, spaces, hyphens, and apostrophes.';
        } else if (!nameRegex.test(lastName)) {
            isValid = false;
            errorMessage = 'Last name can only contain letters, spaces, hyphens, and apostrophes.';
        }

        // Username validation - ONLY SIMPLE LETTERS allowed (no numbers, no special characters)
        const usernameRegex = /^[A-Za-z]+$/;
        if (username.length < 3) {
            isValid = false;
            errorMessage = 'Username must be at least 3 characters long.';
        } else if (!usernameRegex.test(username)) {
            isValid = false;
            errorMessage = 'Username can only contain simple letters (A-Z, a-z). No numbers or special characters allowed.';
        }

        // Password validation
        if (password.length < 6) {
            isValid = false;
            errorMessage = 'Password must be at least 6 characters long.';
        }

        // Phone number validation - only numbers, spaces, +, -, and parentheses allowed
        const phoneRegex = /^[\d\s\+\-\(\)]+$/;
        if (contactNumber && !phoneRegex.test(contactNumber)) {
            isValid = false;
            errorMessage = 'Phone number can only contain numbers, spaces, +, -, and parentheses.';
        }

        // Date of birth validation - cannot be in the future
        if (dateOfBirth) {
            const birthDate = new Date(dateOfBirth);
            const today = new Date();
            if (birthDate > today) {
                isValid = false;
                errorMessage = 'Date of birth cannot be in the future.';
            }

            // Additional validation: Age should be reasonable (between 0 and 120 years)
            const age = today.getFullYear() - birthDate.getFullYear();
            if (age < 0 || age > 120) {
                isValid = false;
                errorMessage = 'Please enter a valid date of birth.';
            }
        }

        if (!isValid) {
            alert(errorMessage);
            return false;
        }

        return true;
    }

    // Real-time validation for form fields
    function validateName(input) {
        const nameRegex = /^[A-Za-z\s\-']*$/;
        if (!nameRegex.test(input.value)) {
            input.classList.add('is-invalid');
            return false;
        } else {
            input.classList.remove('is-invalid');
            return true;
        }
    }

    function validateUsername(input) {
        // Username validation - ONLY SIMPLE LETTERS (no numbers, no special characters)
        const usernameRegex = /^[A-Za-z]*$/;
        if (input.value.length > 0 && (!usernameRegex.test(input.value) || input.value.length < 3)) {
            input.classList.add('is-invalid');
            return false;
        } else {
            input.classList.remove('is-invalid');
            return true;
        }
    }

    function validatePhone(input) {
        const phoneRegex = /^[\d\s\+\-\(\)]*$/;
        if (input.value.length > 0 && !phoneRegex.test(input.value)) {
            input.classList.add('is-invalid');
            return false;
        } else {
            input.classList.remove('is-invalid');
            return true;
        }
    }

    function validateBirthday(input) {
        if (input.value) {
            const birthDate = new Date(input.value);
            const today = new Date();
            if (birthDate > today) {
                input.classList.add('is-invalid');
                return false;
            }

            // Check for reasonable age
            const age = today.getFullYear() - birthDate.getFullYear();
            if (age < 0 || age > 120) {
                input.classList.add('is-invalid');
                return false;
            }
        }
        input.classList.remove('is-invalid');
        return true;
    }

    // Auto-close alerts after 5 seconds
    setTimeout(() => {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        });
    }, 5000);

    // Enter key search
    document.getElementById('searchInput').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            filterPatients();
        }
    });

    // Real-time validation event listeners
    document.addEventListener('DOMContentLoaded', function() {
        // Name validation
        const firstNameInput = document.querySelector('input[name="firstName"]');
        const lastNameInput = document.querySelector('input[name="lastName"]');

        if (firstNameInput) {
            firstNameInput.addEventListener('input', function() {
                validateName(this);
            });
        }

        if (lastNameInput) {
            lastNameInput.addEventListener('input', function() {
                validateName(this);
            });
        }

        // Username validation - ONLY SIMPLE LETTERS
        const usernameInput = document.getElementById('usernameInput');
        if (usernameInput) {
            usernameInput.addEventListener('input', function() {
                validateUsername(this);
            });

            // Also add help text to clarify username requirements
            const helpText = usernameInput.parentElement.querySelector('.form-text');
            if (helpText) {
                helpText.textContent = 'Username must contain only simple letters (A-Z, a-z) - no numbers or special characters';
            }
        }

        // Phone number validation
        const phoneInput = document.querySelector('input[name="contactNumber"]');
        if (phoneInput) {
            phoneInput.addEventListener('input', function() {
                validatePhone(this);
            });
        }

        // Birthday validation
        const birthdayInput = document.querySelector('input[name="dateOfBirth"]');
        if (birthdayInput) {
            birthdayInput.addEventListener('change', function() {
                validateBirthday(this);
            });
        }

        // Password validation
        const passwordInput = document.getElementById('passwordInput');
        if (passwordInput) {
            passwordInput.addEventListener('blur', function() {
                const password = this.value;
                if (password.length > 0 && password.length < 6) {
                    this.classList.add('is-invalid');
                } else {
                    this.classList.remove('is-invalid');
                }
            });
        }
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
</script>
</body>
</html>