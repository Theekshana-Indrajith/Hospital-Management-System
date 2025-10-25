<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Admit Patient - HMS</title>
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

        /* Enhanced Navigation - Matching Dashboard Style */
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

        /* Page Header Background Image - Matching Dashboard */
        .page-header {
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

        /* Card Styling - Matching Dashboard */
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

        .card.border-success::before { background: var(--success-gradient); }
        .card.border-primary::before { background: var(--primary-gradient); }
        .card.border-warning::before { background: var(--warning-gradient); }
        .card.border-danger::before { background: var(--danger-gradient); }
        .card.border-info::before { background: var(--info-gradient); }

        .card-header {
            border-radius: 15px 15px 0 0 !important;
            border: none;
            padding: 1.25rem 1.5rem;
        }

        /* Button Styling - Matching Dashboard */
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

        .btn-outline-secondary {
            border-color: rgba(108, 117, 125, 0.5);
            color: #6c757d;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-outline-secondary:hover {
            background: #6c757d;
            color: #fff;
            border-color: #6c757d;
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(108, 117, 125, 0.3);
        }

        .btn-outline-light {
            border-color: rgba(255, 255, 255, 0.5);
            color: #fff;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-outline-light:hover {
            background: #fff;
            color: #667eea;
            border-color: #fff;
            transform: translateY(-3px);
        }

        .btn-light {
            background: rgba(255, 255, 255, 0.9);
            border: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-light:hover {
            background: #fff;
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(255, 255, 255, 0.3);
        }

        /* Alert Styling - Matching Dashboard */
        .alert {
            border-radius: 12px;
            box-shadow: var(--shadow);
            position: relative;
            overflow: hidden;
            background: var(--light-bg);
            backdrop-filter: blur(10px);
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

        .alert-success::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 6px;
            height: 100%;
            background: var(--success-gradient);
        }

        /* Form Styling */
        .form-control, .form-select {
            border-radius: 10px;
            border: 1px solid #dee2e6;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            transform: translateY(-2px);
        }

        .required-field::after {
            content: " *";
            color: red;
        }

        .border-bottom {
            border-color: #dee2e6 !important;
        }

        /* Footer Styling - Matching Dashboard */
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

        /* Responsive Design - Matching Dashboard */
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

<!-- Updated Navigation Bar - Matching Dashboard -->
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
                    <a class="nav-link" href="/doctor/admissions/manage">
                        <i class="fas fa-procedures"></i>Admissions
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="/doctor/admissions/admit">
                        <i class="fas fa-user-plus"></i>Admit Patient
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/doctor/patients">
                        <i class="fas fa-users"></i>Patients
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
    <!-- Page Header with Background Image - Matching Dashboard -->
    <div class="page-header">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h1 class="mb-1">Admit Patient</h1>
                <p class="text-muted">Admit a new patient to the hospital for medical care and treatment</p>
            </div>
            <div class="col-md-4 text-end">
                <div class="btn-group">
                    <a href="/doctor/admissions/manage" class="btn btn-outline-light">
                        <i class="fas fa-list me-2"></i>View Admissions
                    </a>
                    <a href="/doctor/patients" class="btn btn-light">
                        <i class="fas fa-user-injured me-2"></i>All Patients
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Rest of your existing content remains exactly the same -->
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header bg-success text-white">
                    <h5 class="mb-0"><i class="fas fa-user-plus me-2"></i>Admit Patient</h5>
                </div>
                <div class="card-body">
                    <c:if test="${not empty param.error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <strong>Error:</strong> ${param.error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <c:if test="${not empty param.success}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <strong>Success:</strong> ${param.success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="/doctor/admissions/admit" method="post" id="admissionForm">
                        <!-- Patient Selection -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <h6 class="border-bottom pb-2"><i class="fas fa-user me-2"></i>Patient Information</h6>
                            </div>
                            <div class="col-12">
                                <label for="patientId" class="form-label required-field">Select Patient</label>

                                <!-- Search Bar for Patients -->
                                <div class="input-group mb-2">
                                    <span class="input-group-text">
                                        <i class="fas fa-search"></i>
                                    </span>
                                    <input type="text" class="form-control" id="patientSearch"
                                           placeholder="Search patients by name..."
                                           onkeyup="filterPatients()">
                                </div>

                                <select class="form-select" id="patientId" name="patientId" required>
                                    <option value="">Choose a patient...</option>
                                    <c:forEach var="patient" items="${patients}">
                                        <option value="${patient.id}" data-patient-name="${patient.firstName} ${patient.lastName}"
                                                <c:if test="${param.patientId == patient.id}">selected</c:if>>
                                                ${patient.firstName} ${patient.lastName}
                                            (ID: ${patient.id})
                                        </option>
                                    </c:forEach>
                                </select>
                                <div class="form-text">
                                    <i class="fas fa-info-circle"></i> Use the search bar above to quickly find patients
                                </div>
                            </div>
                        </div>

                        <!-- Ward Selection Only -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <h6 class="border-bottom pb-2"><i class="fas fa-bed me-2"></i>Ward Allocation</h6>
                            </div>
                            <div class="col-12">
                                <label for="wardId" class="form-label required-field">Select Ward</label>
                                <select class="form-select" id="wardId" name="wardId" required>
                                    <option value="">Choose a ward...</option>
                                    <c:forEach var="ward" items="${wards}">
                                        <option value="${ward.id}">
                                                ${ward.wardNumber} (${ward.wardType}) - ${ward.availableBeds} beds available
                                        </option>
                                    </c:forEach>
                                </select>
                                <div class="form-text">A bed will be automatically assigned from the selected ward</div>
                            </div>
                        </div>

                        <!-- Medical Information -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <h6 class="border-bottom pb-2"><i class="fas fa-stethoscope me-2"></i>Medical Information</h6>
                            </div>
                            <div class="col-md-6">
                                <label for="diagnosis" class="form-label required-field">Primary Diagnosis</label>
                                <input type="text" class="form-control" id="diagnosis" name="diagnosis"
                                       placeholder="Enter primary diagnosis" required>
                                <div class="form-text">Main reason for admission</div>
                            </div>
                            <div class="col-md-6">
                                <label for="severityLevel" class="form-label required-field">Severity Level</label>
                                <select class="form-select" id="severityLevel" name="severityLevel" required>
                                    <option value="">Select severity...</option>
                                    <option value="STABLE">Stable</option>
                                    <option value="SERIOUS">Serious</option>
                                    <option value="CRITICAL">Critical</option>
                                </select>
                            </div>
                        </div>

                        <!-- Admission Details -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <label for="reason" class="form-label required-field">Admission Reason & Notes</label>
                                <textarea class="form-control" id="reason" name="reason"
                                          rows="4" placeholder="Detailed reason for admission, initial observations, and any special instructions..."
                                          required></textarea>
                                <div class="form-text">Provide comprehensive details about why this admission is necessary</div>
                            </div>
                        </div>

                        <!-- Form Actions -->
                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="/doctor/admissions/manage" class="btn btn-outline-secondary me-2">
                                <i class="fas fa-times me-1"></i>Cancel
                            </a>
                            <button type="submit" class="btn btn-success">
                                <i class="fas fa-hospital-user me-1"></i>Admit Patient
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Information Card -->
            <div class="card mt-4">
                <div class="card-header bg-info text-white">
                    <h6 class="mb-0"><i class="fas fa-info-circle me-2"></i>How Bed Assignment Works</h6>
                </div>
                <div class="card-body">
                    <ul class="mb-0">
                        <li>Select a ward with available beds</li>
                        <li>The system will automatically assign the first available bed</li>
                        <li>If no beds exist, a new bed will be created automatically</li>
                        <li>Bed status will be updated to "OCCUPIED" after admission</li>
                    </ul>
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
    // Navbar scroll effect - Matching Dashboard
    window.addEventListener('scroll', function() {
        const navbar = document.querySelector('.navbar');
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });

    // Patient search functionality
    function filterPatients() {
        const searchTerm = document.getElementById('patientSearch').value.toLowerCase();
        const patientSelect = document.getElementById('patientId');
        const options = patientSelect.getElementsByTagName('option');

        for (let i = 1; i < options.length; i++) { // Start from 1 to skip the first "Choose a patient..." option
            const patientName = options[i].getAttribute('data-patient-name').toLowerCase();
            if (patientName.includes(searchTerm)) {
                options[i].style.display = '';
            } else {
                options[i].style.display = 'none';
            }
        }

        // If search is cleared, show all options
        if (searchTerm === '') {
            for (let i = 1; i < options.length; i++) {
                options[i].style.display = '';
            }
        }
    }

    // Clear search when patient is selected
    document.getElementById('patientId').addEventListener('change', function() {
        document.getElementById('patientSearch').value = '';
        // Show all options after selection
        const options = this.getElementsByTagName('option');
        for (let i = 1; i < options.length; i++) {
            options[i].style.display = '';
        }
    });

    // Auto-update severity based on diagnosis keywords
    document.getElementById('diagnosis').addEventListener('input', function(e) {
        const diagnosis = e.target.value.toLowerCase();
        const severitySelect = document.getElementById('severityLevel');

        if (!severitySelect.value) {
            if (diagnosis.includes('critical') || diagnosis.includes('emergency') ||
                diagnosis.includes('septic') || diagnosis.includes('cardiac arrest') ||
                diagnosis.includes('stroke') || diagnosis.includes('trauma')) {
                severitySelect.value = 'CRITICAL';
            } else if (diagnosis.includes('serious') || diagnosis.includes('severe') ||
                diagnosis.includes('acute') || diagnosis.includes('fracture') ||
                diagnosis.includes('infection') || diagnosis.includes('pain')) {
                severitySelect.value = 'SERIOUS';
            } else if (diagnosis.trim().length > 0) {
                severitySelect.value = 'STABLE';
            }
        }
    });

    // Form validation
    document.getElementById('admissionForm').addEventListener('submit', function(e) {
        const patientId = document.getElementById('patientId').value;
        const wardId = document.getElementById('wardId').value;
        const diagnosis = document.getElementById('diagnosis').value;
        const severity = document.getElementById('severityLevel').value;
        const reason = document.getElementById('reason').value;

        if (!patientId || !wardId || !diagnosis || !severity || !reason) {
            e.preventDefault();
            alert('Please fill in all required fields (marked with *)');
            return false;
        }

        // Check if selected ward has available beds
        const wardSelect = document.getElementById('wardId');
        const selectedOption = wardSelect.options[wardSelect.selectedIndex];
        const wardText = selectedOption.text;
        const hasAvailableBeds = wardText.includes('beds available') && !wardText.includes('0 beds available');

        if (!hasAvailableBeds) {
            e.preventDefault();
            alert('Please select a ward with available beds');
            return false;
        }
    });

    // Auto-select patient if coming from patient details page
    document.addEventListener('DOMContentLoaded', function() {
        const urlParams = new URLSearchParams(window.location.search);
        const patientId = urlParams.get('patientId');
        if (patientId) {
            document.getElementById('patientId').value = patientId;
        }
    });
</script>
</body>
</html>