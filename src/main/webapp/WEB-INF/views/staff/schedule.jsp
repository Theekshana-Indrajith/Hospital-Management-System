<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>My Schedule - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap');

        /* Define CSS variables for enhanced teal/green theme */
        :root {
            --primary-gradient: linear-gradient(135deg, #20c997 0%, #0d8b6c 100%);
            --success-gradient: linear-gradient(135deg, #38d39f 0%, #20c997 100%);
            --danger-gradient: linear-gradient(135deg, #ff6b6b 0%, #ff8e8e 100%);
            --warning-gradient: linear-gradient(135deg, #ffd93d 0%, #ff9a3d 100%);
            --info-gradient: linear-gradient(135deg, #17a2b8 0%, #138496 100%);
            --dark-gradient: linear-gradient(135deg, #20c997 0%, #0d8b6c 100%);
            --light-bg: rgba(255, 255, 255, 0.95);
            --shadow: 0 8px 32px rgba(0, 0, 0, 0.1);

            /* New color variables for better consistency */
            --primary-color: #20c997;
            --primary-dark: #1ba87e;
            --success-color: #38d39f;
            --danger-color: #ff6b6b;
            --warning-color: #ffd93d;
            --info-color: #17a2b8;
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
            background: linear-gradient(135deg, #f5f7fa 0%, #e3f2fd 100%);
            min-height: 100vh;
            overflow-x: hidden;
            position: relative;
        }

        /* Enhanced Navigation - Teal Theme */
        .navbar {
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.98) 0%, rgba(248, 249, 250, 0.98) 100%) !important;
            backdrop-filter: blur(15px);
            box-shadow: 0 4px 30px rgba(32, 201, 151, 0.1);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            padding: 15px 0;
            border-bottom: 1px solid rgba(32, 201, 151, 0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .navbar.scrolled {
            background: linear-gradient(135deg, rgba(255, 255, 255, 1) 0%, rgba(248, 249, 250, 1) 100%) !important;
            padding: 10px 0;
            box-shadow: 0 8px 40px rgba(32, 201, 151, 0.15);
            border-bottom: 2px solid rgba(32, 201, 151, 0.2);
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, #20c997 0%, #0d8b6c 100%);
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
            background: linear-gradient(135deg, #20c997 0%, #0d8b6c 100%);
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
            background: linear-gradient(135deg, rgba(32, 201, 151, 0.1), rgba(13, 139, 108, 0.1));
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
            background: linear-gradient(90deg, #20c997, #0d8b6c);
            border-radius: 2px;
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }

        .nav-link:hover,
        .nav-link.active {
            color: #20c997 !important;
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
            background: linear-gradient(135deg, rgba(32, 201, 151, 0.1), rgba(13, 139, 108, 0.1));
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
        }

        .navbar-text:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(32, 201, 151, 0.2);
        }

        .navbar-text i {
            margin-right: 0.5rem;
            background: linear-gradient(135deg, #20c997 0%, #0d8b6c 100%);
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
            border: 2px solid #20c997;
            padding: 8px 12px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .navbar-toggler:hover {
            background: rgba(32, 201, 151, 0.1);
            transform: scale(1.05);
        }

        .navbar-toggler:focus {
            box-shadow: 0 0 0 0.25rem rgba(32, 201, 151, 0.25);
        }

        .navbar-toggler-icon {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba(32, 201, 151, 1)' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
        }

        /* Welcome Header Background Image - Schedule Theme */
        .welcome-header {
            position: relative;
            background-image: url('https://images.unsplash.com/photo-1576091160399-112ba8d25d1f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1350&q=80');
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
            background: rgba(32, 201, 151, 0.7);
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
            box-shadow: 0 8px 20px rgba(32, 201, 151, 0.3);
            background: linear-gradient(135deg, #1ba87e 0%, #0c7a5d 100%);
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
            box-shadow: 0 8px 20px rgba(56, 211, 159, 0.3);
            background: linear-gradient(135deg, #32c191 0%, #1ba87e 100%);
        }

        .btn-outline-primary {
            border-color: rgba(32, 201, 151, 0.5);
            color: #20c997;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-outline-primary:hover {
            background: var(--primary-gradient);
            color: #fff;
            border-color: var(--primary-color);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(32, 201, 151, 0.3);
        }

        .btn-outline-success {
            border-color: rgba(56, 211, 159, 0.5);
            color: #38d39f;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-outline-success:hover {
            background: var(--success-gradient);
            color: #fff;
            border-color: var(--success-color);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(56, 211, 159, 0.3);
        }

        .btn-outline-info {
            border-color: rgba(23, 162, 184, 0.5);
            color: #17a2b8;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-outline-info:hover {
            background: var(--info-gradient);
            color: #fff;
            border-color: var(--info-color);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(23, 162, 184, 0.3);
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
            color: #20c997;
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

        /* Shift Card Styling */
        .shift-card {
            border-left: 4px solid;
            transition: all 0.3s ease;
            border-radius: 10px;
            background: var(--light-bg);
            backdrop-filter: blur(12px);
            box-shadow: var(--shadow);
        }

        .shift-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 40px rgba(0,0,0,0.15);
        }

        .shift-morning { border-left-color: #28a745; }
        .shift-evening { border-left-color: #ffc107; }
        .shift-night { border-left-color: #343a40; }

        .current-shift {
            background: linear-gradient(135deg, rgba(32, 201, 151, 0.1), rgba(13, 139, 108, 0.05));
            border: 2px solid var(--primary-color);
        }

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

        .card-hover:hover {
            transform: translateY(-5px);
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
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
                    <a class="nav-link" href="/staff/dashboard">
                        <i class="fas fa-th-large"></i>Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/staff/patients">
                        <i class="fas fa-users"></i>Patients
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/staff/wards">
                        <i class="fas fa-bed"></i>Wards
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="/staff/schedule">
                        <i class="fas fa-calendar-alt"></i>My Schedule
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/staff/prescriptions">
                        <i class="fas fa-prescription"></i>Prescriptions
                    </a>
                </li>
            </ul>
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item">
                    <span class="navbar-text">
                        <i class="fas fa-user-nurse"></i>Welcome, ${username}!
                    </span>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/staff/profile">
                        <i class="fas fa-user"></i>My Profile
                    </a>
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
                    <i class="fas fa-calendar-alt me-2"></i>My Nursing Schedule
                </h2>
                <p class="text-muted mb-0">View your assigned shifts and ward responsibilities</p>
            </div>
            <div class="col-md-4 text-end">
                <div class="btn-group">
                    <a href="/staff/dashboard" class="btn btn-light">
                        <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Staff Information -->
    <c:if test="${not empty staff}">
        <div class="card mb-4">
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <h4><i class="fas fa-user-nurse me-2 text-info"></i>${staff.firstName} ${staff.lastName}</h4>
                        <p class="mb-1"><strong>Staff ID:</strong> ${staff.employeeId}</p>
                        <p class="mb-1"><strong>Position:</strong> ${staff.staffType}</p>
                        <p class="mb-1"><strong>Department:</strong>
                            <c:if test="${not empty staff.department}">${staff.department.name}</c:if>
                            <c:if test="${empty staff.department}">Not assigned</c:if>
                        </p>
                    </div>
                    <div class="col-md-6">
                        <p class="mb-1"><strong>Preferred Shift:</strong>
                            <span class="badge bg-info">${staff.assignedShift}</span>
                        </p>
                        <p class="mb-1"><strong>Working Days:</strong> ${staff.workingDays}</p>
                        <p class="mb-0"><strong>Current Status:</strong>
                            <span class="badge bg-success">ACTIVE</span>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    <!-- Today's Shifts Section -->
    <div class="row">
        <div class="col-lg-6">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">
                        <i class="fas fa-calendar-day me-2"></i>Today's Shifts (${today})
                    </h4>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty todaysShifts}">
                            <c:forEach var="shift" items="${todaysShifts}">
                                <div class="card mb-3 shift-card
                                    <c:choose>
                                        <c:when test="${shift.shiftType == 'MORNING'}">shift-morning</c:when>
                                        <c:when test="${shift.shiftType == 'EVENING'}">shift-evening</c:when>
                                        <c:when test="${shift.shiftType == 'NIGHT'}">shift-night</c:when>
                                    </c:choose>">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-start">
                                            <div>
                                                <h5 class="card-title">
                                                    <span class="badge
                                                        <c:choose>
                                                            <c:when test="${shift.shiftType == 'MORNING'}">bg-success</c:when>
                                                            <c:when test="${shift.shiftType == 'EVENING'}">bg-warning text-dark</c:when>
                                                            <c:when test="${shift.shiftType == 'NIGHT'}">bg-dark</c:when>
                                                            <c:otherwise>bg-info</c:otherwise>
                                                        </c:choose>">
                                                        ${shift.shiftType} SHIFT
                                                    </span>
                                                </h5>
                                                <p class="card-text mb-1">
                                                    <i class="fas fa-hospital me-2 text-muted"></i>
                                                    <strong>Ward:</strong>
                                                    <c:if test="${not empty shift.ward}">
                                                        ${shift.ward.wardNumber} - ${shift.ward.wardType}
                                                    </c:if>
                                                    <c:if test="${empty shift.ward}">
                                                        Not assigned
                                                    </c:if>
                                                </p>
                                                <p class="card-text mb-1">
                                                    <i class="fas fa-clock me-2 text-muted"></i>
                                                    <strong>Time:</strong>
                                                    <c:if test="${not empty shift.startTime}">
                                                        ${shift.startTime} - ${shift.endTime}
                                                    </c:if>
                                                    <c:if test="${empty shift.startTime}">
                                                        ${staff.shiftStartTime} - ${staff.shiftEndTime}
                                                    </c:if>
                                                </p>
                                                <p class="card-text mb-1">
                                                    <i class="fas fa-tasks me-2 text-muted"></i>
                                                    <strong>Status:</strong>
                                                    <span class="badge
                                                        <c:choose>
                                                            <c:when test="${shift.status == 'SCHEDULED'}">bg-primary</c:when>
                                                            <c:when test="${shift.status == 'IN_PROGRESS'}">bg-success</c:when>
                                                            <c:when test="${shift.status == 'COMPLETED'}">bg-secondary</c:when>
                                                            <c:when test="${shift.status == 'CANCELLED'}">bg-danger</c:when>
                                                            <c:otherwise>bg-info</c:otherwise>
                                                        </c:choose>">
                                                            ${shift.status}
                                                    </span>
                                                </p>
                                            </div>
                                            <div class="text-end">
                                                <small class="text-muted">Shift Date</small>
                                                <br>
                                                <strong>${shift.scheduleDate}</strong>
                                            </div>
                                        </div>
                                        <c:if test="${not empty shift.notes}">
                                            <div class="mt-2 p-2 bg-light rounded">
                                                <small><strong>Notes:</strong> ${shift.notes}</small>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-4">
                                <i class="fas fa-calendar-times fa-3x text-muted mb-3"></i>
                                <h5>No Shifts Scheduled for Today</h5>
                                <p class="text-muted">You don't have any shifts scheduled for today.</p>
                                <p class="text-muted"><small>If this is incorrect, please contact the nursing administrator.</small></p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Weekly Schedule Section -->
        <div class="col-lg-6">
            <div class="card">
                <div class="card-header bg-success text-white">
                    <h4 class="mb-0">
                        <i class="fas fa-calendar-week me-2"></i>This Week's Schedule
                        <small class="float-end">${weekStart} to ${weekEnd}</small>
                    </h4>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty weeklySchedule}">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                    <tr>
                                        <th>Date</th>
                                        <th>Shift</th>
                                        <th>Ward</th>
                                        <th>Time</th>
                                        <th>Status</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="shift" items="${weeklySchedule}">
                                        <tr
                                                <c:if test="${shift.scheduleDate == today}">class="table-info"</c:if>
                                        >
                                            <td>
                                                <strong>${shift.scheduleDate}</strong>
                                                <c:if test="${shift.scheduleDate == today}">
                                                    <br><small class="text-primary">Today</small>
                                                </c:if>
                                            </td>
                                            <td>
                                                    <span class="badge
                                                        <c:choose>
                                                            <c:when test="${shift.shiftType == 'MORNING'}">bg-success</c:when>
                                                            <c:when test="${shift.shiftType == 'EVENING'}">bg-warning text-dark</c:when>
                                                            <c:when test="${shift.shiftType == 'NIGHT'}">bg-dark</c:when>
                                                            <c:otherwise>bg-info</c:otherwise>
                                                        </c:choose>">
                                                            ${shift.shiftType}
                                                    </span>
                                            </td>
                                            <td>
                                                <c:if test="${not empty shift.ward}">
                                                    ${shift.ward.wardNumber}
                                                </c:if>
                                                <c:if test="${empty shift.ward}">
                                                    <small class="text-muted">TBA</small>
                                                </c:if>
                                            </td>
                                            <td>
                                                <c:if test="${not empty shift.startTime}">
                                                    <small>${shift.startTime}</small>
                                                </c:if>
                                                <c:if test="${empty shift.startTime}">
                                                    <small class="text-muted">-</small>
                                                </c:if>
                                            </td>
                                            <td>
                                                    <span class="badge
                                                        <c:choose>
                                                            <c:when test="${shift.status == 'SCHEDULED'}">bg-primary</c:when>
                                                            <c:when test="${shift.status == 'IN_PROGRESS'}">bg-success</c:when>
                                                            <c:when test="${shift.status == 'COMPLETED'}">bg-secondary</c:when>
                                                            <c:when test="${shift.status == 'CANCELLED'}">bg-danger</c:when>
                                                            <c:otherwise>bg-info</c:otherwise>
                                                        </c:choose>">
                                                            ${shift.status}
                                                    </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-4">
                                <i class="fas fa-calendar-plus fa-3x text-muted mb-3"></i>
                                <h5>No Weekly Schedule Found</h5>
                                <p class="text-muted">Your weekly schedule hasn't been assigned yet.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
    </div>

    <!-- Help Section -->
    <div class="card mt-4">
        <div class="card-header bg-light">
            <h5 class="mb-0"><i class="fas fa-question-circle me-2 text-info"></i>Need Help?</h5>
        </div>
        <div class="card-body">
            <p>If you notice any issues with your schedule:</p>
            <ul>
                <li>Contact the Nursing Administrator for shift changes</li>
                <li>Report scheduling conflicts at least 48 hours in advance</li>
                <li>Check this page regularly for schedule updates</li>
            </ul>
            <p class="mb-0"><small class="text-muted">Last updated: <span id="currentTime"></span></small></p>
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
    // Update current time
    function updateTime() {
        const now = new Date();
        document.getElementById('currentTime').textContent = now.toLocaleString();
    }
    updateTime();
    setInterval(updateTime, 60000);

    // Navbar scroll effect
    window.addEventListener('scroll', function() {
        const navbar = document.querySelector('.navbar');
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });

    // Auto-close alerts after 5 seconds
    setTimeout(() => {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        });
    }, 5000);
</script>
</body>
</html>