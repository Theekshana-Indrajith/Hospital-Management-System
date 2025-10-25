<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>${status} Beds - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap');

        /* Use the same CSS variables as dashboard */
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

        /* Navigation - Same as dashboard */
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
        .card-header.bg-success {
            background: var(--success-gradient) !important;
            border: none;
        }

        .card-header.bg-danger {
            background: var(--danger-gradient) !important;
            border: none;
        }

        .card-header.bg-warning {
            background: var(--warning-gradient) !important;
            border: none;
        }

        .card-header.bg-info {
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

        .btn-info {
            background: var(--info-gradient);
            border: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-info:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(52, 152, 219, 0.3);
        }

        .btn-warning {
            background: var(--warning-gradient);
            border: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-warning:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(243, 156, 18, 0.3);
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

        .alert-info::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 6px;
            height: 100%;
            background: var(--info-gradient);
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

        .alert-danger::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 6px;
            height: 100%;
            background: var(--danger-gradient);
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

        /* Search Bar Styling */
        .search-container {
            position: relative;
            margin-bottom: 1.5rem;
        }

        .search-input {
            border-radius: 25px;
            padding: 12px 20px;
            border: 2px solid rgba(46, 204, 113, 0.2);
            background: var(--light-bg);
            backdrop-filter: blur(10px);
            transition: all 0.3s ease;
            box-shadow: var(--shadow);
        }

        .search-input:focus {
            border-color: #2ecc71;
            box-shadow: 0 0 0 0.25rem rgba(46, 204, 113, 0.25);
            transform: translateY(-2px);
        }

        .search-btn {
            position: absolute;
            right: 5px;
            top: 50%;
            transform: translateY(-50%);
            border-radius: 20px;
            padding: 8px 20px;
            background: var(--primary-gradient);
            border: none;
            color: white;
            transition: all 0.3s ease;
        }

        .search-btn:hover {
            transform: translateY(-50%) scale(1.05);
            box-shadow: 0 4px 15px rgba(46, 204, 113, 0.3);
        }

        /* Filter Section Styling */
        .filter-section {
            background: var(--light-bg);
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: var(--shadow);
            border-left: 4px solid #2ecc71;
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

            .search-container {
                margin-bottom: 1rem;
            }

            .table-responsive {
                font-size: 0.875rem;
            }
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
                        <i class="fas fa-list"></i>${status} Beds
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
        <h1>
            <c:choose>
                <c:when test="${status == 'AVAILABLE'}">
                    <i class="fas fa-bed text-success me-2"></i>Available Beds
                </c:when>
                <c:when test="${status == 'OCCUPIED'}">
                    <i class="fas fa-procedures text-danger me-2"></i>Occupied Beds
                </c:when>
                <c:when test="${status == 'MAINTENANCE'}">
                    <i class="fas fa-tools text-warning me-2"></i>Maintenance Beds
                </c:when>
                <c:when test="${status == 'CLEANING'}">
                    <i class="fas fa-broom text-info me-2"></i>Cleaning Beds
                </c:when>
                <c:otherwise>
                    <i class="fas fa-bed me-2"></i>${status} Beds
                </c:otherwise>
            </c:choose>
        </h1>
        <span class="badge
            <c:choose>
                <c:when test="${status == 'AVAILABLE'}">bg-success</c:when>
                <c:when test="${status == 'OCCUPIED'}">bg-danger</c:when>
                <c:when test="${status == 'MAINTENANCE'}">bg-warning</c:when>
                <c:otherwise>bg-info</c:otherwise>
            </c:choose> fs-6">
            ${beds.size()} Beds
        </span>
    </div>

    <!-- Search and Filter Section -->
    <div class="filter-section">
        <div class="row">
            <div class="col-md-8">
                <div class="search-container">
                    <input type="text" class="form-control search-input" id="searchInput"
                           placeholder="Search by bed number, ward, patient name...">
                    <button class="btn search-btn" onclick="searchBeds()">
                        <i class="fas fa-search me-1"></i>Search
                    </button>
                </div>
            </div>
            <div class="col-md-4">
                <div class="d-flex gap-2">
                    <select class="form-select" id="wardFilter" onchange="filterBeds()">
                        <option value="">All Wards</option>
                        <c:forEach var="ward" items="${wards}">
                            <option value="${ward.wardNumber}">${ward.wardNumber}</option>
                        </c:forEach>
                    </select>
                    <select class="form-select" id="typeFilter" onchange="filterBeds()">
                        <option value="">All Types</option>
                        <option value="ICU">ICU</option>
                        <option value="GENERAL">General</option>
                        <option value="PEDIATRIC">Pediatric</option>
                        <option value="SURGICAL">Surgical</option>
                        <option value="MATERNITY">Maternity</option>
                    </select>
                </div>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-header
            <c:choose>
                <c:when test="${status == 'AVAILABLE'}">bg-success</c:when>
                <c:when test="${status == 'OCCUPIED'}">bg-danger</c:when>
                <c:when test="${status == 'MAINTENANCE'}">bg-warning</c:when>
                <c:otherwise>bg-info</c:otherwise>
            </c:choose> text-white">
            <h5 class="mb-0">
                <c:choose>
                    <c:when test="${status == 'AVAILABLE'}">
                        <i class="fas fa-list me-2"></i>All Available Beds
                    </c:when>
                    <c:when test="${status == 'OCCUPIED'}">
                        <i class="fas fa-list me-2"></i>All Occupied Beds
                    </c:when>
                    <c:when test="${status == 'MAINTENANCE'}">
                        <i class="fas fa-list me-2"></i>All Maintenance Beds
                    </c:when>
                    <c:when test="${status == 'CLEANING'}">
                        <i class="fas fa-list me-2"></i>All Cleaning Beds
                    </c:when>
                </c:choose>
            </h5>
        </div>
        <div class="card-body">
            <c:if test="${empty beds}">
                <div class="alert alert-info text-center">
                    <c:choose>
                        <c:when test="${status == 'AVAILABLE'}">
                            <i class="fas fa-bed fa-3x mb-3 text-success"></i>
                            <h5>No Available Beds</h5>
                            <p>There are currently no available beds in the system.</p>
                        </c:when>
                        <c:when test="${status == 'OCCUPIED'}">
                            <i class="fas fa-procedures fa-3x mb-3 text-danger"></i>
                            <h5>No Occupied Beds</h5>
                            <p>There are currently no occupied beds in the system.</p>
                        </c:when>
                        <c:when test="${status == 'MAINTENANCE'}">
                            <i class="fas fa-tools fa-3x mb-3 text-warning"></i>
                            <h5>No Maintenance Beds</h5>
                            <p>There are currently no beds under maintenance.</p>
                        </c:when>
                        <c:when test="${status == 'CLEANING'}">
                            <i class="fas fa-broom fa-3x mb-3 text-info"></i>
                            <h5>No Cleaning Beds</h5>
                            <p>There are currently no beds being cleaned.</p>
                        </c:when>
                    </c:choose>
                    <a href="/ward-manager/beds" class="btn btn-primary mt-2">
                        <i class="fas fa-arrow-left me-2"></i>Back to All Beds
                    </a>
                </div>
            </c:if>

            <c:if test="${not empty beds}">
                <div class="table-responsive">
                    <table class="table table-striped table-hover" id="bedsTable">
                        <thead class="table-dark">
                        <tr>
                            <th>Bed Number</th>
                            <th>Ward</th>
                            <th>Ward Type</th>
                            <th>Department</th>
                            <th>Status</th>
                            <c:if test="${status == 'OCCUPIED'}">
                                <th>Patient</th>
                                <th>Admission Date</th>
                            </c:if>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="bed" items="${beds}">
                            <tr class="bed-row" data-bed-number="${bed.bedNumber}" data-ward="${bed.ward.wardNumber}" data-type="${bed.ward.wardType}" data-patient="${bed.patient != null ? bed.patient.firstName + ' ' + bed.patient.lastName : ''}">
                                <td><strong>${bed.bedNumber}</strong></td>
                                <td>
                                    <span class="badge bg-primary">${bed.ward.wardNumber}</span>
                                </td>
                                <td>${bed.ward.wardType}</td>
                                <td>${bed.ward.department.name}</td>
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
                                <c:if test="${status == 'OCCUPIED'}">
                                    <td>
                                        <c:if test="${bed.patient != null}">
                                            <strong>${bed.patient.firstName} ${bed.patient.lastName}</strong><br>
                                            <small class="text-muted">${bed.patient.contactNumber}</small>
                                        </c:if>
                                    </td>
                                    <td>
                                        <c:if test="${bed.admissionDate != null}">
                                            <c:set var="admissionDate" value="${bed.admissionDate}"/>
                                            ${admissionDate.month.toString().substring(0,1).concat(admissionDate.month.toString().substring(1).toLowerCase())}
                                            ${admissionDate.dayOfMonth}, ${admissionDate.year}
                                        </c:if>
                                    </td>
                                </c:if>
                                <td>
                                    <div class="btn-group btn-group-sm" role="group">
                                        <a href="/ward-manager/beds/ward/${bed.ward.id}" class="btn btn-info" title="View Ward">
                                            <i class="fas fa-procedures"></i>
                                        </a>
                                        <a href="/ward-manager/beds/edit/${bed.id}" class="btn btn-warning" title="Edit Bed">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <c:if test="${status == 'AVAILABLE'}">
                                            <a href="/ward-manager/admissions/admit?bedId=${bed.id}" class="btn btn-success" title="Admit Patient">
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

                <!-- Quick Stats -->
                <div class="row mt-4">
                    <div class="col-md-12">
                        <div class="alert
                            <c:choose>
                                <c:when test="${status == 'AVAILABLE'}">alert-success</c:when>
                                <c:when test="${status == 'OCCUPIED'}">alert-danger</c:when>
                                <c:when test="${status == 'MAINTENANCE'}">alert-warning</c:when>
                                <c:otherwise>alert-info</c:otherwise>
                            </c:choose>">
                            <h6><i class="fas fa-chart-pie me-2"></i>Quick Statistics</h6>
                            <div class="row">
                                <div class="col-md-3">
                                    <strong>Total ${status} Beds:</strong> ${beds.size()}
                                </div>
                                <div class="col-md-3">
                                    <c:set var="icuBeds" value="0"/>
                                    <c:forEach var="bed" items="${beds}">
                                        <c:if test="${bed.ward.wardType == 'ICU'}">
                                            <c:set var="icuBeds" value="${icuBeds + 1}"/>
                                        </c:if>
                                    </c:forEach>
                                    <strong>ICU Beds:</strong> ${icuBeds}
                                </div>
                                <div class="col-md-3">
                                    <c:set var="generalBeds" value="0"/>
                                    <c:forEach var="bed" items="${beds}">
                                        <c:if test="${bed.ward.wardType == 'GENERAL'}">
                                            <c:set var="generalBeds" value="${generalBeds + 1}"/>
                                        </c:if>
                                    </c:forEach>
                                    <strong>General Beds:</strong> ${generalBeds}
                                </div>
                                <div class="col-md-3">
                                    <c:set var="otherBeds" value="${beds.size() - icuBeds - generalBeds}"/>
                                    <strong>Other Beds:</strong> ${otherBeds}
                                </div>
                            </div>
                        </div>
                    </div>
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

    // Search functionality
    function searchBeds() {
        const searchTerm = document.getElementById('searchInput').value.toLowerCase();
        const wardFilter = document.getElementById('wardFilter').value.toLowerCase();
        const typeFilter = document.getElementById('typeFilter').value.toLowerCase();

        const rows = document.querySelectorAll('#bedsTable .bed-row');

        rows.forEach(row => {
            const bedNumber = row.getAttribute('data-bed-number').toLowerCase();
            const ward = row.getAttribute('data-ward').toLowerCase();
            const type = row.getAttribute('data-type').toLowerCase();
            const patient = row.getAttribute('data-patient').toLowerCase();

            const matchesSearch = bedNumber.includes(searchTerm) ||
                ward.includes(searchTerm) ||
                type.includes(searchTerm) ||
                patient.includes(searchTerm);

            const matchesWard = !wardFilter || ward.includes(wardFilter);
            const matchesType = !typeFilter || type.includes(typeFilter);

            if (matchesSearch && matchesWard && matchesType) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    }

    function filterBeds() {
        searchBeds(); // Reuse the same function for filtering
    }

    // Add event listener for Enter key in search input
    document.getElementById('searchInput').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            searchBeds();
        }
    });

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