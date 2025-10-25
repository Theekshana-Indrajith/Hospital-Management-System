<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Test Details - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        /* Your existing CSS styles remain exactly the same */
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --danger-gradient: linear-gradient(135deg, #ff6b6b 0%, #ff8e8e 100%);
            --warning-gradient: linear-gradient(135deg, #ffd93d 0%, #ff9a3d 100%);
            --info-gradient: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            --dark-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --light-bg: rgba(255, 255, 255, 0.95);
            --shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            --primary-color: #667eea;
            --primary-dark: #5a6fd8;
            --success-color: #4facfe;
            --danger-color: #ff6b6b;
            --warning-color: #ffd93d;
            --info-color: #6a11cb;
            --light-color: #f8f9fa;
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

        .card {
            border: none;
            border-radius: 15px;
            background: var(--light-bg);
            backdrop-filter: blur(12px);
            box-shadow: var(--shadow);
            transition: transform 0.4s ease, box-shadow 0.4s ease;
            margin-bottom: 1.5rem;
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
            background: var(--primary-gradient);
            transform: scaleX(0);
            transition: transform 0.4s ease;
        }

        .card:hover::before {
            transform: scaleX(1);
        }

        .card.border-primary::before { background: var(--primary-gradient); }
        .card.border-success::before { background: var(--success-gradient); }
        .card.border-warning::before { background: var(--warning-gradient); }
        .card.border-danger::before { background: var(--danger-gradient); }
        .card.border-info::before { background: var(--info-gradient); }

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
            background: linear-gradient(135deg, #5a6fd8 0%, #6a4190 100%);
        }

        .btn-outline-primary {
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-outline-primary:hover {
            background: var(--primary-gradient);
            color: white;
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #6c757d 0%, #495057 100%);
            border: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(108, 117, 125, 0.3);
        }

        .alert {
            border-radius: 12px;
            box-shadow: var(--shadow);
            position: relative;
            overflow: hidden;
            background: var(--light-bg);
            backdrop-filter: blur(10px);
            border: none;
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

        .alert-danger::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 6px;
            height: 100%;
            background: var(--danger-gradient);
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

        .badge {
            padding: 8px 12px;
            border-radius: 20px;
            font-weight: 600;
        }

        .bg-primary { background: var(--primary-gradient) !important; }
        .bg-success { background: var(--success-gradient) !important; }
        .bg-danger { background: var(--danger-gradient) !important; }
        .bg-warning { background: var(--warning-gradient) !important; }
        .bg-info { background: var(--info-gradient) !important; }
        .bg-secondary { background: linear-gradient(135deg, #6c757d 0%, #495057 100%) !important; }

        .table {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }

        .table thead th {
            background: var(--primary-gradient);
            color: white;
            border: none;
            font-weight: 600;
            padding: 15px;
        }

        .table tbody tr {
            transition: all 0.3s ease;
        }

        .table tbody tr:hover {
            background-color: rgba(102, 126, 234, 0.05);
            transform: translateY(-2px);
        }

        .table tbody td {
            padding: 15px;
            vertical-align: middle;
            border-color: rgba(0, 0, 0, 0.05);
        }

        .table-borderless tbody tr:hover {
            background-color: transparent;
            transform: none;
        }

        footer {
            background: var(--dark-gradient) !important;
            color: #fff;
            position: relative;
            overflow: hidden;
            margin-top: 3rem;
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
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center">
            <i class="fas fa-hospital-alt"></i>
            <span>Aurora Health Hospital</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <c:choose>
                    <c:when test="${role == 'DOCTOR'}">
                        <li class="nav-item">
                            <a class="nav-link" href="/doctor/dashboard">
                                <i class="fas fa-th-large"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/lab-tests">
                                <i class="fas fa-arrow-left"></i>Back to Tests
                            </a>
                        </li>
                    </c:when>
                    <c:when test="${role == 'PATIENT'}">
                        <li class="nav-item">
                            <a class="nav-link" href="/patient/dashboard">
                                <i class="fas fa-th-large"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/patient/lab-tests">
                                <i class="fas fa-arrow-left"></i>Back to Tests
                            </a>
                        </li>
                    </c:when>
                    <c:when test="${role == 'LAB_TECH'}">
                        <li class="nav-item">
                            <a class="nav-link" href="/lab-technician/dashboard">
                                <i class="fas fa-th-large"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/lab-technician/tests">
                                <i class="fas fa-list"></i>My Tests
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="nav-link" href="/lab-tests">
                                <i class="fas fa-arrow-left"></i>Back to Tests
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
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

<!-- Debug Information (can be removed in production) -->
<c:if test="${empty labTest}">
    <div class="container mt-3">
        <div class="alert alert-warning">
            <strong>Debug Info:</strong> LabTest object is null or empty. Please check the controller.
        </div>
    </div>
</c:if>

<!-- Main Content -->
<div class="container mt-4">
    <div class="row">
        <div class="col-md-8 mx-auto">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0"><i class="fas fa-file-medical me-2"></i>Laboratory Test Details</h4>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty labTest}">
                            <!-- Test Information -->
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <h6>Test Information</h6>
                                    <table class="table table-sm table-borderless">
                                        <tr>
                                            <td><strong>Test ID:</strong></td>
                                            <td>#${labTest.id}</td>
                                        </tr>
                                        <tr>
                                            <td><strong>Test Name:</strong></td>
                                            <td>${labTest.testName}</td>
                                        </tr>
                                        <tr>
                                            <td><strong>Test Type:</strong></td>
                                            <td><span class="badge bg-info">${labTest.testType}</span></td>
                                        </tr>
                                        <tr>
                                            <td><strong>Priority:</strong></td>
                                            <td>
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
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="col-md-6">
                                    <h6>Status Information</h6>
                                    <table class="table table-sm table-borderless">
                                        <tr>
                                            <td><strong>Status:</strong></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${labTest.status == 'REQUESTED'}">
                                                        <span class="badge bg-warning">REQUESTED</span>
                                                    </c:when>
                                                    <c:when test="${labTest.status == 'IN_PROGRESS'}">
                                                        <span class="badge bg-primary">IN PROGRESS</span>
                                                    </c:when>
                                                    <c:when test="${labTest.status == 'COMPLETED'}">
                                                        <c:choose>
                                                            <c:when test="${labTest.isAbnormal}">
                                                                <span class="badge bg-danger">COMPLETED - ABNORMAL</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-success">COMPLETED - NORMAL</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">${labTest.status}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>Requested:</strong></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty labTest.requestedDate}">
                                                        ${labTest.requestedDate}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Not specified</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                        <c:if test="${not empty labTest.collectionDate}">
                                            <tr>
                                                <td><strong>Collected:</strong></td>
                                                <td>${labTest.collectionDate}</td>
                                            </tr>
                                        </c:if>
                                        <c:if test="${not empty labTest.completedDate}">
                                            <tr>
                                                <td><strong>Completed:</strong></td>
                                                <td>${labTest.completedDate}</td>
                                            </tr>
                                        </c:if>
                                    </table>
                                </div>
                            </div>

                            <!-- Patient & Doctor Information -->
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <h6>Patient Information</h6>
                                    <table class="table table-sm table-borderless">
                                        <tr>
                                            <td><strong>Name:</strong></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty labTest.patient}">
                                                        ${labTest.patient.firstName} ${labTest.patient.lastName}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Patient data not available</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>Patient ID:</strong></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty labTest.patient}">
                                                        ${labTest.patient.id}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">N/A</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>Contact:</strong></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty labTest.patient && not empty labTest.patient.contactNumber}">
                                                        ${labTest.patient.contactNumber}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Not available</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="col-md-6">
                                    <h6>Medical Information</h6>
                                    <table class="table table-sm table-borderless">
<%--                                        <tr>--%>
<%--&lt;%&ndash;                                            <td><strong>Requesting Doctor:</strong></td>&ndash;%&gt;--%>
<%--                                            <td>--%>
<%--                                                <c:choose>--%>
<%--                                                    <c:when test="${not empty test.doctor}">--%>
<%--                                                        <c:choose>--%>
<%--                                                            <c:when test="${not empty test.doctor.name}">--%>
<%--                                                                Dr. ${test.doctor.name}--%>
<%--                                                            </c:when>--%>
<%--                                                            <c:when test="${not empty test.doctor.firstName}">--%>
<%--                                                                Dr. ${test.doctor.firstName} ${test.doctor.lastName}--%>
<%--                                                            </c:when>--%>
<%--                                                            <c:otherwise>--%>
<%--                                                                Dr. ID: ${test.doctor.id}--%>
<%--                                                            </c:otherwise>--%>
<%--                                                        </c:choose>--%>
<%--                                                    </c:when>--%>
<%--                                                    <c:otherwise>--%>
<%--                                                        <span class="text-muted">Not assigned</span>--%>
<%--                                                    </c:otherwise>--%>
<%--                                                </c:choose>--%>
<%--                                            </td>--%>
<%--                                        </tr>--%>
                                        <tr>
                                            <td><strong>Specialization:</strong></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty labTest.doctor && not empty labTest.doctor.specialization}">
                                                        ${labTest.doctor.specialization}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Not specified</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                        <c:if test="${not empty labTest.labTechnician}">
                                            <tr>
                                                <td><strong>Lab Technician:</strong></td>
                                                <td>${labTest.labTechnician.firstName} ${labTest.labTechnician.lastName}</td>
                                            </tr>
                                        </c:if>
                                    </table>
                                </div>
                            </div>

                            <!-- Clinical Information -->
                            <c:if test="${not empty labTest.description}">
                                <div class="mb-4">
                                    <h6>Clinical Description</h6>
                                    <div class="card bg-light">
                                        <div class="card-body">
                                            <p class="mb-0">${labTest.description}</p>
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                            <!-- Test Results -->
                            <c:if test="${labTest.status == 'COMPLETED'}">
                                <div class="mb-4">
                                    <h6 class="text-success"><i class="fas fa-chart-line me-2"></i>Test Results</h6>
                                    <div class="card border-success">
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <strong>Results:</strong>
                                                    <p class="mt-2">
                                                        <c:choose>
                                                            <c:when test="${not empty labTest.results}">
                                                                ${labTest.results}
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">No results available</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="row">
                                                        <div class="col-6">
                                                            <strong>Normal Range:</strong>
                                                            <p>
                                                                <c:choose>
                                                                    <c:when test="${not empty labTest.normalRange}">
                                                                        ${labTest.normalRange}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-muted">N/A</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </p>
                                                        </div>
                                                        <div class="col-6">
                                                            <strong>Units:</strong>
                                                            <p>
                                                                <c:choose>
                                                                    <c:when test="${not empty labTest.units}">
                                                                        ${labTest.units}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-muted">N/A</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <c:if test="${not empty labTest.findings}">
                                                <div class="mt-3">
                                                    <strong>Findings/Interpretation:</strong>
                                                    <p class="mt-2">${labTest.findings}</p>
                                                </div>
                                            </c:if>
                                            <c:if test="${not empty labTest.notes}">
                                                <div class="mt-3">
                                                    <strong>Technician Notes:</strong>
                                                    <p class="mt-2 text-muted">${labTest.notes}</p>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                            <!-- Action Buttons -->
                            <div class="d-flex justify-content-between">
                                <c:if test="${role == 'LAB_TECH' && labTest.status != 'COMPLETED'}">
                                    <a href="/lab-technician/tests/update-results/${labTest.id}"
                                       class="btn btn-primary">
                                        <i class="fas fa-edit me-1"></i>Update Results
                                    </a>
                                </c:if>
                                <c:if test="${role == 'PATIENT'}">
                                    <button class="btn btn-outline-primary" onclick="window.print()">
                                        <i class="fas fa-print me-1"></i>Print Report
                                    </button>
                                </c:if>
                                <a href="javascript:history.back()" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left me-1"></i>Back
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-4">
                                <i class="fas fa-exclamation-triangle fa-3x text-warning mb-3"></i>
                                <h4>Test Not Found</h4>
                                <p class="text-muted">The requested laboratory test could not be found.</p>
                                <a href="javascript:history.back()" class="btn btn-primary">
                                    <i class="fas fa-arrow-left me-1"></i>Go Back
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
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
    // Scroll effect for navbar
    window.addEventListener('scroll', () => {
        const navbar = document.querySelector('.navbar');
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });

    // Debug function to check object structure
    function debugLabTest() {
        console.log('LabTest Object:', ${labTest});
        console.log('Patient Object:', ${labTest.patient});
        console.log('Doctor Object:', ${labTest.doctor});
    }

    // Call debug on page load (remove in production)
    window.addEventListener('load', debugLabTest);
</script>
</body>
</html>