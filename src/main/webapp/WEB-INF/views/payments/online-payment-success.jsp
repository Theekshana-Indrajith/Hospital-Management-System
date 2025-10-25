<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Payment Successful - HMS</title>
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

        .card-header.bg-primary {
            background: var(--primary-gradient);
            color: #fff;
        }

        .card-header.bg-success::before,
        .card-header.bg-primary::before {
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

        .card-header.bg-success:hover::before,
        .card-header.bg-primary:hover::before {
            transform: scaleX(1);
        }

        /* Success Animation Styling */
        .success-animation {
            animation: bounce 2s infinite;
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
            40% { transform: translateY(-10px); }
            60% { transform: translateY(-5px); }
        }

        /* Receipt Card Styling */
        .receipt-card {
            border-left: 5px solid var(--success-gradient);
            background: rgba(241, 245, 249, 0.95);
            backdrop-filter: blur(8px);
            box-shadow: var(--shadow);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .receipt-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        /* Confirmation Details Styling */
        .confirmation-details {
            background: rgba(248, 249, 250, 0.95);
            backdrop-filter: blur(8px);
            border-radius: 10px;
            padding: 15px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .confirmation-details:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        .detail-item {
            padding: 8px 0;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            transition: background 0.3s ease;
        }

        .detail-item:last-child {
            border-bottom: none;
        }

        .detail-item:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        /* Badge Styling */
        .badge-confirmed {
            background: var(--success-gradient);
            font-size: 0.9em;
            color: #fff;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            transition: all 0.3s ease;
        }

        .badge-confirmed:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .badge.bg-info {
            background: var(--info-gradient);
            color: #0c5460;
        }

        .badge.bg-success {
            background: var(--success-gradient);
            color: #fff;
        }

        /* Download Button Styling */
        .download-btn {
            transition: all 0.3s ease;
            padding: 12px 24px;
            font-weight: 600;
            border-radius: 25px;
            position: relative;
            overflow: hidden;
        }

        .download-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }

        .download-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s ease;
        }

        .download-btn:hover::before {
            left: 100%;
        }

        /* Alert Styling */
        .alert {
            border-radius: 10px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(8px);
            border: 1px solid rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .alert-warning {
            background: rgba(255, 243, 205, 0.95);
            border-color: var(--warning-gradient);
            color: #856404;
        }

        .alert-info {
            background: rgba(207, 244, 252, 0.95);
            border-color: var(--info-gradient);
            color: #0c5460;
        }

        /* Button Styling */
        .btn-success, .btn-outline-primary, .btn-outline-warning, .btn-outline-secondary {
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

        .btn-outline-primary {
            border-color: var(--primary-gradient);
            color: var(--primary-gradient);
        }

        .btn-outline-warning {
            border-color: var(--warning-gradient);
            color: var(--warning-gradient);
        }

        .btn-outline-secondary {
            border-color: var(--secondary-gradient);
            color: var(--secondary-gradient);
        }

        .btn-success:hover, .btn-outline-primary:hover, .btn-outline-warning:hover, .btn-outline-secondary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 123, 255, 0.3);
        }

        .btn-success::before, .btn-outline-primary::before, .btn-outline-warning::before, .btn-outline-secondary::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s ease;
        }

        .btn-success:hover::before, .btn-outline-primary:hover::before, .btn-outline-warning:hover::before, .btn-outline-secondary:hover::before {
            left: 100%;
        }

        /* Print Styling */
        .print-only {
            display: none;
        }

        @media print {
            .no-print {
                display: none !important;
            }
            .print-only {
                display: block !important;
            }
            .card {
                border: 2px solid #000 !important;
                box-shadow: none !important;
            }
            .success-animation {
                animation: none !important;
            }
            .btn {
                display: none !important;
            }
            body {
                font-size: 12pt;
                color: #000 !important;
                background: #fff !important;
            }
            .card-header.bg-success, .card-header.bg-primary {
                background: #fff !important;
                color: #000 !important;
                border-bottom: 1px solid #000 !important;
            }
            .receipt-card, .confirmation-details {
                background: #fff !important;
                border-color: #000 !important;
            }
            .badge-confirmed, .badge.bg-success, .badge.bg-info {
                background: #000 !important;
                color: #fff !important;
            }
            h1, h2, h3, h4, h5, h6 {
                color: #000 !important;
            }
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

            .btn-success, .btn-outline-primary, .btn-outline-warning, .btn-outline-secondary {
                padding: 0.5rem 1rem;
                font-size: 0.9rem;
            }

            .confirmation-details, .receipt-card {
                font-size: 0.9rem;
            }

            .success-animation {
                font-size: 3rem;
            }

            footer {
                padding: 2rem 0;
            }
        }

        @media (max-width: 576px) {
            .card-header h2 {
                font-size: 1.5rem;
            }

            .success-animation {
                font-size: 2.5rem;
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
    <!-- Print Header (Only shows when printing) -->
    <div class="print-only text-center mb-4 fade-in">
        <h2>Aurora Health Hospital</h2>
        <h4>Payment Confirmation Receipt</h4>
        <hr>
    </div>

    <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="card border-success shadow-lg fade-in">
                <div class="card-header bg-warning text-white text-center py-4">
                    <div class="success-animation mb-3">
                        <i class="fas fa-check-circle fa-4x"></i>
                    </div>
                    <h2 class="mb-0">Payment Successful - Waiting for Doctor Confirmation</h2>
                    <p class="mb-0 mt-2">Your payment was processed successfully</p>
                </div>
                <div class="card-body">
                    <!-- Appointment Confirmation -->
                    <div class="confirmation-details mb-4 p-4 fade-in">
                        <div class="row text-center mb-4">
                            <div class="col-md-12">
                                <h4 class="text-warning">
                                    <i class="fas fa-clock me-2"></i>
                                    Waiting for Doctor Approval
                                </h4>
                                <p class="text-muted">Your payment was successful but appointment needs doctor confirmation</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="detail-item">
                                    <strong><i class="fas fa-user me-2 text-primary"></i>Patient Name:</strong><br>
                                    ${appointment.patient.firstName} ${appointment.patient.lastName}
                                </div>
                                <div class="detail-item">
                                    <strong><i class="fas fa-id-card me-2 text-primary"></i>Patient ID:</strong><br>
                                    P${appointment.patient.id}
                                </div>
                                <div class="detail-item">
                                    <strong><i class="fas fa-user-md me-2 text-primary"></i>Doctor:</strong><br>
                                    Dr. ${appointment.doctor.name}
                                </div>
                                <div class="detail-item">
                                    <strong><i class="fas fa-stethoscope me-2 text-primary"></i>Specialization:</strong><br>
                                    ${appointment.doctor.specialization}
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="detail-item">
                                    <strong><i class="fas fa-calendar-alt me-2 text-primary"></i>Appointment Date:</strong><br>
                                    ${formattedAppointmentDate}
                                </div>
                                <div class="detail-item">
                                    <strong><i class="fas fa-clock me-2 text-primary"></i>Time:</strong><br>
                                    ${formattedAppointmentTime}
                                </div>
                                <div class="detail-item">
                                    <strong><i class="fas fa-map-marker-alt me-2 text-primary"></i>Room Number:</strong><br>
                                    ${appointment.doctor.roomNumber}
                                </div>
                                <div class="detail-item">
                                    <strong><i class="fas fa-info-circle me-2 text-primary"></i>Appointment Status:</strong><br>
                                    <span class="badge bg-warning text-white p-2">PENDING DOCTOR CONFIRMATION</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Payment Receipt -->
                    <div class="receipt-card card mb-4 fade-in">
                        <div class="card-header bg-primary text-white">
                            <h5 class="mb-0"><i class="fas fa-receipt me-2"></i>Payment Receipt</h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="detail-item">
                                        <strong>Transaction ID:</strong><br>
                                        ${appointment.transactionId}
                                    </div>
                                    <div class="detail-item">
                                        <strong>Payment Date & Time:</strong><br>
                                        ${formattedPaymentDate}
                                    </div>
                                    <div class="detail-item">
                                        <strong>Payment Method:</strong><br>
                                        <span class="badge bg-info text-dark">${appointment.paymentMethod}</span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="detail-item">
                                        <strong>Appointment ID:</strong><br>
                                        A${appointment.id}
                                    </div>
                                    <div class="detail-item">
                                        <strong>Payment Status:</strong><br>
                                        <span class="badge bg-success">${appointment.paymentStatus}</span>
                                    </div>
                                    <div class="detail-item">
                                        <strong>Doctor Contact:</strong><br>
                                        ${appointment.doctor.contactNumber}
                                    </div>
                                </div>
                            </div>
                            <hr class="my-4">
                            <div class="row">
                                <div class="col-md-6">
                                    <h5 class="mb-0">Consultation Fee:</h5>
                                </div>
                                <div class="col-md-6 text-end">
                                    <h4 class="text-success mb-0">Rs. ${appointment.consultationFee}</h4>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Pending Status Information -->
                    <div class="alert alert-warning fade-in">
                        <h6><i class="fas fa-info-circle me-2"></i>Appointment Status</h6>
                        <p class="mb-0">
                            <strong>Current Status:</strong> Pending Doctor Confirmation<br>
                            Your payment has been processed successfully.
                            The doctor will review and confirm your appointment shortly.
                            You will be notified once the appointment is confirmed.
                        </p>
                    </div>

                    <!-- Download Receipt Section -->
                    <div class="download-section text-center mb-4 no-print fade-in">
                        <div class="row justify-content-center">
                            <div class="col-md-8">
                                <h5 class="mb-3"><i class="fas fa-download me-2 text-primary"></i>Download Your Receipt</h5>
                                <p class="text-muted mb-4">Keep a copy of your payment receipt for your records and insurance purposes</p>
                                <div class="d-grid gap-2 d-md-flex justify-content-md-center">
                                    <a href="/payments/download-receipt/${appointment.id}" class="btn btn-primary btn-lg download-btn me-md-3">
                                        <i class="fas fa-file-pdf me-2"></i>Download PDF Receipt
                                    </a>
                                    <button onclick="printConfirmation()" class="btn btn-outline-secondary btn-lg">
                                        <i class="fas fa-print me-2"></i>Print Confirmation
                                    </button>
                                </div>
                                <small class="text-muted mt-2">
                                    <i class="fas fa-info-circle me-1"></i>
                                    The receipt will download as a real PDF file
                                </small>
                            </div>
                        </div>
                    </div>

                    <!-- Important Instructions -->
                    <div class="alert alert-info no-print fade-in">
                        <h6><i class="fas fa-exclamation-triangle me-2"></i>Important Instructions</h6>
                        <ul class="mb-0">
                            <li>Your appointment is <strong>pending doctor approval</strong></li>
                            <li>You will receive notification once the doctor confirms your appointment</li>
                            <li>Please arrive <strong>15 minutes before</strong> your appointment time for registration</li>
                            <li>Bring your <strong>ID proof</strong> and any previous medical reports</li>
                            <li>Show this confirmation at the reception desk for quick processing</li>
                        </ul>
                    </div>

                    <!-- Contact Information -->
                    <div class="alert alert-info no-print fade-in">
                        <h6><i class="fas fa-phone me-2"></i>Contact Information</h6>
                        <div class="row">
                            <div class="col-md-6">
                                <strong>Hospital Reception:</strong> +94 11 234 5678<br>
                                <strong>Emergency:</strong> +94 11 234 5679
                            </div>
                            <div class="col-md-6">
                                <strong>Email:</strong> info@hospital.com<br>
                                <strong>Address:</strong> 123 Hospital Road, Colombo
                            </div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="d-grid gap-2 d-md-flex justify-content-md-center mt-4 no-print fade-in">
                        <a href="/patient/appointments" class="btn btn-success me-md-3 btn-lg">
                            <i class="fas fa-list me-1"></i>View My Appointments
                        </a>
                        <a href="/patient/dashboard" class="btn btn-outline-primary me-md-3 btn-lg">
                            <i class="fas fa-home me-1"></i>Back to Dashboard
                        </a>
                        <a href="/patient/appointments/book" class="btn btn-outline-warning btn-lg">
                            <i class="fas fa-plus me-1"></i>Book Another Appointment
                        </a>
                    </div>

                    <!-- Thank You Message -->
                    <div class="text-center mt-5 pt-4 border-top fade-in">
                        <p class="text-muted">
                            <i class="fas fa-heart text-danger me-1"></i>
                            Thank you for choosing our hospital. We look forward to serving you.
                        </p>
                        <small class="text-muted">
                            This is a computer generated confirmation. No signature required.
                        </small>
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

<!-- Success Confetti Effect (Optional) -->
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

        // Add confetti effect on page load
        setTimeout(() => {
            if (typeof confetti === 'function') {
                confetti({
                    particleCount: 100,
                    spread: 70,
                    origin: { y: 0.6 }
                });
            }
        }, 500);

        // Auto-download receipt after 3 seconds (optional)
        setTimeout(() => {
            console.log('Payment successful! Receipt ready for download.');
        }, 3000);
    });

    // Enhanced print functionality
    function printConfirmation() {
        const printContent = document.querySelector('.card').innerHTML;
        const originalContent = document.body.innerHTML;

        document.body.innerHTML = `
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-10">
                        <div class="card border-dark">
                            ${printContent}
                        </div>
                    </div>
                </div>
            </div>
        `;

        window.print();
        document.body.innerHTML = originalContent;
        location.reload();
    }
</script>

<!-- Confetti Library (Optional - for celebration effect) -->
<script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.5.1/dist/confetti.browser.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>