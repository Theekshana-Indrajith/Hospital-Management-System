<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Appointment Confirmation - HMS</title>
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

        /* Confirmation Card Styling */
        .confirmation-card {
            border: 2px solid var(--success-gradient);
            border-radius: 15px;
            background: var(--light-bg);
            backdrop-filter: blur(12px);
            box-shadow: var(--shadow);
        }

        .confirmation-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
        }

        /* Success Icon Styling */
        .success-icon {
            font-size: 4rem;
            color: var(--success-gradient);
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); opacity: 1; }
            50% { transform: scale(1.1); opacity: 0.9; }
        }

        /* Appointment Details Styling */
        .appointment-details {
            background: rgba(241, 245, 249, 0.95);
            backdrop-filter: blur(8px);
            border-radius: 10px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .appointment-details:hover {
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

        /* Instruction Box Styling */
        .instruction-box {
            background: rgba(255, 243, 205, 0.95);
            backdrop-filter: blur(8px);
            border-left: 4px solid var(--warning-gradient);
            border-radius: 8px;
            padding: 15px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .instruction-box:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        /* Hospital Info Styling */
        .hospital-info {
            background: rgba(227, 242, 253, 0.95);
            backdrop-filter: blur(8px);
            border-radius: 10px;
            padding: 15px;
            border: 1px solid rgba(0, 123, 255, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .hospital-info:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        /* Button Styling */
        .btn-primary, .btn-outline-success {
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
            color: #fff;
        }

        .btn-outline-success {
            border-color: var(--success-gradient);
            color: var(--success-gradient);
        }

        .btn-primary:hover, .btn-outline-success:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 123, 255, 0.3);
        }

        .btn-primary::before, .btn-outline-success::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s ease;
        }

        .btn-primary:hover::before, .btn-outline-success:hover::before {
            left: 100%;
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

            .btn-primary, .btn-outline-success {
                padding: 0.5rem 1rem;
                font-size: 0.9rem;
            }

            .appointment-details, .fee-breakdown, .instruction-box, .hospital-info {
                font-size: 0.9rem;
            }

            .success-icon {
                font-size: 3rem;
            }

            footer {
                padding: 2rem 0;
            }
        }

        @media (max-width: 576px) {
            .card-header h3 {
                font-size: 1.5rem;
            }

            .success-icon {
                font-size: 2.5rem;
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
            </ul>
        </div>
    </div>
</nav>


<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card confirmation-card fade-in">
                <div class="card-header bg-warning text-white text-center">
                    <h3 class="mb-0"><i class="fas fa-clock me-2"></i>Appointment Request Submitted</h3>
                </div>
                <div class="card-body">
                    <!-- Success Header -->
                    <div class="text-center mb-4 fade-in">
                        <div class="success-icon">
                            <i class="fas fa-clock text-warning"></i>
                        </div>
                        <h4 class="text-warning mt-3">Waiting for Doctor Confirmation</h4>
                        <p class="text-muted">Your appointment request has been sent to the doctor</p>
                    </div>

                    <!-- Appointment Details -->
                    <div class="appointment-details mb-4 p-4 rounded fade-in">
                        <h5 class="mb-3"><i class="fas fa-calendar-alt me-2"></i>Appointment Details</h5>
                        <div class="row">
                            <div class="col-md-6">
                                <p class="mb-2"><strong>Appointment ID:</strong> A${appointment.id}</p>
                                <p class="mb-2"><strong>Patient Name:</strong> ${patient.firstName} ${patient.lastName}</p>
                                <p class="mb-2"><strong>Contact:</strong> ${patient.contactNumber}</p>
                            </div>
                            <div class="col-md-6">
                                <p class="mb-2"><strong>Doctor:</strong> Dr. ${appointment.doctor.name}</p>
                                <p class="mb-2"><strong>Specialization:</strong> ${appointment.doctor.specialization}</p>
                                <p class="mb-2"><strong>Date & Time:</strong> ${formattedDateTime}</p>
                                <c:if test="${not empty appointment.doctor.roomNumber}">
                                    <p class="mb-2"><strong>Room:</strong> ${appointment.doctor.roomNumber}</p>
                                </c:if>
                            </div>
                        </div>

                        <!-- Reason for Appointment -->
                        <div class="mt-3">
                            <strong>Reason:</strong>
                            <p class="mb-0 text-muted">${appointment.reason}</p>
                        </div>
                    </div>

                    <!-- Payment Summary -->
                    <div class="payment-summary mb-4 fade-in">
                        <h5 class="mb-3"><i class="fas fa-receipt me-2"></i>Payment Summary</h5>
                        <div class="fee-breakdown">
                            <div class="row mb-2">
                                <div class="col-8">
                                    <span>Consultation Fee:</span>
                                </div>
                                <div class="col-4 text-end">
                                    <span>Rs. ${appointment.consultationFee != null ? appointment.consultationFee : '0.00'}</span>
                                </div>
                            </div>
                            <div class="row mb-2">
                                <div class="col-8">
                                    <span>Service Fee:</span>
                                    <small class="text-muted d-block">(Administrative & facility charges)</small>
                                </div>
                                <div class="col-4 text-end">
                                    <span>Rs. 200.00</span>
                                </div>
                            </div>
                            <hr class="my-2">
                            <div class="row total-amount p-2">
                                <div class="col-8">
                                    <strong>Total Amount Due:</strong>
                                </div>
                                <div class="col-4 text-end">
                                    <strong class="text-success">
                                        Rs. ${(appointment.consultationFee != null ? appointment.consultationFee : 0) + 200.00}
                                    </strong>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Next Steps Information -->
                    <div class="instruction-box p-4 mb-4 fade-in">
                        <h5 class="mb-3"><i class="fas fa-info-circle me-2 text-warning"></i>Next Steps</h5>
                        <p class="mb-2">Your appointment request is currently <strong>pending doctor approval</strong>.</p>
                        <p class="mb-2"><strong>What happens next:</strong></p>
                        <ul class="mb-0">
                            <li>Your request has been sent to Dr. ${appointment.doctor.name} for review</li>
                            <li>The doctor will confirm your appointment within 24 hours</li>
                            <li>You will receive a notification once the appointment is confirmed</li>
                            <li>Visit the hospital reception to complete payment after confirmation</li>
                        </ul>
                    </div>

                    <!-- Hospital Information -->
                    <div class="hospital-info p-3 border rounded fade-in">
                        <h6><i class="fas fa-map-marker-alt me-2"></i>Hospital Information</h6>
                        <div class="row">
                            <div class="col-md-6">
                                <p class="mb-1"><strong>Address:</strong> 123 Hospital Road, Colombo</p>
                                <p class="mb-1"><strong>Reception Hours:</strong> 8:00 AM - 6:00 PM</p>
                            </div>
                            <div class="col-md-6">
                                <p class="mb-1"><strong>Contact:</strong> +94 11 234 5678</p>
                                <p class="mb-0"><strong>Email:</strong> info@hospital.com</p>
                            </div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4 fade-in">
                        <a href="/patient/appointments" class="btn btn-primary me-md-2">
                            <i class="fas fa-list me-1"></i>View My Appointments
                        </a>
                        <a href="/patient/appointments/book" class="btn btn-outline-success">
                            <i class="fas fa-plus me-1"></i>Book Another Appointment
                        </a>
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
    // JavaScript for scroll effects and fade-in animations
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
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>