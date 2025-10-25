<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Secure Payment - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        /* Importing Google Fonts for a clean, professional look */
        @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700;900&display=swap');
        @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&display=swap');

        /* Define CSS variables for consistent theming */
        :root {
            --primary-gradient: linear-gradient(135deg, #007bff 0%, #00d4ff 100%);
            --secondary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --success-gradient: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            --light-success-gradient: linear-gradient(135deg, #90EE90 0%, #B0F4D8 100%);
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
            background: var(--secondary-gradient);
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

        .card-header.bg-primary {
            background: var(--secondary-gradient);
            color: #fff;
        }

        .card-header.bg-primary::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--secondary-gradient);
            transform: scaleX(0);
            transition: transform 0.4s ease;
        }

        .card-header.bg-primary:hover::before {
            transform: scaleX(1);
        }

        /* Payment Card Styling */
        .payment-card {
            border: 2px solid var(--light-success-gradient);
            border-radius: 15px;
            padding: 20px;
            background: var(--light-success-gradient);
            color: white;
            backdrop-filter: blur(12px);
            box-shadow: var(--shadow);
            transition: transform 0.4s ease, box-shadow 0.4s ease;
        }

        .payment-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
        }

        /* Card Logo Styling */
        .card-logo {
            font-size: 2rem;
            margin-bottom: 15px;
            color: #fff;
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); opacity: 1; }
            50% { transform: scale(1.1); opacity: 0.9; }
        }

        /* Form Control Styling */
        .form-control {
            border-radius: 10px;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(8px);
            border: 1px solid rgba(0, 123, 255, 0.2);
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--secondary-gradient);
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            background: rgba(255, 255, 255, 1);
        }

        /* Validation Styles */
        .is-valid {
            border-color: var(--success-gradient) !important;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 8 8'%3e%3cpath fill='%2328a745' d='M2.3 6.73L.6 4.53c-.4-1.04.46-1.4 1.1-.8l1.1 1.4 3.4-3.8c.6-.63 1.6-.27 1.2.7l-4 4.6c-.43.5-.8.4-1.1.1z'/%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right calc(0.375em + 0.1875rem) center;
            background-size: calc(0.75em + 0.375rem) calc(0.75em + 0.375rem);
            transition: all 0.3s ease;
        }

        .is-valid:focus {
            box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25);
        }

        .is-invalid {
            border-color: var(--danger-gradient) !important;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 12 12' width='12' height='12' fill='none' stroke='%23dc3545'%3e%3ccircle cx='6' cy='6' r='4.5'/%3e%3cpath d='m5.8 3.6.4.4.4-.4'/%3e%3cpath d='M6 7v1'/%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right calc(0.375em + 0.1875rem) center;
            background-size: calc(0.75em + 0.375rem) calc(0.75em + 0.375rem);
            animation: shake 0.3s ease;
        }

        .is-invalid:focus {
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        .invalid-feedback {
            display: none;
            width: 100%;
            margin-top: 0.25rem;
            font-size: 0.875em;
            color: var(--danger-gradient);
            background: rgba(255, 255, 255, 0.9);
            padding: 0.25rem 0.5rem;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .is-invalid ~ .invalid-feedback {
            display: block;
        }

        /* Payment Summary Styling */
        .payment-summary {
            background: rgba(241, 245, 249, 0.95);
            backdrop-filter: blur(8px);
            border-radius: 10px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .payment-summary:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        /* Fee Breakdown Styling */
        .fee-breakdown {
            background: rgba(248, 249, 250, 0.95);
            backdrop-filter: blur(8px);
            border-radius: 10px;
            padding: 15px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .fee-breakdown:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        .total-amount {
            background: rgba(200, 230, 201, 0.95);
            backdrop-filter: blur(8px);
            border-left: 4px solid var(--success-gradient);
            border-radius: 8px;
            padding: 10px;
            font-weight: bold;
        }

        /* Alert Styling */
        .alert {
            border-radius: 10px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(8px);
            border: 1px solid rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .alert-danger {
            background: rgba(248, 215, 218, 0.95);
            border-color: var(--danger-gradient);
            color: #721c24;
        }

        .alert-info {
            background: rgba(207, 244, 252, 0.95);
            border-color: var(--info-gradient);
            color: #0c5460;
        }

        /* Button Styling */
        .btn-success, .btn-outline-secondary {
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

        .btn-outline-secondary {
            border-color: var(--secondary-gradient);
            color: var(--secondary-gradient);
        }

        .btn-success:hover, .btn-outline-secondary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 123, 255, 0.3);
        }

        .btn-success::before, .btn-outline-secondary::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s ease;
        }

        .btn-success:hover::before, .btn-outline-secondary:hover::before {
            left: 100%;
        }

        .btn-success:disabled {
            background: var(--secondary-gradient);
            opacity: 0.7;
            cursor: not-allowed;
        }

        /* Payment Security Card Styling */
        .card.border-primary {
            background: rgba(227, 242, 253, 0.95);
            backdrop-filter: blur(8px);
            border-color: var(--secondary-gradient);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card.border-primary:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
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

            .btn-success, .btn-outline-secondary {
                padding: 0.5rem 1rem;
                font-size: 0.9rem;
            }

            .payment-summary, .fee-breakdown, .payment-card {
                font-size: 0.9rem;
            }

            .card-logo {
                font-size: 1.5rem;
            }

            footer {
                padding: 2rem 0;
            }
        }

        @media (max-width: 576px) {
            .card-header h4 {
                font-size: 1.5rem;
            }

            .card-logo {
                font-size: 1.2rem;
            }
        }
    </style>
</head>
<body>
<!-- Navigation -->
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
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card fade-in">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0"><i class="fas fa-lock me-2"></i>Secure Online Payment</h4>
                </div>
                <div class="card-body">
                    <!-- Display Error Messages -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show fade-in" role="alert">
                            <strong>Payment Failed!</strong> ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <!-- Payment Summary -->
                    <div class="payment-summary mb-4 p-3 rounded fade-in">
                        <h6><i class="fas fa-receipt me-2"></i>Payment Summary</h6>
                        <div class="row">
                            <div class="col-md-6">
                                <p class="mb-1">
                                    <strong>Patient:</strong>
                                    <c:choose>
                                        <c:when test="${not empty appointment.patient}">
                                            ${appointment.patient.firstName} ${appointment.patient.lastName}
                                        </c:when>
                                        <c:otherwise>Not specified</c:otherwise>
                                    </c:choose>
                                </p>
                                <p class="mb-1">
                                    <strong>Doctor:</strong>
                                    <c:choose>
                                        <c:when test="${not empty appointment.doctor}">
                                            Dr. ${appointment.doctor.name}
                                        </c:when>
                                        <c:otherwise>Not assigned</c:otherwise>
                                    </c:choose>
                                </p>
                                <p class="mb-1">
                                    <strong>Specialization:</strong>
                                    <c:choose>
                                        <c:when test="${not empty appointment.doctor}">
                                            ${appointment.doctor.specialization}
                                        </c:when>
                                        <c:otherwise>Not specified</c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                            <div class="col-md-6">
                                <p class="mb-1"><strong>Appointment Date:</strong> ${formattedAppointmentDateTime}</p>
                                <p class="mb-1"><strong>Appointment ID:</strong> A${appointment.id}</p>
                            </div>
                        </div>

                        <!-- Fee Breakdown -->
                        <div class="fee-breakdown mt-3">
                            <div class="row mb-1">
                                <div class="col-8">
                                    <span>Consultation Fee:</span>
                                </div>
                                <div class="col-4 text-end">
                                    <span>Rs. ${appointment.consultationFee != null ? appointment.consultationFee : '0.00'}</span>
                                </div>
                            </div>
                            <div class="row mb-1">
                                <div class="col-8">
                                    <span>Service Fee:</span>
                                </div>
                                <div class="col-4 text-end">
                                    <span>Rs. 200.00</span>
                                </div>
                            </div>
                            <hr class="my-2">
                            <div class="row total-amount p-2">
                                <div class="col-8">
                                    <strong>Total Amount:</strong>
                                </div>
                                <div class="col-4 text-end">
                                    <strong class="text-success">
                                        Rs. ${(appointment.consultationFee != null ? appointment.consultationFee : 0) + 200.00}
                                    </strong>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Payment Gateway Form -->
                    <div class="row">
                        <!-- Card Details Form -->
                        <div class="col-md-7">
                            <div class="payment-card fade-in">
                                <div class="text-center">
                                    <i class="fas fa-credit-card card-logo"></i>
                                </div>
                                <form action="/payments/process-online" method="post" id="paymentForm" novalidate>
                                    <input type="hidden" name="appointmentId" value="${appointment.id}">

                                    <!-- Card Number -->
                                    <div class="mb-3">
                                        <label class="form-label"><strong>Card Number *</strong></label>
                                        <div class="input-group">
                                            <input type="text" name="cardNumber" class="form-control card-input"
                                                   placeholder="1234 5678 9012 3456" required
                                                   maxlength="19"
                                                   oninput="formatCardNumber(this)"
                                                   onblur="validateCardNumber(this)">
                                            <span class="input-group-text">
            <i class="fas fa-credit-card"></i>
        </span>
                                        </div>
                                        <div class="invalid-feedback" id="cardNumberError">
                                            Please enter a valid 16-digit card number.
                                        </div>
                                        <small class="text-muted">
                                            <i class="fas fa-info-circle me-1"></i>
                                            Enter any 16-digit number for payment
                                        </small>
                                    </div>

                                    <!-- Card Holder Name -->
                                    <div class="mb-3">
                                        <label class="form-label"><strong>Card Holder Name *</strong></label>
                                        <input type="text" name="cardHolder" class="form-control card-input"
                                               placeholder="JOHN DOE" required
                                               onblur="validateCardHolder(this)">
                                        <div class="invalid-feedback" id="cardHolderError">
                                            Please enter the name as it appears on your card.
                                        </div>
                                    </div>

                                    <!-- Expiry Date and CVV -->
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label class="form-label"><strong>Expiry Date *</strong></label>
                                            <input type="text" name="expiryDate" class="form-control card-input"
                                                   placeholder="MM/YY" required
                                                   maxlength="5"
                                                   oninput="formatExpiryDate(this)"
                                                   onblur="validateExpiryDate(this)">
                                            <div class="invalid-feedback" id="expiryDateError">
                                                Please enter a valid expiry date (MM/YY).
                                            </div>
                                            <small class="text-muted">Format: MM/YY</small>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label"><strong>CVV *</strong></label>
                                            <div class="input-group">
                                                <input type="text" name="cvv" class="form-control card-input"
                                                       placeholder="123" required maxlength="3"
                                                       oninput="formatCVV(this)"
                                                       onblur="validateCVV(this)">
                                                <span class="input-group-text">
                                                    <i class="fas fa-lock"></i>
                                                </span>
                                            </div>
                                            <div class="invalid-feedback" id="cvvError">
                                                Please enter a valid 3-digit CVV.
                                            </div>
                                            <small class="text-muted">3 digits on back of card</small>
                                        </div>
                                    </div>

                                    <!-- Security Notice -->
                                    <div class="alert alert-info">
                                        <small>
                                            <i class="fas fa-shield-alt me-1"></i>
                                            <strong>Secure Payment:</strong> Your payment information is encrypted and secure.
                                            We do not store your card details.
                                        </small>
                                    </div>

                                    <!-- Submit Button -->
                                    <div class="d-grid gap-2">
                                        <button type="submit" class="btn btn-success btn-lg" id="payButton">
                                            <i class="fas fa-lock me-1"></i>Pay Rs. ${appointment.consultationFee + 200.00}
                                        </button>
                                        <a href="/appointments/my-appointments" class="btn btn-outline-secondary">
                                            <i class="fas fa-times me-1"></i>Cancel Payment
                                        </a>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <!-- Payment Security Info -->
                        <div class="col-md-5">
                            <div class="card border-primary fade-in">
                                <div class="card-header bg-primary text-white">
                                    <h6 class="mb-0"><i class="fas fa-shield-alt me-2"></i>Payment Security</h6>
                                </div>
                                <div class="card-body">
                                    <div class="text-center mb-3">
                                        <i class="fas fa-lock fa-3x text-primary"></i>
                                    </div>
                                    <ul class="list-unstyled small">
                                        <li class="mb-2">
                                            <i class="fas fa-check text-success me-2"></i>
                                            SSL Encrypted Connection
                                        </li>
                                        <li class="mb-2">
                                            <i class="fas fa-check text-success me-2"></i>
                                            PCI DSS Compliant
                                        </li>
                                        <li class="mb-2">
                                            <i class="fas fa-check text-success me-2"></i>
                                            Secure Payment Gateway
                                        </li>
                                        <li class="mb-2">
                                            <i class="fas fa-check text-success me-2"></i>
                                            Instant Confirmation
                                        </li>
                                        <li class="mb-0">
                                            <i class="fas fa-check text-success me-2"></i>
                                            Downloadable Receipt
                                        </li>
                                    </ul>

                                    <hr>

                                    <div class="text-center">
                                        <small class="text-muted">
                                            <i class="fas fa-clock me-1"></i>
                                            Payment processed in 2-3 seconds
                                        </small>
                                    </div>
                                </div>
                            </div>
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

<!-- JavaScript -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
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

        const paymentForm = document.getElementById('paymentForm');
        const payButton = document.getElementById('payButton');

        // Remove browser default validation
        paymentForm.setAttribute('novalidate', 'true');

        // Format card number with spaces
        function formatCardNumber(input) {
            let value = input.value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
            let formattedValue = value.match(/.{1,4}/g)?.join(' ');
            input.value = formattedValue || value;

            // Real-time validation
            validateCardNumber(input);
        }

        // Validate card number - ACCEPTS ANY 16-DIGIT NUMBER
        function validateCardNumber(input) {
            const value = input.value.replace(/\s+/g, '');
            const errorElement = document.getElementById('cardNumberError');

            if (value.length === 0) {
                setInvalid(input, errorElement, 'Card number is required.');
                return false;
            }

            if (value.length !== 16 || !/^\d+$/.test(value)) {
                setInvalid(input, errorElement, 'Please enter exactly 16 digits.');
                return false;
            }

            setValid(input, errorElement);
            return true;
        }

        // Format expiry date
        function formatExpiryDate(input) {
            let value = input.value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
            if (value.length >= 2) {
                value = value.substring(0, 2) + '/' + value.substring(2, 4);
            }
            input.value = value;

            // Real-time validation
            validateExpiryDate(input);
        }

        // Format CVV
        function formatCVV(input) {
            let value = input.value.replace(/[^0-9]/gi, '');
            input.value = value.substring(0, 3);

            // Real-time validation
            validateCVV(input);
        }

        // Validate card holder name
        function validateCardHolder(input) {
            const value = input.value.trim();
            const errorElement = document.getElementById('cardHolderError');

            if (value.length === 0) {
                setInvalid(input, errorElement, 'Card holder name is required.');
                return false;
            }

            if (!/^[A-Za-z\s]+$/.test(value)) {
                setInvalid(input, errorElement, 'Please enter a valid name (letters and spaces only).');
                return false;
            }

            if (value.length < 2) {
                setInvalid(input, errorElement, 'Please enter a valid card holder name.');
                return false;
            }

            setValid(input, errorElement);
            return true;
        }

        // Validate expiry date
        function validateExpiryDate(input) {
            const value = input.value;
            const errorElement = document.getElementById('expiryDateError');

            if (value.length === 0) {
                setInvalid(input, errorElement, 'Expiry date is required.');
                return false;
            }

            if (!value.match(/(0[1-9]|1[0-2])\/[0-9]{2}/)) {
                setInvalid(input, errorElement, 'Please enter a valid expiry date (MM/YY).');
                return false;
            }

            // Check if card is expired
            if (isCardExpired(value)) {
                setInvalid(input, errorElement, 'This card has expired. Please use a valid card.');
                return false;
            }

            setValid(input, errorElement);
            return true;
        }

        // Validate CVV
        function validateCVV(input) {
            const value = input.value;
            const errorElement = document.getElementById('cvvError');

            if (value.length === 0) {
                setInvalid(input, errorElement, 'CVV is required.');
                return false;
            }

            if (value.length !== 3 || !/^\d+$/.test(value)) {
                setInvalid(input, errorElement, 'Please enter a valid 3-digit CVV.');
                return false;
            }

            setValid(input, errorElement);
            return true;
        }

        // Set input as invalid
        function setInvalid(input, errorElement, message) {
            input.classList.remove('is-valid');
            input.classList.add('is-invalid');
            errorElement.textContent = message;
            errorElement.style.display = 'block';
        }

        // Set input as valid
        function setValid(input, errorElement) {
            input.classList.remove('is-invalid');
            input.classList.add('is-valid');
            errorElement.style.display = 'none';
        }

        // Check if card is expired
        function isCardExpired(expiryDate) {
            try {
                const [month, year] = expiryDate.split('/');
                const expiry = new Date(2000 + parseInt(year), parseInt(month) - 1);
                const today = new Date();
                today.setHours(0, 0, 0, 0);

                return expiry < today;
            } catch (error) {
                return true;
            }
        }

        // Real-time validation on input
        document.querySelectorAll('.card-input').forEach(input => {
            input.addEventListener('blur', function() {
                switch(input.name) {
                    case 'cardNumber':
                        validateCardNumber(input);
                        break;
                    case 'cardHolder':
                        validateCardHolder(input);
                        break;
                    case 'expiryDate':
                        validateExpiryDate(input);
                        break;
                    case 'cvv':
                        validateCVV(input);
                        break;
                }
            });

            input.addEventListener('input', function() {
                // Clear validation on input
                input.classList.remove('is-invalid', 'is-valid');
                document.getElementById(input.name + 'Error').style.display = 'none';
            });
        });

        // Form submission
        paymentForm.addEventListener('submit', function(e) {
            e.preventDefault();

            // Validate all fields
            const cardNumberValid = validateCardNumber(document.querySelector('input[name="cardNumber"]'));
            const cardHolderValid = validateCardHolder(document.querySelector('input[name="cardHolder"]'));
            const expiryDateValid = validateExpiryDate(document.querySelector('input[name="expiryDate"]'));
            const cvvValid = validateCVV(document.querySelector('input[name="cvv"]'));

            if (cardNumberValid && cardHolderValid && expiryDateValid && cvvValid) {
                // Show loading state
                payButton.disabled = true;
                payButton.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>Processing Payment...';

                // Submit form
                this.submit();
            } else {
                // Scroll to first error
                const firstError = document.querySelector('.is-invalid');
                if (firstError) {
                    firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    firstError.focus();
                }

                // Show error message
                alert('Please fix the errors in the form before submitting.');
            }
        });

        // Auto-format on page load for any pre-filled values
        document.querySelectorAll('.card-input').forEach(input => {
            switch(input.name) {
                case 'cardNumber':
                    formatCardNumber(input);
                    break;
                case 'expiryDate':
                    formatExpiryDate(input);
                    break;
                case 'cvv':
                    formatCVV(input);
                    break;
            }
        });
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>