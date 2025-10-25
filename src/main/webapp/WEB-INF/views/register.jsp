<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Register - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap');

        :root {
            --primary-color: #4f46e5;
            --secondary-color: #10b981;
            --accent-color: #f59e0b;
            --light-bg: #f8fafc;
            --dark-bg: #0f172a;
            --card-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            --transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            position: relative;
            overflow-x: hidden;
        }

        /* Enhanced Animated Background */
        .bg-animation {
            position: absolute;
            width: 100%;
            height: 100%;
            z-index: 0;
            overflow: hidden;
        }

        .gradient-bg {
            position: absolute;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
            opacity: 0.9;
            animation: gradient-shift 15s ease infinite;
        }

        @keyframes gradient-shift {
            0%, 100% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
        }

        .wave {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 200%;
            height: 200px;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120"><path d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z" fill="%23ffffff" fill-opacity="0.05"/></svg>') repeat-x;
            animation: wave 25s linear infinite;
        }

        .wave:nth-child(2) {
            bottom: 20px;
            opacity: 0.5;
            animation: wave 20s linear infinite reverse;
        }

        .wave:nth-child(3) {
            bottom: 40px;
            opacity: 0.3;
            animation: wave 30s linear infinite;
        }

        @keyframes wave {
            0% { transform: translateX(0); }
            100% { transform: translateX(-50%); }
        }

        /* Floating Medical Elements */
        .medical-icon {
            position: absolute;
            color: rgba(255, 255, 255, 0.08);
            font-size: 60px;
            animation: float 20s infinite ease-in-out;
            filter: drop-shadow(0 0 10px rgba(255, 255, 255, 0.2));
        }

        .medical-icon:nth-child(4) { top: 10%; left: 10%; animation-delay: 0s; }
        .medical-icon:nth-child(5) { top: 20%; right: 15%; animation-delay: 3s; font-size: 80px; }
        .medical-icon:nth-child(6) { bottom: 15%; left: 15%; animation-delay: 6s; font-size: 70px; }
        .medical-icon:nth-child(7) { top: 60%; right: 10%; animation-delay: 9s; }
        .medical-icon:nth-child(8) { bottom: 30%; right: 25%; animation-delay: 12s; font-size: 50px; }

        @keyframes float {
            0%, 100% {
                transform: translateY(0) rotate(0deg) scale(1);
                opacity: 0.05;
            }
            25% {
                transform: translateY(-30px) rotate(5deg) scale(1.1);
                opacity: 0.08;
            }
            50% {
                transform: translateY(-50px) rotate(-5deg) scale(1.05);
                opacity: 0.05;
            }
            75% {
                transform: translateY(-30px) rotate(3deg) scale(1.1);
                opacity: 0.08;
            }
        }

        /* Light Particles */
        .particle {
            position: absolute;
            background: rgba(255, 255, 255, 0.6);
            border-radius: 50%;
            box-shadow: 0 0 20px rgba(255, 255, 255, 0.8);
            animation: particle-rise 12s infinite ease-in;
        }

        .particle:nth-child(9) { width: 3px; height: 3px; left: 20%; bottom: -10px; animation-delay: 0s; }
        .particle:nth-child(10) { width: 4px; height: 4px; left: 40%; bottom: -10px; animation-delay: 2s; }
        .particle:nth-child(11) { width: 2px; height: 2px; left: 60%; bottom: -10px; animation-delay: 4s; }
        .particle:nth-child(12) { width: 5px; height: 5px; left: 80%; bottom: -10px; animation-delay: 6s; }
        .particle:nth-child(13) { width: 3px; height: 3px; left: 30%; bottom: -10px; animation-delay: 8s; }
        .particle:nth-child(14) { width: 4px; height: 4px; left: 70%; bottom: -10px; animation-delay: 10s; }

        @keyframes particle-rise {
            0% { transform: translateY(0) translateX(0); opacity: 0; }
            10% { opacity: 1; }
            90% { opacity: 1; }
            100% { transform: translateY(-120vh) translateX(100px); opacity: 0; }
        }

        .container {
            position: relative;
            z-index: 1;
        }

        .register-wrapper {
            display: flex;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 30px;
            overflow: hidden;
            box-shadow: 0 40px 100px rgba(0, 0, 0, 0.4),
            0 0 80px rgba(102, 126, 234, 0.3);
            max-width: 1100px;
            width: 100%;
            animation: slideIn 1s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: scale(0.8) translateY(60px) rotateX(10deg);
            }
            to {
                opacity: 1;
                transform: scale(1) translateY(0) rotateX(0deg);
            }
        }

        /* New Glow Effect */
        .register-wrapper::before {
            content: '';
            position: absolute;
            top: -10px;
            left: -10px;
            right: -10px;
            bottom: -10px;
            background: linear-gradient(45deg, #667eea, #764ba2, #f093fb, #667eea);
            background-size: 400% 400%;
            border-radius: 35px;
            z-index: -1;
            animation: glow-border 8s ease infinite;
            filter: blur(20px);
            opacity: 0.7;
        }

        @keyframes glow-border {
            0%, 100% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
        }

        .register-left {
            flex: 1.2;
            background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
            padding: 80px 50px;
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            position: relative;
            overflow: hidden;
        }

        .register-left::before {
            content: '';
            position: absolute;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.15) 0%, transparent 70%);
            border-radius: 50%;
            top: -200px;
            right: -200px;
            animation: pulse-slow 8s ease-in-out infinite;
        }

        .register-left::after {
            content: '';
            position: absolute;
            width: 300px;
            height: 300px;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
            border-radius: 50%;
            bottom: -150px;
            left: -150px;
            animation: pulse-slow 10s ease-in-out infinite reverse;
        }

        @keyframes pulse-slow {
            0%, 100% { transform: scale(1); opacity: 1; }
            50% { transform: scale(1.1); opacity: 0.8; }
        }

        .hospital-logo {
            position: relative;
            z-index: 1;
            margin-bottom: 40px;
            text-align: center;
        }

        .logo-container {
            position: relative;
            display: inline-block;
            margin-bottom: 30px;
        }

        .icon-circle {
            width: 140px;
            height: 140px;
            background: rgba(255, 255, 255, 0.15);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto;
            backdrop-filter: blur(10px);
            border: 4px solid rgba(255, 255, 255, 0.3);
            position: relative;
            animation: pulse-glow 3s ease-in-out infinite;
            box-shadow: 0 0 60px rgba(255, 255, 255, 0.3);
        }

        .icon-circle::before {
            content: '';
            position: absolute;
            width: 160px;
            height: 160px;
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            animation: rotate-ring 10s linear infinite;
        }

        .icon-circle::after {
            content: '';
            position: absolute;
            width: 180px;
            height: 180px;
            border: 2px dashed rgba(255, 255, 255, 0.15);
            border-radius: 50%;
            animation: rotate-ring 15s linear infinite reverse;
        }

        @keyframes rotate-ring {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        @keyframes pulse-glow {
            0%, 100% {
                box-shadow: 0 0 40px rgba(255, 255, 255, 0.3),
                0 0 60px rgba(255, 255, 255, 0.2),
                inset 0 0 20px rgba(255, 255, 255, 0.1);
                transform: scale(1);
            }
            50% {
                box-shadow: 0 0 60px rgba(255, 255, 255, 0.5),
                0 0 80px rgba(255, 255, 255, 0.3),
                inset 0 0 30px rgba(255, 255, 255, 0.2);
                transform: scale(1.05);
            }
        }

        .icon-circle i {
            font-size: 70px;
            color: white;
            position: relative;
            z-index: 1;
            animation: icon-beat 2s ease-in-out infinite;
        }

        @keyframes icon-beat {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }

        .hospital-name {
            font-size: 3rem;
            font-weight: 800;
            text-align: center;
            margin-bottom: 15px;
            text-shadow: 3px 3px 6px rgba(0, 0, 0, 0.3);
            position: relative;
            z-index: 1;
            letter-spacing: 1px;
            background: linear-gradient(to right, #ffffff, #e0e7ff);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: text-shimmer 3s ease-in-out infinite;
        }

        @keyframes text-shimmer {
            0%, 100% { background-position: -200% center; }
            50% { background-position: 200% center; }
        }

        .hospital-tagline {
            font-size: 1.1rem;
            text-align: center;
            opacity: 0.95;
            font-weight: 300;
            margin-bottom: 50px;
            position: relative;
            z-index: 1;
            letter-spacing: 0.5px;
            animation: fade-in-out 4s ease-in-out infinite;
        }

        @keyframes fade-in-out {
            0%, 100% { opacity: 0.7; }
            50% { opacity: 1; }
        }

        .features {
            position: relative;
            z-index: 1;
            width: 100%;
        }

        .feature-item {
            display: flex;
            align-items: center;
            margin-bottom: 25px;
            font-size: 1rem;
            padding: 15px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: all 0.4s ease;
            animation: slide-in-left 0.8s ease-out;
        }

        .feature-item:nth-child(1) { animation-delay: 0.2s; }
        .feature-item:nth-child(2) { animation-delay: 0.4s; }
        .feature-item:nth-child(3) { animation-delay: 0.6s; }
        .feature-item:nth-child(4) { animation-delay: 0.8s; }

        @keyframes slide-in-left {
            from {
                opacity: 0;
                transform: translateX(-50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .feature-item:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateX(10px) scale(1.02);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }

        .feature-item .icon-wrapper {
            font-size: 28px;
            margin-right: 20px;
            background: rgba(255, 255, 255, 0.2);
            padding: 15px;
            border-radius: 12px;
            min-width: 56px;
            height: 56px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .feature-item:hover .icon-wrapper {
            transform: rotate(15deg) scale(1.1);
            background: rgba(255, 255, 255, 0.3);
        }

        .register-right {
            flex: 1;
            padding: 80px 60px;
            background: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            position: relative;
        }

        .register-header {
            margin-bottom: 40px;
            animation: slide-in-right 0.8s ease-out;
        }

        @keyframes slide-in-right {
            from {
                opacity: 0;
                transform: translateX(50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .register-header h2 {
            color: #1a202c;
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 10px;
            background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .register-header p {
            color: #718096;
            font-size: 1rem;
            font-weight: 400;
        }

        .alert {
            border-radius: 15px;
            border: none;
            font-size: 0.95rem;
            padding: 16px 20px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            animation: slideInRight 0.5s ease;
        }

        @keyframes slideInRight {
            from {
                opacity: 0;
                transform: translateX(20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .alert i {
            margin-right: 12px;
            font-size: 1.2rem;
        }

        .alert-danger {
            background: linear-gradient(135deg, #fee 0%, #fdd 100%);
            color: #c53030;
            border-left: 4px solid #c53030;
        }

        .alert-success {
            background: linear-gradient(135deg, #efe 0%, #dfd 100%);
            color: #276749;
            border-left: 4px solid #276749;
        }

        .alert-info {
            background: linear-gradient(135deg, #e6f7ff 0%, #d1f0ff 100%);
            color: #2c5282;
            border-left: 4px solid #2c5282;
        }

        .form-group {
            margin-bottom: 30px;
            position: relative;
            animation: form-appear 0.8s ease-out;
        }

        .form-group:nth-child(1) { animation-delay: 0.3s; }
        .form-group:nth-child(2) { animation-delay: 0.5s; }
        .form-group:nth-child(3) { animation-delay: 0.7s; }
        .form-group:nth-child(4) { animation-delay: 0.9s; }

        @keyframes form-appear {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-label {
            color: #4a5568;
            font-weight: 600;
            font-size: 0.95rem;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
        }

        .form-label i {
            margin-right: 10px;
            color: #4f46e5;
            font-size: 1.1rem;
        }

        .input-wrapper {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: #a0aec0;
            font-size: 1.2rem;
            z-index: 2;
            transition: all 0.3s ease;
        }

        .form-control {
            border: 2px solid #e2e8f0;
            border-radius: 15px;
            padding: 16px 20px 16px 55px;
            font-size: 1rem;
            transition: all 0.3s ease;
            width: 100%;
            background: #f7fafc;
        }

        .form-control:focus {
            border-color: #4f46e5;
            box-shadow: 0 0 0 5px rgba(79, 70, 229, 0.1);
            outline: none;
            background: white;
            transform: translateY(-2px);
        }

        .form-control:focus ~ .input-icon {
            color: #4f46e5;
            transform: translateY(-50%) scale(1.1);
            animation: icon-bounce 0.5s ease;
        }

        @keyframes icon-bounce {
            0%, 100% { transform: translateY(-50%) scale(1.1); }
            50% { transform: translateY(-50%) scale(1.3); }
        }

        .btn-primary {
            background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
            border: none;
            border-radius: 15px;
            padding: 18px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.4s ease;
            box-shadow: 0 10px 30px rgba(79, 70, 229, 0.3);
            width: 100%;
            margin-top: 15px;
            position: relative;
            overflow: hidden;
            cursor: pointer;
            animation: btn-appear 0.8s ease-out 1.1s both;
        }

        @keyframes btn-appear {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .btn-primary::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.6s ease;
        }

        .btn-primary:hover::before {
            left: 100%;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(79, 70, 229, 0.5);
        }

        .btn-primary:active {
            transform: translateY(-1px);
        }

        .btn-primary i {
            margin-right: 10px;
        }

        .login-link {
            text-align: center;
            margin-top: 30px;
            font-size: 0.95rem;
            color: #718096;
            animation: fade-in 1s ease-out 1.3s both;
        }

        @keyframes fade-in {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .login-link a {
            color: #4f46e5;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            position: relative;
        }

        .login-link a::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: #4f46e5;
            transition: width 0.3s ease;
        }

        .login-link a:hover::after {
            width: 100%;
        }

        .login-link a:hover {
            color: #7c3aed;
        }

        /* Enhanced Close Button */
        .close-btn {
            position: absolute;
            top: 30px;
            right: 30px;
            width: 50px;
            height: 50px;
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
            text-decoration: none;
            transition: all 0.3s ease;
            border: 2px solid rgba(255, 255, 255, 0.2);
            z-index: 10;
            animation: close-btn-appear 0.8s ease-out 0.5s both;
        }

        @keyframes close-btn-appear {
            from {
                opacity: 0;
                transform: scale(0);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        .close-btn:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: rotate(90deg) scale(1.1);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
        }

        .close-btn i {
            transition: transform 0.3s ease;
        }

        /* New Floating Particles in Form */
        .form-particle {
            position: absolute;
            width: 6px;
            height: 6px;
            background: #4f46e5;
            border-radius: 50%;
            animation: form-particle-float 8s infinite ease-in-out;
            opacity: 0.3;
        }

        .form-particle:nth-child(1) { top: 20%; left: 10%; animation-delay: 0s; }
        .form-particle:nth-child(2) { top: 60%; right: 15%; animation-delay: 2s; }
        .form-particle:nth-child(3) { bottom: 30%; left: 20%; animation-delay: 4s; }
        .form-particle:nth-child(4) { top: 40%; right: 25%; animation-delay: 6s; }

        @keyframes form-particle-float {
            0%, 100% { transform: translateY(0) translateX(0); opacity: 0.3; }
            25% { transform: translateY(-20px) translateX(10px); opacity: 0.5; }
            50% { transform: translateY(-10px) translateX(-10px); opacity: 0.3; }
            75% { transform: translateY(-30px) translateX(5px); opacity: 0.5; }
        }

        /* Responsive Design */
        @media (max-width: 968px) {
            .register-wrapper {
                flex-direction: column;
                max-width: 500px;
                margin: 20px;
            }

            .register-left {
                padding: 50px 40px;
            }

            .register-right {
                padding: 50px 40px;
            }

            .hospital-name {
                font-size: 2.2rem;
            }

            .features {
                display: none;
            }

            .icon-circle {
                width: 120px;
                height: 120px;
            }

            .icon-circle i {
                font-size: 60px;
            }

            .close-btn {
                top: 20px;
                right: 20px;
                width: 45px;
                height: 45px;
                font-size: 20px;
            }
        }

        @media (max-width: 576px) {
            .register-wrapper {
                margin: 10px;
            }

            .register-left,
            .register-right {
                padding: 30px 25px;
            }

            .hospital-name {
                font-size: 1.8rem;
            }

            .register-header h2 {
                font-size: 1.8rem;
            }

            .close-btn {
                top: 15px;
                right: 15px;
                width: 40px;
                height: 40px;
                font-size: 18px;
            }
        }

        /* Add validation styles */
        .is-invalid {
            border-color: #dc3545 !important;
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25) !important;
        }

        .is-valid {
            border-color: #198754 !important;
            box-shadow: 0 0 0 0.2rem rgba(25, 135, 84, 0.25) !important;
        }

        .invalid-feedback {
            display: none;
            width: 100%;
            margin-top: 0.25rem;
            font-size: 0.875em;
            color: #dc3545;
        }

        .was-validated .form-control:invalid ~ .invalid-feedback,
        .was-validated .form-control:invalid ~ .invalid-tooltip,
        .form-control.is-invalid ~ .invalid-feedback,
        .form-control.is-invalid ~ .invalid-tooltip {
            display: block;
        }

        .validation-icon {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 1.2rem;
            z-index: 3;
        }

        .fa-check-circle {
            color: #198754;
        }

        .fa-times-circle {
            color: #dc3545;
        }
    </style>
</head>
<body>
<div class="bg-animation">
    <div class="gradient-bg"></div>
    <div class="wave"></div>
    <div class="wave"></div>
    <div class="wave"></div>
    <div class="medical-icon"><i class="fas fa-heartbeat"></i></div>
    <div class="medical-icon"><i class="fas fa-stethoscope"></i></div>
    <div class="medical-icon"><i class="fas fa-user-md"></i></div>
    <div class="medical-icon"><i class="fas fa-plus"></i></div>
    <div class="medical-icon"><i class="fas fa-hospital"></i></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
</div>

<div class="container">
    <div class="register-wrapper">
        <!-- Left Side - Hospital Branding -->
        <div class="register-left">
            <div class="hospital-logo">
                <div class="logo-container">
                    <div class="icon-circle">
                        <i class="fas fa-hospital"></i>
                    </div>
                </div>
                <h1 class="hospital-name">Aurora Health</h1>
                <p class="hospital-tagline">Advanced Hospital Management System</p>
            </div>

            <div class="features">
                <div class="feature-item">
                    <div class="icon-wrapper">
                        <i class="fas fa-user-md"></i>
                    </div>
                    <span>Expert Medical Professionals</span>
                </div>
                <div class="feature-item">
                    <div class="icon-wrapper">
                        <i class="fas fa-heartbeat"></i>
                    </div>
                    <span>24/7 Emergency Care Services</span>
                </div>
                <div class="feature-item">
                    <div class="icon-wrapper">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <span>Secure Patient Data Protection</span>
                </div>
                <div class="feature-item">
                    <div class="icon-wrapper">
                        <i class="fas fa-clock"></i>
                    </div>
                    <span>Instant Appointment Booking</span>
                </div>
            </div>
        </div>

        <!-- Right Side - Registration Form -->
        <div class="register-right">
            <!-- Form Particles -->
            <div class="form-particle"></div>
            <div class="form-particle"></div>
            <div class="form-particle"></div>
            <div class="form-particle"></div>

            <div class="register-header">
                <h2>Create Account</h2>
                <p>Join our healthcare community today</p>
            </div>

            <!-- Error/Success Messages -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle"></i>
                        ${error}
                </div>
            </c:if>

            <form action="/register" method="post" id="registrationForm" novalidate>
                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-user"></i>
                        First Name
                    </label>
                    <div class="input-wrapper">
                        <input type="text" name="firstName" class="form-control"
                               placeholder="Enter your first name"
                               value="${firstName}"
                               pattern="^[a-zA-Z\\s]+$"
                               required>
                        <i class="fas fa-user input-icon"></i>
                        <div class="validation-icon">
                            <i class="fas fa-check-circle d-none"></i>
                            <i class="fas fa-times-circle d-none"></i>
                        </div>
                        <div class="invalid-feedback">
                            Please enter a valid first name.
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-user"></i>
                        Last Name
                    </label>
                    <div class="input-wrapper">
                        <input type="text" name="lastName" class="form-control"
                               placeholder="Enter your last name"
                               value="${lastName}"
                               pattern="^[a-zA-Z\\s]+$"
                               required>
                        <i class="fas fa-user input-icon"></i>
                        <div class="validation-icon">
                            <i class="fas fa-check-circle d-none"></i>
                            <i class="fas fa-times-circle d-none"></i>
                        </div>
                        <div class="invalid-feedback">
                            Please enter a valid last name.
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-at"></i>
                        Username
                    </label>
                    <div class="input-wrapper">
                        <input type="text" name="username" class="form-control"
                               placeholder="Enter your username"
                               value="${username}"
                               pattern="^[a-zA-Z]+$"
                               required>
                        <i class="fas fa-at input-icon"></i>
                        <div class="validation-icon">
                            <i class="fas fa-check-circle d-none"></i>
                            <i class="fas fa-times-circle d-none"></i>
                        </div>
                        <div class="invalid-feedback">
                            Username must contain only letters (no digits or spaces).
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-envelope"></i>
                        Email
                    </label>
                    <div class="input-wrapper">
                        <input type="email" name="email" class="form-control"
                               placeholder="Enter your email"
                               value="${email}"
                               required>
                        <i class="fas fa-envelope input-icon"></i>
                        <div class="validation-icon">
                            <i class="fas fa-check-circle d-none"></i>
                            <i class="fas fa-times-circle d-none"></i>
                        </div>
                        <div class="invalid-feedback">
                            Please enter a valid email address.
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-lock"></i>
                        Password
                    </label>
                    <div class="input-wrapper">
                        <input type="password" name="password" class="form-control"
                               placeholder="Enter your password (minimum 6 characters)"
                               required minlength="6">
                        <i class="fas fa-lock input-icon"></i>
                        <div class="validation-icon">
                            <i class="fas fa-check-circle d-none"></i>
                            <i class="fas fa-times-circle d-none"></i>
                        </div>
                        <div class="invalid-feedback">
                            Password must be at least 6 characters long.
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-lock"></i>
                        Confirm Password
                    </label>
                    <div class="input-wrapper">
                        <input type="password" name="confirmPassword" class="form-control"
                               placeholder="Confirm your password"
                               required minlength="6">
                        <i class="fas fa-lock input-icon"></i>
                        <div class="validation-icon">
                            <i class="fas fa-check-circle d-none"></i>
                            <i class="fas fa-times-circle d-none"></i>
                        </div>
                        <div class="invalid-feedback">
                            Please confirm your password.
                        </div>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-user-plus"></i> Create Account
                </button>
            </form>

            <div class="login-link">
                Already have an account? <a href="/login">Login here</a>
            </div>
        </div>
    </div>

    <!-- Close Button -->
    <a href="/" class="close-btn" title="Back to Home">
        <i class="fas fa-times"></i>
    </a>
</div>

<script>
    // Real-time validation
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.getElementById('registrationForm');
        const inputs = form.querySelectorAll('input[pattern]');

        // Add real-time validation for pattern-based inputs
        inputs.forEach(input => {
            input.addEventListener('input', function() {
                validateField(this);
            });

            input.addEventListener('blur', function() {
                validateField(this);
            });
        });

        // Password confirmation validation
        const password = document.querySelector('input[name="password"]');
        const confirmPassword = document.querySelector('input[name="confirmPassword"]');

        if (password && confirmPassword) {
            confirmPassword.addEventListener('input', function() {
                validatePasswordMatch();
            });

            password.addEventListener('input', function() {
                validatePasswordMatch();
            });
        }

        function validateField(field) {
            const pattern = field.getAttribute('pattern');
            const value = field.value.trim();
            const validationIcon = field.parentElement.querySelector('.validation-icon');
            const checkIcon = validationIcon.querySelector('.fa-check-circle');
            const timesIcon = validationIcon.querySelector('.fa-times-circle');

            if (value === '') {
                checkIcon.classList.add('d-none');
                timesIcon.classList.add('d-none');
                field.classList.remove('is-valid', 'is-invalid');
                return;
            }

            const regex = new RegExp(pattern);
            const isValid = regex.test(value);

            if (isValid) {
                field.classList.remove('is-invalid');
                field.classList.add('is-valid');
                checkIcon.classList.remove('d-none');
                timesIcon.classList.add('d-none');
            } else {
                field.classList.remove('is-valid');
                field.classList.add('is-invalid');
                checkIcon.classList.add('d-none');
                timesIcon.classList.remove('d-none');
            }
        }

        function validatePasswordMatch() {
            const passwordValue = password.value;
            const confirmValue = confirmPassword.value;
            const validationIcon = confirmPassword.parentElement.querySelector('.validation-icon');
            const checkIcon = validationIcon.querySelector('.fa-check-circle');
            const timesIcon = validationIcon.querySelector('.fa-times-circle');

            if (confirmValue === '') {
                checkIcon.classList.add('d-none');
                timesIcon.classList.add('d-none');
                confirmPassword.classList.remove('is-valid', 'is-invalid');
                return;
            }

            if (passwordValue === confirmValue && passwordValue.length >= 6) {
                confirmPassword.classList.remove('is-invalid');
                confirmPassword.classList.add('is-valid');
                checkIcon.classList.remove('d-none');
                timesIcon.classList.add('d-none');
            } else {
                confirmPassword.classList.remove('is-valid');
                confirmPassword.classList.add('is-invalid');
                checkIcon.classList.add('d-none');
                timesIcon.classList.remove('d-none');
            }
        }

        // Form submission validation
        form.addEventListener('submit', function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }

            form.classList.add('was-validated');
        });
    });
</script>
</body>
</html>