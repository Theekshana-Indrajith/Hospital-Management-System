<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>My Appointments - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        /* Importing Google Fonts */
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

            --primary-color: #667eea;
            --primary-dark: #5a6fd8;
            --success-color: #4facfe;
            --danger-color: #ff6b6b;
            --warning-color: #ffd93d;
            --info-color: #6a11cb;
            --light-color: #f8f9fa;
        }

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

        /* Enhanced Navigation - Matching Receptionist Style */
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

        /* Page Header with Background Image */
        .page-header {
            position: relative;
            background-image: url('https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80'); background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            padding: 2rem 1rem;
            border-radius: 15px;
            overflow: hidden;
            margin-bottom: 1.5rem;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(102, 126, 234, 0.7);
            z-index: 0;
        }

        .page-header > * {
            position: relative;
            z-index: 1;
            color: #fff;
        }

        .page-header h2 {
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

        .page-header .btn {
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
        }

        /* Card Styling */
        .card {
            border: none;
            border-radius: 15px;
            background: var(--light-bg);
            backdrop-filter: blur(12px);
            box-shadow: var(--shadow);
            transition: transform 0.4s ease, box-shadow 0.4s ease;
            margin-bottom: 2.5rem;
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

        .card-header.bg-secondary {
            background: var(--dark-gradient) !important;
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
        }

        .btn-warning {
            background: var(--warning-gradient);
            border: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-warning:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(255, 217, 61, 0.3);
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
            box-shadow: 0 8px 20px rgba(106, 17, 203, 0.3);
        }

        .btn-danger {
            background: var(--danger-gradient);
            border: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-danger:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(255, 107, 107, 0.3);
        }

        .btn-outline-primary, .btn-outline-success, .btn-outline-warning, .btn-outline-info {
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-outline-primary {
            border-color: rgba(102, 126, 234, 0.5);
            color: #667eea;
        }

        .btn-outline-primary:hover {
            background: var(--primary-gradient);
            color: #fff;
            transform: translateY(-3px);
        }

        .btn-outline-success {
            border-color: rgba(79, 172, 254, 0.5);
            color: #4facfe;
        }

        .btn-outline-success:hover {
            background: var(--success-gradient);
            color: #fff;
            transform: translateY(-3px);
        }

        .btn-outline-warning {
            border-color: rgba(255, 217, 61, 0.5);
            color: #ffd93d;
        }

        .btn-outline-warning:hover {
            background: var(--warning-gradient);
            color: #fff;
            transform: translateY(-3px);
        }

        .btn-outline-info {
            border-color: rgba(106, 17, 203, 0.5);
            color: #6a11cb;
        }

        .btn-outline-info:hover {
            background: var(--info-gradient);
            color: #fff;
            transform: translateY(-3px);
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

        .table-hover tbody tr:hover {
            background: rgba(102, 126, 234, 0.05);
        }

        /* Badge Styling */
        .badge {
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: 12px;
        }

        .bg-primary { background: var(--primary-color) !important; }
        .bg-success { background: var(--success-color) !important; }
        .bg-danger { background: var(--danger-color) !important; }
        .bg-warning { background: var(--warning-color) !important; }
        .bg-info { background: var(--info-color) !important; }
        .bg-secondary { background: #6c757d !important; }
        .bg-light { background: var(--light-color) !important; color: #495057 !important; }

        .text-primary { color: var(--primary-color) !important; }
        .text-success { color: var(--success-color) !important; }
        .text-danger { color: var(--danger-color) !important; }
        .text-warning { color: var(--warning-color) !important; }
        .text-info { color: var(--info-color) !important; }

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

        .reschedule-count {
            font-size: 0.7em;
            opacity: 0.8;
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

            .page-header h2 {
                font-size: 2rem;
            }
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
                    <a class="nav-link" href="/patient/dashboard">
                        <i class="fas fa-th-large"></i>Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/patient/profile">
                        <i class="fas fa-user"></i>My Profile
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="/patient/appointments">
                        <i class="fas fa-calendar-check"></i>My Appointments
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/patient/lab-tests">
                        <i class="fas fa-flask"></i>Lab Results
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/patient/admissions">
                        <i class="fas fa-procedures"></i>My Admissions
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/patient/medical-records">
                        <i class="fas fa-file-medical"></i>My Prescription
                    </a>
                </li>
            </ul>
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item">
                    <span class="navbar-text">
                        <i class="fas fa-user-circle"></i>Welcome, ${patient.firstName}!
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

<!-- Page Header -->
<div class="page-header fade-in">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h1 class="mb-1">
                    <i class="fas fa-heartbeat me-2"></i>My Appointments
                </h1>
                <p class="lead mb-0">Manage and view your medical appointments</p>
            </div>
            <div class="text-end">
                <a href="/patient/appointments/book" class="btn btn-success">
                    <i class="fas fa-calendar-plus me-2"></i>Book New Appointment
                </a>
            </div>
        </div>
    </div>
</div>

<div class="container-fluid mt-4">
    <!-- Success/Error Messages -->
    <c:if test="${not empty param.success}">
        <div class="alert alert-success alert-dismissible fade show fade-in" role="alert">
            <i class="fas fa-check-circle me-2"></i>${param.success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:if test="${not empty param.error}">
        <div class="alert alert-danger alert-dismissible fade show fade-in" role="alert">
            <i class="fas fa-exclamation-circle me-2"></i>${param.error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="row">
        <!-- Main Content -->
        <div class="col-lg-8 mb-4">
            <div class="card fade-in">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">
                        <i class="fas fa-history me-2"></i>Appointment History
                        <span class="badge bg-light text-primary ms-2">${appointments.size()} appointments</span>
                    </h5>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty appointments}">
                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <thead>
                                    <tr>
                                        <th>Appointment ID</th>
                                        <th>Date & Time</th>
                                        <th>Doctor</th>
                                        <th>Specialization</th>
                                        <th>Reason</th>
                                        <th>Status</th>
                                        <th>Payment</th>
                                        <th>Actions</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="appointment" items="${appointments}">
                                        <tr>
                                            <td>
                                                <strong>#ApID${appointment.id}</strong>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty appointment.appointmentDateTime}">
                                                        <strong>${appointment.appointmentDateTime.toLocalDate()}</strong><br>
                                                        <small class="text-muted">${appointment.appointmentDateTime.toLocalTime()}</small>
                                                        <c:if test="${not empty appointment.originalAppointmentDateTime}">
                                                            <br><small class="text-warning">
                                                            <i class="fas fa-history me-1"></i>
                                                            Rescheduled from ${appointment.originalAppointmentDateTime.toLocalDate()}
                                                        </small>
                                                        </c:if>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <strong>Date not set</strong><br>
                                                        <small class="text-muted">Time not set</small>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:if test="${not empty appointment.doctor}">
                                                    Dr. ${appointment.doctor.name}
                                                </c:if>
                                                <c:if test="${empty appointment.doctor}">
                                                    <span class="text-muted">Not assigned</span>
                                                </c:if>
                                            </td>
                                            <td>
                                                <c:if test="${not empty appointment.doctor}">
                                                    ${appointment.doctor.specialization}
                                                </c:if>
                                                <c:if test="${empty appointment.doctor}">
                                                    <span class="text-muted">-</span>
                                                </c:if>
                                            </td>
                                            <td>${appointment.reason}</td>
                                            <td>
                                                <span class="badge
                                                    <c:choose>
                                                        <c:when test="${appointment.status == 'PENDING_DOCTOR'}">bg-warning</c:when>
                                                        <c:when test="${appointment.status == 'SCHEDULED'}">bg-primary</c:when>
                                                        <c:when test="${appointment.status == 'COMPLETED'}">bg-success</c:when>
                                                        <c:when test="${appointment.status == 'CANCELLED'}">bg-danger</c:when>
                                                        <c:when test="${appointment.status == 'CONFIRMED'}">bg-info</c:when>
                                                        <c:otherwise>bg-secondary</c:otherwise>
                                                    </c:choose>">
                                                    <c:choose>
                                                        <c:when test="${appointment.status == 'PENDING_DOCTOR'}">PENDING DOCTOR</c:when>
                                                        <c:otherwise>${appointment.status}</c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </td>
                                            <td>
                                                <span class="badge
                                                    <c:choose>
                                                        <c:when test="${appointment.paymentStatus == 'PAID'}">bg-success</c:when>
                                                        <c:when test="${appointment.paymentStatus == 'PENDING'}">bg-warning</c:when>
                                                        <c:when test="${appointment.paymentStatus == 'FAILED'}">bg-danger</c:when>
                                                        <c:otherwise>bg-secondary</c:otherwise>
                                                    </c:choose>">
                                                        ${appointment.paymentStatus}
                                                </span>
                                                <c:if test="${not empty appointment.paymentMethod}">
                                                    <br>
                                                    <small class="
                                                        <c:choose>
                                                            <c:when test="${appointment.paymentMethod == 'ONLINE'}">text-primary</c:when>
                                                            <c:when test="${appointment.paymentMethod == 'MANUAL'}">text-info</c:when>
                                                            <c:otherwise>text-muted</c:otherwise>
                                                        </c:choose>">
                                                        <i class="fas
                                                            <c:choose>
                                                                <c:when test="${appointment.paymentMethod == 'ONLINE'}">fa-credit-card</c:when>
                                                                <c:when test="${appointment.paymentMethod == 'MANUAL'}">fa-money-bill-wave</c:when>
                                                                <c:otherwise>fa-question-circle</c:otherwise>
                                                            </c:choose> me-1">
                                                        </i>${appointment.paymentMethod}
                                                    </small>
                                                </c:if>
                                            </td>
                                            <td>
                                                <!-- PENDING_DOCTOR Status Actions -->
                                                <c:if test="${appointment.status == 'PENDING_DOCTOR'}">
                                                    <div class="btn-group-vertical btn-group-sm" role="group">
                                                        <!-- Reschedule Button - Available for BOTH PENDING_DOCTOR and SCHEDULED appointments -->
                                                        <a href="/patient/appointments/reschedule/${appointment.id}"
                                                           class="btn btn-warning btn-sm mb-1"
                                                           title="Reschedule Appointment">
                                                            <i class="fas fa-calendar-alt me-1"></i>Reschedule
                                                            <c:if test="${appointment.rescheduleCount > 0}">
                                                                <br><small class="reschedule-count">(${appointment.rescheduleCount}/2 used)</small>
                                                            </c:if>
                                                        </a>

                                                        <!-- Show payment button for online payment if not paid yet -->
                                                        <c:if test="${appointment.paymentMethod == 'ONLINE' && appointment.paymentStatus == 'PENDING'}">
                                                            <a href="/payments/online/${appointment.id}"
                                                               class="btn btn-primary btn-sm mb-1"
                                                               title="Pay Online">
                                                                <i class="fas fa-credit-card me-1"></i>Pay Online
                                                            </a>
                                                        </c:if>

                                                        <!-- Cancel button available for pending appointments -->
                                                        <form action="/patient/appointments/cancel" method="post" class="d-inline mb-1">
                                                            <input type="hidden" name="appointmentId" value="${appointment.id}">
                                                            <button type="submit"
                                                                    class="btn btn-danger btn-sm w-100"
                                                                    onclick="return confirm('Are you sure you want to cancel this appointment request?')"
                                                                    title="Cancel Appointment Request">
                                                                <i class="fas fa-times me-1"></i>Cancel Request
                                                            </button>
                                                        </form>
                                                    </div>
                                                </c:if>

                                                <!-- SCHEDULED Status Actions -->
                                                <c:if test="${appointment.status == 'SCHEDULED'}">
                                                    <div class="btn-group-vertical btn-group-sm" role="group">
                                                        <!-- Reschedule Button - Available for BOTH PENDING_DOCTOR and SCHEDULED appointments -->
                                                        <a href="/patient/appointments/reschedule/${appointment.id}"
                                                           class="btn btn-warning btn-sm mb-1"
                                                           title="Reschedule Appointment">
                                                            <i class="fas fa-calendar-alt me-1"></i>Reschedule
                                                            <c:if test="${appointment.rescheduleCount > 0}">
                                                                <br><small class="reschedule-count">(${appointment.rescheduleCount}/2 used)</small>
                                                            </c:if>
                                                        </a>

                                                        <!-- Online Payment Button - Only show for ONLINE payment method with PENDING status -->
                                                        <c:if test="${appointment.paymentMethod == 'ONLINE' && appointment.paymentStatus == 'PENDING'}">
                                                            <a href="/payments/online/${appointment.id}"
                                                               class="btn btn-primary btn-sm mb-1"
                                                               title="Pay Online">
                                                                <i class="fas fa-credit-card me-1"></i>Pay Online
                                                            </a>
                                                        </c:if>

                                                        <!-- Manual Payment Info - Show for manual payments with PENDING status -->
                                                        <c:if test="${appointment.paymentMethod == 'MANUAL' && appointment.paymentStatus == 'PENDING'}">
                                                            <span class="badge bg-info text-dark mb-1 p-2 d-block">
                                                                <i class="fas fa-money-bill-wave me-1"></i>Pay at Hospital
                                                            </span>
                                                        </c:if>

                                                        <!-- Cancel Button - Available for BOTH manual and online payment patients -->
                                                        <form action="/patient/appointments/cancel" method="post" class="d-inline mb-1">
                                                            <input type="hidden" name="appointmentId" value="${appointment.id}">
                                                            <button type="submit"
                                                                    class="btn btn-danger btn-sm w-100"
                                                                    onclick="return confirm('Are you sure you want to cancel this appointment?')"
                                                                    title="Cancel Appointment">
                                                                <i class="fas fa-times me-1"></i>Cancel
                                                            </button>
                                                        </form>
                                                    </div>
                                                </c:if>

                                                <!-- Other Statuses -->
                                                <c:if test="${appointment.status != 'PENDING_DOCTOR' && appointment.status != 'SCHEDULED'}">
                                                    <span class="text-muted small">
                                                        <c:choose>
                                                            <c:when test="${appointment.status == 'COMPLETED'}">
                                                                <i class="fas fa-check-circle text-success me-1"></i>Completed
                                                            </c:when>
                                                            <c:when test="${appointment.status == 'CANCELLED'}">
                                                                <i class="fas fa-times-circle text-danger me-1"></i>Cancelled
                                                            </c:when>
                                                            <c:otherwise>
                                                                No actions available<br>
                                                                <small>Status: ${appointment.status}</small>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-5 text-muted fade-in">
                                <i class="fas fa-calendar-times fa-3x mb-3"></i>
                                <h4>No Appointments Found</h4>
                                <p class="mb-3">You haven't booked any appointments yet.</p>
                                <a href="/patient/appointments/book" class="btn btn-primary">
                                    <i class="fas fa-calendar-plus me-2"></i>Book Your First Appointment
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Sidebar -->
        <div class="col-lg-4">
            <!-- Upcoming Appointments Card -->
            <div class="card fade-in mb-4">
                <div class="card-header bg-success text-white">
                    <h5 class="mb-0">
                        <i class="fas fa-clock me-2"></i>Upcoming Appointments
                    </h5>
                </div>
                <div class="card-body">
                    <c:set var="now" value="<%= java.time.LocalDateTime.now() %>" />
                    <c:set var="upcomingAppointmentsCount" value="0" />

                    <c:forEach var="appointment" items="${appointments}">
                        <c:if test="${(appointment.status == 'SCHEDULED' || appointment.status == 'PENDING_DOCTOR') &&
                                    not empty appointment.appointmentDateTime &&
                                    appointment.appointmentDateTime.isAfter(now)}">
                            <c:set var="upcomingAppointmentsCount" value="${upcomingAppointmentsCount + 1}" />
                        </c:if>
                    </c:forEach>

                    <c:choose>
                        <c:when test="${upcomingAppointmentsCount > 0}">
                            <div class="list-group list-group-flush">
                                <c:forEach var="appointment" items="${appointments}">
                                    <c:if test="${(appointment.status == 'SCHEDULED' || appointment.status == 'PENDING_DOCTOR') &&
                                                not empty appointment.appointmentDateTime &&
                                                appointment.appointmentDateTime.isAfter(now)}">
                                        <div class="list-group-item px-0 border-bottom">
                                            <div class="d-flex w-100 justify-content-between">
                                                <h6 class="mb-1">
                                                    <c:choose>
                                                        <c:when test="${not empty appointment.doctor}">
                                                            Dr. ${appointment.doctor.name}
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">Doctor not assigned</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </h6>
                                                <small class="text-muted">
                                                    <c:if test="${not empty appointment.appointmentDateTime}">
                                                        ${appointment.appointmentDateTime.toLocalTime()}
                                                    </c:if>
                                                </small>
                                            </div>
                                            <p class="mb-1 small">
                                                <c:if test="${not empty appointment.doctor}">
                                                    ${appointment.doctor.specialization}
                                                </c:if>
                                            </p>
                                            <small class="text-muted">
                                                <c:if test="${not empty appointment.appointmentDateTime}">
                                                    ${appointment.appointmentDateTime.toLocalDate()}
                                                </c:if>
                                            </small>
                                            <div class="mt-2">
                                                <span class="badge
                                                    <c:choose>
                                                        <c:when test="${appointment.paymentMethod == 'ONLINE'}">bg-primary</c:when>
                                                        <c:when test="${appointment.paymentMethod == 'MANUAL'}">bg-info</c:when>
                                                        <c:otherwise>bg-secondary</c:otherwise>
                                                    </c:choose>">
                                                        ${appointment.paymentMethod}
                                                </span>
                                                <span class="badge
                                                    <c:choose>
                                                        <c:when test="${appointment.paymentStatus == 'PAID'}">bg-success</c:when>
                                                        <c:when test="${appointment.paymentStatus == 'PENDING'}">bg-warning</c:when>
                                                        <c:otherwise>bg-secondary</c:otherwise>
                                                    </c:choose>">
                                                        ${appointment.paymentStatus}
                                                </span>
                                                <span class="badge
                                                    <c:choose>
                                                        <c:when test="${appointment.status == 'PENDING_DOCTOR'}">bg-warning</c:when>
                                                        <c:when test="${appointment.status == 'SCHEDULED'}">bg-primary</c:when>
                                                        <c:otherwise>bg-secondary</c:otherwise>
                                                    </c:choose>">
                                                        ${appointment.status}
                                                </span>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p class="text-muted mb-0">No upcoming appointments scheduled.</p>
                            <a href="/patient/appointments/book" class="btn btn-outline-success btn-sm mt-2">
                                <i class="fas fa-calendar-plus me-1"></i>Book Now
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Quick Actions Card -->
            <div class="card fade-in mb-4">
                <div class="card-header bg-info text-white">
                    <h5 class="mb-0">
                        <i class="fas fa-bolt me-2"></i>Quick Actions
                    </h5>
                </div>
                <div class="card-body">
                    <div class="d-grid gap-2">
                        <a href="/patient/appointments/book" class="btn btn-outline-primary text-start">
                            <i class="fas fa-calendar-plus me-2"></i>Book New Appointment
                        </a>

                        <!-- Check if there are any pending or scheduled appointments for reschedule option -->
                        <c:set var="hasReschedulableAppointments" value="false" />
                        <c:forEach var="appointment" items="${appointments}">
                            <c:if test="${appointment.status == 'SCHEDULED' || appointment.status == 'PENDING_DOCTOR'}">
                                <c:set var="hasReschedulableAppointments" value="true" />
                            </c:if>
                        </c:forEach>

                        <c:if test="${hasReschedulableAppointments}">
                            <a href="/patient/appointments" class="btn btn-outline-warning text-start">
                                <i class="fas fa-calendar-alt me-2"></i>Reschedule Appointment
                            </a>
                        </c:if>

                        <a href="/patient/lab-tests" class="btn btn-outline-success text-start">
                            <i class="fas fa-flask me-2"></i>View Lab Results
                        </a>
                        <a href="/patient/medical-records" class="btn btn-outline-secondary text-start">
                            <i class="fas fa-file-medical me-2"></i>My Prescription
                        </a>
                    </div>
                </div>
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
    // Auto-close alerts after 5 seconds
    setTimeout(() => {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        });
    }, 5000);

    // Scroll effect for navbar
    window.addEventListener('scroll', () => {
        const navbar = document.querySelector('.navbar');
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });

    // Fade-in animations
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
            }
        });
    }, observerOptions);

    document.querySelectorAll('.fade-in').forEach(element => {
        observer.observe(element);
    });

    // Enhanced confirmation for cancellation
    document.addEventListener('DOMContentLoaded', function() {
        const cancelButtons = document.querySelectorAll('form[action*="/cancel"] button');
        cancelButtons.forEach(button => {
            button.addEventListener('click', function(e) {
                if (!confirm('Are you sure you want to cancel this appointment? This action cannot be undone.')) {
                    e.preventDefault();
                }
            });
        });
    });
</script>
</body>
</html>