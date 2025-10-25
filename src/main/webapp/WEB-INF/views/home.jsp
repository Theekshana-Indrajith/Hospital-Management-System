<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aurora Health Hospital - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            overflow-x: hidden;
        }

        /* Enhanced Hero Section with Animations */
        .hero-section {
            background: linear-gradient(135deg, rgba(0, 123, 255, 0.9) 0%, rgba(0, 184, 217, 0.9) 100%),
            url('https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?q=80&w=2000') center/cover;
            color: white;
            padding: 150px 0;
            text-align: center;
            position: relative;
            overflow: hidden;
            min-height: 100vh;
            display: flex;
            align-items: center;
            animation: heroBackground 20s ease-in-out infinite;
        }

        @keyframes heroBackground {
            0%, 100% {
                background: linear-gradient(135deg, rgba(0, 123, 255, 0.9) 0%, rgba(0, 184, 217, 0.9) 100%),
                url('https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?q=80&w=2000') center/cover;
            }
            33% {
                background: linear-gradient(135deg, rgba(16, 172, 132, 0.9) 0%, rgba(0, 123, 255, 0.9) 100%),
                url('https://images.unsplash.com/photo-1538108149393-fbbd81895907?q=80&w=2000') center/cover;
            }
            66% {
                background: linear-gradient(135deg, rgba(0, 123, 255, 0.9) 0%, rgba(16, 172, 132, 0.9) 100%),
                url('https://images.unsplash.com/photo-1504439904031-93ded9f93e4e?q=80&w=2000') center/cover;
            }
        }

        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 1000"><polygon fill="rgba(255,255,255,0.05)" points="0,1000 1000,0 1000,1000"/></svg>');
            background-size: cover;
            animation: float 20s infinite linear;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0) rotate(0deg); }
            33% { transform: translateY(-20px) rotate(1deg); }
            66% { transform: translateY(10px) rotate(-1deg); }
        }

        .hero-content {
            position: relative;
            z-index: 2;
            animation: fadeInUp 1.5s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .hospital-brand {
            background: linear-gradient(45deg, #ffffff, #f0f9ff);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            animation: textGlow 3s ease-in-out infinite alternate;
        }

        @keyframes textGlow {
            from { filter: drop-shadow(0 0 10px rgba(255, 255, 255, 0.5)); }
            to { filter: drop-shadow(0 0 20px rgba(255, 255, 255, 0.8)); }
        }

        /* Floating Elements */
        .floating-elements {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            z-index: 1;
        }

        .floating-element {
            position: absolute;
            color: rgba(255, 255, 255, 0.1);
            font-size: 40px;
            animation: floatElement 15s infinite ease-in-out;
        }

        .floating-element:nth-child(1) { top: 20%; left: 10%; animation-delay: 0s; }
        .floating-element:nth-child(2) { top: 60%; right: 15%; animation-delay: 3s; font-size: 60px; }
        .floating-element:nth-child(3) { bottom: 20%; left: 20%; animation-delay: 6s; font-size: 50px; }
        .floating-element:nth-child(4) { top: 40%; right: 25%; animation-delay: 9s; }
        .floating-element:nth-child(5) { bottom: 40%; left: 15%; animation-delay: 12s; font-size: 55px; }

        @keyframes floatElement {
            0%, 100% { transform: translateY(0) rotate(0deg) scale(1); }
            25% { transform: translateY(-30px) rotate(5deg) scale(1.1); }
            50% { transform: translateY(-50px) rotate(-5deg) scale(1.05); }
            75% { transform: translateY(-30px) rotate(3deg) scale(1.1); }
        }

        /* Enhanced Navigation */
        .navbar {
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.98) 0%, rgba(248, 249, 250, 0.98) 100%) !important;
            backdrop-filter: blur(15px);
            box-shadow: 0 4px 30px rgba(0, 123, 255, 0.1);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            padding: 15px 0;
            border-bottom: 1px solid rgba(0, 123, 255, 0.1);
        }

        .navbar.scrolled {
            background: linear-gradient(135deg, rgba(255, 255, 255, 1) 0%, rgba(248, 249, 250, 1) 100%) !important;
            padding: 10px 0;
            box-shadow: 0 8px 40px rgba(0, 123, 255, 0.15);
            border-bottom: 2px solid rgba(0, 123, 255, 0.2);
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, #007bff 0%, #00b8d9 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            transition: all 0.3s ease;
            letter-spacing: -0.5px;
        }

        .navbar-brand:hover {
            transform: scale(1.05);
            filter: brightness(1.2);
        }

        .navbar-brand i {
            background: linear-gradient(135deg, #007bff 0%, #00b8d9 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: pulse 2s ease-in-out infinite;
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
            background: linear-gradient(135deg, rgba(0, 123, 255, 0.1), rgba(0, 184, 217, 0.1));
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
            background: linear-gradient(90deg, #007bff, #00b8d9);
            border-radius: 2px;
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }

        .nav-link:hover {
            color: #007bff !important;
            transform: translateY(-2px);
        }

        .nav-link:hover::before {
            opacity: 1;
        }

        .nav-link:hover::after {
            width: 80%;
        }

        .navbar .btn-primary {
            background: linear-gradient(135deg, #007bff 0%, #00b8d9 100%);
            border: none;
            padding: 10px 25px !important;
            font-weight: 600;
            box-shadow: 0 4px 15px rgba(0, 123, 255, 0.3);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .navbar .btn-primary::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
            transition: left 0.5s ease;
        }

        .navbar .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 25px rgba(0, 123, 255, 0.4);
        }

        .navbar .btn-primary:hover::before {
            left: 100%;
        }

        .navbar-toggler {
            border: 2px solid #007bff;
            padding: 8px 12px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .navbar-toggler:hover {
            background: rgba(0, 123, 255, 0.1);
            transform: scale(1.05);
        }

        .navbar-toggler:focus {
            box-shadow: 0 0 0 0.25rem rgba(0, 123, 255, 0.25);
        }

        .navbar-toggler-icon {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba(0, 123, 255, 1)' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
        }

        /* Enhanced Cards with 3D Effects */
        .feature-card {
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            border: none;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            height: 100%;
            border-radius: 20px;
            overflow: hidden;
            position: relative;
            background: white;
        }

        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(45deg, #007bff, #00b8d9);
            transform: scaleX(0);
            transition: transform 0.4s ease;
        }

        .feature-card:hover {
            transform: translateY(-15px) scale(1.02);
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
        }

        .feature-card:hover::before {
            transform: scaleX(1);
        }

        .feature-icon {
            position: relative;
            display: inline-block;
            margin-bottom: 20px;
        }

        .feature-icon::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 80px;
            height: 80px;
            background: rgba(0, 123, 255, 0.1);
            border-radius: 50%;
            transform: translate(-50%, -50%) scale(0);
            transition: transform 0.4s ease;
        }

        .feature-card:hover .feature-icon::after {
            transform: translate(-50%, -50%) scale(1);
        }

        /* Contact Cards */
        .contact-card {
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            border: none;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            height: 100%;
            border-radius: 20px;
            overflow: hidden;
            position: relative;
            background: white;
        }

        .contact-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(45deg, #007bff, #00b8d9);
            transform: scaleX(0);
            transition: transform 0.4s ease;
        }

        .contact-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }

        .contact-card:hover::before {
            transform: scaleX(1);
        }

        .contact-icon {
            position: relative;
            display: inline-block;
            margin-bottom: 20px;
        }

        /* Social Media Cards */
        .social-card {
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            border: none;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            height: 100%;
            border-radius: 20px;
            overflow: hidden;
            position: relative;
            background: white;
        }

        .social-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(45deg, #007bff, #00b8d9);
            transform: scaleX(0);
            transition: transform 0.4s ease;
        }

        .social-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }

        .social-card:hover::before {
            transform: scaleX(1);
        }

        /* Contact Form */
        .contact-form {
            background: white;
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.1);
            padding: 40px;
        }

        .form-control {
            border-radius: 12px;
            padding: 12px 20px;
            border: 2px solid #e9ecef;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }

        /* Map Section */
        .map-container {
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.1);
        }

        /* Stats Section with Counter Animation */
        .stats-section {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 100px 0;
            position: relative;
        }

        .stat-number {
            font-size: 3.5rem;
            font-weight: 800;
            background: linear-gradient(45deg, #007bff, #00b8d9);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            line-height: 1;
        }

        /* Role Cards with Enhanced Interactions */
        .role-card {
            border: none;
            border-radius: 20px;
            transition: all 0.4s ease;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
            background: white;
        }

        .role-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(45deg, #007bff, #00b8d9);
            transform: scaleX(0);
            transition: transform 0.4s ease;
        }

        .role-card:hover {
            transform: translateY(-10px) scale(1.03);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }

        .role-card:hover::before {
            transform: scaleX(1);
        }

        .role-icon {
            position: relative;
            display: inline-block;
        }

        .role-icon::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 70px;
            height: 70px;
            background: rgba(0, 123, 255, 0.1);
            border-radius: 50%;
            transform: translate(-50%, -50%) scale(0);
            transition: transform 0.4s ease;
        }

        .role-card:hover .role-icon::after {
            transform: translate(-50%, -50%) scale(1);
        }

        /* Enhanced Buttons */
        .btn {
            border-radius: 50px;
            font-weight: 600;
            padding: 12px 30px;
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.6s ease;
        }

        .btn:hover::before {
            left: 100%;
        }

        .btn-light, .btn-outline-light {
            border: none;
        }

        /* Image hover effects */
        .img-fluid {
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .img-fluid:hover {
            transform: scale(1.05);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2) !important;
        }

        /* Section Animations */
        .section-hidden {
            opacity: 0;
            transform: translateY(50px);
            transition: all 0.8s ease;
        }

        .section-visible {
            opacity: 1;
            transform: translateY(0);
        }

        /* Footer Enhancements */
        footer {
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
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
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 1000"><polygon fill="rgba(255,255,255,0.02)" points="0,0 1000,1000 0,1000"/></svg>');
            background-size: cover;
        }

        /* Particle Background */
        .particles {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 1;
        }

        .particle {
            position: absolute;
            background: rgba(255, 255, 255, 0.6);
            border-radius: 50%;
            animation: particle-rise 15s infinite linear;
        }

        .particle:nth-child(1) { width: 3px; height: 3px; left: 10%; animation-delay: 0s; }
        .particle:nth-child(2) { width: 4px; height: 4px; left: 30%; animation-delay: 2s; }
        .particle:nth-child(3) { width: 2px; height: 2px; left: 50%; animation-delay: 4s; }
        .particle:nth-child(4) { width: 5px; height: 5px; left: 70%; animation-delay: 6s; }
        .particle:nth-child(5) { width: 3px; height: 3px; left: 90%; animation-delay: 8s; }

        @keyframes particle-rise {
            0% { transform: translateY(100vh) translateX(0); opacity: 0; }
            10% { opacity: 1; }
            90% { opacity: 1; }
            100% { transform: translateY(-100px) translateX(100px); opacity: 0; }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .hero-section {
                padding: 100px 0;
                min-height: 80vh;
            }

            .display-4 {
                font-size: 2.5rem;
            }

            .stat-number {
                font-size: 2.5rem;
            }

            .contact-form {
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-light fixed-top">
    <div class="container">
        <a class="navbar-brand fw-bold" href="/">
            <i class="fas fa-hospital me-2"></i>Aurora Health Hospital
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto nav-links">
                <li class="nav-item"><a class="nav-link" href="#features">Features</a></li>
                <li class="nav-item"><a class="nav-link" href="#roles">Access Portals</a></li>
                <li class="nav-item"><a class="nav-link" href="#about">About</a></li>
                <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
                <li class="nav-item"><a class="nav-link btn btn-primary btn-sm ms-2 px-3" href="/login">
                    <i class="fas fa-sign-in-alt me-1"></i>Login
                </a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero-section">
    <div class="floating-elements">
        <div class="floating-element"><i class="fas fa-heartbeat"></i></div>
        <div class="floating-element"><i class="fas fa-stethoscope"></i></div>
        <div class="floating-element"><i class="fas fa-user-md"></i></div>
        <div class="floating-element"><i class="fas fa-hospital"></i></div>
        <div class="floating-element"><i class="fas fa-ambulance"></i></div>
    </div>
    <div class="particles">
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
    </div>
    <div class="container position-relative">
        <div class="row justify-content-center">
            <div class="col-lg-8 hero-content">
                <h1 class="display-3 fw-bold mb-4">Welcome to <span class="hospital-brand">Aurora Health Hospital</span></h1>
                <p class="lead mb-5 fs-4">Advanced Hospital Management System for superior patient care and operational excellence</p>
                <div class="d-flex flex-column flex-sm-row justify-content-center gap-3">
                    <a href="/login" class="btn btn-light btn-lg px-5 py-3 fw-bold">
                        <i class="fas fa-sign-in-alt me-2"></i>Login to Portal
                    </a>
                    <a href="/register" class="btn btn-outline-light btn-lg px-5 py-3 fw-bold">
                        <i class="fas fa-user-plus me-2"></i>Register Now
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Quick Stats -->
<section class="stats-section section-hidden">
    <div class="container">
        <div class="row text-center">
            <div class="col-md-3 col-6 mb-4">
                <div class="stat-number" id="patientsCount">0</div>
                <p class="text-muted">Patients Served</p>
            </div>
            <div class="col-md-3 col-6 mb-4">
                <div class="stat-number" id="doctorsCount">0</div>
                <p class="text-muted">Medical Professionals</p>
            </div>
            <div class="col-md-3 col-6 mb-4">
                <div class="stat-number" id="appointmentsCount">0</div>
                <p class="text-muted">Appointments</p>
            </div>
            <div class="col-md-3 col-6 mb-4">
                <div class="stat-number" id="staffCount">0</div>
                <p class="text-muted">Healthcare Staff</p>
            </div>
        </div>
    </div>
</section>

<!-- System Features -->
<section id="features" class="system-features py-5 section-hidden">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="display-4 fw-bold text-primary mb-3">Comprehensive Healthcare Management</h2>
            <p class="lead text-muted">End-to-end digital solutions for modern healthcare facilities</p>

            <!-- Doctor Team Images -->
            <div class="row justify-content-center mt-5 mb-4">
                <div class="col-lg-10">
                    <div class="row g-3">
                        <div class="col-md-3 col-6">
                            <div class="position-relative">
                                <img src="https://images.unsplash.com/photo-1622253692010-333f2da6031d?w=300&h=300&fit=crop"
                                     alt="Cardiologist"
                                     class="img-fluid rounded-circle shadow-lg"
                                     style="object-fit: cover; width: 100%; aspect-ratio: 1;">
                                <div class="position-absolute bottom-0 start-50 translate-middle-x bg-primary text-white px-3 py-1 rounded-pill small fw-bold">
                                    Cardiology
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-6">
                            <div class="position-relative">
                                <img src="https://images.unsplash.com/photo-1594824476967-48c8b964273f?w=300&h=300&fit=crop"
                                     alt="Surgeon"
                                     class="img-fluid rounded-circle shadow-lg"
                                     style="object-fit: cover; width: 100%; aspect-ratio: 1;">
                                <div class="position-absolute bottom-0 start-50 translate-middle-x bg-success text-white px-3 py-1 rounded-pill small fw-bold">
                                    Surgery
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-6">
                            <div class="position-relative">
                                <img src="https://images.unsplash.com/photo-1651008376811-b90baee60c1f?w=300&h=300&fit=crop"
                                     alt="Pediatrician"
                                     class="img-fluid rounded-circle shadow-lg"
                                     style="object-fit: cover; width: 100%; aspect-ratio: 1;">
                                <div class="position-absolute bottom-0 start-50 translate-middle-x bg-info text-white px-3 py-1 rounded-pill small fw-bold">
                                    Pediatrics
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-6">
                            <div class="position-relative">
                                <img src="https://images.unsplash.com/photo-1638202993928-7267aad84c31?w=300&h=300&fit=crop"
                                     alt="General Physician"
                                     class="img-fluid rounded-circle shadow-lg"
                                     style="object-fit: cover; width: 100%; aspect-ratio: 1;">
                                <div class="position-absolute bottom-0 start-50 translate-middle-x bg-warning text-dark px-3 py-1 rounded-pill small fw-bold">
                                    General
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <div class="col-md-4">
                <div class="card feature-card h-100">
                    <div class="card-body text-center p-4">
                        <div class="feature-icon mb-3">
                            <i class="fas fa-user-injured fa-3x text-primary"></i>
                        </div>
                        <h4 class="card-title fw-bold">Patient Management</h4>
                        <p class="card-text text-muted">
                            Complete patient lifecycle management from registration to discharge with
                            electronic health records and appointment scheduling.
                        </p>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card feature-card h-100">
                    <div class="card-body text-center p-4">
                        <div class="feature-icon mb-3">
                            <i class="fas fa-user-md fa-3x text-success"></i>
                        </div>
                        <h4 class="card-title fw-bold">Medical Records</h4>
                        <p class="card-text text-muted">
                            Comprehensive electronic health records with secure access
                            for authorized medical professionals.
                        </p>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card feature-card h-100">
                    <div class="card-body text-center p-4">
                        <div class="feature-icon mb-3">
                            <i class="fas fa-pills fa-3x text-info"></i>
                        </div>
                        <h4 class="card-title fw-bold">Pharmacy Management</h4>
                        <p class="card-text text-muted">
                            Digital prescription system with medication tracking,
                            inventory management, and automated refill reminders.
                        </p>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card feature-card h-100">
                    <div class="card-body text-center p-4">
                        <div class="feature-icon mb-3">
                            <i class="fas fa-procedures fa-3x text-warning"></i>
                        </div>
                        <h4 class="card-title fw-bold">Ward Management</h4>
                        <p class="card-text text-muted">
                            Real-time bed availability tracking, patient admissions,
                            and discharge management with automated bed allocation.
                        </p>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card feature-card h-100">
                    <div class="card-body text-center p-4">
                        <div class="feature-icon mb-3">
                            <i class="fas fa-flask fa-3x text-danger"></i>
                        </div>
                        <h4 class="card-title fw-bold">Laboratory System</h4>
                        <p class="card-text text-muted">
                            Seamless lab test ordering, result tracking, and integration
                            with patient records for comprehensive diagnostic management.
                        </p>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card feature-card h-100">
                    <div class="card-body text-center p-4">
                        <div class="feature-icon mb-3">
                            <i class="fas fa-chart-line fa-3x text-secondary"></i>
                        </div>
                        <h4 class="card-title fw-bold">Analytics & Reporting</h4>
                        <p class="card-text text-muted">
                            Advanced reporting system with operational metrics,
                            patient care statistics, and performance analytics.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Role-Based Access Portals -->
<section id="roles" class="py-5 bg-light section-hidden">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="display-4 fw-bold text-primary mb-3">Access Your Portal</h2>
            <p class="lead text-muted">Secure, role-based access to specialized healthcare management tools</p>
            <div class="alert alert-info d-inline-block border-0 shadow-sm">
                <i class="fas fa-info-circle me-2"></i>
                All portals require secure login authentication
            </div>
        </div>

        <div class="row g-4">
            <!-- Medical Professionals -->
            <div class="col-lg-4 col-md-6">
                <div class="card role-card h-100">
                    <div class="card-body text-center p-4">
                        <div class="role-icon mb-3">
                            <i class="fas fa-user-md fa-3x text-primary"></i>
                        </div>
                        <h5 class="card-title fw-bold text-primary">Medical Professionals</h5>
                        <p class="card-text text-muted small">
                            Doctors and healthcare providers access patient records,
                            manage appointments, and provide medical care.
                        </p>
                        <a href="/login" class="btn btn-primary btn-sm mt-2 px-4">
                            <i class="fas fa-sign-in-alt me-1"></i>Access Portal
                        </a>
                        <div class="portal-note">Secure login required</div>
                    </div>
                </div>
            </div>

            <!-- Hospital Staff -->
            <div class="col-lg-4 col-md-6">
                <div class="card role-card h-100">
                    <div class="card-body text-center p-4">
                        <div class="role-icon mb-3">
                            <i class="fas fa-user-nurse fa-3x text-success"></i>
                        </div>
                        <h5 class="card-title fw-bold text-success">Hospital Staff</h5>
                        <p class="card-text text-muted small">
                            Nursing staff, administrators, and support personnel
                            manage daily operations and patient care.
                        </p>
                        <a href="/login" class="btn btn-success btn-sm mt-2 px-4">
                            <i class="fas fa-sign-in-alt me-1"></i>Access Portal
                        </a>
                        <div class="portal-note">Secure login required</div>
                    </div>
                </div>
            </div>

            <!-- Patients -->
            <div class="col-lg-4 col-md-6">
                <div class="card role-card h-100">
                    <div class="card-body text-center p-4">
                        <div class="role-icon mb-3">
                            <i class="fas fa-user-injured fa-3x text-info"></i>
                        </div>
                        <h5 class="card-title fw-bold text-info">Patients</h5>
                        <p class="card-text text-muted small">
                            Access medical records, book appointments, view test results,
                            and manage healthcare needs.
                        </p>
                        <a href="/login" class="btn btn-info btn-sm mt-2 px-4">
                            <i class="fas fa-sign-in-alt me-1"></i>Access Portal
                        </a>
                        <div class="portal-note">Secure login required</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Login CTA -->
        <div class="row mt-5">
            <div class="col-12 text-center">
                <div class="card bg-primary text-white border-0 shadow-lg">
                    <div class="card-body py-5">
                        <h4 class="card-title mb-3">
                            <i class="fas fa-shield-alt me-2"></i>Secure Access Required
                        </h4>
                        <p class="card-text mb-4 fs-5">
                            All hospital management portals require verified login credentials for patient data protection
                            and healthcare compliance standards.
                        </p>
                        <div class="d-flex flex-column flex-sm-row justify-content-center gap-3">
                            <a href="/login" class="btn btn-light btn-lg px-5">
                                <i class="fas fa-sign-in-alt me-2"></i>Login to System
                            </a>
                            <a href="/register" class="btn btn-outline-light btn-lg px-5">
                                <i class="fas fa-user-plus me-2"></i>Register Account
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- About Section -->
<section id="about" class="py-5 section-hidden">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6">
                <h2 class="display-4 fw-bold text-primary mb-4">About Aurora Health Hospital</h2>
                <p class="lead text-muted mb-4">
                    Aurora Health Hospital provides comprehensive healthcare services with state-of-the-art
                    medical facilities and a dedicated team of healthcare professionals committed to excellence in patient care.
                </p>
                <div class="row">
                    <div class="col-6">
                        <ul class="list-unstyled">
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>24/7 Emergency Care</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Advanced Medical Technology</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Expert Medical Staff</li>
                        </ul>
                    </div>
                    <div class="col-6">
                        <ul class="list-unstyled">
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Patient-Centered Care</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Modern Facilities</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Comprehensive Services</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="row g-3">
                    <div class="col-6">
                        <img src="https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=400&h=500&fit=crop"
                             alt="Professional Doctor"
                             class="img-fluid rounded-4 shadow-lg"
                             style="object-fit: cover; height: 280px; width: 100%;">
                    </div>
                    <div class="col-6">
                        <img src="https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=400&h=500&fit=crop"
                             alt="Medical Team"
                             class="img-fluid rounded-4 shadow-lg mt-4"
                             style="object-fit: cover; height: 280px; width: 100%;">
                    </div>
                    <div class="col-12">
                        <img src="https://images.unsplash.com/photo-1666214280557-f1b5022eb634?w=800&h=300&fit=crop"
                             alt="Healthcare Professionals"
                             class="img-fluid rounded-4 shadow-lg"
                             style="object-fit: cover; height: 180px; width: 100%;">
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Contact Section -->
<section id="contact" class="py-5 bg-light section-hidden">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="display-4 fw-bold text-primary mb-3">Contact Us</h2>
            <p class="lead text-muted">Get in touch with us for all your healthcare needs and inquiries</p>
        </div>

        <div class="row g-4">
            <!-- Contact Information -->
            <div class="col-lg-4">
                <div class="mb-4">
                    <h3 class="fw-bold text-primary mb-4">Contact Information</h3>

                    <!-- Emergency Contact -->
                    <div class="card contact-card mb-4">
                        <div class="card-body text-center p-4">
                            <div class="contact-icon mb-3">
                                <i class="fas fa-ambulance fa-3x text-danger"></i>
                            </div>
                            <h4 class="card-title fw-bold">Emergency Services</h4>
                            <p class="card-text text-muted mb-3">
                                Available 24/7 for urgent medical situations
                            </p>
                            <div class="contact-info">
                                <h5 class="text-danger fw-bold">011-2224455</h5>
                                <p class="text-muted small">Immediate assistance</p>
                            </div>
                        </div>
                    </div>

                    <!-- General Inquiries -->
                    <div class="card contact-card mb-4">
                        <div class="card-body text-center p-4">
                            <div class="contact-icon mb-3">
                                <i class="fas fa-headset fa-3x text-primary"></i>
                            </div>
                            <h4 class="card-title fw-bold">General Inquiries</h4>
                            <p class="card-text text-muted mb-3">
                                For appointments and general questions
                            </p>
                            <div class="contact-info">
                                <h5 class="text-primary fw-bold">011-2223344</h5>
                                <p class="text-muted small">Mon-Sun: 7:00 AM - 10:00 PM</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Social Media & Email -->
            <div class="col-lg-4">
                <div class="mb-4">
                    <h3 class="fw-bold text-primary mb-4">Connect With Us</h3>

                    <!-- Email Contact -->
                    <div class="card social-card mb-4">
                        <div class="card-body text-center p-4">
                            <div class="contact-icon mb-3">
                                <i class="fas fa-envelope fa-3x text-success"></i>
                            </div>
                            <h4 class="card-title fw-bold">Email Us</h4>
                            <p class="card-text text-muted mb-3">
                                Send us your questions and feedback
                            </p>
                            <a href="mailto:info@aurorahealth.com" class="btn btn-success btn-lg px-4">
                                <i class="fas fa-envelope me-2"></i>Send Email
                            </a>
                            <div class="contact-info mt-3">
                                <h6 class="text-success fw-bold">info@aurorahealth.com</h6>
                                <p class="text-muted small">Response within 24 hours</p>
                            </div>
                        </div>
                    </div>

                    <!-- Facebook -->
                    <div class="card social-card">
                        <div class="card-body text-center p-4">
                            <div class="contact-icon mb-3">
                                <i class="fab fa-facebook fa-3x text-primary"></i>
                            </div>
                            <h4 class="card-title fw-bold">Follow on Facebook</h4>
                            <p class="card-text text-muted mb-3">
                                Stay updated with our latest news and health tips
                            </p>
                            <a href="https://facebook.com/aurorahealthhospital" target="_blank" class="btn btn-primary btn-lg px-4">
                                <i class="fab fa-facebook me-2"></i>Visit Facebook
                            </a>
                            <div class="contact-info mt-3">
                                <h6 class="text-primary fw-bold">@AuroraHealthHospital</h6>
                                <p class="text-muted small">Connect with our community</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Location & Map -->
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-body p-4">
                        <h5 class="fw-bold mb-3"><i class="fas fa-map-marker-alt text-primary me-2"></i>Our Location</h5>
                        <p class="text-muted mb-3">
                            <strong>Aurora Health Hospital</strong><br>
                            123 Health Avenue, Medical District<br>
                            Colombo, Sri Lanka
                        </p>
                        <div class="operating-hours mb-4">
                            <h6 class="fw-bold mb-2">Operating Hours</h6>
                            <p class="text-muted mb-1"><strong>Emergency:</strong> 24/7</p>
                            <p class="text-muted mb-1"><strong>Outpatient:</strong> 7:00 AM - 10:00 PM</p>
                            <p class="text-muted mb-0"><strong>Pharmacy:</strong> 8:00 AM - 10:00 PM</p>
                        </div>
                        <div class="map-container">
                            <iframe
                                    src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3960.798511757687!2d79.86175541532638!3d6.921668295003807!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3ae2596b1f38b249%3A0x5a7b6a6e3b7b3b3b!2sColombo%2C%20Sri%20Lanka!5e0!3m2!1sen!2sus!4v1633023226784!5m2!1sen!2sus"
                                    width="100%"
                                    height="200"
                                    style="border:0;"
                                    allowfullscreen=""
                                    loading="lazy">
                            </iframe>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

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
                <div class="social-links mt-3">
                    <a href="https://facebook.com/aurorahealthhospital" target="_blank" class="text-light-emphasis me-3">
                        <i class="fab fa-facebook fa-lg"></i>
                    </a>
                    <a href="mailto:info@aurorahealth.com" class="text-light-emphasis">
                        <i class="fas fa-envelope fa-lg"></i>
                    </a>
                </div>
            </div>
            <div class="col-lg-2 col-6 mb-4">
                <h6 class="fw-bold">Quick Access</h6>
                <ul class="list-unstyled">
                    <li><a href="/login" class="text-light-emphasis text-decoration-none">Login</a></li>
                    <li><a href="/register" class="text-light-emphasis text-decoration-none">Register</a></li>
                    <li><a href="#features" class="text-light-emphasis text-decoration-none">Features</a></li>
                </ul>
            </div>
            <div class="col-lg-3 col-6 mb-4">
                <h6 class="fw-bold">Support</h6>
                <ul class="list-unstyled">
                    <li><a href="#" class="text-light-emphasis text-decoration-none">Help Center</a></li>
                    <li><a href="#contact" class="text-light-emphasis text-decoration-none">Contact Us</a></li>
                    <li><a href="#" class="text-light-emphasis text-decoration-none">Emergency</a></li>
                </ul>
            </div>
            <div class="col-lg-3 mb-4">
                <h6 class="fw-bold">Contact Info</h6>
                <ul class="list-unstyled text-light-emphasis">
                    <li><i class="fas fa-phone me-2"></i>Emergency: 011-2224455</li>
                    <li><i class="fas fa-envelope me-2"></i>info@aurorahealth.com</li>
                    <li><i class="fas fa-map-marker-alt me-2"></i>Colombo, Sri Lanka</li>
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
    // Enhanced counter animation for stats
    function animateCounter(element, target) {
        let current = 0;
        const increment = target / 50;
        const timer = setInterval(() => {
            current += increment;
            if (current >= target) {
                clearInterval(timer);
                current = target;
            }
            element.textContent = Math.floor(current) + '+';
        }, 30);
    }

    // Scroll animations
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('section-visible');

                // Animate stats when stats section comes into view
                if (entry.target.classList.contains('stats-section')) {
                    animateCounter(document.getElementById('patientsCount'), 1250);
                    animateCounter(document.getElementById('doctorsCount'), 75);
                    animateCounter(document.getElementById('appointmentsCount'), 5800);
                    animateCounter(document.getElementById('staffCount'), 120);
                }
            }
        });
    }, observerOptions);

    // Observe all sections
    document.querySelectorAll('.section-hidden').forEach(section => {
        observer.observe(section);
    });

    // Navbar scroll effect
    window.addEventListener('scroll', () => {
        const navbar = document.querySelector('.navbar');
        if (window.scrollY > 100) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });

    // Smooth scrolling for navigation links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });

    // Add hover effects to cards
    document.querySelectorAll('.feature-card, .role-card, .contact-card, .social-card').forEach(card => {
        card.addEventListener('mouseenter', function() {
            if (this.classList.contains('feature-card')) {
                this.style.transform = 'translateY(-15px) scale(1.02)';
            } else if (this.classList.contains('role-card')) {
                this.style.transform = 'translateY(-10px) scale(1.03)';
            } else {
                this.style.transform = 'translateY(-10px)';
            }
        });

        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0) scale(1)';
        });
    });
</script>
</body>
</html>