<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Request Lab Test - HMS</title>
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
        /* Add to the existing CSS */
        .has-warning {
            border-color: #ffc107 !important;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 12 12' width='12' height='12' fill='none' stroke='%23ffc107'%3e%3ccircle cx='6' cy='6' r='4.5'/%3e%3cpath d='M5.8 3.6.4.4.4-.4'/%3e%3cpath d='M6 7v1'/%3e%3c/svg%3e") !important;
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
        }

        .btn-outline-primary {
            border-color: rgba(102, 126, 234, 0.5);
            color: #667eea;
        }

        .btn-outline-primary:hover {
            background: var(--primary-gradient);
            color: #fff;
            border-color: var(--primary-gradient);
        }

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
            border: 1px solid rgba(102, 126, 234, 0.2);
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.25rem rgba(102, 126, 234, 0.25);
        }

        .form-label {
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 0.5rem;
        }

        /* Validation Styles */
        .is-invalid {
            border-color: #dc3545 !important;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 12 12' width='12' height='12' fill='none' stroke='%23dc3545'%3e%3ccircle cx='6' cy='6' r='4.5'/%3e%3cpath d='m5.8 3.6.4.4.4-.4'/%3e%3cpath d='M6 7v1'/%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right calc(0.375em + 0.1875rem) center;
            background-size: calc(0.75em + 0.375rem) calc(0.75em + 0.375rem);
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
    </style>
</head>
<body>
<!-- Updated Navigation Bar - Matching Doctor Dashboard -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" >
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
                    <a class="nav-link" href="/doctor/patients">
                        <i class="fas fa-users"></i>Patients
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/prescriptions/add">
                        <i class="fas fa-prescription"></i>Prescriptions
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="/lab-tests/request">
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
    <!-- Updated Welcome Section with Background Image -->
    <div class="welcome-header mb-4">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h2 class="mb-1">Request Laboratory Test</h2>
                <p>Order diagnostic tests for your patients</p>
            </div>
            <div class="col-md-4 text-end">
                <div class="btn-group">
                    <a href="/doctor/dashboard" class="btn btn-outline-light">
                        <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                    </a>
                    <a href="/lab-tests" class="btn btn-light">
                        <i class="fas fa-eye me-2"></i>View Tests
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="row">
        <div class="col-md-8 mx-auto">
            <div class="card border-info">
                <div class="card-header bg-info text-white">
                    <h4 class="mb-0"><i class="fas fa-flask me-2"></i>Request Laboratory Test</h4>
                </div>
                <div class="card-body">
                    <!-- Success/Error Messages -->
                    <c:if test="${not empty param.success}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                                ${param.success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty param.error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                ${param.error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="/lab-tests/request" method="post" id="labTestForm" novalidate>
                        <div class="mb-3">
                            <label for="patientId" class="form-label">Select Patient *</label>

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
                                    <option value="${patient.id}" data-patient-name="${patient.firstName} ${patient.lastName}">
                                            ${patient.firstName} ${patient.lastName}
                                        (ID: ${patient.id}, ${patient.gender}, ${patient.dateOfBirth})
                                    </option>
                                </c:forEach>
                            </select>
                            <div class="invalid-feedback">
                                Please select a patient.
                            </div>
                            <div class="form-text">
                                <i class="fas fa-info-circle"></i> Use the search bar above to quickly find patients
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="testName" class="form-label">Test Name *</label>
                                <input type="text" class="form-control" id="testName" name="testName"
                                       placeholder="e.g., Complete Blood Count, Lipid Profile" required
                                       pattern="[A-Za-z\s]+" title="Test name should contain only letters and spaces">
                                <div class="invalid-feedback">
                                    Please enter a valid test name (letters and spaces only).
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="testType" class="form-label">Test Type *</label>
                                <select class="form-select" id="testType" name="testType" required>
                                    <option value="">Select test type...</option>
                                    <option value="BLOOD">Blood Test</option>
                                    <option value="URINE">Urine Analysis</option>
                                    <option value="XRAY">X-Ray</option>
                                    <option value="MRI">MRI Scan</option>
                                    <option value="CT">CT Scan</option>
                                    <option value="ULTRASOUND">Ultrasound</option>
                                    <option value="ECG">ECG</option>
                                    <option value="BIOPSY">Biopsy</option>
                                    <option value="CULTURE">Culture</option>
                                    <option value="OTHER">Other</option>
                                </select>
                                <div class="invalid-feedback">
                                    Please select a test type.
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="priority" class="form-label">Priority *</label>
                                <select class="form-select" id="priority" name="priority" required>
                                    <option value="NORMAL">Normal</option>
                                    <option value="URGENT">Urgent</option>
                                    <option value="STAT">STAT (Immediate)</option>
                                </select>
                                <div class="invalid-feedback">
                                    Please select a priority level.
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Requesting Doctor</label>
                                <input type="text" class="form-control" value="Dr. ${username}" readonly>
                                <small class="form-text text-muted">Automatically assigned to you</small>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="description" class="form-label">Clinical Description</label>
                            <textarea class="form-control" id="description" name="description" rows="3"
                                      placeholder="Brief clinical description or reason for test..."></textarea>
                        </div>

                        <div class="mb-3">
                            <label for="instructions" class="form-label">Special Instructions</label>
                            <textarea class="form-control" id="instructions" name="instructions" rows="2"
                                      placeholder="Any special instructions for the lab..."></textarea>
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="/doctor/dashboard" class="btn btn-secondary me-md-2">Cancel</a>
                            <button type="submit" class="btn btn-primary" id="submitBtn">
                                <i class="fas fa-paper-plane me-1"></i>Submit Test Request
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Common Test Templates -->
            <div class="card mt-4 border-warning">
                <div class="card-header bg-warning text-white">
                    <h6 class="mb-0"><i class="fas fa-lightbulb me-2"></i>Common Test Templates</h6>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-4">
                            <button class="btn btn-outline-primary btn-sm w-100 mb-2 template-btn" data-test="Complete Blood Count" data-type="BLOOD">
                                Complete Blood Count
                            </button>
                        </div>
                        <div class="col-md-4">
                            <button class="btn btn-outline-primary btn-sm w-100 mb-2 template-btn" data-test="Lipid Profile" data-type="BLOOD">
                                Lipid Profile
                            </button>
                        </div>
                        <div class="col-md-4">
                            <button class="btn btn-outline-primary btn-sm w-100 mb-2 template-btn" data-test="Liver Function Test" data-type="BLOOD">
                                Liver Function Test
                            </button>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <button class="btn btn-outline-primary btn-sm w-100 mb-2 template-btn" data-test="Urine Analysis" data-type="URINE">
                                Urine Analysis
                            </button>
                        </div>
                        <div class="col-md-4">
                            <button class="btn btn-outline-primary btn-sm w-100 mb-2 template-btn" data-test="Thyroid Profile" data-type="BLOOD">
                                Thyroid Profile
                            </button>
                        </div>
                        <div class="col-md-4">
                            <button class="btn btn-outline-primary btn-sm w-100 mb-2 template-btn" data-test="Chest X-Ray" data-type="XRAY">
                                Chest X-Ray
                            </button>
                        </div>
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
    // Navbar scroll effect
    window.addEventListener('scroll', function() {
        const navbar = document.querySelector('.navbar');
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });

    // Template button functionality
    document.querySelectorAll('.template-btn').forEach(button => {
        button.addEventListener('click', function() {
            document.getElementById('testName').value = this.getAttribute('data-test');
            document.getElementById('testType').value = this.getAttribute('data-type');

            // Clear validation errors when using templates
            clearValidationErrors();
        });
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

    // Validation functions
    function validateTestName() {
        const testName = document.getElementById('testName');
        const regex = /^[A-Za-z\s]+$/;

        if (testName.value.trim() === '') {
            testName.classList.add('is-invalid');
            showWarning('testNameWarning', 'Test name is required. Please enter a test name.');
            return false;
        }
        else if (!regex.test(testName.value.trim())) {
            testName.classList.add('is-invalid');
            showWarning('testNameWarning', 'Test name should contain only letters and spaces. Numbers and special characters are not allowed.');
            return false;
        } else {
            testName.classList.remove('is-invalid');
            hideWarning('testNameWarning');
            return true;
        }
    }

    function validateRequiredField(fieldId, fieldName) {
        const field = document.getElementById(fieldId);
        if (!field.value.trim()) {
            field.classList.add('is-invalid');
            showWarning(fieldId + 'Warning', fieldName + ' is required. Please select a ' + fieldName.toLowerCase() + '.');
            return false;
        } else {
            field.classList.remove('is-invalid');
            hideWarning(fieldId + 'Warning');
            return true;
        }
    }

    function showWarning(warningId, message) {
        let warningElement = document.getElementById(warningId);
        const field = document.getElementById(warningId.replace('Warning', ''));

        if (!warningElement) {
            warningElement = document.createElement('div');
            warningElement.id = warningId;
            warningElement.className = 'alert alert-warning alert-dismissible fade show mt-2';
            warningElement.innerHTML = `
                <i class="fas fa-exclamation-triangle me-2"></i>${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            `;
            field.parentNode.appendChild(warningElement);
        } else {
            warningElement.innerHTML = `
                <i class="fas fa-exclamation-triangle me-2"></i>${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            `;
            warningElement.classList.remove('d-none');
        }
    }

    function hideWarning(warningId) {
        const warningElement = document.getElementById(warningId);
        if (warningElement) {
            warningElement.classList.add('d-none');
        }
    }

    function validateForm() {
        let isValid = true;

        // Validate test name
        if (!validateTestName()) {
            isValid = false;
        }

        // Validate other required fields
        if (!validateRequiredField('patientId', 'Patient')) {
            isValid = false;
        }

        if (!validateRequiredField('testType', 'Test type')) {
            isValid = false;
        }

        if (!validateRequiredField('priority', 'Priority')) {
            isValid = false;
        }

        return isValid;
    }

    function clearValidationErrors() {
        const fields = document.querySelectorAll('.is-invalid');
        fields.forEach(field => {
            field.classList.remove('is-invalid');
        });

        // Hide all warnings
        hideWarning('testNameWarning');
        hideWarning('patientIdWarning');
        hideWarning('testTypeWarning');
        hideWarning('priorityWarning');
    }

    // Real-time validation
    document.getElementById('testName').addEventListener('input', validateTestName);

    // Real-time validation for other fields
    document.getElementById('patientId').addEventListener('change', function() {
        validateRequiredField('patientId', 'Patient');
    });

    document.getElementById('testType').addEventListener('change', function() {
        validateRequiredField('testType', 'Test type');
    });

    document.getElementById('priority').addEventListener('change', function() {
        validateRequiredField('priority', 'Priority');
    });

    // Form submission validation
    document.getElementById('labTestForm').addEventListener('submit', function(e) {
        if (!validateForm()) {
            e.preventDefault();
            e.stopPropagation();

            // Show all warnings
            validateTestName();
            validateRequiredField('patientId', 'Patient');
            validateRequiredField('testType', 'Test type');
            validateRequiredField('priority', 'Priority');

            // Scroll to first error
            const firstError = document.querySelector('.is-invalid');
            if (firstError) {
                firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                firstError.focus();
            }
        }
    });

    // Clear validation on input for required fields
    document.querySelectorAll('[required]').forEach(field => {
        field.addEventListener('input', function() {
            if (this.value.trim()) {
                this.classList.remove('is-invalid');
                hideWarning(this.id + 'Warning');
            }
        });
    });
</script>
</body>
</html>