<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Ward Report - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap');

        /* Use the same CSS variables as dashboard */
        :root {
            --primary-gradient: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            --success-gradient: linear-gradient(135deg, #00b4db 0%, #0083b0 100%);
            --danger-gradient: linear-gradient(135deg, #ff416c 0%, #ff4b2b 100%);
            --warning-gradient: linear-gradient(135deg, #f7971e 0%, #ffd200 100%);
            --info-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --dark-gradient: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
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
            box-shadow: 0 4px 30px rgba(30, 60, 114, 0.1);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            padding: 15px 0;
            border-bottom: 1px solid rgba(30, 60, 114, 0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .navbar.scrolled {
            background: linear-gradient(135deg, rgba(255, 255, 255, 1) 0%, rgba(248, 249, 250, 1) 100%) !important;
            padding: 10px 0;
            box-shadow: 0 8px 40px rgba(30, 60, 114, 0.15);
            border-bottom: 2px solid rgba(30, 60, 114, 0.2);
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
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
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
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
            background: linear-gradient(135deg, rgba(30, 60, 114, 0.1), rgba(42, 82, 152, 0.1));
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
            background: linear-gradient(90deg, #1e3c72, #2a5298);
            border-radius: 2px;
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }

        .nav-link:hover,
        .nav-link.active {
            color: #1e3c72 !important;
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
            background: linear-gradient(135deg, rgba(30, 60, 114, 0.1), rgba(42, 82, 152, 0.1));
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
        }

        .navbar-text:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(30, 60, 114, 0.2);
        }

        .navbar-text i {
            margin-right: 0.5rem;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
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

        /* Summary Cards */
        .card.bg-info {
            background: var(--info-gradient) !important;
            border: none;
        }

        .card.bg-success {
            background: var(--success-gradient) !important;
            border: none;
        }

        .card.bg-primary {
            background: var(--primary-gradient) !important;
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
            box-shadow: 0 8px 20px rgba(30, 60, 114, 0.3);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #6c757d 0%, #868e96 100%);
            border: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(108, 117, 125, 0.3);
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
            border-color: rgba(30, 60, 114, 0.1);
        }

        .table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(30, 60, 114, 0.05);
        }

        .table-hover tbody tr:hover {
            background-color: rgba(30, 60, 114, 0.1);
            transform: translateY(-1px);
            transition: all 0.2s ease;
        }

        /* Progress Bar Styling */
        .progress {
            background-color: rgba(30, 60, 114, 0.1);
            border-radius: 10px;
            overflow: hidden;
        }

        .progress-bar {
            border-radius: 10px;
            font-weight: 600;
            font-size: 0.8rem;
            transition: all 0.3s ease;
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

        /* Border boxes for summary sections */
        .border.rounded {
            border: 2px solid rgba(30, 60, 114, 0.1) !important;
            border-radius: 12px !important;
            transition: all 0.3s ease;
        }

        .border.rounded:hover {
            border-color: rgba(30, 60, 114, 0.3) !important;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
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

            .table-responsive {
                font-size: 0.875rem;
            }

            .progress {
                height: 20px !important;
            }
        }

        /* Ward-specific styling */
        .ward-capacity-item {
            transition: all 0.3s ease;
        }

        .ward-capacity-item:hover {
            background-color: rgba(30, 60, 114, 0.05);
            border-radius: 8px;
            padding: 0.5rem;
            margin: -0.5rem;
        }
    </style>
</head>
<body>
<!-- Enhanced Navigation Bar -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center">
            <i class="fas fa-hospital-alt"></i>
            <span>Aurora Health Hospital</span>
        </a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item">
                    <span class="navbar-text">
                        <i class="fas fa-user-circle"></i>Welcome, ${username} (Administrator)
                    </span>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header bg-warning text-white">
                    <h4 class="mb-0"><i class="fas fa-bed me-2"></i>Ward Occupancy Report - ${report.generatedDate}</h4>
                </div>
                <div class="card-body">
                    <!-- Calculate summary statistics from ward data -->
                    <c:set var="totalBeds" value="0" />
                    <c:set var="occupiedBeds" value="0" />
                    <c:set var="availableBeds" value="0" />
                    <c:forEach items="${report.wardStatistics}" var="ward">
                        <c:set var="totalBeds" value="${totalBeds + ward.value.totalBeds}" />
                        <c:set var="occupiedBeds" value="${occupiedBeds + ward.value.occupiedBeds}" />
                        <c:set var="availableBeds" value="${availableBeds + ward.value.availableBeds}" />
                    </c:forEach>
                    <c:set var="overallOccupancyRate" value="${totalBeds > 0 ? (occupiedBeds / totalBeds) * 100 : 0}" />

                    <!-- Ward Summary Cards -->
                    <div class="row mb-4">
                        <div class="col-md-3">
                            <div class="card text-white bg-info">
                                <div class="card-body text-center">
                                    <h5>Total Wards</h5>
                                    <h3>${report.totalWards}</h3>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card text-white bg-success">
                                <div class="card-body text-center">
                                    <h5>Total Beds</h5>
                                    <h3>${totalBeds}</h3>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card text-white bg-primary">
                                <div class="card-body text-center">
                                    <h5>Available Beds</h5>
                                    <h3>${availableBeds}</h3>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card text-white bg-danger">
                                <div class="card-body text-center">
                                    <h5>Occupied Beds</h5>
                                    <h3>${occupiedBeds}</h3>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Detailed Ward Information -->
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead class="table-dark">
                            <tr>
                                <th>Ward Details</th>
                                <th>Bed Capacity</th>
                                <th>Current Status</th>
                                <th>Occupancy Rate</th>
                                <th>Daily Charge</th>
                                <th>Estimated Revenue</th>
                                <th>Status</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${report.wardStatistics}" var="ward">
                                <tr>
                                    <td>
                                        <strong>${ward.key}</strong>
                                        <br>
                                        <small class="text-muted">Type: ${ward.value.wardType}</small>
                                    </td>
                                    <td>
                                        <div class="d-flex flex-column">
                                            <span class="badge bg-primary mb-1">Total: ${ward.value.totalBeds}</span>
                                            <span class="badge bg-success mb-1">Available: ${ward.value.availableBeds}</span>
                                            <span class="badge bg-danger">Occupied: ${ward.value.occupiedBeds}</span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="d-flex flex-column">
                                            <span>Available: ${ward.value.availableBeds}</span>
                                            <span>Occupied: ${ward.value.occupiedBeds}</span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="progress" style="height: 25px;">
                                            <div class="progress-bar
                                                    <c:choose>
                                                        <c:when test="${ward.value.occupancyRate >= 80}">bg-danger</c:when>
                                                        <c:when test="${ward.value.occupancyRate >= 60}">bg-warning</c:when>
                                                        <c:otherwise>bg-success</c:otherwise>
                                                    </c:choose>"
                                                 style="width: ${ward.value.occupancyRate}%">
                                                    ${ward.value.occupancyRate}%
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <strong>Rs. <fmt:formatNumber value="${ward.value.chargePerDay}" pattern="#,##0.00"/></strong>
                                        <br>
                                        <small class="text-muted">Per Day</small>
                                    </td>
                                    <td>
                                        <c:set var="dailyRevenue" value="${ward.value.occupiedBeds * ward.value.chargePerDay}" />
                                        <strong>Rs. <fmt:formatNumber value="${dailyRevenue}" pattern="#,##0.00"/></strong>
                                        <br>
                                        <small class="text-muted">Daily Revenue</small>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${ward.value.occupancyRate >= 90}">
                                                <span class="badge bg-danger">Critical</span>
                                            </c:when>
                                            <c:when test="${ward.value.occupancyRate >= 75}">
                                                <span class="badge bg-warning">High</span>
                                            </c:when>
                                            <c:when test="${ward.value.occupancyRate >= 50}">
                                                <span class="badge bg-info">Moderate</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-success">Low</span>
                                            </c:otherwise>
                                        </c:choose>
                                        <br>
                                        <small class="text-muted">
                                            <c:choose>
                                                <c:when test="${ward.value.availableBeds == 0}">No Beds Available</c:when>
                                                <c:when test="${ward.value.availableBeds <= 2}">Limited Availability</c:when>
                                                <c:otherwise>Available</c:otherwise>
                                            </c:choose>
                                        </small>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- Ward Performance Summary -->
                    <div class="row mb-4">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-header bg-info text-white">
                                    <h5 class="mb-0"><i class="fas fa-tachometer-alt me-2"></i>Ward Performance Summary</h5>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="text-center p-3 border rounded">
                                                <h6 class="text-muted">Highest Occupancy</h6>
                                                <c:set var="highestWard" value="" />
                                                <c:set var="highestRate" value="0" />
                                                <c:forEach items="${report.wardStatistics}" var="ward">
                                                    <c:if test="${ward.value.occupancyRate > highestRate}">
                                                        <c:set var="highestRate" value="${ward.value.occupancyRate}" />
                                                        <c:set var="highestWard" value="${ward.key}" />
                                                    </c:if>
                                                </c:forEach>
                                                <h4 class="text-danger">${highestWard}</h4>
                                                <small class="text-muted"><fmt:formatNumber value="${highestRate}" pattern="#0.0"/>% Full</small>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="text-center p-3 border rounded">
                                                <h6 class="text-muted">Lowest Occupancy</h6>
                                                <c:set var="lowestWard" value="" />
                                                <c:set var="lowestRate" value="100" />
                                                <c:forEach items="${report.wardStatistics}" var="ward">
                                                    <c:if test="${ward.value.occupancyRate < lowestRate}">
                                                        <c:set var="lowestRate" value="${ward.value.occupancyRate}" />
                                                        <c:set var="lowestWard" value="${ward.key}" />
                                                    </c:if>
                                                </c:forEach>
                                                <h4 class="text-success">${lowestWard}</h4>
                                                <small class="text-muted"><fmt:formatNumber value="${lowestRate}" pattern="#0.0"/>% Full</small>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="text-center p-3 border rounded">
                                                <h6 class="text-muted">Total Daily Revenue</h6>
                                                <c:set var="totalDailyRevenue" value="0" />
                                                <c:forEach items="${report.wardStatistics}" var="ward">
                                                    <c:set var="wardRevenue" value="${ward.value.occupiedBeds * ward.value.chargePerDay}" />
                                                    <c:set var="totalDailyRevenue" value="${totalDailyRevenue + wardRevenue}" />
                                                </c:forEach>
                                                <h4 class="text-primary">Rs. <fmt:formatNumber value="${totalDailyRevenue}" pattern="#,##0.00"/></h4>
                                                <small class="text-muted">From Ward Charges</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Additional Ward Statistics -->
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-header bg-success text-white">
                                    <h5 class="mb-0"><i class="fas fa-chart-bar me-2"></i>Ward Capacity Analysis</h5>
                                </div>
                                <div class="card-body">
                                    <c:forEach items="${report.wardStatistics}" var="ward">
                                        <div class="mb-3 ward-capacity-item">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <span class="fw-bold">${ward.key}</span>
                                                <span class="badge
                                                    <c:choose>
                                                        <c:when test="${ward.value.occupancyRate >= 80}">bg-danger</c:when>
                                                        <c:when test="${ward.value.occupancyRate >= 60}">bg-warning</c:when>
                                                        <c:otherwise>bg-success</c:otherwise>
                                                    </c:choose>">
                                                    <fmt:formatNumber value="${ward.value.occupancyRate}" pattern="#0.0"/>% Full
                                                </span>
                                            </div>
                                            <div class="progress mt-1" style="height: 15px;">
                                                <div class="progress-bar
                                                    <c:choose>
                                                        <c:when test="${ward.value.occupancyRate >= 80}">bg-danger</c:when>
                                                        <c:when test="${ward.value.occupancyRate >= 60}">bg-warning</c:when>
                                                        <c:otherwise>bg-success</c:otherwise>
                                                    </c:choose>"
                                                     style="width: ${ward.value.occupancyRate}%">
                                                </div>
                                            </div>
                                            <small class="text-muted">
                                                    ${ward.value.occupiedBeds} of ${ward.value.totalBeds} beds occupied
                                            </small>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="row mt-4">
                        <div class="col-md-12">
                            <a href="/admin/reports" class="btn btn-secondary">
                                <i class="fas fa-arrow-left me-2"></i>Back to Reports
                            </a>
                            <button onclick="window.print()" class="btn btn-primary">
                                <i class="fas fa-print me-2"></i>Print Report
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

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

    // Function to handle save as draft
    function saveAsDraft() {
        const form = document.getElementById('saveReportForm');
        const draftInput = document.createElement('input');
        draftInput.type = 'hidden';
        draftInput.name = 'isDraft';
        draftInput.value = 'true';
        form.appendChild(draftInput);
        form.submit();
    }

    // Function to handle schedule report
    function scheduleReport() {
        const scheduleDate = prompt('Enter schedule date (YYYY-MM-DD):', new Date().toISOString().split('T')[0]);
        if (scheduleDate) {
            const form = document.getElementById('saveReportForm');
            const scheduleInput = document.createElement('input');
            scheduleInput.type = 'hidden';
            scheduleInput.name = 'scheduleDate';
            scheduleInput.value = scheduleDate;
            form.appendChild(scheduleInput);
            form.submit();
        }
    }

    // Form submission handler
    document.getElementById('saveReportForm').addEventListener('submit', function(e) {
        e.preventDefault();

        const formData = new FormData(this);

        // Show loading state
        const submitBtn = this.querySelector('button[type="submit"]');
        const originalText = submitBtn.innerHTML;
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Saving...';
        submitBtn.disabled = true;

        fetch(this.action, {
            method: 'POST',
            body: formData
        })
            .then(response => {
                if (response.ok) {
                    alert('Report saved successfully!');
                    // Optionally redirect or refresh the page
                    // window.location.reload();
                } else {
                    alert('Failed to save report. Please try again.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred while saving the report.');
            })
            .finally(() => {
                submitBtn.innerHTML = originalText;
                submitBtn.disabled = false;
            });
    });
</script>
</body>
</html>