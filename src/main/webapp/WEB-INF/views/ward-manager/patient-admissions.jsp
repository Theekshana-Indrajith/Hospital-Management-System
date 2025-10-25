<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Patient Admission History - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-info">
    <div class="container">
        <a class="navbar-brand" href="">🏥 HMS - Ward Management</a>
        <div class="navbar-nav">
            <a class="nav-link" href="/ward-manager/dashboard">Dashboard</a>
            <a class="nav-link" href="/ward-manager/admissions">← Back to Admissions</a>
            <a class="nav-link active" href="#">Patient History</a>
        </div>
        <div class="navbar-nav ms-auto">
            <span class="navbar-text">Welcome, ${username} (Ward Manager)</span>
            <a class="nav-link" href="/logout">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1><i class="fas fa-history me-2"></i>Admission History</h1>
        <a href="/ward-manager/admissions/admit" class="btn btn-success">
            <i class="fas fa-user-plus me-1"></i>Admit New Patient
        </a>
    </div>

    <!-- Patient Information -->
    <div class="card mb-4">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0"><i class="fas fa-user me-2"></i>Patient Information</h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-3">
                    <strong>Name:</strong> ${patient.firstName} ${patient.lastName}
                </div>
                <div class="col-md-3">
                    <strong>Date of Birth:</strong> <fmt:formatDate value="${patient.dateOfBirth}" pattern="MMM dd, yyyy"/>
                </div>
                <div class="col-md-3">
                    <strong>Gender:</strong> ${patient.gender}
                </div>
                <div class="col-md-3">
                    <strong>Contact:</strong> ${patient.contactNumber}
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-md-6">
                    <strong>Email:</strong> ${patient.email}
                </div>
                <div class="col-md-6">
                    <strong>Address:</strong> ${patient.address}
                </div>
            </div>
        </div>
    </div>

    <!-- Admission History -->
    <div class="card">
        <div class="card-header bg-info text-white">
            <h5 class="mb-0"><i class="fas fa-list me-2"></i>Admission History (${admissions.size()})</h5>
        </div>
        <div class="card-body">
            <c:if test="${empty admissions}">
                <div class="alert alert-info text-center">
                    <i class="fas fa-info-circle fa-2x mb-3"></i>
                    <h5>No Admission History</h5>
                    <p>This patient has no previous admissions.</p>
                    <a href="/ward-manager/admissions/admit" class="btn btn-primary">Admit This Patient</a>
                </div>
            </c:if>

            <c:if test="${not empty admissions}">
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead class="table-dark">
                        <tr>
                            <th>Admission ID</th>
                            <th>Ward</th>
                            <th>Bed</th>
                            <th>Admission Date</th>
                            <th>Discharge Date</th>
                            <th>Duration</th>
                            <th>Reason</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="admission" items="${admissions}">
                            <tr>
                                <td><strong>#${admission.id}</strong></td>
                                <td>
                                    <span class="badge bg-primary">${admission.ward.wardNumber}</span><br>
                                    <small>${admission.ward.wardType}</small>
                                </td>
                                <td>
                                    <span class="badge bg-info">${admission.bed.bedNumber}</span>
                                </td>
                                <td>
                                    <fmt:formatDate value="${admission.admissionDate}" pattern="MMM dd, yyyy HH:mm"/>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${admission.dischargeDate != null}">
                                            <fmt:formatDate value="${admission.dischargeDate}" pattern="MMM dd, yyyy HH:mm"/>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-warning">Currently Admitted</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${admission.dischargeDate != null}">
                                            <c:set var="duration" value="${admission.dischargeDate.time - admission.admissionDate.time}"/>
                                            <c:set var="days" value="${duration / (1000 * 60 * 60 * 24)}"/>
                                            <fmt:formatNumber value="${days}" pattern="0.0"/> days
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="duration" value="${now.time - admission.admissionDate.time}"/>
                                            <c:set var="days" value="${duration / (1000 * 60 * 60 * 24)}"/>
                                            <fmt:formatNumber value="${days}" pattern="0.0"/> days
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${admission.reason}</td>
                                <td>
                                        <span class="badge
                                            <c:choose>
                                                <c:when test="${admission.status == 'ADMITTED'}">bg-success</c:when>
                                                <c:when test="${admission.status == 'DISCHARGED'}">bg-secondary</c:when>
                                                <c:when test="${admission.status == 'TRANSFERRED'}">bg-warning</c:when>
                                                <c:otherwise>bg-info</c:otherwise>
                                            </c:choose>">
                                                ${admission.status}
                                        </span>
                                </td>
                                <td>
                                    <c:if test="${admission.status == 'ADMITTED'}">
                                        <div class="btn-group btn-group-sm" role="group">
                                            <a href="/ward-manager/admissions/transfer/${admission.id}"
                                               class="btn btn-warning" title="Transfer Patient">
                                                <i class="fas fa-exchange-alt"></i>
                                            </a>
                                            <form action="/ward-manager/admissions/discharge" method="post" class="d-inline">
                                                <input type="hidden" name="admissionId" value="${admission.id}">
                                                <button type="submit" class="btn btn-success"
                                                        onclick="return confirm('Discharge ${patient.firstName} from ${admission.ward.wardNumber}?')"
                                                        title="Discharge Patient">
                                                    <i class="fas fa-sign-out-alt"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </c:if>
                                    <c:if test="${admission.status != 'ADMITTED'}">
                                        <span class="text-muted">Completed</span>
                                    </c:if>
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
</body>
</html>