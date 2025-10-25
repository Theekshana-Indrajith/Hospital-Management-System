<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Beds in ${ward.wardNumber} - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        /* Your existing CSS remains exactly the same */
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap');

        :root {
            --primary-gradient: linear-gradient(135deg, #2ecc71 0%, #27ae60 100%);
            --success-gradient: linear-gradient(135deg, #27ae60 0%, #2ecc71 100%);
            --danger-gradient: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
            --warning-gradient: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);
            --info-gradient: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            --dark-gradient: linear-gradient(135deg, #2ecc71 0%, #27ae60 100%);
            --light-bg: rgba(255, 255, 255, 0.95);
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
        }

        /* Your existing navigation and other CSS styles remain exactly the same */
        .navbar {
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.98) 0%, rgba(248, 249, 250, 0.98) 100%) !important;
            backdrop-filter: blur(15px);
            box-shadow: 0 4px 30px rgba(46, 204, 113, 0.1);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            padding: 15px 0;
            border-bottom: 1px solid rgba(46, 204, 113, 0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .navbar.scrolled {
            background: linear-gradient(135deg, rgba(255, 255, 255, 1) 0%, rgba(248, 249, 250, 1) 100%) !important;
            padding: 10px 0;
            box-shadow: 0 8px 40px rgba(46, 204, 113, 0.15);
            border-bottom: 2px solid rgba(46, 204, 113, 0.2);
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, #2ecc71 0%, #27ae60 100%);
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
            background: linear-gradient(135deg, #2ecc71 0%, #27ae60 100%);
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
            background: linear-gradient(135deg, rgba(46, 204, 113, 0.1), rgba(39, 174, 96, 0.1));
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
            background: linear-gradient(90deg, #2ecc71, #27ae60);
            border-radius: 2px;
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }

        .nav-link:hover,
        .nav-link.active {
            color: #2ecc71 !important;
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

        .navbar-text {
            font-weight: 600;
            color: #2c3e50 !important;
            padding: 8px 20px;
            margin: 0 5px;
            border-radius: 8px;
            background: linear-gradient(135deg, rgba(46, 204, 113, 0.1), rgba(39, 174, 96, 0.1));
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
        }

        .navbar-text:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(46, 204, 113, 0.2);
        }

        .navbar-text i {
            margin-right: 0.5rem;
            background: linear-gradient(135deg, #2ecc71 0%, #27ae60 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        /* Card Styling */
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
            background: var(--success-gradient);
            transform: scaleX(0);
            transition: transform 0.4s ease;
        }

        .card:hover::before {
            transform: scaleX(1);
        }

        /* Card Headers */
        .card-header.bg-primary {
            background: var(--primary-gradient) !important;
            border: none;
        }

        .card-header.bg-info {
            background: var(--info-gradient) !important;
            border: none;
        }

        /* Statistics Cards */
        .card.bg-success {
            background: var(--success-gradient) !important;
            border: none;
        }

        .card.bg-danger {
            background: var(--danger-gradient) !important;
            border: none;
        }

        .card.bg-warning {
            background: var(--warning-gradient) !important;
            border: none;
        }

        .card.bg-info {
            background: var(--info-gradient) !important;
            border: none;
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
            box-shadow: 0 8px 20px rgba(46, 204, 113, 0.3);
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
            box-shadow: 0 8px 20px rgba(39, 174, 96, 0.3);
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

        /* Table Styling */
        .table-responsive {
            border-radius: 12px;
            overflow: hidden;
        }

        .table {
            margin-bottom: 0;
            border-radius: 12px;
            overflow: hidden;
        }

        .table th {
            background: var(--primary-gradient);
            color: white;
            border: none;
            padding: 1rem;
            font-weight: 600;
        }

        .table td {
            padding: 1rem;
            vertical-align: middle;
            border-color: rgba(46, 204, 113, 0.1);
        }

        .table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(46, 204, 113, 0.05);
        }

        .table-hover tbody tr:hover {
            background-color: rgba(46, 204, 113, 0.1);
            transform: translateY(-1px);
            transition: all 0.2s ease;
        }

        /* Badge Styling */
        .badge {
            font-weight: 500;
            padding: 0.5em 0.75em;
            border-radius: 6px;
            transition: all 0.3s ease;
        }

        .badge:hover {
            transform: scale(1.05);
        }

        /* Bed Card Styling */
        .bed-card {
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .bed-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        .bed-card.border-success {
            border-color: #27ae60 !important;
        }

        .bed-card.border-danger {
            border-color: #e74c3c !important;
        }

        .bed-card.border-warning {
            border-color: #f39c12 !important;
        }

        .bed-card.border-info {
            border-color: #3498db !important;
        }

        .bed-actions {
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .bed-card:hover .bed-actions {
            opacity: 1;
        }

        /* Form Select Styling */
        .form-select {
            border-radius: 8px;
            border: 1px solid rgba(46, 204, 113, 0.2);
            transition: all 0.3s ease;
        }

        .form-select:focus {
            border-color: #2ecc71;
            box-shadow: 0 0 0 0.25rem rgba(46, 204, 113, 0.25);
        }

        /* Page Header */
        h1 {
            color: #2c3e50;
            font-weight: 700;
            margin-bottom: 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 3px solid #2ecc71;
            display: inline-block;
        }

        /* Footer Styling */
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

        /* Statistics Cards Enhancement */
        .stat-card {
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
        }

        /* Ward Information Styling */
        .ward-info-section {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }

        /* Empty Bed Styling */
        .empty-bed-card {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border: 2px dashed #dee2e6;
            opacity: 0.7;
        }

        .empty-bed-card:hover {
            transform: none;
            box-shadow: none;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .navbar-brand {
                font-size: 1.3rem;
            }

            .nav-link {
                padding: 0.7rem 1.2rem !important;
                font-size: 0.9rem;
            }

            .card {
                margin-bottom: 1rem;
            }

            .table-responsive {
                font-size: 0.875rem;
            }

            .bed-card {
                margin-bottom: 1rem;
            }
        }

        /* Custom colors for ward types */
        .bg-pink {
            background: linear-gradient(135deg, #e83e8c 0%, #d91c7d 100%) !important;
        }
    </style>
</head>
<body>
<!-- Enhanced Navigation Bar -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="">
            <i class="fas fa-hospital-alt"></i>
            <span>Aurora Health - Ward Management</span>
        </a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="/ward-manager/dashboard">
                        <i class="fas fa-th-large"></i>Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/ward-manager/beds">
                        <i class="fas fa-bed"></i>Bed Management
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="#">
                        <i class="fas fa-procedures"></i>Beds in ${ward.wardNumber}
                    </a>
                </li>
            </ul>
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item">
                    <span class="navbar-text">
                        <i class="fas fa-user-circle"></i>Welcome, ${username} (Ward Manager)
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
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1><i class="fas fa-bed me-2"></i>Beds in ${ward.wardNumber}</h1>
        <div>
            <a href="/ward-manager/beds" class="btn btn-primary">
                <i class="fas fa-arrow-left me-1"></i>All Beds
            </a>
        </div>
    </div>

    <!-- Success/Error Messages -->
    <c:if test="${not empty param.success}">
        <div class="alert alert-success alert-dismissible fade show">
            <i class="fas fa-check-circle me-2"></i><strong>Success!</strong> ${param.success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:if test="${not empty param.error}">
        <div class="alert alert-danger alert-dismissible fade show">
            <i class="fas fa-exclamation-triangle me-2"></i><strong>Error!</strong> ${param.error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Ward Information -->
    <div class="card mb-4">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0"><i class="fas fa-info-circle me-2"></i>Ward Information</h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-4">
                    <strong>Ward Number:</strong> ${ward.wardNumber}<br>
                    <strong>Type:</strong>
                    <span class="badge
                        <c:choose>
                            <c:when test="${ward.wardType == 'ICU'}">bg-danger</c:when>
                            <c:when test="${ward.wardType == 'GENERAL'}">bg-primary</c:when>
                            <c:when test="${ward.wardType == 'PEDIATRIC'}">bg-info</c:when>
                            <c:when test="${ward.wardType == 'SURGICAL'}">bg-warning</c:when>
                            <c:when test="${ward.wardType == 'MATERNITY'}">bg-pink</c:when>
                            <c:otherwise>bg-secondary</c:otherwise>
                        </c:choose>">
                        ${ward.wardType}
                    </span><br>
                    <strong>Department:</strong> ${ward.department.name}
                </div>
                <div class="col-md-4">
                    <strong>Total Beds:</strong> ${ward.totalBeds}<br>
                    <strong>Available:</strong> <span class="badge bg-success">${ward.availableBeds}</span><br>
                    <strong>Occupied:</strong> <span class="badge bg-danger">${ward.totalBeds - ward.availableBeds}</span>
                </div>
                <div class="col-md-4">
                    <strong>Charge per Day:</strong> Rs. <fmt:formatNumber value="${ward.chargePerDay}" pattern="#,##0.00"/><br>
                    <strong>Description:</strong> ${ward.description}<br>
                    <strong>Status:</strong>
                    <c:set var="occupancyRate" value="${ward.totalBeds > 0 ? ((ward.totalBeds - ward.availableBeds) / ward.totalBeds) * 100 : 0}"/>
                    <span class="badge
                        <c:choose>
                            <c:when test="${occupancyRate >= 90}">bg-danger</c:when>
                            <c:when test="${occupancyRate >= 70}">bg-warning</c:when>
                            <c:otherwise>bg-success</c:otherwise>
                        </c:choose>">
                        <fmt:formatNumber value="${occupancyRate}" pattern="#0.0"/>% Occupied
                    </span>
                </div>
            </div>
        </div>
    </div>

    <!-- Bed Statistics -->
    <div class="row mb-4">
        <div class="col-md-3">
            <div class="card text-center bg-success text-white stat-card">
                <div class="card-body py-3">
                    <h5>Available</h5>
                    <h3>${availableBeds.size()}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center bg-danger text-white stat-card">
                <div class="card-body py-3">
                    <h5>Occupied</h5>
                    <h3>${occupiedBeds.size()}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center bg-warning text-white stat-card">
                <div class="card-body py-3">
                    <h5>Maintenance</h5>
                    <h3>${maintenanceBeds.size()}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center bg-info text-white stat-card">
                <div class="card-body py-3">
                    <h5>Cleaning</h5>
                    <h3>${cleaningBeds.size()}</h3>
                </div>
            </div>
        </div>
    </div>

    <!-- Beds Grid -->
    <div class="card">
        <div class="card-header bg-info text-white d-flex justify-content-between align-items-center">
            <h5 class="mb-0"><i class="fas fa-bed me-2"></i>Bed Layout - ${ward.totalBeds} Beds</h5>
            <div>
                <button class="btn btn-sm btn-light me-2" onclick="toggleBedView()">
                    <i class="fas fa-th"></i> Toggle View
                </button>
                <span class="badge bg-light text-info">Last updated: <span id="currentTime"></span></span>
            </div>
        </div>
        <div class="card-body">
            <!-- Check if actual beds match configured beds -->
            <c:if test="${beds.size() != ward.totalBeds}">
                <div class="alert alert-warning mb-4">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    <strong>Data Mismatch:</strong>
                    Ward is configured for ${ward.totalBeds} beds, but ${beds.size()} actual bed records found.
                    <a href="/ward-manager/beds/synchronize-ward-counts?wardId=${ward.id}" class="btn btn-warning btn-sm ms-2">
                        <i class="fas fa-sync-alt me-1"></i>Synchronize
                    </a>
                </div>
            </c:if>

            <c:if test="${empty beds && ward.totalBeds > 0}">
                <div class="alert alert-warning text-center">
                    <i class="fas fa-bed fa-3x mb-3 text-warning"></i>
                    <h5>No Bed Records Found</h5>
                    <p>This ward is configured for ${ward.totalBeds} beds but no actual bed records exist.</p>
                    <a href="/ward-manager/beds/initialize-ward-beds?wardId=${ward.id}" class="btn btn-primary mt-2">
                        <i class="fas fa-plus me-2"></i>Initialize Beds
                    </a>
                </div>
            </c:if>

            <c:if test="${not empty beds}">
                <div class="row" id="bedGrid">
                    <c:forEach var="bed" items="${beds}">
                        <div class="col-md-3 mb-4">
                            <div class="card h-100 bed-card ${bed.status == 'AVAILABLE' ? 'border-success' : bed.status == 'OCCUPIED' ? 'border-danger' : bed.status == 'MAINTENANCE' ? 'border-warning' : 'border-info'}">
                                <div class="card-header ${bed.status == 'AVAILABLE' ? 'bg-success' : bed.status == 'OCCUPIED' ? 'bg-danger' : bed.status == 'MAINTENANCE' ? 'bg-warning' : 'bg-info'} text-white text-center py-2">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <strong>${bed.bedNumber}</strong>
                                        <div class="bed-actions">
                                            <a href="/ward-manager/beds/edit/${bed.id}" class="text-white me-1">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <c:if test="${bed.status != 'OCCUPIED'}">
                                                <a href="/ward-manager/beds/delete/${bed.id}" class="text-white"
                                                   onclick="return confirm('Delete bed ${bed.bedNumber}?')">
                                                    <i class="fas fa-trash"></i>
                                                </a>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body text-center py-3">
                                    <div class="mb-3">
                                        <c:choose>
                                            <c:when test="${bed.status == 'AVAILABLE'}">
                                                <i class="fas fa-bed fa-3x text-success"></i>
                                            </c:when>
                                            <c:when test="${bed.status == 'OCCUPIED'}">
                                                <i class="fas fa-procedures fa-3x text-danger"></i>
                                            </c:when>
                                            <c:when test="${bed.status == 'MAINTENANCE'}">
                                                <i class="fas fa-tools fa-3x text-warning"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-broom fa-3x text-info"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <h6>
                                        <span class="badge
                                            <c:choose>
                                                <c:when test="${bed.status == 'AVAILABLE'}">bg-success</c:when>
                                                <c:when test="${bed.status == 'OCCUPIED'}">bg-danger</c:when>
                                                <c:when test="${bed.status == 'MAINTENANCE'}">bg-warning</c:when>
                                                <c:otherwise>bg-info</c:otherwise>
                                            </c:choose>">
                                                ${bed.status}
                                        </span>
                                    </h6>

                                    <c:if test="${bed.status == 'OCCUPIED' && bed.patient != null}">
                                        <div class="mt-2">
                                            <small class="text-muted">Patient:</small><br>
                                            <strong class="text-danger">
                                                    ${bed.patient.firstName} ${bed.patient.lastName}
                                            </strong>
                                            <c:if test="${bed.admissionDate != null}">
                                                <br>
                                                <small class="text-muted">
                                                    Since:
                                                    <c:set var="admissionDate" value="${bed.admissionDate}"/>
                                                        ${admissionDate.month.toString().substring(0,1).concat(admissionDate.month.toString().substring(1).toLowerCase())}
                                                        ${admissionDate.dayOfMonth}, ${admissionDate.year}
                                                </small>
                                            </c:if>
                                        </div>
                                    </c:if>

                                    <c:if test="${bed.status == 'AVAILABLE'}">
                                        <div class="mt-2">
                                            <small class="text-success">
                                                <i class="fas fa-check-circle me-1"></i>Ready for admission
                                            </small>
                                        </div>
                                    </c:if>
                                </div>
                                <div class="card-footer bg-transparent py-2">
                                    <div class="btn-group w-100" role="group">
                                        <c:if test="${bed.status != 'OCCUPIED'}">
                                            <form action="/ward-manager/beds/update-status" method="post" class="d-inline w-100">
                                                <input type="hidden" name="bedId" value="${bed.id}">
                                                <select name="status" class="form-select form-select-sm" onchange="this.form.submit()">
                                                    <option value="AVAILABLE" ${bed.status == 'AVAILABLE' ? 'selected' : ''}>Available</option>
                                                    <option value="MAINTENANCE" ${bed.status == 'MAINTENANCE' ? 'selected' : ''}>Maintenance</option>
                                                    <option value="CLEANING" ${bed.status == 'CLEANING' ? 'selected' : ''}>Cleaning</option>
                                                </select>
                                            </form>
                                        </c:if>
                                        <c:if test="${bed.status == 'OCCUPIED'}">
                                            <small class="text-muted">Patient admitted</small>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Table View (Hidden by default) -->
                <div class="table-responsive d-none" id="bedTableView">
                    <table class="table table-striped table-hover">
                        <thead class="table-dark">
                        <tr>
                            <th>Bed Number</th>
                            <th>Status</th>
                            <th>Patient</th>
                            <th>Admission Date</th>
                            <th>Ward</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="bed" items="${beds}">
                            <tr>
                                <td><strong>${bed.bedNumber}</strong></td>
                                <td>
                                        <span class="badge
                                            <c:choose>
                                                <c:when test="${bed.status == 'AVAILABLE'}">bg-success</c:when>
                                                <c:when test="${bed.status == 'OCCUPIED'}">bg-danger</c:when>
                                                <c:when test="${bed.status == 'MAINTENANCE'}">bg-warning</c:when>
                                                <c:otherwise>bg-info</c:otherwise>
                                            </c:choose>">
                                                ${bed.status}
                                        </span>
                                </td>
                                <td>
                                    <c:if test="${bed.status == 'OCCUPIED' && bed.patient != null}">
                                        ${bed.patient.firstName} ${bed.patient.lastName}
                                    </c:if>
                                    <c:if test="${bed.status != 'OCCUPIED'}">
                                        <span class="text-muted">-</span>
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${bed.admissionDate != null}">
                                        <c:set var="admissionDate" value="${bed.admissionDate}"/>
                                        ${admissionDate.month.toString().substring(0,1).concat(admissionDate.month.toString().substring(1).toLowerCase())}
                                        ${admissionDate.dayOfMonth}, ${admissionDate.year}
                                    </c:if>
                                    <c:if test="${bed.admissionDate == null}">
                                        <span class="text-muted">-</span>
                                    </c:if>
                                </td>
                                <td>${bed.ward.wardNumber}</td>
                                <td>
                                    <div class="btn-group btn-group-sm">
                                        <a href="/ward-manager/beds/edit/${bed.id}" class="btn btn-warning">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <c:if test="${bed.status != 'OCCUPIED'}">
                                            <a href="/ward-manager/beds/delete/${bed.id}" class="btn btn-danger"
                                               onclick="return confirm('Delete bed ${bed.bedNumber}?')">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        </c:if>
                                        <c:if test="${bed.status == 'AVAILABLE'}">
                                            <a href="/ward-manager/admissions/admit?bedId=${bed.id}" class="btn btn-success">
                                                <i class="fas fa-user-plus"></i>
                                            </a>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
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

    // Update current time
    function updateCurrentTime() {
        const now = new Date();
        document.getElementById('currentTime').textContent = now.toLocaleTimeString();
    }
    setInterval(updateCurrentTime, 1000);
    updateCurrentTime();

    // Toggle between grid and table view
    function toggleBedView() {
        const gridView = document.getElementById('bedGrid');
        const tableView = document.getElementById('bedTableView');

        if (gridView.classList.contains('d-none')) {
            gridView.classList.remove('d-none');
            tableView.classList.add('d-none');
        } else {
            gridView.classList.add('d-none');
            tableView.classList.remove('d-none');
        }
    }

    // Auto-hide alerts after 5 seconds
    setTimeout(() => {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        });
    }, 5000);
</script>
</body>
</html>