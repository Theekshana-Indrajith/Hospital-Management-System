<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <title>Ward Management - HMS</title>--%>
<%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">--%>
<%--    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">--%>
<%--</head>--%>
<%--<body>--%>
<%--<nav class="navbar navbar-expand-lg navbar-dark bg-danger">--%>
<%--    <div class="container">--%>
<%--        <a class="navbar-brand" href="/">🏥 HMS</a>--%>
<%--        <div class="navbar-nav">--%>
<%--            <a class="nav-link" href="/admin/dashboard">Dashboard</a>--%>
<%--            <a class="nav-link" href="/admin/users">User Management</a>--%>
<%--            <a class="nav-link" href="/admin/doctors">Doctor Management</a>--%>
<%--            <a class="nav-link" href="/admin/patients">Patient Management</a>--%>
<%--            <a class="nav-link" href="/medical-staff/dashboard">Staff & Departments</a>--%>
<%--&lt;%&ndash;            <a class="nav-link active" href="/admin/wards-management">Ward Management</a>&ndash;%&gt;--%>
<%--&lt;%&ndash;            <a class="nav-link" href="/beds">Beds</a>&ndash;%&gt;--%>
<%--            <a class="nav-link" href="/admin/reports">Reports</a>--%>
<%--            <a class="nav-link" href="/admin/settings">Settings</a>--%>
<%--        </div>--%>
<%--        <div class="navbar-nav ms-auto">--%>
<%--            <span class="navbar-text">Welcome, Administrator!</span>--%>
<%--            <a class="nav-link" href="/logout">Logout</a>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</nav>--%>

<%--<div class="container mt-4">--%>
<%--    <div class="d-flex justify-content-between align-items-center mb-4">--%>
<%--        <h1><i class="fas fa-procedures me-2"></i>Ward Management</h1>--%>
<%--        <a href="/wards" class="btn btn-primary">--%>
<%--            <i class="fas fa-external-link-alt me-1"></i>Go to Wards--%>
<%--        </a>--%>
<%--    </div>--%>

<%--    <!-- Ward Statistics -->--%>
<%--    <div class="row mb-4">--%>
<%--        <div class="col-md-3">--%>
<%--            <div class="card text-center">--%>
<%--                <div class="card-body">--%>
<%--                    <h5 class="card-title">Total Wards</h5>--%>
<%--                    <h3 class="text-primary">${wards.size()}</h3>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col-md-3">--%>
<%--            <div class="card text-center">--%>
<%--                <div class="card-body">--%>
<%--                    <h5 class="card-title">Total Beds</h5>--%>
<%--                    <c:set var="totalBeds" value="0"/>--%>
<%--                    <c:forEach var="ward" items="${wards}">--%>
<%--                        <c:set var="totalBeds" value="${totalBeds + ward.totalBeds}"/>--%>
<%--                    </c:forEach>--%>
<%--                    <h3 class="text-success">${totalBeds}</h3>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col-md-3">--%>
<%--            <div class="card text-center">--%>
<%--                <div class="card-body">--%>
<%--                    <h5 class="card-title">Available Beds</h5>--%>
<%--                    <c:set var="availableBeds" value="0"/>--%>
<%--                    <c:forEach var="ward" items="${wards}">--%>
<%--                        <c:set var="availableBeds" value="${availableBeds + ward.availableBeds}"/>--%>
<%--                    </c:forEach>--%>
<%--                    <h3 class="text-info">${availableBeds}</h3>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col-md-3">--%>
<%--            <div class="card text-center">--%>
<%--                <div class="card-body">--%>
<%--                    <h5 class="card-title">Occupancy Rate</h5>--%>
<%--                    <c:set var="occupancyRate" value="${(totalBeds - availableBeds) / totalBeds * 100}"/>--%>
<%--                    <h3 class="text-warning"><fmt:formatNumber value="${occupancyRate}" pattern="0.0"/>%</h3>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>

<%--    <!-- Ward Management Actions -->--%>
<%--    <div class="card mb-4">--%>
<%--        <div class="card-header">--%>
<%--            <h5 class="mb-0">Quick Actions</h5>--%>
<%--        </div>--%>
<%--        <div class="card-body">--%>
<%--            <div class="row text-center">--%>
<%--                <div class="col-md-2">--%>
<%--                    <a href="/wards" class="btn btn-outline-primary w-100">--%>
<%--                        <i class="fas fa-list me-1"></i>View All--%>
<%--                    </a>--%>
<%--                </div>--%>
<%--                <div class="col-md-2">--%>
<%--                    <a href="/wards/available" class="btn btn-outline-success w-100">--%>
<%--                        <i class="fas fa-bed me-1"></i>Available--%>
<%--                    </a>--%>
<%--                </div>--%>
<%--                <div class="col-md-2">--%>
<%--                    <a href="/beds" class="btn btn-outline-info w-100">--%>
<%--                        <i class="fas fa-bed me-1"></i>Bed Management--%>
<%--                    </a>--%>
<%--                </div>--%>
<%--                <div class="col-md-2">--%>
<%--                    <a href="/admissions" class="btn btn-outline-warning w-100">--%>
<%--                        <i class="fas fa-hospital me-1"></i>Admissions--%>
<%--                    </a>--%>
<%--                </div>--%>
<%--                <div class="col-md-2">--%>
<%--                    <button class="btn btn-outline-secondary w-100" onclick="generateWardReport()">--%>
<%--                        <i class="fas fa-chart-bar me-1"></i>Reports--%>
<%--                    </button>--%>
<%--                </div>--%>
<%--                <div class="col-md-2">--%>
<%--                    <button class="btn btn-outline-danger w-100" onclick="showMaintenance()">--%>
<%--                        <i class="fas fa-tools me-1"></i>Maintenance--%>
<%--                    </button>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>

<%--    <!-- Wards Overview -->--%>
<%--    <div class="card">--%>
<%--        <div class="card-header">--%>
<%--            <h5 class="mb-0"><i class="fas fa-list me-2"></i>All Wards Overview</h5>--%>
<%--        </div>--%>
<%--        <div class="card-body">--%>
<%--            <div class="table-responsive">--%>
<%--                <table class="table table-striped table-hover">--%>
<%--                    <thead class="table-dark">--%>
<%--                    <tr>--%>
<%--                        <th>Ward Number</th>--%>
<%--                        <th>Type</th>--%>
<%--                        <th>Description</th>--%>
<%--                        <th>Total Beds</th>--%>
<%--                        <th>Available</th>--%>
<%--                        <th>Occupied</th>--%>
<%--                        <th>Charge/Day</th>--%>
<%--                        <th>Status</th>--%>
<%--                        <th>Actions</th>--%>
<%--                    </tr>--%>
<%--                    </thead>--%>
<%--                    <tbody>--%>
<%--                    <c:forEach var="ward" items="${wards}">--%>
<%--                        <tr>--%>
<%--                            <td><strong>${ward.wardNumber}</strong></td>--%>
<%--                            <td>--%>
<%--                                    <span class="badge--%>
<%--                                        <c:choose>--%>
<%--                                            <c:when test="${ward.wardType == 'ICU'}">bg-danger</c:when>--%>
<%--                                            <c:when test="${ward.wardType == 'GENERAL'}">bg-primary</c:when>--%>
<%--                                            <c:when test="${ward.wardType == 'PEDIATRIC'}">bg-info</c:when>--%>
<%--                                            <c:when test="${ward.wardType == 'SURGICAL'}">bg-warning</c:when>--%>
<%--                                            <c:when test="${ward.wardType == 'MATERNITY'}">bg-pink</c:when>--%>
<%--                                            <c:otherwise>bg-secondary</c:otherwise>--%>
<%--                                        </c:choose>">--%>
<%--                                            ${ward.wardType}--%>
<%--                                    </span>--%>
<%--                            </td>--%>
<%--                            <td>${ward.description}</td>--%>
<%--                            <td>${ward.totalBeds}</td>--%>
<%--                            <td>--%>
<%--                                <span class="badge bg-success">${ward.availableBeds}</span>--%>
<%--                            </td>--%>
<%--                            <td>--%>
<%--                                <span class="badge bg-danger">${ward.totalBeds - ward.availableBeds}</span>--%>
<%--                            </td>--%>
<%--                            <td>Rs. ${ward.chargePerDay}</td>--%>
<%--                            <td>--%>
<%--                                <c:set var="occupancyRate" value="${(ward.totalBeds - ward.availableBeds) / ward.totalBeds * 100}"/>--%>
<%--                                <c:choose>--%>
<%--                                    <c:when test="${occupancyRate >= 90}">--%>
<%--                                        <span class="badge bg-danger">Full</span>--%>
<%--                                    </c:when>--%>
<%--                                    <c:when test="${occupancyRate >= 70}">--%>
<%--                                        <span class="badge bg-warning">Busy</span>--%>
<%--                                    </c:when>--%>
<%--                                    <c:when test="${occupancyRate >= 50}">--%>
<%--                                        <span class="badge bg-info">Moderate</span>--%>
<%--                                    </c:when>--%>
<%--                                    <c:otherwise>--%>
<%--                                        <span class="badge bg-success">Available</span>--%>
<%--                                    </c:otherwise>--%>
<%--                                </c:choose>--%>
<%--                            </td>--%>
<%--                            <td>--%>
<%--                                <div class="btn-group btn-group-sm">--%>
<%--                                    <a href="/wards/edit/${ward.id}" class="btn btn-outline-primary">--%>
<%--                                        <i class="fas fa-edit"></i>--%>
<%--                                    </a>--%>
<%--                                    <a href="/beds/ward/${ward.id}" class="btn btn-outline-info">--%>
<%--                                        <i class="fas fa-bed"></i>--%>
<%--                                    </a>--%>
<%--                                    <a href="/admissions?wardId=${ward.id}" class="btn btn-outline-success">--%>
<%--                                        <i class="fas fa-procedures"></i>--%>
<%--                                    </a>--%>
<%--                                    <c:if test="${ward.availableBeds == ward.totalBeds}">--%>
<%--                                        <button class="btn btn-outline-danger"--%>
<%--                                                onclick="deleteWard(${ward.id}, '${ward.wardNumber}')">--%>
<%--                                            <i class="fas fa-trash"></i>--%>
<%--                                        </button>--%>
<%--                                    </c:if>--%>
<%--                                </div>--%>
<%--                            </td>--%>
<%--                        </tr>--%>
<%--                    </c:forEach>--%>
<%--                    </tbody>--%>
<%--                </table>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>
<%--<!-- Footer -->--%>
<%--<footer class="py-5 text-white">--%>
<%--    <div class="container position-relative">--%>
<%--        <div class="row">--%>
<%--            <div class="col-lg-4 mb-4">--%>
<%--                <h5 class="fw-bold mb-3">--%>
<%--                    <i class="fas fa-hospital me-2"></i>Aurora Health Hospital--%>
<%--                </h5>--%>
<%--                <p class="text-light-emphasis">--%>
<%--                    Providing exceptional healthcare services with compassion and excellence.--%>
<%--                    Your health is our priority.--%>
<%--                </p>--%>
<%--            </div>--%>
<%--            <div class="col-lg-2 col-6 mb-4">--%>
<%--                <h6 class="fw-bold">Quick Access</h6>--%>
<%--                <ul class="list-unstyled">--%>
<%--                    <li><a href="/login" class="text-light-emphasis text-decoration-none">Login</a></li>--%>
<%--                    <li><a href="/register" class="text-light-emphasis text-decoration-none">Register</a></li>--%>
<%--                    <li><a href="#features" class="text-light-emphasis text-decoration-none">Features</a></li>--%>
<%--                </ul>--%>
<%--            </div>--%>
<%--            <div class="col-lg-3 col-6 mb-4">--%>
<%--                <h6 class="fw-bold">Support</h6>--%>
<%--                <ul class="list-unstyled">--%>
<%--                    <li><a href="#" class="text-light-emphasis text-decoration-none">Help Center</a></li>--%>
<%--                    <li><a href="#" class="text-light-emphasis text-decoration-none">Contact Us</a></li>--%>
<%--                    <li><a href="#" class="text-light-emphasis text-decoration-none">Emergency</a></li>--%>
<%--                </ul>--%>
<%--            </div>--%>
<%--            <div class="col-lg-3 mb-4">--%>
<%--                <h6 class="fw-bold">Contact Info</h6>--%>
<%--                <ul class="list-unstyled text-light-emphasis">--%>
<%--                    <li><i class="fas fa-phone me-2"></i>Emergency: 011-2224455</li>--%>
<%--                    <li><i class="fas fa-envelope me-2"></i>info@aurorahealth.com</li>--%>
<%--                    <li><i class="fas fa-map-marker-alt me-2"></i>Colombo, Srilanka</li>--%>
<%--                </ul>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <hr class="my-4">--%>
<%--        <div class="text-center">--%>
<%--            <p class="mb-0 text-light-emphasis">--%>
<%--                &copy; 2025 Aurora Health Hospital. All rights reserved. |--%>
<%--                <span class="text-warning">Compassionate Care • Advanced Medicine</span>--%>
<%--            </p>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</footer>--%>
<%--<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>--%>
<%--<script>--%>
<%--    function generateWardReport() {--%>
<%--        alert('Generating ward occupancy report...');--%>
<%--        // In real implementation, generate and download report--%>
<%--    }--%>

<%--    function showMaintenance() {--%>
<%--        alert('Opening ward maintenance panel...');--%>
<%--        // In real implementation, show maintenance options--%>
<%--    }--%>

<%--    function deleteWard(wardId, wardNumber) {--%>
<%--        if (confirm(`Are you sure you want to delete ward ${wardNumber}? This action cannot be undone.`)) {--%>
<%--            if (confirm('WARNING: This will also delete all beds in this ward. Continue?')) {--%>
<%--                alert(`Delete functionality for ward ${wardId} would be implemented here`);--%>
<%--            }--%>
<%--        }--%>
<%--    }--%>

<%--    // Auto-hide alerts--%>
<%--    setTimeout(() => {--%>
<%--        const alerts = document.querySelectorAll('.alert');--%>
<%--        alerts.forEach(alert => {--%>
<%--            if (alert.style.display !== 'none') {--%>
<%--                alert.style.display = 'none';--%>
<%--            }--%>
<%--        });--%>
<%--    }, 5000);--%>
<%--</script>--%>

<%--<style>--%>
<%--    .bg-pink {--%>
<%--        background-color: #e83e8c !important;--%>
<%--    }--%>
<%--</style>--%>
<%--</body>--%>
<%--</html>--%>