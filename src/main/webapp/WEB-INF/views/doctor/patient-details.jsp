<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Patient Details - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap');

        /* Define CSS variables for consistent theming */
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --danger-gradient: linear-gradient(135deg, #ff6b6b 0%, #ff8e8e 100%);
            --warning-gradient: linear-gradient(135deg, #ffd93d 0%, #ff9a3d 100%);
            --info-gradient: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            --dark-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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

        /* Enhanced Navigation - Matching Doctor Dashboard */
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

        /* Patient Header Background Image - Matching Dashboard Style */
        .patient-header {
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

        .patient-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(102, 126, 234, 0.7);
            z-index: 0;
        }

        .patient-header > * {
            position: relative;
            z-index: 1;
            color: #fff;
        }

        .patient-header h2 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            color: #fff;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);
        }

        .patient-header p {
            font-size: 1.1rem;
            opacity: 0.9;
            color: #fff;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.5);
        }

        .patient-header strong {
            color: #fff;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.5);
        }

        .patient-header .text-muted {
            color: rgba(255, 255, 255, 0.9) !important;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.5);
        }

        .patient-header i {
            color: #fff;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.5);
        }

        /* Card Styling - Matching Dashboard */
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

        .card.border-success::before { background: var(--success-gradient); }
        .card.border-primary::before { background: var(--primary-gradient); }
        .card.border-warning::before { background: var(--warning-gradient); }
        .card.border-danger::before { background: var(--danger-gradient); }
        .card.border-info::before { background: var(--info-gradient); }

        .btn-success {
            background: var(--success-gradient);
            border: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-success:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(40, 167, 69, 0.3);
        }

        .btn-outline-success {
            border-color: rgba(40, 167, 69, 0.5);
            color: #28a745;
        }

        .btn-outline-success:hover {
            background: var(--success-gradient);
            color: #fff;
            border-color: var(--success-gradient);
        }

        .btn-light {
            background: rgba(255, 255, 255, 0.9);
            border: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            color: #333;
        }

        .btn-light:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(255, 255, 255, 0.3);
            background: rgba(255, 255, 255, 1);
        }

        /* Tab Styling */
        .tab-content {
            min-height: 400px;
            border-left: 1px solid #dee2e6;
            border-right: 1px solid #dee2e6;
            border-bottom: 1px solid #dee2e6;
            padding: 20px;
            border-radius: 0 0 15px 15px;
            background: var(--light-bg);
        }

        .nav-tabs .nav-link.active {
            font-weight: 600;
            border-bottom: 3px solid #198754;
            background: var(--light-bg);
            border-color: #dee2e6 #dee2e6 var(--light-bg);
        }

        .nav-tabs .nav-link {
            border-radius: 10px 10px 0 0;
            margin-bottom: -1px;
        }

        /* Medical History Items */
        .medical-history-item {
            border-left: 4px solid #0dcaf0;
            padding-left: 15px;
        }

        .prescription-item {
            border-left: 4px solid #198754;
            padding-left: 15px;
        }

        .stats-badge {
            font-size: 0.7em;
            margin-left: 5px;
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

        .alert-info::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 6px;
            height: 100%;
            background: var(--info-gradient);
        }

        /* Stats Items */
        .stats-item {
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .stats-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
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

            .patient-header h2 {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
<!-- Updated Navigation Bar - Matching Doctor Dashboard -->
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
                    <a class="nav-link" href="/doctor/dashboard">
                        <i class="fas fa-th-large"></i>Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/doctor/schedule">
                        <i class="fas fa-calendar-check"></i>Schedule
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="/doctor/patients">
                        <i class="fas fa-users"></i>Patients
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/prescriptions/add">
                        <i class="fas fa-prescription"></i>Prescriptions
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/lab-tests/request">
                        <i class="fas fa-flask"></i>Lab Tests
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/lab-tests">
                        <i class="fas fa-eye"></i>View Tests
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/doctor/admissions/manage">
                        <i class="fas fa-procedures"></i>Admissions
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/doctor/profile">
                        <i class="fas fa-user-md"></i>My Profile
                    </a>
                </li>
            </ul>
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item">
                    <span class="navbar-text">
                        <i class="fas fa-user-circle"></i>Welcome, Dr. ${username}!
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
    <!-- Patient Header with Background Image - Matching Dashboard Style -->
    <div class="patient-header">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h2>${patient.firstName} ${patient.lastName}</h2>
                <div class="row mt-3">
                    <div class="col-md-6">
                        <p class="mb-1">
                            <i class="fas fa-id-card me-2"></i>
                            <strong>Patient ID:</strong> #${patient.id}
                        </p>
                        <p class="mb-1">
                            <i class="fas fa-venus-mars me-2"></i>
                            <strong>Gender:</strong>
                            <c:choose>
                                <c:when test="${not empty patient.gender}">${patient.gender}</c:when>
                                <c:otherwise>Not specified</c:otherwise>
                            </c:choose>
                        </p>
                        <p class="mb-1">
                            <i class="fas fa-birthday-cake me-2"></i>
                            <strong>Date of Birth:</strong>
                            <c:choose>
                                <c:when test="${patient.dateOfBirth != null}">
                                    ${patient.dateOfBirth}
                                    <c:set var="currentYear" value="<%= java.time.Year.now().getValue() %>"/>
                                    (${currentYear - patient.dateOfBirth.year} years)
                                </c:when>
                                <c:otherwise>Not specified</c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                    <div class="col-md-6">
                        <p class="mb-1">
                            <i class="fas fa-phone me-2"></i>
                            <strong>Contact:</strong>
                            <c:choose>
                                <c:when test="${not empty patient.contactNumber}">${patient.contactNumber}</c:when>
                                <c:otherwise>No contact</c:otherwise>
                            </c:choose>
                        </p>
                        <p class="mb-1">
                            <i class="fas fa-envelope me-2"></i>
                            <strong>Email:</strong> ${patient.email}
                        </p>
                        <p class="mb-1">
                            <i class="fas fa-map-marker-alt me-2"></i>
                            <strong>Address:</strong>
                            <c:choose>
                                <c:when test="${not empty patient.address}">${patient.address}</c:when>
                                <c:otherwise>No address</c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 text-end">
                <div class="btn-group-vertical w-100">
                    <a href="/doctor/admissions/admit?patientId=${patient.id}" class="btn btn-light mb-2">
                        <i class="fas fa-hospital-user me-2"></i>Admit Patient
                    </a>
                    <a href="/prescriptions/add?patientId=${patient.id}" class="btn btn-light">
                        <i class="fas fa-prescription me-2"></i>New Prescription
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- Patient Quick Info -->
        <div class="col-md-4">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h6 class="mb-0"><i class="fas fa-info-circle me-2"></i>Medical Information</h6>
                </div>
                <div class="card-body">
                    <div class="patient-info">
                        <div class="mb-3">
                            <strong>Blood Type:</strong><br>
                            <c:choose>
                                <c:when test="${not empty patient.bloodType}">
                                    <span class="badge bg-danger">${patient.bloodType}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-muted">Not recorded</span>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="mb-3">
                            <strong>Allergies:</strong><br>
                            <c:choose>
                                <c:when test="${not empty patient.allergies}">
                                    <small class="text-danger">${patient.allergies}</small>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-muted">None recorded</span>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="mb-3">
                            <strong>Emergency Contact:</strong><br>
                            <c:choose>
                                <c:when test="${not empty patient.emergencyContactName}">
                                    <div class="small">
                                        <strong>Name:</strong> ${patient.emergencyContactName}<br>
                                        <c:if test="${not empty patient.emergencyContactRelationship}">
                                            <strong>Relationship:</strong> ${patient.emergencyContactRelationship}<br>
                                        </c:if>
                                        <c:if test="${not empty patient.emergencyContactPhone}">
                                            <strong>Phone:</strong> ${patient.emergencyContactPhone}
                                        </c:if>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-muted">Not specified</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-header bg-info text-white">
                    <h6 class="mb-0"><i class="fas fa-chart-bar me-2"></i>Patient Statistics</h6>
                </div>
                <div class="card-body">
                    <div class="stats-item mb-3 p-2 bg-light rounded">
                        <div class="d-flex justify-content-between">
                            <span>Total Appointments:</span>
                            <strong class="text-primary">${appointments.size()}</strong>
                        </div>
                    </div>

                    <div class="stats-item mb-3 p-2 bg-light rounded">
                        <div class="d-flex justify-content-between">
                            <span>Total Admissions:</span>
                            <strong class="text-primary">${admissions.size()}</strong>
                        </div>
                    </div>

                    <div class="stats-item mb-3 p-2 bg-light rounded">
                        <div class="d-flex justify-content-between">
                            <span>Active Admissions:</span>
                            <strong class="text-success">
                                <c:set var="activeAdmissions" value="0"/>
                                <c:forEach var="admission" items="${admissions}">
                                    <c:if test="${admission.status == 'ADMITTED'}">
                                        <c:set var="activeAdmissions" value="${activeAdmissions + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${activeAdmissions}
                            </strong>
                        </div>
                    </div>

                    <div class="stats-item p-2 bg-light rounded">
                        <div class="d-flex justify-content-between">
                            <span>Last Visit:</span>
                            <strong class="text-warning">
                                <c:choose>
                                    <c:when test="${not empty appointments}">
                                        ${appointments[0].appointmentDateTime.toLocalDate()}
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted">No visits</span>
                                    </c:otherwise>
                                </c:choose>
                            </strong>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Patient Details Tabs -->
        <div class="col-md-8">
            <ul class="nav nav-tabs" id="patientTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="admissions-tab" data-bs-toggle="tab"
                            data-bs-target="#admissions" type="button" role="tab">
                        <i class="fas fa-procedures me-1"></i>Admissions
                        <span class="badge bg-primary stats-badge">${admissions.size()}</span>
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="prescriptions-tab" data-bs-toggle="tab"
                            data-bs-target="#prescriptions" type="button" role="tab">
                        <i class="fas fa-prescription me-1"></i>Prescriptions
                        <span class="badge bg-primary stats-badge">${prescriptions.size()}</span>
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="labtests-tab" data-bs-toggle="tab"
                            data-bs-target="#labtests" type="button" role="tab">
                        <i class="fas fa-flask me-1"></i>Lab Tests
                        <span class="badge bg-primary stats-badge">${labTests.size()}</span>
                    </button>
                </li>
            </ul>

            <div class="tab-content" id="patientTabsContent">
                <!-- Admissions Tab -->
                <div class="tab-pane fade show active" id="admissions" role="tabpanel">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5>Admission History</h5>
                        <a href="/doctor/admissions/admit?patientId=${patient.id}" class="btn btn-success btn-sm">
                            <i class="fas fa-plus me-1"></i>New Admission
                        </a>
                    </div>

                    <c:choose>
                        <c:when test="${empty admissions}">
                            <div class="alert alert-info text-center py-4">
                                <i class="fas fa-procedures fa-3x text-muted mb-3"></i>
                                <h5>No Admission History</h5>
                                <p class="text-muted">This patient has no admission records.</p>
                                <a href="/doctor/admissions/admit?patientId=${patient.id}" class="btn btn-primary">
                                    <i class="fas fa-hospital-user me-1"></i>Admit Patient
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-sm table-striped table-hover">
                                    <thead class="table-dark">
                                    <tr>
                                        <th>Admission Date</th>
                                        <th>Discharge Date</th>
                                        <th>Ward</th>
                                        <th>Bed</th>
                                        <th>Reason</th>
                                        <th>Status</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="admission" items="${admissions}">
                                        <tr>
                                            <td>
                                                <strong>${admission.admissionDate.toLocalDate()}</strong>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${admission.dischargeDate != null}">
                                                        ${admission.dischargeDate.toLocalDate()}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-warning">Active</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${admission.ward != null}">
                                                        ${admission.ward.wardNumber}<br>
                                                        <small class="text-muted">${admission.ward.wardType}</small>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Not assigned</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${admission.bed != null}">
                                                        <span class="badge bg-secondary">${admission.bed.bedNumber}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Not assigned</span>
                                                    </c:otherwise>
                                                </c:choose>
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
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Prescriptions Tab -->
                <div class="tab-pane fade" id="prescriptions" role="tabpanel">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5>Prescription History</h5>
                        <a href="/prescriptions/add?patientId=${patient.id}" class="btn btn-success btn-sm">
                            <i class="fas fa-plus me-1"></i>New Prescription
                        </a>
                    </div>

                    <c:choose>
                        <c:when test="${empty prescriptions}">
                            <div class="alert alert-info text-center py-4">
                                <i class="fas fa-prescription fa-3x text-muted mb-3"></i>
                                <h5>No Prescription History</h5>
                                <p class="text-muted">This patient has no prescription records.</p>
                                <a href="/prescriptions/add?patientId=${patient.id}" class="btn btn-primary">
                                    <i class="fas fa-prescription me-1"></i>Add First Prescription
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="row">
                                <c:forEach var="prescription" items="${prescriptions}">
                                    <div class="col-lg-6 mb-3">
                                        <div class="card prescription-item h-100">
                                            <div class="card-body">
                                                <div class="d-flex justify-content-between align-items-start mb-2">
                                                    <h6 class="card-title text-success">${prescription.medicationName}</h6>
                                                    <!-- Delete button for doctor -->
                                                    <form action="/prescriptions/delete-from-patient/${prescription.id}" method="post"
                                                          class="d-inline" onsubmit="return confirm('Are you sure you want to delete this prescription?');">
                                                        <button type="submit" class="btn btn-sm btn-outline-danger">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </form>
                                                </div>
                                                <div class="mb-2">
                                                    <small class="text-muted">
                                                        <strong>Dosage:</strong> ${prescription.dosage}<br>
                                                        <strong>Frequency:</strong> ${prescription.frequency}<br>
                                                        <strong>Duration:</strong> ${prescription.duration}
                                                    </small>
                                                </div>
                                                <c:if test="${not empty prescription.instructions}">
                                                    <div class="mb-2">
                                                        <small>
                                                            <strong>Instructions:</strong> ${prescription.instructions}
                                                        </small>
                                                    </div>
                                                </c:if>
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <small class="text-muted">
                                                            ${prescription.prescriptionDate.toLocalDate()}
                                                    </small>
                                                    <span class="badge
                                                    <c:choose>
                                                        <c:when test="${prescription.status == 'ACTIVE'}">bg-success</c:when>
                                                        <c:when test="${prescription.status == 'COMPLETED'}">bg-secondary</c:when>
                                                        <c:when test="${prescription.status == 'CANCELLED'}">bg-danger</c:when>
                                                        <c:otherwise>bg-warning</c:otherwise>
                                                    </c:choose>">
                                                            ${prescription.status}
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Lab Tests Tab -->
                <div class="tab-pane fade" id="labtests" role="tabpanel">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5>Laboratory Tests</h5>
                        <a href="/lab-tests/request?patientId=${patient.id}" class="btn btn-success btn-sm">
                            <i class="fas fa-plus me-1"></i>Request Test
                        </a>
                    </div>

                    <c:choose>
                        <c:when test="${empty labTests}">
                            <div class="alert alert-info text-center py-4">
                                <i class="fas fa-flask fa-3x text-muted mb-3"></i>
                                <h5>No Laboratory Tests</h5>
                                <p class="text-muted">This patient has no lab test records.</p>
                                <a href="/lab-tests/request?patientId=${patient.id}" class="btn btn-primary">
                                    <i class="fas fa-flask me-1"></i>Request First Test
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-sm table-striped table-hover">
                                    <thead class="table-dark">
                                    <tr>
                                        <th>Test Name</th>
                                        <th>Type</th>
                                        <th>Requested Date</th>
                                        <th>Status</th>
                                        <th>Results</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="test" items="${labTests}">
                                        <tr>
                                            <td>
                                                <strong>${test.testName}</strong>
                                            </td>
                                            <td>${test.testType}</td>
                                            <td>
                                                    ${test.requestedDate.toLocalDate()}
                                            </td>
                                            <td>
                                            <span class="badge
                                                <c:choose>
                                                    <c:when test="${test.status == 'COMPLETED'}">bg-success</c:when>
                                                    <c:when test="${test.status == 'IN_PROGRESS'}">bg-warning</c:when>
                                                    <c:when test="${test.status == 'REQUESTED'}">bg-info</c:when>
                                                    <c:otherwise>bg-secondary</c:otherwise>
                                                </c:choose>">
                                                    ${test.status}
                                            </span>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${test.status == 'COMPLETED' && not empty test.results}">
                                                        <button onclick="window.location.href='/doctor/lab-tests/${test.id}'"
                                                                class="btn btn-sm btn-outline-primary">
                                                            <i class="fas fa-file-medical me-1"></i>View Results
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Pending</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:otherwise>
                    </c:choose>
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
    // Navbar scroll effect - Matching Doctor Dashboard
    window.addEventListener('scroll', function() {
        const navbar = document.querySelector('.navbar');
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });

    // Initialize tabs
    document.addEventListener('DOMContentLoaded', function() {
        var triggerTabList = [].slice.call(document.querySelectorAll('#patientTabs button'))
        triggerTabList.forEach(function (triggerEl) {
            var tabTrigger = new bootstrap.Tab(triggerEl)
            triggerEl.addEventListener('click', function (event) {
                event.preventDefault()
                tabTrigger.show()
            })
        })
    });
</script>
</body>
</html>