<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>My Profile - HMS</title>
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
            background-image: url('https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80');
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

        /* Profile Header Styling */
        .profile-header {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            background-blend-mode: overlay;
            backdrop-filter: blur(12px);
            padding: 2rem 0;
            margin-bottom: 2rem;
            box-shadow: var(--shadow);
            position: relative;
            overflow: hidden;
        }

        .profile-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle fill="rgba(0,123,255,0.05)" cx="50" cy="50" r="3"/></svg>');
            background-size: 25px 25px;
            animation: bgMove 15s linear infinite;
        }

        @keyframes bgMove {
            0% { transform: translate(0, 0); }
            100% { transform: translate(25px, 25px); }
        }

        .profile-pic {
            border-radius: 50%;
            border: 3px solid var(--primary-gradient);
            box-shadow: 0 4px 12px rgba(0, 123, 255, 0.3);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .profile-pic:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 20px rgba(0, 123, 255, 0.4);
        }

        .profile-header h1 {
            font-family: 'Playfair Display', serif;
            font-weight: 700;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 0.5rem;
            position: relative;
        }

        .profile-header h1::after {
            content: '';
            position: absolute;
            bottom: -4px;
            left: 0;
            width: 0;
            height: 3px;
            background: var(--primary-gradient);
            transition: width 0.5s ease;
        }

        .profile-header:hover h1::after {
            width: 100%;
        }

        .profile-header p {
            font-size: 1.1rem;
            color: #2c3e50;
        }

        .profile-header .badge {
            font-weight: 600;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            background: var(--success-gradient);
            color: #fff;
            transition: transform 0.3s ease;
        }

        .profile-header .badge:hover {
            transform: scale(1.1);
        }

        /* Profile Card Styling */
        .profile-card {
            border: none;
            border-radius: 15px;
            background: var(--light-bg);
            backdrop-filter: blur(12px);
            box-shadow: var(--shadow);
            transition: transform 0.4s ease, box-shadow 0.4s ease;
            position: relative;
            overflow: hidden;
        }

        .profile-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
        }

        .profile-card::before {
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

        .profile-card:hover::before {
            transform: scaleX(1);
        }

        .profile-card .card-header {
            font-weight: 600;
            padding: 1rem 1.5rem;
            border-bottom: none;
        }

        .profile-card .card-header.bg-primary::before { background: var(--primary-gradient); }
        .profile-card .card-header.bg-success::before { background: var(--success-gradient); }
        .profile-card .card-header.bg-info::before { background: var(--info-gradient); }
        .profile-card .card-header.bg-warning::before { background: var(--warning-gradient); }
        .profile-card .card-header.bg-danger::before { background: var(--danger-gradient); }

        /* Form Styling */
        .form-control, .form-select {
            border-radius: 10px;
            border: 2px solid rgba(0, 123, 255, 0.2);
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(8px);
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-gradient);
            box-shadow: 0 0 8px rgba(0, 123, 255, 0.3);
            background: #fff;
        }

        .form-label {
            font-weight: 500;
            color: #2c3e50;
            margin-bottom: 0.5rem;
        }

        .form-control::placeholder {
            color: #6c757d;
            opacity: 0.7;
        }

        /* Button Styling */
        .btn-primary, .btn-outline-primary, .btn-outline-info, .btn-outline-warning, .btn-outline-success {
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

        .btn-outline-primary {
            border: 2px solid var(--primary-gradient);
            color: #007bff;
        }

        .btn-outline-info {
            border: 2px solid var(--info-gradient);
            color: #17a2b8;
        }

        .btn-outline-warning {
            border: 2px solid var(--warning-gradient);
            color: #ffca28;
        }

        .btn-outline-success {
            border: 2px solid var(--success-gradient);
            color: #28a745;
        }

        .btn-primary:hover, .btn-outline-primary:hover, .btn-outline-info:hover, .btn-outline-warning:hover, .btn-outline-success:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 123, 255, 0.3);
        }

        .btn-primary::before, .btn-outline-primary::before, .btn-outline-info::before, .btn-outline-warning::before, .btn-outline-success::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s ease;
        }

        .btn-primary:hover::before, .btn-outline-primary:hover::before, .btn-outline-info:hover::before, .btn-outline-warning:hover::before, .btn-outline-success:hover::before {
            left: 100%;
        }

        .btn-secondary {
            background: var(--dark-gradient);
            border: none;
            border-radius: 25px;
            color: #fff;
        }

        .btn-secondary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
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
        }

        .alert-success::before { background: var(--success-gradient); }
        .alert-danger::before { background: var(--danger-gradient); }
        .alert-warning::before { background: var(--warning-gradient); }

        .alert i {
            animation: alertIcon 2s ease-in-out infinite;
        }

        @keyframes alertIcon {
            0%, 100% { transform: rotate(0deg); }
            25% { transform: rotate(10deg); }
            75% { transform: rotate(-10deg); }
        }

        /* Medical Summary and Quick Actions */
        .card-body .d-flex {
            transition: transform 0.3s ease;
        }

        .card-body .d-flex:hover {
            transform: translateX(8px);
        }

        .card-body strong.text-primary, .card-body strong.text-success, .card-body strong.text-warning, .card-body strong.text-danger {
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .card-body strong.text-success { background: var(--success-gradient); }
        .card-body strong.text-warning { background: var(--warning-gradient); }
        .card-body strong.text-danger { background: var(--danger-gradient); }

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
            .profile-header {
                padding: 1.5rem 0;
            }

            .profile-pic {
                width: 100px;
                height: 100px;
            }

            .profile-header h1 {
                font-size: 1.8rem;
            }

            .profile-header p {
                font-size: 1rem;
            }

            .profile-card:hover {
                transform: translateY(-5px) scale(1.01);
            }

            .btn-primary, .btn-outline-primary, .btn-outline-info, .btn-outline-warning, .btn-outline-success, .btn-secondary {
                padding: 0.5rem 1rem;
                font-size: 0.9rem;
            }

            footer {
                padding: 2rem 0;
            }
        }

        @media (max-width: 576px) {
            .profile-header h1 {
                font-size: 1.6rem;
            }

            .profile-pic {
                width: 80px;
                height: 80px;
            }

            .profile-header .badge {
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
                    <a class="nav-link active" href="/patient/profile">
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
                        <i class="fas fa-user-circle"></i>Welcome,
                        <c:choose>
                            <c:when test="${not empty patient and not empty patient.firstName}">
                                ${patient.firstName}!
                            </c:when>
                            <c:otherwise>
                                Patient!
                            </c:otherwise>
                        </c:choose>
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
            <div class="col-md-2">
                <c:set var="patientName" value="${not empty patient ? patient.firstName : 'Patient'}" />
                <c:set var="patientLastName" value="${not empty patient ? patient.lastName : ''}" />
                <img src="https://ui-avatars.com/api/?name=${patientName}+${patientLastName}&background=007bff&color=fff&size=150"
                     alt="Profile" class="profile-pic">
            </div>
            <div class="col-md-8 text-start">
                <h1>${patientName} ${patientLastName}</h1>
                <p class="mb-0">
                    Patient ID:
                    <c:choose>
                        <c:when test="${not empty patient and not empty patient.id}">
                            ${patient.id}
                        </c:when>
                        <c:otherwise>
                            N/A
                        </c:otherwise>
                    </c:choose>
                    | Member since 2025
                </p>
            </div>
            <div class="col-md-2">
                <span class="badge bg-success fs-6">Active Patient</span>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <!-- Success Message -->
    <c:if test="${not empty param.success}">
        <div class="alert alert-success alert-dismissible fade show fade-in" role="alert">
            <i class="fas fa-check-circle me-2"></i><strong>Success!</strong> Your profile has been updated successfully.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="row">
        <!-- Personal Information -->
        <div class="col-md-8">
            <div class="card profile-card fade-in">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">Personal Information</h5>
                </div>
                <div class="card-body">
                    <form id="profileForm" action="/patient/profile/update" method="post" onsubmit="return validateForm()">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">First Name <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="firstName" id="firstName"
                                           value="${not empty patient ? patient.firstName : ''}" required maxlength="50"
                                           pattern="[A-Za-z\s]{2,}" title="First name must be at least 2 characters long and contain only letters">
                                    <div class="invalid-feedback" id="firstNameError">
                                        Please enter a valid first name (minimum 2 letters, no numbers or special characters)
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Last Name <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="lastName" id="lastName"
                                           value="${not empty patient ? patient.lastName : ''}" required maxlength="50"
                                           pattern="[A-Za-z\s]{2,}" title="Last name must be at least 2 characters long and contain only letters">
                                    <div class="invalid-feedback" id="lastNameError">
                                        Please enter a valid last name (minimum 2 letters, no numbers or special characters)
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Date of Birth <span class="text-danger">*</span></label>
                                    <input type="date" class="form-control" name="dateOfBirth" id="dateOfBirth"
                                           value="${not empty patient ? patient.dateOfBirth : ''}" required>
                                    <div class="invalid-feedback" id="dobError">
                                        Please select a valid date of birth (must be at least 1 year old and not in the future)
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Gender <span class="text-danger">*</span></label>
                                    <select class="form-select" name="gender" id="gender" required>
                                        <option value="">Select Gender</option>
                                        <option value="Male" ${not empty patient and patient.gender == 'Male' ? 'selected' : ''}>Male</option>
                                        <option value="Female" ${not empty patient and patient.gender == 'Female' ? 'selected' : ''}>Female</option>
                                        <option value="Other" ${not empty patient and patient.gender == 'Other' ? 'selected' : ''}>Other</option>
                                    </select>
                                    <div class="invalid-feedback" id="genderError">
                                        Please select your gender
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Email Address <span class="text-danger">*</span></label>
                            <input type="email" class="form-control" name="email" id="email"
                                   value="${not empty patient ? patient.email : ''}" required maxlength="100"
                                   pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                                   title="Please enter a valid email address">
                            <div class="invalid-feedback" id="emailError">
                                Please enter a valid email address (e.g., name@example.com)
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Contact Number <span class="text-danger">*</span></label>
                            <input type="tel" class="form-control" name="contactNumber" id="contactNumber"
                                   value="${not empty patient ? patient.contactNumber : ''}" required
                                   pattern="[\+]?94\d{9}|\d{10}"
                                   title="Please enter a valid phone number (10 digits or +94 followed by 9 digits)"
                                   placeholder="+94XXXXXXXXX or 07XXXXXXXX">
                            <div class="invalid-feedback" id="contactError">
                                Please enter a valid phone number (10 digits)
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Address <span class="text-danger">*</span></label>
                            <textarea class="form-control" name="address" id="address" rows="3" required
                                      maxlength="255" placeholder="Enter your full address">${not empty patient ? patient.address : ''}</textarea>
                            <div class="invalid-feedback" id="addressError">
                                Please enter your complete address (maximum 255 characters)
                            </div>
                        </div>

                        <!-- Emergency Contact Information -->
                        <div class="row mt-4">
                            <div class="col-12">
                                <h6 class="border-bottom pb-2">Emergency Contact Information</h6>
                            </div>
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="form-label">Emergency Contact Name <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="emergencyContactName" id="emergencyContactName"
                                           value="${not empty patient ? patient.emergencyContactName : ''}" required maxlength="50"
                                           pattern="^(?!.*\.\.)(?!.*\.$)(?!^\.)[A-Za-z\.\s]{2,50}$"
                                           title="Name must be 2-50 characters, can contain letters, spaces, and single dots (but not consecutive dots or ending with dot)"
                                           placeholder="Enter Name">
                                    <div class="invalid-feedback" id="emergencyNameError">
                                        Please enter emergency contact name (minimum 2 letters)
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="form-label">Relationship <span class="text-danger">*</span></label>
                                    <select class="form-select" name="emergencyContactRelationship" id="emergencyContactRelationship" required>
                                        <option value="">Select Relationship</option>
                                        <option value="Spouse" ${not empty patient and patient.emergencyContactRelationship == 'Spouse' ? 'selected' : ''}>Spouse</option>
                                        <option value="Parent" ${not empty patient and patient.emergencyContactRelationship == 'Parent' ? 'selected' : ''}>Parent</option>
                                        <option value="Child" ${not empty patient and patient.emergencyContactRelationship == 'Child' ? 'selected' : ''}>Child</option>
                                        <option value="Sibling" ${not empty patient and patient.emergencyContactRelationship == 'Sibling' ? 'selected' : ''}>Sibling</option>
                                        <option value="Friend" ${not empty patient and patient.emergencyContactRelationship == 'Friend' ? 'selected' : ''}>Friend</option>
                                        <option value="Other" ${not empty patient and patient.emergencyContactRelationship == 'Other' ? 'selected' : ''}>Other</option>
                                    </select>
                                    <div class="invalid-feedback" id="emergencyRelationshipError">
                                        Please select relationship with emergency contact
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="form-label">Emergency Contact Phone <span class="text-danger">*</span></label>
                                    <input type="tel" class="form-control" name="emergencyContactPhone" id="emergencyContactPhone"
                                           value="${not empty patient ? patient.emergencyContactPhone : ''}" required
                                           pattern="[\+]?94\d{9}|\d{10}"
                                           title="Please enter a valid phone number (10 digits or +94 followed by 9 digits)"
                                           placeholder="+94XXXXXXXXX or 07XXXXXXXX">
                                    <div class="invalid-feedback" id="emergencyPhoneError">
                                        Please enter a valid emergency contact phone number
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Medical Information -->
                        <div class="row mt-4">
                            <div class="col-12">
                                <h6 class="border-bottom pb-2">Medical Information</h6>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Blood Type <span class="text-danger">*</span></label>
                                    <select class="form-select" name="bloodType" id="bloodType" required>
                                        <option value="">Select Blood Type</option>
                                        <option value="A+" ${not empty patient and patient.bloodType == 'A+' ? 'selected' : ''}>A+</option>
                                        <option value="A-" ${not empty patient and patient.bloodType == 'A-' ? 'selected' : ''}>A-</option>
                                        <option value="B+" ${not empty patient and patient.bloodType == 'B+' ? 'selected' : ''}>B+</option>
                                        <option value="B-" ${not empty patient and patient.bloodType == 'B-' ? 'selected' : ''}>B-</option>
                                        <option value="AB+" ${not empty patient and patient.bloodType == 'AB+' ? 'selected' : ''}>AB+</option>
                                        <option value="AB-" ${not empty patient and patient.bloodType == 'AB-' ? 'selected' : ''}>AB-</option>
                                        <option value="O+" ${not empty patient and patient.bloodType == 'O+' ? 'selected' : ''}>O+</option>
                                        <option value="O-" ${not empty patient and patient.bloodType == 'O-' ? 'selected' : ''}>O-</option>
                                    </select>
                                    <div class="invalid-feedback" id="bloodTypeError">
                                        Please select your blood type
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Allergies</label>
                                    <textarea class="form-control" name="allergies" id="allergies" rows="3"
                                              maxlength="500"
                                              placeholder="List any allergies (e.g., Penicillin, Peanuts, etc.)">${not empty patient ? patient.allergies : ''}</textarea>
                                    <div class="form-text">Separate multiple allergies with commas (maximum 500 characters)</div>
                                </div>
                            </div>
                        </div>

                        <!-- Hidden ID field for update -->
                        <input type="hidden" name="id" value="${not empty patient ? patient.id : ''}">

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                            <button type="submit" class="btn btn-primary">Update Profile</button>
                            <a href="/patient/dashboard" class="btn btn-secondary">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Quick Stats Sidebar -->
        <div class="col-md-4">
            <div class="card profile-card mb-4 fade-in">
                <div class="card-header bg-info text-white">
                    <h6 class="mb-0">Medical Summary</h6>
                </div>
                <div class="card-body">
                    <div class="d-flex justify-content-between mb-2">
                        <span>Upcoming Appointments:</span>
                        <strong class="text-primary">2</strong>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Active Prescriptions:</span>
                        <strong class="text-success">1</strong>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Recent Admissions:</span>
                        <strong class="text-warning">3</strong>
                    </div>
                    <div class="d-flex justify-content-between">
                        <span>Pending Results:</span>
                        <strong class="text-danger">0</strong>
                    </div>
                </div>
            </div>

            <!-- Emergency Contact Quick View -->
            <div class="card profile-card mb-4 fade-in">
                <div class="card-header bg-warning text-dark">
                    <h6 class="mb-0">Emergency Contact</h6>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty patient and not empty patient.emergencyContactName}">
                            <div class="d-flex align-items-center mb-3">
                                <i class="fas fa-user-injured text-warning me-2 fs-5"></i>
                                <div>
                                    <strong>${patient.emergencyContactName}</strong><br>
                                    <small class="text-muted">${patient.emergencyContactRelationship}</small>
                                </div>
                            </div>
                            <div class="d-flex align-items-center">
                                <i class="fas fa-phone text-success me-2"></i>
                                <span>${patient.emergencyContactPhone}</span>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center text-muted">
                                <i class="fas fa-exclamation-triangle fa-2x mb-2"></i>
                                <p>No emergency contact set</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Medical Information Quick View -->
            <div class="card profile-card mb-4 fade-in">
                <div class="card-header bg-danger text-white">
                    <h6 class="mb-0">Medical Information</h6>
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <strong>Blood Type:</strong><br>
                        <c:choose>
                            <c:when test="${not empty patient and not empty patient.bloodType}">
                                <span class="badge bg-danger fs-6">${patient.bloodType}</span>
                            </c:when>
                            <c:otherwise>
                                <span class="text-muted">Not specified</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div>
                        <strong>Allergies:</strong><br>
                        <c:choose>
                            <c:when test="${not empty patient and not empty patient.allergies}">
                                <span class="text-danger">${patient.allergies}</span>
                            </c:when>
                            <c:otherwise>
                                <span class="text-muted">No known allergies</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <div class="card profile-card fade-in">
                <div class="card-header bg-success text-white">
                    <h6 class="mb-0">Quick Actions</h6>
                </div>
                <div class="card-body">
                    <div class="d-grid gap-2">
                        <a href="/appointments/book" class="btn btn-outline-primary btn-sm">Book Appointment</a>
                        <a href="/patient/medical-records" class="btn btn-outline-info btn-sm">View My Prescription</a>
                        <a href="/patient/appointments" class="btn btn-outline-warning btn-sm">My Appointments</a>
                        <a href="/patient/admissions" class="btn btn-outline-success btn-sm">Admission History</a>
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
    // Enhanced validation functions
    function validateForm() {
        let isValid = true;

        // Clear previous error states
        clearErrors();

        // Validate First Name
        const firstName = document.getElementById('firstName');
        if (!validateName(firstName.value)) {
            showError(firstName, 'firstNameError', 'Please enter a valid first name (minimum 2 letters)');
            isValid = false;
        }

        // Validate Last Name
        const lastName = document.getElementById('lastName');
        if (!validateName(lastName.value)) {
            showError(lastName, 'lastNameError', 'Please enter a valid last name (minimum 2 letters)');
            isValid = false;
        }

        // Validate Date of Birth
        const dob = document.getElementById('dateOfBirth');
        if (!validateDOB(dob.value)) {
            showError(dob, 'dobError', 'Please select a valid date of birth (must be at least 1 year old)');
            isValid = false;
        }

        // Validate Gender
        const gender = document.getElementById('gender');
        if (!gender.value) {
            showError(gender, 'genderError', 'Please select your gender');
            isValid = false;
        }

        // Validate Email
        const email = document.getElementById('email');
        if (!validateEmail(email.value)) {
            showError(email, 'emailError', 'Please enter a valid email address');
            isValid = false;
        }

        // Validate Contact Number
        const contact = document.getElementById('contactNumber');
        if (!validatePhone(contact.value)) {
            showError(contact, 'contactError', 'Please enter a valid phone number (10 digits)');
            isValid = false;
        }

        // Validate Address
        const address = document.getElementById('address');
        if (!address.value.trim() || address.value.trim().length < 10) {
            showError(address, 'addressError', 'Please enter a complete address (minimum 10 characters)');
            isValid = false;
        }

        // Validate Emergency Contact Name
        const emergencyName = document.getElementById('emergencyContactName');
        if (!validateName(emergencyName.value)) {
            showError(emergencyName, 'emergencyNameError', 'Please enter emergency contact name');
            isValid = false;
        }

        // Validate Emergency Contact Relationship
        const emergencyRelationship = document.getElementById('emergencyContactRelationship');
        if (!emergencyRelationship.value) {
            showError(emergencyRelationship, 'emergencyRelationshipError', 'Please select relationship');
            isValid = false;
        }

        // Validate Emergency Contact Phone
        const emergencyPhone = document.getElementById('emergencyContactPhone');
        if (!validatePhone(emergencyPhone.value)) {
            showError(emergencyPhone, 'emergencyPhoneError', 'Please enter a valid emergency contact phone number');
            isValid = false;
        }

        // Validate Blood Type
        const bloodType = document.getElementById('bloodType');
        if (!bloodType.value) {
            showError(bloodType, 'bloodTypeError', 'Please select your blood type');
            isValid = false;
        }

        return isValid;
    }

    // Update the validateName function
    // Update the validateName function to properly handle names with dots
    function validateName(name) {
        // Allow letters, spaces, dots anywhere in the name, minimum 2 characters
        const nameRegex = /^(?!.*\.\.)(?!.*\.$)(?!^\.)[A-Za-z\.\s]{2,50}$/;
        return nameRegex.test(name.trim());
    }

    function validateEmail(email) {
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        return emailRegex.test(email.trim());
    }

    // Update the validatePhone function
    function validatePhone(phone) {
        // Allow +94 followed by 9 digits (total 12 characters) OR 10 digits without country code
        const phoneRegex = /^(\+94\d{9}|\d{10})$/;
        const cleanedPhone = phone.replace(/[^\d+]/g, '');
        return phoneRegex.test(cleanedPhone);
    }

    function validateDOB(dob) {
        if (!dob) return false;

        const birthDate = new Date(dob);
        const today = new Date();
        const minDate = new Date();
        minDate.setFullYear(today.getFullYear() - 120); // Maximum age 120 years
        const maxDate = new Date();
        maxDate.setFullYear(today.getFullYear() - 1); // Minimum age 1 year

        return birthDate >= minDate && birthDate <= maxDate;
    }

    // Error handling functions
    function showError(inputElement, errorElementId, message) {
        inputElement.classList.add('is-invalid');
        const errorElement = document.getElementById(errorElementId);
        if (errorElement) {
            errorElement.textContent = message;
            errorElement.style.display = 'block';
        }
        inputElement.focus();
    }

    function clearErrors() {
        // Remove all invalid classes
        const invalidElements = document.querySelectorAll('.is-invalid');
        invalidElements.forEach(element => {
            element.classList.remove('is-invalid');
        });

        // Hide all error messages
        const errorElements = document.querySelectorAll('.invalid-feedback');
        errorElements.forEach(element => {
            element.style.display = 'none';
        });
    }

    // Real-time validation for better UX
    document.addEventListener('DOMContentLoaded', function() {
        // Add input event listeners for real-time validation
        const inputs = document.querySelectorAll('input, select, textarea');
        inputs.forEach(input => {
            input.addEventListener('blur', function() {
                validateField(this);
            });

            input.addEventListener('input', function() {
                // Clear error when user starts typing
                if (this.classList.contains('is-invalid')) {
                    this.classList.remove('is-invalid');
                    const errorId = this.id + 'Error';
                    const errorElement = document.getElementById(errorId);
                    if (errorElement) {
                        errorElement.style.display = 'none';
                    }
                }
            });
        });

        // Set max date for date of birth (today - 1 year)
        const dateOfBirthInput = document.getElementById('dateOfBirth');
        if (dateOfBirthInput) {
            const today = new Date();
            const maxDate = new Date();
            maxDate.setFullYear(today.getFullYear() - 1);
            const maxDateFormatted = maxDate.toISOString().split('T')[0];
            dateOfBirthInput.setAttribute('max', maxDateFormatted);

            // Set min date (120 years ago)
            const minDate = new Date();
            minDate.setFullYear(today.getFullYear() - 120);
            const minDateFormatted = minDate.toISOString().split('T')[0];
            dateOfBirthInput.setAttribute('min', minDateFormatted);
        }
    });

    function validateField(field) {
        let isValid = true;
        let errorMessage = '';

        switch (field.id) {
            case 'firstName':
            case 'lastName':
            case 'emergencyContactName':
                isValid = validateName(field.value);
                errorMessage = 'Please enter a valid name (minimum 2 letters)';
                break;
            case 'email':
                isValid = validateEmail(field.value);
                errorMessage = 'Please enter a valid email address';
                break;
            case 'contactNumber':
            case 'emergencyContactPhone':
                isValid = validatePhone(field.value);
                errorMessage = 'Please enter a valid phone number (10 digits)';
                break;
            case 'dateOfBirth':
                isValid = validateDOB(field.value);
                errorMessage = 'Please select a valid date of birth';
                break;
            case 'address':
                isValid = field.value.trim().length >= 10;
                errorMessage = 'Please enter a complete address (minimum 10 characters)';
                break;
            case 'gender':
            case 'emergencyContactRelationship':
            case 'bloodType':
                isValid = field.value !== '';
                errorMessage = 'This field is required';
                break;
        }

        if (!isValid && field.value.trim() !== '') {
            field.classList.add('is-invalid');
            const errorElement = document.getElementById(field.id + 'Error');
            if (errorElement) {
                errorElement.textContent = errorMessage;
                errorElement.style.display = 'block';
            }
        } else {
            field.classList.remove('is-invalid');
            const errorElement = document.getElementById(field.id + 'Error');
            if (errorElement) {
                errorElement.style.display = 'none';
            }
        }
    }

    // Auto-hide success alert after 5 seconds
    setTimeout(function() {
        const alert = document.querySelector('.alert');
        if (alert) {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        }
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