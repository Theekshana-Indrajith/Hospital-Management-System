<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Laboratory Tests - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap');

        /* Define CSS variables for lab technician theme */
        :root {
            --primary-gradient: linear-gradient(135deg, #17a2b8 0%, #20c997 100%);
            --success-gradient: linear-gradient(135deg, #20c997 0%, #3bd9ac 100%);
            --danger-gradient: linear-gradient(135deg, #ff6b6b 0%, #ff8e8e 100%);
            --warning-gradient: linear-gradient(135deg, #ffc107 0%, #ffd54f 100%);
            --info-gradient: linear-gradient(135deg, #6f42c1 0%, #8e6cff 100%);
            --dark-gradient: linear-gradient(135deg, #17a2b8 0%, #138496 100%);
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
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            overflow-x: hidden;
            position: relative;
        }

        /* Enhanced Navigation - Lab Technician Theme */
        .navbar {
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.98) 0%, rgba(248, 249, 250, 0.98) 100%) !important;
            backdrop-filter: blur(15px);
            box-shadow: 0 4px 30px rgba(23, 162, 184, 0.1);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            padding: 15px 0;
            border-bottom: 1px solid rgba(23, 162, 184, 0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .navbar.scrolled {
            background: linear-gradient(135deg, rgba(255, 255, 255, 1) 0%, rgba(248, 249, 250, 1) 100%) !important;
            padding: 10px 0;
            box-shadow: 0 8px 40px rgba(23, 162, 184, 0.15);
            border-bottom: 2px solid rgba(23, 162, 184, 0.2);
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, #17a2b8 0%, #20c997 100%);
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
            background: linear-gradient(135deg, #17a2b8 0%, #20c997 100%);
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
            background: linear-gradient(135deg, rgba(23, 162, 184, 0.1), rgba(32, 201, 151, 0.1));
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
            background: linear-gradient(90deg, #17a2b8, #20c997);
            border-radius: 2px;
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }

        .nav-link:hover,
        .nav-link.active {
            color: #17a2b8 !important;
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
            background: linear-gradient(135deg, rgba(23, 162, 184, 0.1), rgba(32, 201, 151, 0.1));
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
        }

        .navbar-text:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(23, 162, 184, 0.2);
        }

        .navbar-text i {
            margin-right: 0.5rem;
            background: linear-gradient(135deg, #17a2b8 0%, #20c997 100%);
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
            border: 2px solid #17a2b8;
            padding: 8px 12px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .navbar-toggler:hover {
            background: rgba(23, 162, 184, 0.1);
            transform: scale(1.05);
        }

        .navbar-toggler:focus {
            box-shadow: 0 0 0 0.25rem rgba(23, 162, 184, 0.25);
        }

        .navbar-toggler-icon {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba(23, 162, 184, 1)' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
        }

        /* Welcome Header Background Image - Lab Theme */
        .welcome-header {
            position: relative;
            background-image: url('https://images.unsplash.com/photo-1582719471384-894fbb16e074?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            padding: 2rem 1rem;
            border-radius: 15px;
            overflow: hidden;
            margin-bottom: 1.5rem;
        }

        .welcome-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(23, 162, 184, 0.7);
            z-index: 0;
        }

        .welcome-header > * {
            position: relative;
            z-index: 1;
            color: #fff;
        }

        .welcome-header h2 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            color: #fff;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);
        }

        .welcome-header p {
            font-size: 1.1rem;
            opacity: 0.9;
            color: #fff;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.5);
        }

        /* Card Styling */
        .card {
            border: none;
            border-radius: 15px;
            background: var(--light-bg);
            backdrop-filter: blur(12px);
            box-shadow: var(--shadow);
            transition: transform 0.4s ease, box-shadow 0.4s ease;
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

        .card.border-success::before { background: var(--success-gradient); }
        .card.border-primary::before { background: var(--primary-gradient); }
        .card.border-warning::before { background: var(--warning-gradient); }
        .card.border-danger::before { background: var(--danger-gradient); }
        .card.border-info::before { background: var(--info-gradient); }

        /* Button Styling */
        .btn-info {
            background: var(--primary-gradient);
            border: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-info:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(23, 162, 184, 0.3);
        }

        .btn-outline-info {
            border-color: rgba(23, 162, 184, 0.5);
            color: #17a2b8;
        }

        .btn-outline-info:hover {
            background: var(--primary-gradient);
            color: #fff;
            border-color: var(--primary-gradient);
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

        .alert-warning::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 6px;
            height: 100%;
            background: var(--warning-gradient);
        }

        /* Footer Styling */
        footer {
            background: var(--dark-gradient) !important;
            color: #fff;
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
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"><path fill="rgba(255,255,255,0.05)" d="M0,96L48,112C96,128,192,160,288,160C384,160,480,128,576,112C672,96,768,96,864,112C960,128,1056,160,1152,160C1248,160,1344,128,1392,112L1440,96L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>');
            background-size: cover;
            animation: footerWave 10s ease-in-out infinite;
        }

        @keyframes footerWave {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-15px); }
        }

        /* Responsive Design */
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

            .welcome-header h2 {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
<!-- Updated Navigation Bar - Matching Doctor Dashboard -->
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
                <c:if test="${role == 'LAB_TECH'}">
                    <li class="nav-item">
                        <a class="nav-link" href="/lab-technician/dashboard">
                            <i class="fas fa-th-large"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/lab-technician/tests">
                            <i class="fas fa-vial"></i>My Tests
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/lab-technician/tests/pending">
                            <i class="fas fa-clock"></i>Pending Tests
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="/lab-tests">
                            <i class="fas fa-list"></i>All Tests
                        </a>
                    </li>
<%--                    <li class="nav-item">--%>
<%--                        <a class="nav-link" href="/lab-tests/abnormal">--%>
<%--                            <i class="fas fa-exclamation-triangle"></i>Abnormal Results--%>
<%--                        </a>--%>
<%--                    </li>--%>
                </c:if>
                <c:if test="${role == 'DOCTOR'}">
                    <li class="nav-item">
                        <a class="nav-link" href="/doctor/dashboard">
                            <i class="fas fa-th-large"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/doctor/schedule">
                            <i class="fas fa-calendar-check"></i>Schedule
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/doctor/patients">
                            <i class="fas fa-users"></i>Patients
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/prescriptions/add">
                            <i class="fas fa-prescription"></i>Prescriptions
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/lab-tests/request">
                            <i class="fas fa-flask"></i>Lab Tests
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="/lab-tests">
                            <i class="fas fa-eye"></i>View Tests
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/doctor/admissions/manage">
                            <i class="fas fa-procedures"></i>Admissions
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/doctor/profile">
                            <i class="fas fa-user-md"></i>My Profile
                        </a>
                    </li>
                </c:if>
                <c:if test="${role == 'ADMIN'}">
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/dashboard">
                            <i class="fas fa-th-large"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="/lab-tests">
                            <i class="fas fa-flask"></i>Lab Tests
                        </a>
                    </li>
                </c:if>
            </ul>
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item">
                    <span class="navbar-text">
                        <i class="fas fa-user-circle"></i>Welcome, ${username}
                        <span class="badge bg-primary ms-2">${role}</span>
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
    <!-- Updated Welcome Section with Background Image -->
    <div class="welcome-header mb-4">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h2 class="mb-1"><i class="fas fa-flask me-2"></i>${pageTitle}</h2>
                <p>View and manage laboratory test results</p>
            </div>
            <div class="col-md-4 text-end">
                <c:if test="${role == 'DOCTOR'}">
                    <a href="/lab-tests/request" class="btn btn-light">
                        <i class="fas fa-plus me-2"></i>Request New Test
                    </a>
                </c:if>
<%--                <a href="/lab-tests/abnormal" class="btn btn-warning">--%>
<%--                    <i class="fas fa-exclamation-triangle me-2"></i>Abnormal Results--%>
<%--                </a>--%>
            </div>
        </div>
    </div>

    <!-- Success/Error Messages -->
    <c:if test="${not empty param.success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${param.success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty param.error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${param.error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Filter Options -->
    <div class="card border-info mb-4">
        <div class="card-header bg-info text-white">
            <h5 class="mb-0"><i class="fas fa-filter me-2"></i>Filter Tests</h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-3">
                    <label class="form-label">Filter by Status</label>
                    <select class="form-select" onchange="filterTests(this.value, 'status')">
                        <option value="">All Statuses</option>
                        <option value="REQUESTED">Requested</option>
                        <option value="IN_PROGRESS">In Progress</option>
                        <option value="COMPLETED">Completed</option>
                        <option value="CANCELLED">Cancelled</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Filter by Priority</label>
                    <select class="form-select" onchange="filterTests(this.value, 'priority')">
                        <option value="">All Priorities</option>
                        <option value="NORMAL">Normal</option>
                        <option value="URGENT">Urgent</option>
                        <option value="STAT">STAT</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Filter by Type</label>
                    <select class="form-select" onchange="filterTests(this.value, 'type')">
                        <option value="">All Types</option>
                        <option value="BLOOD">Blood</option>
                        <option value="URINE">Urine</option>
                        <option value="XRAY">X-Ray</option>
                        <option value="MRI">MRI</option>
                    </select>
                </div>
<%--                <div class="col-md-3">--%>
<%--                    <label class="form-label">Quick Actions</label>--%>
<%--                    <div class="d-grid gap-2">--%>
<%--                        <a href="/lab-tests/abnormal" class="btn btn-warning btn-sm">--%>
<%--                            <i class="fas fa-exclamation-triangle me-1"></i>Abnormal Results--%>
<%--                        </a>--%>
<%--                    </div>--%>
<%--                </div>--%>
            </div>
        </div>
    </div>

    <!-- Tests Table -->
    <div class="card border-primary">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0"><i class="fas fa-list me-2"></i>Laboratory Tests</h5>
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty labTests}">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover" id="testsTable">
                            <thead>
                            <tr>
                                <th>Test ID</th>
                                <th>Patient</th>
                                <th>Test Name</th>
                                <th>Type</th>
                                <th>Priority</th>
                                <th>Status</th>
                                <th>Technician</th>
                                <th>Requested Date</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="test" items="${labTests}">
                                <tr class="test-row"
                                    data-status="${test.status}"
                                    data-priority="${test.priority}"
                                    data-type="${test.testType}">
                                    <td><strong>#${test.id}</strong></td>
                                    <td>
                                        <strong>${test.patient.firstName} ${test.patient.lastName}</strong>
                                        <br><small class="text-muted">ID: ${test.patient.id}</small>
                                    </td>
                                    <td>${test.testName}</td>
                                    <td>
                                        <span class="badge bg-info">${test.testType}</span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${test.priority == 'URGENT'}">
                                                <span class="badge bg-danger">URGENT</span>
                                            </c:when>
                                            <c:when test="${test.priority == 'STAT'}">
                                                <span class="badge bg-warning">STAT</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">NORMAL</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${test.status == 'REQUESTED'}">
                                                <span class="badge bg-warning">REQUESTED</span>
                                            </c:when>
                                            <c:when test="${test.status == 'IN_PROGRESS'}">
                                                <span class="badge bg-primary">IN PROGRESS</span>
                                            </c:when>
                                            <c:when test="${test.status == 'COMPLETED'}">
                                                <c:choose>
                                                    <c:when test="${test.isAbnormal}">
                                                        <span class="badge bg-danger">ABNORMAL</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-success">COMPLETED</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">${test.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:if test="${not empty test.labTechnician}">
                                            ${test.labTechnician.firstName} ${test.labTechnician.lastName}
                                        </c:if>
                                        <c:if test="${empty test.labTechnician}">
                                            <span class="text-muted">Not assigned</span>
                                        </c:if>
                                    </td>
                                    <td>${test.requestedDate}</td>
                                    <td>
                                        <div class="btn-group">
                                            <a href="/lab-tests/details/${test.id}" class="btn btn-info btn-sm">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <c:if test="${role == 'ADMIN' && empty test.labTechnician}">
                                                <button class="btn btn-warning btn-sm" data-bs-toggle="modal"
                                                        data-bs-target="#assignModal"
                                                        data-testid="${test.id}">
                                                    <i class="fas fa-user-plus"></i>
                                                </button>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-4">
                        <i class="fas fa-flask fa-3x text-muted mb-3"></i>
                        <h4>No Laboratory Tests</h4>
                        <p class="text-muted">No laboratory tests have been requested yet.</p>
                        <c:if test="${role == 'DOCTOR'}">
                            <a href="/lab-tests/request" class="btn btn-primary">
                                <i class="fas fa-plus me-1"></i>Request First Test
                            </a>
                        </c:if>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<!-- Assign Technician Modal -->
<div class="modal fade" id="assignModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title"><i class="fas fa-user-plus me-2"></i>Assign Lab Technician</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="/lab-tests/assign-technician/" method="post" id="assignForm">
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Select Lab Technician</label>
                        <select class="form-select" name="technicianId" required>
                            <option value="">Choose a technician...</option>
                            <!-- Technicians would be populated from database -->
                            <option value="1">Damsana D.V. (Lab Technician)</option>
                            <option value="2">Ravindu Perera (Lab Technician)</option>
                            <option value="3">Nadeesha Silva (Lab Technician)</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Assign Technician</button>
                </div>
            </form>
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

    // Filter functionality
    function filterTests(value, type) {
        const rows = document.querySelectorAll('.test-row');
        rows.forEach(row => {
            if (!value || row.getAttribute('data-' + type) === value) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    }

    // Assign modal functionality
    document.addEventListener('DOMContentLoaded', function() {
        const assignModal = document.getElementById('assignModal');
        if (assignModal) {
            assignModal.addEventListener('show.bs.modal', function(event) {
                const button = event.relatedTarget;
                const testId = button.getAttribute('data-testid');
                const form = document.getElementById('assignForm');
                form.action = '/lab-tests/assign-technician/' + testId;
            });
        }
    });
</script>
</body>
</html>