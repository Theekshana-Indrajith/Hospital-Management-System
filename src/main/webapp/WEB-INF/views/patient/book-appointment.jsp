<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Book Appointment - HMS</title>
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
            background-image: url('https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80');
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
            background: var(--success-gradient);
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
            position: relative;
        }

        .card-header.bg-success {
            background: var(--success-gradient);
            color: #fff;
        }

        .card-header.bg-success::before {
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

        .card-header.bg-success:hover::before {
            transform: scaleX(1);
        }

        /* Success Message Card */
        #successMessage {
            display: none;
            border: none;
            background: var(--light-bg);
            backdrop-filter: blur(12px);
            box-shadow: var(--shadow);
        }

        #successMessage .card-header {
            background: var(--success-gradient);
        }

        /* Patient Info Styling */
        .patient-info {
            background: rgba(241, 245, 249, 0.95);
            backdrop-filter: blur(8px);
            border-radius: 10px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .patient-info:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        /* Time Slot Info Styling */
        .time-slot-info {
            background: rgba(227, 242, 253, 0.95);
            backdrop-filter: blur(8px);
            border-radius: 10px;
            padding: 15px;
            border: 1px solid rgba(0, 123, 255, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .time-slot-info:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        /* Fee Breakdown Styling */
        .fee-breakdown {
            background: rgba(227, 242, 253, 0.95);
            backdrop-filter: blur(8px);
            border-radius: 10px;
            padding: 15px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .fee-breakdown:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        .total-fee {
            background: rgba(200, 230, 201, 0.95);
            backdrop-filter: blur(8px);
            border-left: 4px solid var(--success-gradient);
            border-radius: 8px;
            padding: 10px;
        }

        .doctor-fee {
            font-weight: bold;
            color: #2c5aa0;
            background: linear-gradient(135deg, #007bff 0%, #00d4ff 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        /* Payment Option Styling */
        .payment-option {
            border: 2px solid rgba(0, 123, 255, 0.2);
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 15px;
            cursor: pointer;
            transition: all 0.3s ease;
            background: var(--light-bg);
            backdrop-filter: blur(8px);
            position: relative;
            overflow: hidden;
        }

        .payment-option:hover {
            border-color: var(--primary-gradient);
            background: rgba(232, 241, 255, 0.95);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 123, 255, 0.2);
        }

        .payment-option.selected {
            border-color: var(--primary-gradient);
            background: rgba(232, 241, 255, 0.95);
            box-shadow: 0 8px 20px rgba(0, 123, 255, 0.3);
        }

        .payment-option::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s ease;
        }

        .payment-option:hover::before {
            left: 100%;
        }

        .payment-icon {
            font-size: 2rem;
            margin-bottom: 10px;
            transition: transform 0.3s ease;
        }

        .payment-option:hover .payment-icon {
            transform: scale(1.2) rotate(5deg);
        }

        /* Loading Spinner Styling */
        .loading-spinner {
            display: none;
            background: var(--light-bg);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 2rem;
            box-shadow: var(--shadow);
            position: relative;
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); opacity: 1; }
            50% { transform: scale(1.05); opacity: 0.9; }
        }

        .spinner-border {
            border-width: 4px;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Form Styling */
        .form-control, .form-select, .form-check-input {
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-gradient);
            box-shadow: 0 0 10px rgba(0, 123, 255, 0.3);
        }

        .form-check-input:checked {
            background-color: var(--success-gradient);
            border-color: var(--success-gradient);
        }

        .form-check-label {
            color: #2c3e50;
        }

        /* Button Styling */
        .btn-success, .btn-primary, .btn-secondary, .btn-outline-success {
            border-radius: 25px;
            font-weight: 600;
            padding: 0.75rem 1.5rem;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .btn-success {
            background: var(--success-gradient);
            border: none;
            color: #fff;
        }

        .btn-primary {
            background: var(--primary-gradient);
            border: none;
            color: #fff;
        }

        .btn-secondary {
            background: var(--dark-gradient);
            border: none;
            color: #fff;
        }

        .btn-outline-success {
            border-color: var(--success-gradient);
            color: var(--success-gradient);
        }

        .btn-success:hover, .btn-primary:hover, .btn-secondary:hover, .btn-outline-success:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 123, 255, 0.3);
        }

        .btn-success::before, .btn-primary::before, .btn-secondary::before, .btn-outline-success::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s ease;
        }

        .btn-success:hover::before, .btn-primary:hover::before, .btn-secondary:hover::before, .btn-outline-success:hover::before {
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

        .alert.alert-danger::before, .alert.alert-info::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 6px;
            height: 100%;
            background: var(--danger-gradient);
        }

        .alert.alert-info::before {
            background: var(--info-gradient);
        }

        .alert i {
            animation: alertIcon 2s ease-in-out infinite;
        }

        @keyframes alertIcon {
            0%, 100% { transform: rotate(0deg); }
            25% { transform: rotate(10deg); }
            75% { transform: rotate(-10deg); }
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
            .card {
                padding: 1rem;
            }

            .card:hover {
                transform: translateY(-5px) scale(1.01);
            }

            .btn-success, .btn-primary, .btn-secondary, .btn-outline-success {
                padding: 0.5rem 1rem;
                font-size: 0.9rem;
            }

            .patient-info, .time-slot-info, .fee-breakdown, .payment-option {
                font-size: 0.9rem;
            }

            .payment-icon {
                font-size: 1.8rem;
            }

            .loading-spinner {
                padding: 1.5rem;
            }

            footer {
                padding: 2rem 0;
            }
        }

        @media (max-width: 576px) {
            .card-header h4 {
                font-size: 1.5rem;
            }

            .form-control, .form-select, .form-check-label {
                font-size: 0.9rem;
            }

            .payment-icon {
                font-size: 1.5rem;
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
                    <a class="nav-link" href="/patient/dashboard">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="/patient/appointments">← Back to Appointments</a>
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


<div class="container-fluid mt-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <!-- Loading Spinner -->
            <div class="text-center loading-spinner fade-in" id="loadingSpinner">
                <div class="spinner-border text-primary" role="status" style="width: 3rem; height: 3rem;">
                    <span class="visually-hidden">Loading...</span>
                </div>
                <p class="mt-2">Creating your appointment...</p>
            </div>

            <!-- Success Message (Initially Hidden) -->
            <div class="card border-success mb-4 fade-in" id="successMessage">
                <div class="card-header bg-success text-white">
                    <h4 class="mb-0"><i class="fas fa-check-circle me-2"></i>Appointment Booked Successfully!</h4>
                </div>
                <div class="card-body">
                    <div id="successContent">
                        <!-- Success content will be loaded here via AJAX -->
                    </div>
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-3">
                        <a href="/patient/appointments" class="btn btn-primary me-md-2">
                            <i class="fas fa-list me-1"></i>View My Appointments
                        </a>
                        <button onclick="resetForm()" class="btn btn-outline-success">
                            <i class="fas fa-plus me-1"></i>Book Another Appointment
                        </button>
                    </div>
                </div>
            </div>

            <!-- Booking Form (Initially Visible) -->
            <div class="card fade-in" id="bookingFormCard">
                <div class="card-header bg-success text-white">
                    <h4 class="mb-0"><i class="fas fa-calendar-plus me-2"></i>Book New Appointment</h4>
                </div>
                <div class="card-body">
                    <!-- Display Error Messages -->
                    <c:if test="${not empty param.error}">
                        <div class="alert alert-danger alert-dismissible fade show fade-in" role="alert">
                            <strong>Error!</strong> ${param.error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <!-- Patient Information -->
                    <div class="patient-info mb-4 p-3 rounded fade-in">
                        <h6><i class="fas fa-user me-2"></i>Patient Information</h6>
                        <div class="row">
                            <div class="col-md-6">
                                <p class="mb-1"><strong>Name:</strong> ${patient.firstName} ${patient.lastName}</p>
                                <p class="mb-1"><strong>Contact:</strong> ${patient.contactNumber}</p>
                            </div>
                            <div class="col-md-6">
                                <p class="mb-1"><strong>Email:</strong> ${patient.email}</p>
                                <p class="mb-0"><strong>Patient ID:</strong> P${patient.id}</p>
                            </div>
                        </div>
                    </div>

                    <!-- Time Slot Information -->
                    <div class="time-slot-info mb-4 p-3 border border-primary rounded fade-in">
                        <h6 class="text-primary mb-3">
                            <i class="fas fa-calendar-day me-2"></i>Available Appointment Slots
                        </h6>
                        <div class="row">
                            <div class="col-md-6">
                                <p class="mb-2">
                                    <strong><i class="fas fa-calendar me-2 text-success"></i>Days:</strong><br>
                                    <span class="ms-4">Monday to Saturday</span>
                                </p>
                            </div>
                            <div class="col-md-6">
                                <p class="mb-2">
                                    <strong><i class="fas fa-clock me-2 text-success"></i>Timing:</strong><br>
                                    <span class="ms-4">4:00 PM to 10:00 PM</span>
                                </p>
                            </div>
                        </div>
                    </div>

                    <!-- Booking Form -->
                    <form id="bookingForm" action="/patient/appointments/book" method="post" class="fade-in">
                        <!-- Doctor Selection -->
                        <div class="mb-4">
                            <label class="form-label"><strong>Select Doctor *</strong></label>

                            <!-- Search Bar for Specialization -->
                            <div class="input-group mb-3">
                                <span class="input-group-text"><i class="fas fa-search"></i></span>
                                <input type="text" class="form-control" id="specializationSearch"
                                       placeholder="Search by specialization (e.g., Cardiology, Neurology, Pediatrics...)"
                                       onkeyup="filterDoctors()">
                            </div>

                            <select name="doctorId" class="form-select" id="doctorSelect" required
                                    onchange="updateFeeCalculation()">
                                <option value="">Choose a doctor...</option>
                                <c:forEach var="doctor" items="${doctors}">
                                    <option value="${doctor.id}"
                                            data-specialization="${doctor.specialization}"
                                            class="doctor-option">
                                        Dr. ${doctor.name} - ${doctor.specialization}
                                        <c:if test="${not empty doctor.roomNumber}">
                                            (Room: ${doctor.roomNumber})
                                        </c:if>
                                    </option>
                                </c:forEach>
                            </select>
                            <small class="text-muted">
                                <i class="fas fa-info-circle me-1"></i>
                                Each doctor has a specific consultation fee based on their specialization
                            </small>

                            <!-- Search Results Info -->
                            <div id="searchResultsInfo" class="mt-2" style="display: none;">
                                <small class="text-info">
                                    <i class="fas fa-filter me-1"></i>
                                    <span id="resultsCount">0</span> doctors found matching your search
                                </small>
                            </div>
                        </div>

                        <!-- Fee Calculation Display -->
                        <div class="mb-4 fade-in" id="feeSection" style="display: none;">
                            <div class="fee-breakdown p-3 mb-2">
                                <h6 class="mb-3"><i class="fas fa-calculator me-2"></i>Fee Breakdown</h6>
                                <div class="row mb-2">
                                    <div class="col-8">
                                        <span id="feeDescription">Consultation Fee:</span>
                                    </div>
                                    <div class="col-4 text-end">
                                        <span id="consultationFeeAmount" class="doctor-fee">Rs. 0.00</span>
                                    </div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-8">
                                        <span>Service Fee:</span>
                                        <small class="text-muted d-block">(Administrative & facility charges)</small>
                                    </div>
                                    <div class="col-4 text-end">
                                        <span id="serviceFeeAmount">Rs. 0.00</span>
                                    </div>
                                </div>
                                <hr class="my-2">
                                <div class="row total-fee p-2">
                                    <div class="col-8">
                                        <strong>Total Amount Payable:</strong>
                                    </div>
                                    <div class="col-4 text-end">
                                        <strong id="totalFeeAmount" class="text-success">Rs. 0.00</strong>
                                    </div>
                                </div>
                            </div>
                            <small class="text-muted">
                                <i class="fas fa-info-circle me-1"></i>
                                Service fee includes administrative and facility charges
                            </small>
                        </div>

                        <!-- Appointment Date & Time -->
                        <div class="mb-3">
                            <label class="form-label"><strong>Appointment Date & Time *</strong></label>
                            <input type="datetime-local" name="appointmentDateTime" class="form-control" required
                                   id="appointmentDateTime"
                                   min="<%= java.time.LocalDateTime.now().plusHours(2).format(java.time.format.DateTimeFormatter.ISO_LOCAL_DATE_TIME).substring(0,16) %>">
                            <small class="text-muted">
                                <i class="fas fa-info-circle me-1"></i>
                                Available: <strong>Monday to Saturday, 4:00 PM - 10:00 PM</strong>. Appointments must be booked at least 2 hours in advance.
                            </small>
                            <div id="datetimeHelp" class="form-text text-info">
                                <i class="fas fa-calendar me-1"></i>Select from available slots: Mon-Sat, 4PM-10PM
                            </div>
                        </div>

                        <!-- Reason for Appointment -->
                        <div class="mb-4">
                            <label class="form-label"><strong>Reason for Appointment *</strong></label>
                            <textarea name="reason" class="form-control" rows="3"
                                      placeholder="Please describe the reason for your appointment (symptoms, concerns, follow-up, etc.)..."
                                      required id="reasonText"></textarea>
                        </div>

                        <!-- Payment Method Selection -->
                        <div class="mb-4">
                            <label class="form-label"><strong>Select Payment Method *</strong></label>
                            <div class="row">
                                <!-- Manual Payment Option -->
                                <div class="col-md-6">
                                    <div class="payment-option fade-in" id="manualOption" data-payment-method="MANUAL">
                                        <div class="text-center">
                                            <div class="payment-icon text-primary">
                                                <i class="fas fa-hospital"></i>
                                            </div>
                                            <h6>Pay at Hospital</h6>
                                            <p class="small mb-1">Pay cash at reception counter</p>
                                            <small class="text-muted">Pay the total amount shown above</small>
                                        </div>
                                    </div>
                                </div>

                                <!-- Online Payment Option -->
                                <div class="col-md-6">
                                    <div class="payment-option fade-in" id="onlineOption" data-payment-method="ONLINE">
                                        <div class="text-center">
                                            <div class="payment-icon text-success">
                                                <i class="fas fa-credit-card"></i>
                                            </div>
                                            <h6>Online Payment</h6>
                                            <p class="small mb-1">Pay now with card/online banking</p>
                                            <small class="text-muted">Instant confirmation</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <input type="hidden" name="paymentMethod" id="paymentMethod" required>
                            <div class="invalid-feedback fade-in" id="paymentMethodError" style="display: none;">
                                Please select a payment method
                            </div>
                        </div>

                        <!-- Payment Instructions -->
                        <div class="alert alert-info fade-in" id="paymentInstructions">
                            <small>
                                <i class="fas fa-info-circle me-1"></i>
                                <span id="instructionsText">Please select a payment method</span>
                            </small>
                        </div>

                        <!-- Terms and Conditions -->
                        <div class="form-check mb-4 fade-in">
                            <input class="form-check-input" type="checkbox" id="termsCheck" required>
                            <label class="form-check-label small" for="termsCheck">
                                I understand and agree to the appointment cancellation policy and terms of service.
                                I will pay the total amount of <strong id="termsTotalAmount">Rs. 0.00</strong> as shown above.
                            </label>
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="/patient/appointments" class="btn btn-secondary me-md-2">
                                <i class="fas fa-times me-1"></i>Cancel
                            </a>
                            <button type="submit" class="btn btn-success" id="submitBtn">
                                <i class="fas fa-calendar-check me-1"></i>Book Appointment
                            </button>
                        </div>
                    </form>
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
    let selectedPaymentMethod = '';
    const SERVICE_FEE = 200.00; // Fixed service fee
    let currentConsultationFee = 0;
    let currentTotalFee = 0;

    // Fee structure based on specialization
    const FEE_STRUCTURE = {
        'CARDIOLOGY': 2500.00,
        'NEUROLOGY': 2200.00,
        'ORTHOPEDICS': 1800.00,
        'PEDIATRICS': 1200.00,
        'DERMATOLOGY': 1500.00,
        'GENERAL PHYSICIAN': 1000.00,
        'GENERAL': 1000.00
    };

    // Filter doctors by specialization search
    function filterDoctors() {
        const searchTerm = document.getElementById('specializationSearch').value.toLowerCase();
        const doctorOptions = document.querySelectorAll('.doctor-option');
        const doctorSelect = document.getElementById('doctorSelect');
        const searchResultsInfo = document.getElementById('searchResultsInfo');
        const resultsCount = document.getElementById('resultsCount');

        let visibleCount = 0;

        doctorOptions.forEach(option => {
            const specialization = option.getAttribute('data-specialization').toLowerCase();
            const optionText = option.textContent.toLowerCase();

            if (specialization.includes(searchTerm) || optionText.includes(searchTerm) || searchTerm === '') {
                option.style.display = '';
                visibleCount++;
            } else {
                option.style.display = 'none';
            }
        });

        // Show/hide search results info
        if (searchTerm !== '') {
            searchResultsInfo.style.display = 'block';
            resultsCount.textContent = visibleCount;

            // If no doctors found, show message
            if (visibleCount === 0) {
                resultsCount.innerHTML = '<span class="text-danger">0</span> - No doctors found for "' + searchTerm + '"';
            }
        } else {
            searchResultsInfo.style.display = 'none';
        }

        // Reset selection if current selection is hidden
        const selectedOption = doctorSelect.options[doctorSelect.selectedIndex];
        if (selectedOption.style.display === 'none' && selectedOption.value !== '') {
            doctorSelect.value = '';
            updateFeeCalculation();
        }
    }

    // Initialize payment method selection when DOM is loaded
    document.addEventListener('DOMContentLoaded', function() {
        // Add click event listeners to payment options
        document.querySelectorAll('.payment-option').forEach(option => {
            option.addEventListener('click', function() {
                const method = this.getAttribute('data-payment-method');
                selectPaymentMethod(method);
            });
        });

        const form = document.getElementById('bookingForm');
        const termsCheck = document.getElementById('termsCheck');
        const submitBtn = document.getElementById('submitBtn');
        const loadingSpinner = document.getElementById('loadingSpinner');

        // Set minimum date/time for appointment (2 hours from now)
        const now = new Date();
        now.setHours(now.getHours() + 2);
        const minDateTime = now.toISOString().slice(0, 16);
        document.getElementById('appointmentDateTime').min = minDateTime;

        form.addEventListener('submit', function(e) {
            e.preventDefault(); // Prevent default form submission

            let isValid = true;
            let errorMessage = '';

            // Check terms and conditions
            if (!termsCheck.checked) {
                isValid = false;
                errorMessage = 'Please accept the terms and conditions to proceed.';
                termsCheck.focus();
            }

            // Check if doctor is selected
            const doctorSelect = document.getElementById('doctorSelect');
            if (doctorSelect.value === '') {
                isValid = false;
                errorMessage = 'Please select a doctor.';
                doctorSelect.focus();
            }

            // Check if payment method is selected
            if (!selectedPaymentMethod) {
                isValid = false;
                errorMessage = 'Please select a payment method.';
                document.getElementById('paymentMethodError').style.display = 'block';
            } else {
                document.getElementById('paymentMethodError').style.display = 'none';
            }

            // Check if date/time is valid
            const appointmentDateTime = document.getElementById('appointmentDateTime').value;
            if (!appointmentDateTime) {
                isValid = false;
                errorMessage = 'Please select appointment date and time.';
            }

            // Check if reason is provided
            const reasonText = document.getElementById('reasonText').value.trim();
            if (!reasonText) {
                isValid = false;
                errorMessage = 'Please provide reason for appointment.';
                document.getElementById('reasonText').focus();
            }

            if (!isValid) {
                alert(errorMessage);
                return false;
            }

            // Show loading state
            submitBtn.disabled = true;

            if (selectedPaymentMethod === 'MANUAL') {
                // Use AJAX for manual payment
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>Creating Appointment...';
                submitManualAppointment();
            } else if (selectedPaymentMethod === 'ONLINE') {
                // For online payment, use normal form submission
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>Redirecting to Payment...';

                // Ensure payment method is set in the form
                document.getElementById('paymentMethod').value = 'ONLINE';

                // Submit the form normally for online payment
                form.submit();
            }

            return true;
        });

        // Real-time validation
        const inputs = form.querySelectorAll('input, select, textarea');
        inputs.forEach(input => {
            input.addEventListener('change', function() {
                validateForm();
            });
            input.addEventListener('keyup', function() {
                validateForm();
            });
        });

        function validateForm() {
            const doctorSelected = doctorSelect.value !== '';
            const dateTimeSelected = document.getElementById('appointmentDateTime').value !== '';
            const reasonProvided = document.getElementById('reasonText').value.trim() !== '';
            const termsAccepted = termsCheck.checked;
            const paymentSelected = selectedPaymentMethod !== '';

            submitBtn.disabled = !(doctorSelected && dateTimeSelected && reasonProvided && termsAccepted && paymentSelected);
        }

        // Initialize form validation
        validateForm();

        // Set initial available datetime
        const dateTimeInput = document.getElementById('appointmentDateTime');
        const initialDateTime = suggestNextAvailableDateTime();
        dateTimeInput.value = initialDateTime.toISOString().slice(0, 16);

        // Add event listeners for time slot checking
        document.getElementById('doctorSelect').addEventListener('change', checkTimeSlotAvailability);
        document.getElementById('appointmentDateTime').addEventListener('change', checkTimeSlotAvailability);

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
    });

    // Update fee calculation based on doctor selection
    function updateFeeCalculation() {
        const doctorSelect = document.getElementById('doctorSelect');
        const feeSection = document.getElementById('feeSection');
        const consultationFeeAmount = document.getElementById('consultationFeeAmount');
        const serviceFeeAmount = document.getElementById('serviceFeeAmount');
        const totalFeeAmount = document.getElementById('totalFeeAmount');
        const feeDescription = document.getElementById('feeDescription');
        const termsTotalAmount = document.getElementById('termsTotalAmount');

        const selectedOption = doctorSelect.options[doctorSelect.selectedIndex];

        if (selectedOption.value !== '') {
            const specialization = selectedOption.getAttribute('data-specialization');
            // Get the specific consultation fee for this doctor's specialization
            currentConsultationFee = FEE_STRUCTURE[specialization.toUpperCase()] || FEE_STRUCTURE[specialization.toUpperCase().split(' ')[0]] || 1500.00;
            currentTotalFee = currentConsultationFee + SERVICE_FEE;

            // Update fee display
            consultationFeeAmount.textContent = 'Rs. ' + currentConsultationFee.toLocaleString('en-IN');
            serviceFeeAmount.textContent = 'Rs. ' + SERVICE_FEE.toLocaleString('en-IN');
            totalFeeAmount.textContent = 'Rs. ' + currentTotalFee.toLocaleString('en-IN');
            termsTotalAmount.textContent = 'Rs. ' + currentTotalFee.toLocaleString('en-IN');
            feeDescription.textContent = specialization + ' Consultation Fee:';

            feeSection.style.display = 'block';

            // Update payment instructions if payment method is already selected
            updatePaymentInstructions();
        } else {
            feeSection.style.display = 'none';
            currentConsultationFee = 0;
            currentTotalFee = 0;
        }
        validateForm();
    }

    // Select payment method
    function selectPaymentMethod(method) {
        selectedPaymentMethod = method;
        document.getElementById('paymentMethod').value = method;

        // Update UI
        document.querySelectorAll('.payment-option').forEach(opt => {
            opt.classList.remove('selected');
        });

        if (method === 'MANUAL') {
            document.getElementById('manualOption').classList.add('selected');
            document.getElementById('submitBtn').innerHTML = '<i class="fas fa-calendar-plus me-1"></i>Book Appointment';
        } else if (method === 'ONLINE') {
            document.getElementById('onlineOption').classList.add('selected');
            document.getElementById('submitBtn').innerHTML = '<i class="fas fa-credit-card me-1"></i>Proceed to Payment';
        }

        // Update payment instructions
        updatePaymentInstructions();

        // Hide any payment method error
        document.getElementById('paymentMethodError').style.display = 'none';

        validateForm();
    }

    // Update payment instructions based on selected method and fees
    function updatePaymentInstructions() {
        const instructionsText = document.getElementById('instructionsText');

        if (selectedPaymentMethod === 'MANUAL') {
            if (currentTotalFee > 0) {
                instructionsText.innerHTML =
                    `<strong>Pay at Hospital:</strong> Your appointment will be created immediately. Please visit the hospital reception and pay the total fee of <strong>Rs. ${currentTotalFee.toLocaleString('en-IN')}</strong> before your appointment time.`;
            } else {
                instructionsText.innerHTML =
                    '<strong>Pay at Hospital:</strong> Your appointment will be created immediately. Please visit the hospital reception and pay the total fee before your appointment time.';
            }
        } else if (selectedPaymentMethod === 'ONLINE') {
            if (currentTotalFee > 0) {
                instructionsText.innerHTML =
                    `<strong>Online Payment:</strong> You will be redirected to secure payment gateway to pay <strong>Rs. ${currentTotalFee.toLocaleString('en-IN')}</strong>. Your appointment will be confirmed instantly after successful payment.`;
            } else {
                instructionsText.innerHTML =
                    '<strong>Online Payment:</strong> You will be redirected to secure payment gateway. Your appointment will be confirmed instantly after successful payment.';
            }
        } else {
            instructionsText.innerHTML = 'Please select a payment method';
        }
    }

    // AJAX function for manual payment
    function submitManualAppointment() {
        const formData = new FormData(document.getElementById('bookingForm'));

        // Ensure payment method is included in the form data
        formData.append('paymentMethod', 'MANUAL');

        // Show loading spinner
        document.getElementById('loadingSpinner').style.display = 'block';
        document.getElementById('bookingFormCard').style.display = 'none';

        fetch('/patient/appointments/book-manual-ajax', {
            method: 'POST',
            body: formData
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                // Hide loading spinner
                document.getElementById('loadingSpinner').style.display = 'none';

                if (data.success) {
                    // Redirect to manual confirmation page
                    window.location.href = data.redirectUrl;
                } else {
                    alert('Error: ' + data.message);
                    resetSubmitButton();
                    document.getElementById('bookingFormCard').style.display = 'block';
                }
            })
            .catch(error => {
                console.error('Error:', error);
                // Hide loading spinner
                document.getElementById('loadingSpinner').style.display = 'none';
                alert('Network error. Please try again.');
                resetSubmitButton();
                document.getElementById('bookingFormCard').style.display = 'block';
            });
    }

    // Reset submit button to original state
    function resetSubmitButton() {
        const submitBtn = document.getElementById('submitBtn');
        submitBtn.disabled = false;
        if (selectedPaymentMethod === 'MANUAL') {
            submitBtn.innerHTML = '<i class="fas fa-calendar-plus me-1"></i>Book Appointment';
        } else {
            submitBtn.innerHTML = '<i class="fas fa-credit-card me-1"></i>Proceed to Payment';
        }
    }

    // Add this function to check time slot availability in real-time
    function checkTimeSlotAvailability() {
        const doctorId = document.getElementById('doctorSelect').value;
        const dateTime = document.getElementById('appointmentDateTime').value;

        if (!doctorId || !dateTime) return;

        fetch(`/appointments/check-availability?doctorId=${doctorId}&dateTime=${dateTime}`)
            .then(response => response.json())
            .then(data => {
                const helpText = document.getElementById('datetimeHelp');
                if (data.available) {
                    helpText.innerHTML = '<i class="fas fa-check-circle me-1 text-success"></i>✅ Time slot available';
                    helpText.className = 'form-text text-success';
                } else {
                    // helpText.innerHTML = '<i class="fas fa-times-circle me-1 text-danger"></i>❌ Time slot not available. Please choose another time.';
                    helpText.className = 'form-text text-danger';
                }
            })
            .catch(error => {
                console.error('Error checking time slot:', error);
            });
    }

    // Function to suggest next available datetime
    function suggestNextAvailableDateTime() {
        const now = new Date();
        let suggestedDate = new Date();

        // Start from 2 hours from now
        suggestedDate.setTime(now.getTime() + 2 * 60 * 60 * 1000);

        // If it's Sunday, move to Monday
        if (suggestedDate.getDay() === 0) {
            suggestedDate.setDate(suggestedDate.getDate() + 1);
            suggestedDate.setHours(16, 0, 0, 0); // Set to 4:00 PM
        }
        // If current time is after 10 PM, move to next day
        else if (suggestedDate.getHours() >= 22) {
            suggestedDate.setDate(suggestedDate.getDate() + 1);
            suggestedDate.setHours(16, 0, 0, 0); // Set to 4:00 PM

            // If next day is Sunday, move to Monday
            if (suggestedDate.getDay() === 0) {
                suggestedDate.setDate(suggestedDate.getDate() + 1);
            }
        }
        // If current time is before 4 PM, set to 4 PM today
        else if (suggestedDate.getHours() < 16) {
            suggestedDate.setHours(16, 0, 0, 0);
        }
        // If between 4 PM and 10 PM, round to next 30-minute slot
        else {
            const minutes = suggestedDate.getMinutes();
            if (minutes > 30) {
                suggestedDate.setHours(suggestedDate.getHours() + 1);
                suggestedDate.setMinutes(0);
            } else {
                suggestedDate.setMinutes(30);
            }
        }

        return suggestedDate;
    }

    // Reset form to book another appointment
    function resetForm() {
        document.getElementById('successMessage').style.display = 'none';
        document.getElementById('bookingFormCard').style.display = 'block';
        document.getElementById('bookingForm').reset();
        selectedPaymentMethod = '';
        document.getElementById('feeSection').style.display = 'none';
        document.querySelectorAll('.payment-option').forEach(opt => {
            opt.classList.remove('selected');
        });
        document.getElementById('instructionsText').innerHTML = 'Please select a payment method';
        document.getElementById('termsTotalAmount').textContent = 'Rs. 0.00';
        currentConsultationFee = 0;
        currentTotalFee = 0;
        resetSubmitButton();
        validateForm();

        // Reset to initial available datetime
        const initialDateTime = suggestNextAvailableDateTime();
        document.getElementById('appointmentDateTime').value = initialDateTime.toISOString().slice(0, 16);
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>