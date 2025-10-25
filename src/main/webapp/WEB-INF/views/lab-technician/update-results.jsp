<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Update Test Results - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap');

        /* Define CSS variables for lab technician theme */
        :root {
            --primary-gradient: linear-gradient(135deg, #17a2b8 0%, #20c997 100%);
            --success-gradient: linear-gradient(135deg, #20c997 0%, #3bd9ac 100%);
            --danger-gradient: linear-gradient(135deg, #ff6b6b 0%, #ff8e8e 100%);
            --warning-gradient: linear-gradient(135deg, #ffc107 0%, #ffd54f 100%);
            --info-gradient: linear-gradient(135deg, #6f42c1 0%, #8e6cff 100%);
            --dark-gradient: linear-gradient(135deg, #17a2b8 0%, #138496 100%);
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

        /* Enhanced Navigation - Lab Technician Theme */
        .navbar {
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.98) 0%, rgba(248, 249, 250, 0.98) 100%) !important;
            backdrop-filter: blur(15px);
            box-shadow: 0 4px 30px rgba(23, 162, 184, 0.1);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            padding: 15px 0;
            border-bottom: 1px solid rgba(23, 162, 184, 0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .navbar.scrolled {
            background: linear-gradient(135deg, rgba(255, 255, 255, 1) 0%, rgba(248, 249, 250, 1) 100%) !important;
            padding: 10px 0;
            box-shadow: 0 8px 40px rgba(23, 162, 184, 0.15);
            border-bottom: 2px solid rgba(23, 162, 184, 0.2);
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, #17a2b8 0%, #20c997 100%);
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
            background: linear-gradient(135deg, #17a2b8 0%, #20c997 100%);
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
            background: linear-gradient(135deg, rgba(23, 162, 184, 0.1), rgba(32, 201, 151, 0.1));
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
            background: linear-gradient(90deg, #17a2b8, #20c997);
            border-radius: 2px;
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }

        .nav-link:hover,
        .nav-link.active {
            color: #17a2b8 !important;
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
            background: linear-gradient(135deg, rgba(23, 162, 184, 0.1), rgba(32, 201, 151, 0.1));
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
        }

        .navbar-text:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(23, 162, 184, 0.2);
        }

        .navbar-text i {
            margin-right: 0.5rem;
            background: linear-gradient(135deg, #17a2b8 0%, #20c997 100%);
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
            border: 2px solid #17a2b8;
            padding: 8px 12px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .navbar-toggler:hover {
            background: rgba(23, 162, 184, 0.1);
            transform: scale(1.05);
        }

        .navbar-toggler:focus {
            box-shadow: 0 0 0 0.25rem rgba(23, 162, 184, 0.25);
        }

        .navbar-toggler-icon {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba(23, 162, 184, 1)' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
        }

        /* Page Header Background Image - Lab Theme */
        .page-header {
            position: relative;
            background-image: url('https://images.unsplash.com/photo-1582719471384-894fbb16e074?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1350&q=80');
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
            background: rgba(23, 162, 184, 0.7);
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
            box-shadow: 0 8px 20px rgba(23, 162, 184, 0.3);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #6c757d 0%, #868e96 100%);
            border: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(108, 117, 125, 0.3);
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
            box-shadow: 0 8px 20px rgba(32, 201, 151, 0.3);
        }

        /* Form Styling */
        .form-control {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: #17a2b8;
            box-shadow: 0 0 0 0.2rem rgba(23, 162, 184, 0.25);
            transform: translateY(-2px);
        }

        .form-label {
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 0.5rem;
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

        .alert-danger::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 6px;
            height: 100%;
            background: var(--danger-gradient);
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
        <a class="navbar-brand d-flex align-items-center" >
            <i class="fas fa-flask"></i>
            <span>Aurora Health Laboratory</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="/lab-technician/dashboard">
                        <i class="fas fa-th-large"></i>Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/lab-technician/tests">
                        <i class="fas fa-vial"></i>My Tests
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/lab-technician/tests/pending">
                        <i class="fas fa-clock"></i>Pending Tests
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/lab-tests">
                        <i class="fas fa-list"></i>All Tests
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

<div class="container mt-4">
    <!-- Updated Page Header with Background Image -->
    <div class="page-header mb-4">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h1 class="mb-1"><i class="fas fa-edit me-2"></i>Update Test Results</h1>
                <p class="text-muted">Enter laboratory test results and findings</p>
            </div>
            <div class="col-md-4 text-end">
                <a href="/lab-technician/tests" class="btn btn-secondary">
                    <i class="fas fa-arrow-left me-1"></i>Back to Tests
                </a>
            </div>
        </div>
    </div>

    <!-- Error Messages -->
    <c:if test="${not empty param.error}">
        <div class="alert alert-danger alert-dismissible fade show mt-3" role="alert">
            <i class="fas fa-exclamation-triangle me-2"></i>${param.error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Test Information -->
    <div class="card mt-4">
        <div class="card-header bg-light">
            <h5 class="mb-0"><i class="fas fa-info-circle me-2"></i>Test Information</h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-3">
                    <strong>Test ID:</strong> #${labTest.id}
                </div>
                <div class="col-md-3">
                    <strong>Patient:</strong> ${labTest.patient.firstName} ${labTest.patient.lastName}
                </div>
                <div class="col-md-3">
                    <strong>Test Name:</strong> ${labTest.testName}
                </div>
                <div class="col-md-3">
                    <strong>Type:</strong> <span class="badge bg-info">${labTest.testType}</span>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-md-3">
                    <strong>Priority:</strong>
                    <c:choose>
                        <c:when test="${labTest.priority == 'URGENT'}">
                            <span class="badge bg-danger">URGENT</span>
                        </c:when>
                        <c:when test="${labTest.priority == 'STAT'}">
                            <span class="badge bg-warning">STAT</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-secondary">NORMAL</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="col-md-3">
                    <strong>Status:</strong>
                    <c:choose>
                        <c:when test="${labTest.status == 'IN_PROGRESS'}">
                            <span class="badge bg-primary">IN PROGRESS</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-warning">${labTest.status}</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="col-md-3">
                    <strong>Requested:</strong> ${labTest.requestedDate}
                </div>
            </div>
            <c:if test="${not empty labTest.description}">
                <div class="row mt-2">
                    <div class="col-12">
                        <strong>Description:</strong> ${labTest.description}
                    </div>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Results Form -->
    <div class="card mt-4">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0"><i class="fas fa-flask me-2"></i>Test Results</h5>
        </div>
        <div class="card-body">
            <form action="/lab-technician/tests/update-results/${labTest.id}" method="post" id="resultsForm" novalidate>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="results" class="form-label">Test Results *</label>
                        <textarea class="form-control" id="results" name="results" rows="3"
                                  placeholder="Enter test results..." required>${labTest.results}</textarea>
                        <div class="invalid-feedback">
                            Please enter test results.
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="normalRange" class="form-label">Normal Range</label>
                        <input type="text" class="form-control" id="normalRange" name="normalRange"
                               placeholder="e.g., 0-100 mg/dL" value="${labTest.normalRange}">
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label for="units" class="form-label">Units</label>
                        <input type="text" class="form-control" id="units" name="units"
                               placeholder="e.g., mg/dL, U/L, %" value="${labTest.units}">
                    </div>
                    <div class="col-md-8 mb-3">
                        <label for="findings" class="form-label">Findings/Interpretation *</label>
                        <textarea class="form-control" id="findings" name="findings" rows="2"
                                  placeholder="Enter findings and interpretation..." required>${labTest.findings}</textarea>
                        <div class="invalid-feedback">
                            Please enter findings and interpretation.
                        </div>
                        <div class="form-text">
                            Use terms like "Normal", "Abnormal", "Elevated", "Decreased" for automatic detection.
                        </div>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="notes" class="form-label">Technician Notes</label>
                    <textarea class="form-control" id="notes" name="notes" rows="2"
                              placeholder="Any additional notes or observations...">${labTest.notes}</textarea>
                </div>

                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                    <a href="/lab-technician/tests" class="btn btn-secondary me-md-2">Cancel</a>
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-save me-1"></i>Save Results & Complete Test
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
    // Navbar scroll effect
    window.addEventListener('scroll', function() {
        const navbar = document.querySelector('.navbar');
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });

    // Validation functions
    function validateTestResults() {
        const results = document.getElementById('results');
        const value = results.value.trim();

        // Check if empty
        if (!value) {
            results.classList.add('is-invalid');
            showCustomError(results, 'Test results are required.');
            return false;
        }

        // Check if contains only integers
        const onlyIntegers = /^\d+$/.test(value);
        if (onlyIntegers) {
            results.classList.add('is-invalid');
            showCustomError(results, 'Test results cannot contain only numbers. Please include text description.');
            return false;
        }

        results.classList.remove('is-invalid');
        hideCustomError(results);
        return true;
    }

    function validateUnits() {
        const units = document.getElementById('units');
        const value = units.value.trim();

        // Optional field, but if filled must contain both characters and numbers
        if (value) {
            const hasLetters = /[A-Za-z]/.test(value);
            const hasNumbers = /\d/.test(value);

            if (!hasLetters || !hasNumbers) {
                units.classList.add('is-invalid');
                showCustomError(units, 'Units should contain both letters and numbers (e.g., mg/dL, U/L).');
                return false;
            }
        }

        units.classList.remove('is-invalid');
        hideCustomError(units);
        return true;
    }

    function validateNormalRange() {
        const normalRange = document.getElementById('normalRange');
        const value = normalRange.value.trim();

        // Optional field, but if filled must contain both characters and numbers
        if (value) {
            const hasLetters = /[A-Za-z]/.test(value);
            const hasNumbers = /\d/.test(value);

            if (!hasLetters || !hasNumbers) {
                normalRange.classList.add('is-invalid');
                showCustomError(normalRange, 'Normal range should contain both numbers and units (e.g., 0-100 mg/dL).');
                return false;
            }
        }

        normalRange.classList.remove('is-invalid');
        hideCustomError(normalRange);
        return true;
    }

    function validateFindings() {
        const findings = document.getElementById('findings');
        const value = findings.value.trim();

        if (!value) {
            findings.classList.add('is-invalid');
            showCustomError(findings, 'Findings and interpretation are required.');
            return false;
        }

        findings.classList.remove('is-invalid');
        hideCustomError(findings);
        return true;
    }

    function showCustomError(field, message) {
        // Remove existing custom error
        hideCustomError(field);

        // Create and show custom error
        const errorDiv = document.createElement('div');
        errorDiv.className = 'invalid-feedback';
        errorDiv.textContent = message;
        errorDiv.id = field.id + 'CustomError';
        field.parentNode.appendChild(errorDiv);
        field.classList.add('is-invalid');
    }

    function hideCustomError(field) {
        const existingError = document.getElementById(field.id + 'CustomError');
        if (existingError) {
            existingError.remove();
        }
    }

    function validateForm() {
        let isValid = true;

        // Validate all fields
        if (!validateTestResults()) isValid = false;
        if (!validateUnits()) isValid = false;
        if (!validateNormalRange()) isValid = false;
        if (!validateFindings()) isValid = false;

        return isValid;
    }

    // Form submission validation
    document.getElementById('resultsForm').addEventListener('submit', function(e) {
        if (!validateForm()) {
            e.preventDefault();
            e.stopPropagation();

            // Scroll to first error
            const firstError = document.querySelector('.is-invalid');
            if (firstError) {
                firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                firstError.focus();
            }
        }
    });

    // Real-time validation
    document.getElementById('results').addEventListener('input', validateTestResults);
    document.getElementById('units').addEventListener('input', validateUnits);
    document.getElementById('normalRange').addEventListener('input', validateNormalRange);
    document.getElementById('findings').addEventListener('input', validateFindings);

    // Clear validation on input for required fields
    document.querySelectorAll('[required]').forEach(field => {
        field.addEventListener('input', function() {
            if (this.value.trim()) {
                this.classList.remove('is-invalid');
                hideCustomError(this);
            }
        });
    });
</script>
</body>
</html>