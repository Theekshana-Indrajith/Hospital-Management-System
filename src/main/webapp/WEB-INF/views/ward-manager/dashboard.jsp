<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Ward Manager Dashboard - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap');

        /* Define CSS variables for ward manager theme - Emerald/Teal Theme */
        :root {
            --primary-gradient: linear-gradient(135deg, #0eae59 0%, #07b12e 100%);
            --success-gradient: linear-gradient(135deg, #27ae60 0%, #2ecc71 100%);
            --danger-gradient: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
            --warning-gradient: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);
            --info-gradient: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            --dark-gradient: linear-gradient(135deg, #2ecc71 0%, #27ae60 100%);
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

        /* Enhanced Navigation - Ward Manager Theme */
        .navbar {
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.98) 0%, rgba(248, 249, 250, 0.98) 100%) !important;
            backdrop-filter: blur(15px);
            box-shadow: 0 4px 30px rgba(46, 204, 113, 0.1);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            padding: 15px 0;
            border-bottom: 1px solid rgba(46, 204, 113, 0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .navbar.scrolled {
            background: linear-gradient(135deg, rgba(255, 255, 255, 1) 0%, rgba(248, 249, 250, 1) 100%) !important;
            padding: 10px 0;
            box-shadow: 0 8px 40px rgba(46, 204, 113, 0.15);
            border-bottom: 2px solid rgba(46, 204, 113, 0.2);
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, #2ecc71 0%, #27ae60 100%);
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
            background: linear-gradient(135deg, #2ecc71 0%, #27ae60 100%);
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
            background: linear-gradient(135deg, rgba(46, 204, 113, 0.1), rgba(39, 174, 96, 0.1));
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
            background: linear-gradient(90deg, #2ecc71, #27ae60);
            border-radius: 2px;
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }

        .nav-link:hover,
        .nav-link.active {
            color: #2ecc71 !important;
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
            background: linear-gradient(135deg, rgba(46, 204, 113, 0.1), rgba(39, 174, 96, 0.1));
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
        }

        .navbar-text:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(46, 204, 113, 0.2);
        }

        .navbar-text i {
            margin-right: 0.5rem;
            background: linear-gradient(135deg, #2ecc71 0%, #27ae60 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .nav-link[href="/logout"] {
            background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
            color: #fff !important;
            box-shadow: 0 4px 15px rgba(231, 76, 60, 0.3);
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
            box-shadow: 0 6px 25px rgba(231, 76, 60, 0.4);
            color: #fff !important;
        }

        .navbar-toggler {
            border: 2px solid #2ecc71;
            padding: 8px 12px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .navbar-toggler:hover {
            background: rgba(46, 204, 113, 0.1);
            transform: scale(1.05);
        }

        .navbar-toggler:focus {
            box-shadow: 0 0 0 0.25rem rgba(46, 204, 113, 0.25);
        }

        .navbar-toggler-icon {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba(46, 204, 113, 1)' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
        }

        /* Page Header Background Image - Ward Management Theme */
        .page-header {
            position: relative;
            background-image: url('https://images.unsplash.com/photo-1551601651-2a8555f1a136?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
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
            background: rgba(46, 204, 113, 0.7);
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

        /* Card Styling */
        .card {
            border: none;
            border-radius: 15px;
            background: var(--light-bg);
            backdrop-filter: blur(12px);
            box-shadow: var(--shadow);
            transition: transform 0.4s ease, box-shadow 0.4s ease;
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
        .card.bg-primary {
            background: var(--primary-gradient) !important;
            border: none;
        }

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

        /* Button Styling */
        .btn-outline-primary {
            border-color: rgba(46, 204, 113, 0.5);
            color: #2ecc71;
        }

        .btn-outline-primary:hover {
            background: var(--primary-gradient);
            color: #fff;
            border-color: var(--primary-gradient);
        }

        .btn-outline-success {
            border-color: rgba(39, 174, 96, 0.5);
            color: #27ae60;
        }

        .btn-outline-success:hover {
            background: var(--success-gradient);
            color: #fff;
            border-color: var(--success-gradient);
        }

        .btn-outline-info {
            border-color: rgba(52, 152, 219, 0.5);
            color: #3498db;
        }

        .btn-outline-info:hover {
            background: var(--info-gradient);
            color: #fff;
            border-color: var(--info-gradient);
        }

        .btn-outline-warning {
            border-color: rgba(243, 156, 18, 0.5);
            color: #f39c12;
        }

        .btn-outline-warning:hover {
            background: var(--warning-gradient);
            color: #fff;
            border-color: var(--warning-gradient);
        }

        .btn-outline-secondary {
            border-color: rgba(108, 117, 125, 0.5);
            color: #6c757d;
        }

        .btn-outline-secondary:hover {
            background: linear-gradient(135deg, #6c757d 0%, #868e96 100%);
            color: #fff;
            border-color: #6c757d;
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
        .table {
            border-radius: 10px;
            overflow: hidden;
        }

        .table thead th {
            background: var(--dark-gradient);
            color: white;
            border: none;
            font-weight: 600;
            padding: 1rem;
        }

        .table tbody tr {
            transition: all 0.3s ease;
        }

        .table tbody tr:hover {
            background-color: rgba(46, 204, 113, 0.05);
            transform: translateX(5px);
        }

        /* Footer Styling */
        footer {
            background: var(--dark-gradient) !important;
            color: #fff;
            position: relative;
            overflow: hidden;
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

        /* Custom Badge Colors */
        .bg-pink {
            background-color: #e83e8c !important;
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
        }
    </style>
</head>
<body>
<!-- Enhanced Navigation Bar -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="">
            <i class="fas fa-hospital-alt"></i>
            <span>Aurora Health - Ward Management</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link active" href="/ward-manager/dashboard">
                        <i class="fas fa-th-large"></i>Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/ward-manager/wards">
                        <i class="fas fa-procedures"></i>Manage Wards
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/ward-manager/beds">
                        <i class="fas fa-bed"></i>Manage Beds
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/ward-manager/admissions">
                        <i class="fas fa-hospital-user"></i>Admission Management
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/ward-manager/wards/available">
                        <i class="fas fa-list"></i>Available Wards
                    </a>
                </li>
            </ul>
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item">
                    <span class="navbar-text">
                        <i class="fas fa-user-circle"></i>Welcome, ${username} (Ward Manager)
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
                <h1 class="mb-1"><i class="fas fa-tachometer-alt me-2"></i>Ward Manager Dashboard</h1>
                <p class="text-muted">Manage hospital wards, beds, and admissions efficiently</p>
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
            <i class="fas fa-exclamation-triangle me-2"></i><strong>Error!</strong> ${param.error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Statistics Cards -->
    <div class="row mt-4">
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-primary">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h5>Total Wards</h5>
                            <h3>${totalWards}</h3>
                        </div>
                        <div class="align-self-center">
                            <i class="fas fa-procedures fa-2x"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-success">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h5>Total Beds</h5>
                            <h3>${totalBeds}</h3>
                        </div>
                        <div class="align-self-center">
                            <i class="fas fa-bed fa-2x"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-info">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h5>Available Beds</h5>
                            <h3>${availableBeds}</h3>
                        </div>
                        <div class="align-self-center">
                            <i class="fas fa-bed fa-2x"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-warning">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h5>Occupancy Rate</h5>
                            <h3>${occupancyRate}%</h3>
                        </div>
                        <div class="align-self-center">
                            <i class="fas fa-chart-pie fa-2x"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Ward Overview -->
    <div class="row mt-4">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="fas fa-list me-2"></i>Ward Overview</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead>
                            <tr>
                                <th>Ward Number</th>
                                <th>Type</th>
                                <th>Department</th>
                                <th>Total Beds</th>
                                <th>Available</th>
                                <th>Status</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="ward" items="${wards}">
                                <tr>
                                    <td><strong>${ward.wardNumber}</strong></td>
                                    <td>
                                            <span class="badge
                                                <c:choose>
                                                    <c:when test="${ward.wardType == 'ICU'}">bg-danger</c:when>
                                                    <c:when test="${ward.wardType == 'GENERAL'}">bg-primary</c:when>
                                                    <c:when test="${ward.wardType == 'PEDIATRIC'}">bg-info</c:when>
                                                    <c:when test="${ward.wardType == 'SURGICAL'}">bg-warning</c:when>
                                                    <c:when test="${ward.wardType == 'MATERNITY'}">bg-pink</c:when>
                                                    <c:otherwise>bg-secondary</c:otherwise>
                                                </c:choose>">
                                                    ${ward.wardType}
                                            </span>
                                    </td>
                                    <td>${ward.department.name}</td>
                                    <td>${ward.totalBeds}</td>
                                    <td>
                                            <span class="badge ${ward.availableBeds > 0 ? 'bg-success' : 'bg-danger'}">
                                                    ${ward.availableBeds}
                                            </span>
                                    </td>
                                    <td>
                                        <c:set var="wardOccupancy" value="${(ward.totalBeds - ward.availableBeds) / ward.totalBeds * 100}"/>
                                        <c:choose>
                                            <c:when test="${wardOccupancy >= 90}">
                                                <span class="badge bg-danger">Full</span>
                                            </c:when>
                                            <c:when test="${wardOccupancy >= 70}">
                                                <span class="badge bg-warning">Busy</span>
                                            </c:when>
                                            <c:when test="${wardOccupancy >= 50}">
                                                <span class="badge bg-info">Moderate</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-success">Available</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="col-md-4">
            <div class="card">
                <div class="card-header bg-success text-white">
                    <h5 class="mb-0"><i class="fas fa-bolt me-2"></i>Quick Actions</h5>
                </div>
                <div class="card-body">
                    <div class="d-grid gap-2">
                        <a href="/ward-manager/beds" class="btn btn-outline-success btn-lg">
                            <i class="fas fa-bed me-2"></i>Manage Beds
                        </a>
                        <a href="/ward-manager/wards/available" class="btn btn-outline-info btn-lg">
                            <i class="fas fa-list me-2"></i>Available Wards
                        </a>
                        <a href="/admissions" class="btn btn-outline-warning btn-lg">
                            <i class="fas fa-hospital me-2"></i>View Admissions
                        </a>
                        <a href="/ward-manager/wards" class="btn btn-outline-secondary btn-lg">
                            <i class="fas fa-plus-circle me-2"></i>Add New Ward
                        </a>
                    </div>
                </div>
            </div>

            <!-- Occupancy Chart -->
            <div class="card mt-3">
                <div class="card-header bg-info text-white">
                    <h5 class="mb-0"><i class="fas fa-chart-bar me-2"></i>Occupancy Overview</h5>
                </div>
                <div class="card-body">
                    <canvas id="occupancyChart" width="100%" height="200"></canvas>
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
    // Navbar scroll effect
    window.addEventListener('scroll', function() {
        const navbar = document.querySelector('.navbar');
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });

    // Occupancy Chart
    const ctx = document.getElementById('occupancyChart').getContext('2d');
    const occupancyChart = new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ['Occupied Beds', 'Available Beds'],
            datasets: [{
                data: [${totalBeds - availableBeds}, ${availableBeds}],
                backgroundColor: ['#e74c3c', '#2ecc71'],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'bottom'
                }
            }
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
</script>
</body>
</html>