<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Add Prescription - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap');

        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --danger-gradient: linear-gradient(135deg, #ff6b6b 0%, #ff8e8e 100%);
            --warning-gradient: linear-gradient(135deg, #ffd93d 0%, #ff9a3d 100%);
            --info-gradient: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            --dark-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --light-bg: rgba(251, 251, 251, 0.95);
            --shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
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

        /* Rest of the existing CSS remains exactly the same */
        .card {
            border: none;
            border-radius: 15px;
            background: var(--light-bg);
            backdrop-filter: blur(12px);
            box-shadow: var(--shadow);
            transition: transform 0.4s ease, box-shadow 0.4s ease;
            color: #19060d;
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

        .card.bg-primary::before { background: var(--primary-gradient); }
        .card.bg-success::before { background: var(--success-gradient); }
        .card.bg-warning::before { background: var(--warning-gradient); }
        .card.bg-info::before { background: var(--info-gradient); }

        .btn-outline-primary {
            border-color: rgba(102, 126, 234, 0.5);
            color: #667eea;
        }

        .btn-outline-primary:hover {
            background: var(--primary-gradient);
            color: #fff;
            border-color: var(--primary-gradient);
        }

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
<!-- Updated Navigation Bar -->
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
                    <a class="nav-link active" href="/prescriptions/add">
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
    <!-- Updated Welcome Section with Background Image -->
    <div class="welcome-header mb-4">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h2 class="mb-1">Add New Prescription</h2>
                <p class="text-muted">Prescribe medications for your patients</p>
            </div>
        </div>
    </div>

    <!-- Rest of the content remains exactly the same -->
    <div class="row">
        <div class="col-md-8 mx-auto">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0"><i class="fas fa-prescription me-2"></i>Add New Prescription</h4>
                </div>
                <div class="card-body">
                    <!-- Success/Error Messages -->
                    <c:if test="${not empty success}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                                ${success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="/prescriptions/add" method="post" id="prescriptionForm" novalidate>
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
                                        (ID: ${patient.id})
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
                            <div class="col-md-8 mb-3">
                                <label for="medicationName" class="form-label">Medication Name *</label>
                                <input type="text" class="form-control" id="medicationName" name="medicationName"
                                       placeholder="e.g., Amoxicillin, Paracetamol" required
                                       pattern="[A-Za-z\s]+" title="Medication name should contain only letters and spaces">
                                <div class="invalid-feedback">
                                    Please enter a valid medication name (letters and spaces only, no numbers).
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="dosage" class="form-label">Dosage *</label>
                                <input type="text" class="form-control" id="dosage" name="dosage"
                                       placeholder="e.g., 500mg, 10ml" required
                                       pattern="^[A-Za-z\s]*[0-9]+[A-Za-z\s]*$" title="Dosage should contain both letters and numbers (e.g., 500mg, 10ml)">
                                <div class="invalid-feedback">
                                    Please enter a valid dosage format (combination of letters and numbers, e.g., 500mg, 10ml).
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="frequency" class="form-label">Frequency *</label>
                                <select class="form-select" id="frequency" name="frequency" required>
                                    <option value="">Select frequency...</option>
                                    <option value="Once daily">Once daily</option>
                                    <option value="Twice daily">Twice daily</option>
                                    <option value="Three times daily">Three times daily</option>
                                    <option value="Four times daily">Four times daily</option>
                                    <option value="Every 6 hours">Every 6 hours</option>
                                    <option value="Every 8 hours">Every 8 hours</option>
                                    <option value="Every 12 hours">Every 12 hours</option>
                                    <option value="As needed">As needed</option>
                                </select>
                                <div class="invalid-feedback">
                                    Please select a frequency.
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="duration" class="form-label">Duration *</label>
                                <input type="text" class="form-control" id="duration" name="duration"
                                       placeholder="e.g., 7 days, 2 weeks, 1 month" required>
                                <div class="invalid-feedback">
                                    Please enter the duration.
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="instructions" class="form-label">Special Instructions</label>
                            <textarea class="form-control" id="instructions" name="instructions" rows="3"
                                      placeholder="e.g., Take with food, Avoid alcohol, Complete full course..."></textarea>
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="/doctor/dashboard" class="btn btn-secondary me-md-2">Cancel</a>
                            <button type="submit" class="btn btn-primary" id="submitBtn">
                                <i class="fas fa-save me-1"></i>Save Prescription
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Common Medications -->
            <div class="card mt-4">
                <div class="card-header bg-light">
                    <h6 class="mb-0"><i class="fas fa-lightbulb me-2"></i>Common Medications</h6>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-4">
                            <button class="btn btn-outline-primary btn-sm w-100 mb-2 template-btn"
                                    data-medication="Amoxicillin" data-dosage="500mg" data-frequency="Three times daily" data-duration="7 days">
                                Amoxicillin 500mg
                            </button>
                        </div>
                        <div class="col-md-4">
                            <button class="btn btn-outline-primary btn-sm w-100 mb-2 template-btn"
                                    data-medication="Paracetamol" data-dosage="500mg" data-frequency="Every 6 hours" data-duration="5 days">
                                Paracetamol 500mg
                            </button>
                        </div>
                        <div class="col-md-4">
                            <button class="btn btn-outline-primary btn-sm w-100 mb-2 template-btn"
                                    data-medication="Ibuprofen" data-dosage="400mg" data-frequency="Three times daily" data-duration="3 days">
                                Ibuprofen 400mg
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
<script>
    // Template button functionality
    document.querySelectorAll('.template-btn').forEach(button => {
        button.addEventListener('click', function() {
            document.getElementById('medicationName').value = this.getAttribute('data-medication');
            document.getElementById('dosage').value = this.getAttribute('data-dosage');
            document.getElementById('frequency').value = this.getAttribute('data-frequency');
            document.getElementById('duration').value = this.getAttribute('data-duration');

            // Clear any validation errors when using templates
            clearValidationErrors();
        });
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
    function validateMedicationName() {
        const medicationName = document.getElementById('medicationName');
        const regex = /^[A-Za-z\s]+$/;

        if (!regex.test(medicationName.value.trim())) {
            medicationName.classList.add('is-invalid');
            return false;
        } else {
            medicationName.classList.remove('is-invalid');
            return true;
        }
    }

    function validateDosage() {
        const dosage = document.getElementById('dosage');
        // Pattern: must contain at least one letter and one number
        const regex = /^(?=.*[A-Za-z])(?=.*\d).+$/;

        if (!regex.test(dosage.value.trim())) {
            dosage.classList.add('is-invalid');
            return false;
        } else {
            dosage.classList.remove('is-invalid');
            return true;
        }
    }

    function validateForm() {
        let isValid = true;

        // Validate medication name (letters only)
        if (!validateMedicationName()) {
            isValid = false;
        }

        // Validate dosage (letters + numbers)
        if (!validateDosage()) {
            isValid = false;
        }

        // Validate required fields
        const requiredFields = document.querySelectorAll('[required]');
        requiredFields.forEach(field => {
            if (!field.value.trim()) {
                field.classList.add('is-invalid');
                isValid = false;
            } else {
                field.classList.remove('is-invalid');
            }
        });

        return isValid;
    }

    function clearValidationErrors() {
        const fields = document.querySelectorAll('.is-invalid');
        fields.forEach(field => {
            field.classList.remove('is-invalid');
        });
    }

    // Real-time validation
    document.getElementById('medicationName').addEventListener('input', validateMedicationName);
    document.getElementById('dosage').addEventListener('input', validateDosage);

    // Form submission validation
    document.getElementById('prescriptionForm').addEventListener('submit', function(e) {
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

    // Bootstrap validation
    (function() {
        'use strict';
        window.addEventListener('load', function() {
            // Clear validation on input
            const forms = document.getElementsByClassName('needs-validation');
            Array.prototype.filter.call(forms, function(form) {
                form.addEventListener('input', function(event) {
                    if (event.target.hasAttribute('pattern')) {
                        if (event.target.checkValidity()) {
                            event.target.classList.remove('is-invalid');
                        }
                    }
                }, false);
            });
        }, false);
    })();
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>