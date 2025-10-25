<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>My Admissions - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        /* Importing Google Fonts for a clean, professional look */
        @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700;900&display=swap');
        @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&display=swap');

        /* Define CSS variables for consistent theming */
        :root {
            --primary-gradient: linear-gradient(135deg, #007bff 0%, #00d4ff 100%);
            --secondary-gradient: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            --success-gradient: linear-gradient(135deg, #28a745 0%, #71dd37 100%);
            --danger-gradient: linear-gradient(135deg, #dc3545 0%, #ff6b6b 100%);
            --warning-gradient: linear-gradient(135deg, #ffca28 0%, #ff8f00 100%);
            --info-gradient: linear-gradient(135deg, #17a2b8 0%, #00ddeb 100%);
            --dark-gradient: linear-gradient(135deg, #1e3a8a 0%, #3b82f6 100%);
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
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, #e0f2fe 0%, #bae6fd 100%);
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
            position: relative;
            overflow: hidden;
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
            font-weight: 600;
            padding: 1rem 1.5rem;
            border-bottom: none;
        }

        .card-header.bg-primary::before { background: var(--primary-gradient); }
        .card-header.bg-success::before { background: var(--success-gradient); }
        .card-header.bg-info::before { background: var(--info-gradient); }
        .card-header.bg-warning::before { background: var(--warning-gradient); }
        .card-header.bg-light::before { background: var(--light-bg); }

        /* Table Styling */
        .table {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(8px);
            border-radius: 10px;
            overflow: hidden;
        }

        .table th {
            background: var(--dark-gradient);
            color: #fff;
            font-weight: 600;
            border-bottom: 2px solid rgba(0, 123, 255, 0.2);
        }

        .table td {
            vertical-align: middle;
            border-bottom: 1px solid rgba(0, 123, 255, 0.1);
        }

        .table-hover tbody tr:hover {
            background: rgba(0, 123, 255, 0.05);
            transform: translateX(5px);
            transition: all 0.3s ease;
        }

        /* Button Styling */
        .btn-primary, .btn-secondary, .btn-info {
            border-radius: 25px;
            font-weight: 600;
            padding: 0.75rem 1.5rem;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .btn-primary {
            background: var(--primary-gradient);
            border: none;
        }

        .btn-secondary {
            background: var(--dark-gradient);
            border: none;
        }

        .btn-info {
            background: var(--info-gradient);
            border: none;
        }

        .btn-primary:hover, .btn-secondary:hover, .btn-info:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 123, 255, 0.3);
        }

        .btn-primary::before, .btn-secondary::before, .btn-info::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s ease;
        }

        .btn-primary:hover::before, .btn-secondary:hover::before, .btn-info:hover::before {
            left: 100%;
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

        .alert::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 6px;
            height: 100%;
            background: var(--success-gradient);
        }

        .alert i {
            animation: alertIcon 2s ease-in-out infinite;
        }

        @keyframes alertIcon {
            0%, 100% { transform: rotate(0deg); }
            25% { transform: rotate(10deg); }
            75% { transform: rotate(-10deg); }
        }

        /* Badge Styling */
        .badge {
            font-weight: 600;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            transition: transform 0.3s ease;
        }

        .badge.bg-primary { background: var(--primary-gradient); }
        .badge.bg-success { background: var(--success-gradient); }
        .badge.bg-info { background: var(--info-gradient); }
        .badge.bg-warning { background: var(--warning-gradient); }
        .badge.bg-secondary { background: var(--dark-gradient); }
        .badge.bg-light { background: var(--light-bg); color: #2c3e50; }

        .badge:hover {
            transform: scale(1.1);
        }

        /* Modal Styling */
        .modal-content {
            background: var(--light-bg);
            backdrop-filter: blur(12px);
            border: none;
            border-radius: 15px;
            box-shadow: var(--shadow);
        }

        .modal-header {
            border-bottom: none;
            position: relative;
        }

        .modal-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--primary-gradient);
        }

        .modal-footer {
            border-top: none;
        }

        .btn-close {
            filter: invert(1);
        }

        /* Footer Styling */
        footer {
            background: var(--dark-gradient) !important;
            color: #fff;
            position: relative;
            overflow: hidden;
            padding: 3rem 0;
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

        footer h5, footer h6 {
            font-family: 'Playfair Display', serif;
            font-weight: 700;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        footer p, footer a, footer li {
            color: #d1d5db;
            transition: color 0.3s ease;
        }

        footer a:hover {
            color: #fff;
            text-decoration: underline;
        }

        footer hr {
            border-color: rgba(255, 255, 255, 0.2);
        }

        footer .text-warning {
            background: var(--warning-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 10px;
        }

        ::-webkit-scrollbar-track {
            background: rgba(0, 0, 0, 0.05);
            border-radius: 10px;
        }

        ::-webkit-scrollbar-thumb {
            background: var(--primary-gradient);
            border-radius: 10px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: var(--secondary-gradient);
        }

        /* Fade-in Animation for Scroll */
        .fade-in {
            opacity: 0;
            transform: translateY(20px);
            transition: all 0.6s ease;
        }

        .fade-in.visible {
            opacity: 1;
            transform: translateY(0);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .page-header {
                padding: 1.5rem 0;
            }

            .page-header h2 {
                font-size: 1.8rem;
            }

            .page-header p {
                font-size: 1rem;
            }

            .card:hover {
                transform: translateY(-5px) scale(1.01);
            }

            .btn-primary, .btn-secondary, .btn-info {
                padding: 0.5rem 1rem;
                font-size: 0.9rem;
            }

            footer {
                padding: 2rem 0;
            }

            .table-responsive {
                font-size: 0.9rem;
            }

            .table th, .table td {
                padding: 0.5rem;
            }
        }

        @media (max-width: 576px) {
            .page-header h2 {
                font-size: 1.6rem;
            }

            .badge {
                font-size: 0.9rem;
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
                    <a class="nav-link" href="/patient/appointments">
                        <i class="fas fa-calendar-check"></i>My Appointments
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/patient/lab-tests">
                        <i class="fas fa-flask"></i>Lab Results
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="/patient/admissions">
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
                    <i class="fas fa-heartbeat me-2"></i>My Hospital Admissions
                </h1>
                <p class="lead mb-0">View your admission history and current status</p>
            </div>
            <div class="text-end">
                <span class="badge bg-success fs-6">Patient ID: ${patient.id}</span>
            </div>
        </div>
    </div>
</div>


<div class="container-fluid mt-4">
    <!-- Admission Statistics -->
    <div class="row mb-4">
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-primary fade-in">
                <div class="card-body text-center">
                    <i class="fas fa-procedures fa-2x text-primary mb-3"></i>
                    <h3 class="text-primary">${admissions.size()}</h3>
                    <p class="card-text">Total Admissions</p>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-success fade-in">
                <div class="card-body text-center">
                    <i class="fas fa-check-circle fa-2x text-success mb-3"></i>
                    <h3 class="text-success">
                        <c:set var="dischargedCount" value="0" />
                        <c:forEach var="admission" items="${admissions}">
                            <c:if test="${admission.status == 'DISCHARGED'}">
                                <c:set var="dischargedCount" value="${dischargedCount + 1}" />
                            </c:if>
                        </c:forEach>
                        ${dischargedCount}
                    </h3>
                    <p class="card-text">Completed</p>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-info fade-in">
                <div class="card-body text-center">
                    <i class="fas fa-bed fa-2x text-info mb-3"></i>
                    <h3 class="text-info">
                        <c:set var="admittedCount" value="0" />
                        <c:forEach var="admission" items="${admissions}">
                            <c:if test="${admission.status == 'ADMITTED'}">
                                <c:set var="admittedCount" value="${admittedCount + 1}" />
                            </c:if>
                        </c:forEach>
                        ${admittedCount}
                    </h3>
                    <p class="card-text">Current</p>
                </div>
            </div>
        </div>
<%--        <div class="col-xl-3 col-md-6 mb-4">--%>
<%--            <div class="card border-warning fade-in">--%>
<%--                <div class="card-body text-center">--%>
<%--                    <i class="fas fa-clock fa-2x text-warning mb-3"></i>--%>
<%--                    <h3 class="text-warning">--%>
<%--                        <c:set var="avgStay" value="0" />--%>
<%--                        <c:if test="${not empty admissions}">--%>
<%--                            <c:set var="totalDays" value="0" />--%>
<%--                            <c:set var="count" value="0" />--%>
<%--                            <c:forEach var="admission" items="${admissions}">--%>
<%--                                <c:if test="${admission.status == 'DISCHARGED' && admission.dischargeDate != null}">--%>
<%--                                    <c:set var="days" value="${java.time.temporal.ChronoUnit.DAYS.between(admission.admissionDate.toLocalDate(), admission.dischargeDate.toLocalDate())}" />--%>
<%--                                    <c:set var="totalDays" value="${totalDays + days}" />--%>
<%--                                    <c:set var="count" value="${count + 1}" />--%>
<%--                                </c:if>--%>
<%--                            </c:forEach>--%>
<%--                            <c:if test="${count > 0}">--%>
<%--                                <c:set var="avgStay" value="${totalDays / count}" />--%>
<%--                            </c:if>--%>
<%--                        </c:if>--%>
<%--                        <fmt:formatNumber value="${avgStay}" pattern="#.#"/> days--%>
<%--                    </h3>--%>
<%--                    <p class="card-text">Average Stay</p>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
    </div>

    <!-- Admission History -->
    <div class="card fade-in">
        <div class="card-header bg-light">
            <h5 class="mb-0">
                <i class="fas fa-list me-2"></i>Admission History
            </h5>
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty admissions}">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead class="table-dark">
                            <tr>
                                <th>Admission Date</th>
                                <th>Discharge Date</th>
                                <th>Ward & Bed</th>
                                <th>Reason</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="admission" items="${admissions}">
                                <tr>
                                    <td>${admission.admissionDate.toLocalDate()}</td>
                                    <td>
                                        <c:if test="${not empty admission.dischargeDate}">
                                            ${admission.dischargeDate.toLocalDate()}
                                        </c:if>
                                        <c:if test="${empty admission.dischargeDate}">
                                            <span class="text-muted">Not discharged</span>
                                        </c:if>
                                    </td>
                                    <td>
                                        <c:if test="${not empty admission.ward}">
                                            <strong>${admission.ward.wardNumber}</strong> - Bed ${admission.bed.bedNumber}<br>
                                            <small class="text-muted">${admission.ward.wardType}</small>
                                        </c:if>
                                        <c:if test="${empty admission.ward}">
                                            <span class="text-muted">Not assigned</span>
                                        </c:if>
                                    </td>
                                    <td>${admission.reason}</td>
                                    <td>
                                        <span class="badge
                                            <c:choose>
                                                <c:when test="${admission.status == 'ADMITTED'}">bg-success</c:when>
                                                <c:when test="${admission.status == 'DISCHARGED'}">bg-secondary</c:when>
                                                <c:when test="${admission.status == 'TRANSFERRED'}">bg-info</c:when>
                                                <c:otherwise>bg-warning</c:otherwise>
                                            </c:choose>">
                                                ${admission.status}
                                        </span>
                                    </td>
                                    <td>
                                        <!-- CHANGED: Link to details page instead of modal -->
                                        <a href="/patient/admissions/details/${admission.id}" class="btn btn-sm btn-info">
                                            <i class="fas fa-eye me-1"></i>View Details
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-5 text-muted fade-in">
                        <i class="fas fa-procedures fa-3x mb-3"></i>
                        <h4>No Admission History</h4>
                        <p class="mb-3">You have no previous hospital admissions.</p>
                        <p class="text-muted">Admissions will appear here when you are admitted to the hospital.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Current Admission Alert -->
    <c:if test="${not empty admissions}">
        <c:forEach var="admission" items="${admissions}">
            <c:if test="${admission.status == 'ADMITTED'}">
                <div class="alert alert-success mt-4 fade-in">
                    <h6><i class="fas fa-info-circle me-2"></i>Current Admission</h6>
                    <p class="mb-0">
                        You are currently admitted in <strong>${admission.ward.wardNumber}</strong>
                        (Bed ${admission.bed.bedNumber}) since ${admission.admissionDate.toLocalDate()}.
                    </p>
                </div>
            </c:if>
        </c:forEach>
    </c:if>
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
</script>
</body>
</html>