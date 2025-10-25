<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Reschedule Appointment - HMS</title>
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

        /* Enhanced Navigation Bar with Glass Morphism */
        .navbar {
            background: rgba(255, 255, 255, 0.95) !important;
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            padding: 1rem 0;
            position: sticky;
            top: 0;
            z-index: 1000;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            transition: all 0.3s ease;
        }

        .navbar.scrolled {
            background: rgba(255, 255, 255, 0.98) !important;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
            padding: 0.8rem 0;
        }

        .navbar::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.1) 0%, rgba(255, 255, 255, 0.05) 100%);
            pointer-events: none;
            z-index: -1;
        }

        .navbar::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"><path fill="rgba(0,123,255,0.1)" d="M0,160L48,176C96,192,192,224,288,213.3C384,203,480,149,576,138.7C672,128,768,160,864,160C960,160,1056,128,1152,138.7C1248,149,1344,203,1392,229.3L1440,256L1440,0L1392,0C1344,0,1248,0,1152,0C1056,0,960,0,864,0C768,0,672,0,576,0C480,0,384,0,288,0C192,0,96,0,48,0L0,0Z"></path></svg>');
            background-size: cover;
            animation: wave 8s ease-in-out infinite;
        }

        @keyframes wave {
            0%, 100% { transform: translateX(0); }
            50% { transform: translateX(-20px); }
        }

        .navbar-brand {
            font-weight: 800;
            font-size: 1.8rem;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            display: flex;
            align-items: center;
            transition: all 0.3s ease;
            padding: 0.3rem 0.8rem;
            border-radius: 15px;
            position: relative;
            overflow: hidden;
            font-family: 'Playfair Display', serif;
            margin-right: auto;
            justify-content: flex-start;
            white-space: nowrap;
            max-width: 200px;
        }

        .navbar-brand::before {
            content: '🏥';
            margin-right: 0.5rem;
            font-size: 1.4rem;
            animation: heartbeat 2s ease-in-out infinite;
        }

        @keyframes heartbeat {
            0%, 100% { transform: scale(1); }
            25% { transform: scale(1.1); }
            50% { transform: scale(1); }
            75% { transform: scale(1.05); }
        }

        .navbar-brand::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            width: 0;
            height: 3px;
            background: var(--primary-gradient);
            transition: all 0.4s ease;
            transform: translateX(-50%);
        }

        .navbar-brand:hover::after {
            width: 80%;
        }

        .navbar-brand:hover {
            transform: translateY(-2px);
            text-shadow: 0 5px 15px rgba(0, 123, 255, 0.3);
        }

        .navbar-nav {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 0.5rem;
            width: 100%;
            max-width: 700px;
        }

        .nav-link {
            font-weight: 600;
            color: #2c3e50 !important;
            padding: 0.8rem 1.5rem;
            border-radius: 25px;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            text-transform: uppercase;
            font-size: 0.9rem;
            letter-spacing: 0.5px;
            margin: 0 0.2rem;
            text-align: center;
            overflow: hidden;
            border: 2px solid transparent;
        }

        .nav-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: var(--primary-gradient);
            transition: left 0.4s ease;
            z-index: -1;
            border-radius: 25px;
        }

        .nav-link:hover::before,
        .nav-link.active::before {
            left: 0;
        }

        .nav-link:hover,
        .nav-link.active {
            color: #fff !important;
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0, 123, 255, 0.3);
            border-color: rgba(255, 255, 255, 0.3);
        }

        .nav-link i {
            margin-right: 0.6rem;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            display: inline-block;
        }

        .nav-link:hover i {
            transform: scale(1.2) rotate(10deg);
            animation: iconFloat 2s ease-in-out infinite;
        }

        @keyframes iconFloat {
            0%, 100% { transform: translateY(0) scale(1.2) rotate(10deg); }
            50% { transform: translateY(-3px) scale(1.3) rotate(-5deg); }
        }

        .nav-link.active::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 50%;
            width: 6px;
            height: 6px;
            background: var(--success-gradient);
            border-radius: 50%;
            transform: translateX(-50%);
            animation: activePulse 2s ease-in-out infinite;
        }

        @keyframes activePulse {
            0%, 100% { transform: translateX(-50%) scale(1); opacity: 1; }
            50% { transform: translateX(-50%) scale(1.5); opacity: 0.7; }
        }

        .navbar-toggler {
            border: 2px solid rgba(0, 123, 255, 0.2);
            padding: 0.7rem;
            transition: all 0.4s ease;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 12px;
            position: relative;
            overflow: hidden;
        }

        .navbar-toggler::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: var(--primary-gradient);
            opacity: 0.1;
            transition: left 0.4s ease;
        }

        .navbar-toggler:hover::before {
            left: 0;
        }

        .navbar-toggler:hover {
            transform: rotate(90deg) scale(1.1);
            border-color: rgba(0, 123, 255, 0.4);
            box-shadow: 0 5px 15px rgba(0, 123, 255, 0.2);
        }

        .navbar-toggler-icon {
            background-image: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 30 30"><path stroke="rgba(0,123,255,0.8)" stroke-width="2" stroke-linecap="round" stroke-miterlimit="10" d="M4 7h22M4 15h22M4 23h22"/></svg>');
            transition: transform 0.3s ease;
        }

        .navbar-toggler:hover .navbar-toggler-icon {
            transform: scale(1.1);
        }

        @media (max-width: 991px) {
            .navbar-collapse {
                background: rgba(255, 255, 255, 0.98);
                backdrop-filter: blur(20px);
                border-radius: 20px;
                margin-top: 1rem;
                padding: 1.5rem;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
                border: 1px solid rgba(255, 255, 255, 0.3);
            }

            .nav-link {
                margin: 0.3rem 0;
                text-align: left;
                border: 1px solid rgba(0, 123, 255, 0.1);
            }

            .navbar-nav {
                flex-direction: column;
                gap: 0.5rem;
            }
        }

        @media (max-width: 768px) {
            .navbar-brand {
                font-size: 1.8rem;
                padding: 0.4rem 0.8rem;
            }

            .nav-link {
                padding: 0.7rem 1.2rem;
                font-size: 0.85rem;
            }

            .navbar-toggler {
                padding: 0.6rem;
            }
        }

        @media (max-width: 576px) {
            .navbar-brand {
                font-size: 1.6rem;
            }

            .navbar-brand::before {
                font-size: 1.4rem;
                margin-right: 0.5rem;
            }

            .nav-link {
                padding: 0.6rem 1rem;
                font-size: 0.8rem;
            }

            .nav-link i {
                margin-right: 0.4rem;
                font-size: 1rem;
            }
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
            background: var(--warning-gradient);
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

        .card-header.bg-warning {
            background: var(--warning-gradient);
            color: #2c3e50;
        }

        .card-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--warning-gradient);
            transform: scaleX(0);
            transition: transform 0.4s ease;
        }

        .card-header:hover::before {
            transform: scaleX(1);
        }

        /* Current Appointment Styling */
        .current-appointment {
            background: rgba(255, 243, 224, 0.95);
            backdrop-filter: blur(8px);
            border-left: 4px solid var(--warning-gradient);
            border-radius: 10px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .current-appointment:hover {
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

        /* Form Styling */
        .form-control, .form-check-input {
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .form-control:focus {
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
        .btn-warning, .btn-secondary {
            border-radius: 25px;
            font-weight: 600;
            padding: 0.75rem 1.5rem;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .btn-warning {
            background: var(--warning-gradient);
            border: none;
            color: #2c3e50;
        }

        .btn-secondary {
            background: var(--dark-gradient);
            border: none;
            color: #fff;
        }

        .btn-warning:hover, .btn-secondary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 123, 255, 0.3);
        }

        .btn-warning::before, .btn-secondary::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s ease;
        }

        .btn-warning:hover::before, .btn-secondary:hover::before {
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
            background: var(--danger-gradient);
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

            .btn-warning, .btn-secondary {
                padding: 0.5rem 1rem;
                font-size: 0.9rem;
            }

            .current-appointment, .time-slot-info {
                font-size: 0.9rem;
            }

            footer {
                padding: 2rem 0;
            }
        }

        @media (max-width: 576px) {
            .card-header h4 {
                font-size: 1.5rem;
            }

            .form-control, .form-check-label {
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="">Aurora Health Hospital</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <div class="navbar-nav me-auto">
                <a class="nav-link" href="/patient/dashboard">Dashboard</a>
                <a class="nav-link active" href="/patient/appointments">← Back to Appointments</a>
            </div>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card fade-in">
                <div class="card-header bg-warning text-dark">
                    <h4 class="mb-0"><i class="fas fa-calendar-alt me-2"></i>Reschedule Appointment</h4>
                </div>
                <div class="card-body">
                    <!-- Display Error Messages -->
                    <c:if test="${not empty param.error}">
                        <div class="alert alert-danger alert-dismissible fade show fade-in" role="alert">
                            <strong>Reschedule Failed!</strong> ${param.error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <!-- Current Appointment Details -->
                    <div class="current-appointment mb-4 p-3 rounded fade-in">
                        <h6><i class="fas fa-info-circle me-2"></i>Current Appointment Details</h6>
                        <div class="row">
                            <div class="col-md-6">
                                <p class="mb-1"><strong>Doctor:</strong> Dr. ${appointment.doctor.name}</p>
                                <p class="mb-1"><strong>Specialization:</strong> ${appointment.doctor.specialization}</p>
                                <p class="mb-1"><strong>Current Date:</strong> ${appointment.appointmentDateTime.toLocalDate()}</p>
                            </div>
                            <div class="col-md-6">
                                <p class="mb-1"><strong>Current Time:</strong> ${appointment.appointmentDateTime.toLocalTime()}</p>
                                <p class="mb-1"><strong>Payment Status:</strong>
                                    <span class="badge ${appointment.paymentStatus == 'PAID' ? 'bg-success' : 'bg-warning'}">
                                        ${appointment.paymentStatus}
                                    </span>
                                </p>
                                <p class="mb-1"><strong>Reschedules Used:</strong> ${appointment.rescheduleCount}/2</p>
                                <p class="mb-0"><strong>Room:</strong> ${appointment.doctor.roomNumber}</p>
                            </div>
                        </div>
                    </div>

                    <!-- Reschedule Form -->
                    <form action="/patient/appointments/reschedule" method="post" class="fade-in">
                        <input type="hidden" name="appointmentId" value="${appointment.id}">

                        <!-- New Date & Time -->
                        <div class="mb-3">
                            <label class="form-label"><strong>Select New Date & Time *</strong></label>
                            <input type="datetime-local" name="appointmentDateTime" class="form-control" required
                                   id="appointmentDateTime"
                                   min="<%= java.time.LocalDateTime.now().plusHours(1).format(java.time.format.DateTimeFormatter.ISO_LOCAL_DATE_TIME).substring(0,16) %>">
                            <small class="text-muted">
                                <i class="fas fa-info-circle me-1"></i>
                                Available: <strong>Monday to Saturday, 4:00 PM - 10:00 PM</strong>. Appointments must be at least 1 hour in advance.
                            </small>
                            <div id="datetimeHelp" class="form-text text-info">
                                <i class="fas fa-calendar me-1"></i>Select from available slots: Mon-Sat, 4PM-10PM
                            </div>
                        </div>

                        <!-- Time Slot Information -->
                        <div class="time-slot-info mb-4 p-3 border border-warning rounded fade-in">
                            <h6 class="text-warning mb-3">
                                <i class="fas fa-calendar-day me-2"></i>Available Reschedule Slots
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

                        <!-- Reschedule Reason -->
                        <div class="mb-4">
                            <label class="form-label"><strong>Reason for Rescheduling *</strong></label>
                            <textarea name="rescheduleReason" class="form-control" rows="3"
                                      placeholder="Please provide reason for rescheduling..."
                                      required maxlength="500"></textarea>
                            <small class="text-muted">Maximum 500 characters</small>
                        </div>

                        <!-- Terms and Conditions -->
                        <div class="form-check mb-4">
                            <input class="form-check-input" type="checkbox" id="termsCheck" required>
                            <label class="form-check-label small" for="termsCheck">
                                I understand that I can reschedule this appointment only
                                <strong>${2 - appointment.rescheduleCount} more time(s)</strong>.
                                After rescheduling, the appointment will require doctor confirmation again.
                                Available for both pending and confirmed appointments.
                            </label>
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="/patient/appointments" class="btn btn-secondary me-md-2">
                                <i class="fas fa-times me-1"></i>Cancel
                            </a>
                            <button type="submit" class="btn btn-warning">
                                <i class="fas fa-calendar-alt me-1"></i>Reschedule Appointment
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
    document.addEventListener('DOMContentLoaded', function() {
        const dateTimeInput = document.getElementById('appointmentDateTime');

        // Set minimum date/time for appointment (1 hour from now)
        const now = new Date();
        now.setHours(now.getHours() + 1);
        const minDateTime = now.toISOString().slice(0, 16);
        dateTimeInput.min = minDateTime;

        // Function to validate selected datetime (KEEP Mon-Sat 4PM-10PM validation)
        function validateDateTime(selectedDateTime) {
            const dayOfWeek = selectedDateTime.getDay(); // 0 = Sunday, 1 = Monday, ..., 6 = Saturday
            const hour = selectedDateTime.getHours();
            const minutes = selectedDateTime.getMinutes();

            // Check if Sunday
            if (dayOfWeek === 0) {
                return {
                    isValid: false,
                    message: '❌ Sundays are not available. Please select Monday to Saturday.'
                };
            }

            // Check if time is between 4 PM (16) and 10 PM (22)
            if (hour < 16 || hour >= 22) {
                return {
                    isValid: false,
                    message: '❌ Time must be between 4:00 PM and 10:00 PM. Please select a time within this range.'
                };
            }

            return {
                isValid: true,
                message: '✅ Valid time slot selected'
            };
        }

        // Real-time validation (KEEP the validation, just don't auto-correct)
        dateTimeInput.addEventListener('change', function() {
            const selectedDateTime = new Date(this.value);
            const validation = validateDateTime(selectedDateTime);

            const helpText = document.getElementById('datetimeHelp');
            if (validation.isValid) {
                helpText.innerHTML = `<i class="fas fa-check-circle me-1 text-success"></i>${validation.message}`;
                helpText.className = 'form-text text-success';
            } else {
                helpText.innerHTML = `<i class="fas fa-exclamation-circle me-1 text-danger"></i>${validation.message}`;
                helpText.className = 'form-text text-danger';
                // REMOVED: this.value = ''; // Don't auto-clear invalid selection
            }
        });

        // Set initial value to current appointment time (don't auto-correct to nearest valid)
        function setInitialDateTime() {
            const currentAppointmentTime = new Date('${appointment.appointmentDateTime}');
            const now = new Date();

            let suggestedDate = currentAppointmentTime;

            // If current appointment time is in the past or less than 1 hour from now, suggest tomorrow at same time
            if (suggestedDate.getTime() < now.getTime() + 60 * 60 * 1000) {
                suggestedDate = new Date(now.getTime() + 24 * 60 * 60 * 1000); // Tomorrow
                suggestedDate.setHours(currentAppointmentTime.getHours(), currentAppointmentTime.getMinutes(), 0, 0);
            }

            // Validate the suggested date but don't auto-correct
            const validation = validateDateTime(suggestedDate);
            if (validation.isValid) {
                dateTimeInput.value = suggestedDate.toISOString().slice(0, 16);
            } else {
                // Just set the value without auto-correction - let user see the invalid time
                dateTimeInput.value = suggestedDate.toISOString().slice(0, 16);
            }
        }

        // Set initial value when page loads
        setInitialDateTime();

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
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>