<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>My Prescriptions - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="">🏥 HMS</a>
        <div class="navbar-nav">


            <a class="nav-link" href="/patient/dashboard">Dashboard</a>
            <a class="nav-link" href="/patient/profile">My Profile</a>
            <a class="nav-link" href="/appointments/my-appointments">My Appointments</a>
            <a class="nav-link" href="/patient/lab-results">Lab Results</a>
            <a class="nav-link active" href="/prescriptions/my-prescriptions">My Prescriptions</a>
            <a class="nav-link" href="/patient/admissions">My Admissions</a>
        </div>
        <div class="navbar-nav ms-auto">
            <span class="navbar-text">Welcome, ${patient.firstName}!</span>
            <a class="nav-link" href="/logout">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <h1><i class="fas fa-prescription me-2"></i>My Prescriptions</h1>
    <p class="text-muted">View your current and past medication prescriptions</p>

    <!-- Statistics -->
    <div class="row mt-4">
        <div class="col-md-4">
            <div class="card text-center bg-primary text-white">
                <div class="card-body">
                    <h5><i class="fas fa-pills"></i> Active Prescriptions</h5>
                    <h3>${activePrescriptionsCount}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card text-center bg-success text-white">
                <div class="card-body">
                    <h5><i class="fas fa-check-circle"></i> Completed</h5>
                    <h3>${completedPrescriptionsCount}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card text-center bg-info text-white">
                <div class="card-body">
                    <h5><i class="fas fa-history"></i> Total</h5>
                    <h3>${totalPrescriptionsCount}</h3>
                </div>
            </div>
        </div>
    </div>

    <!-- Prescriptions List -->
    <div class="card mt-4">
        <div class="card-header bg-light">
            <h5 class="mb-0"><i class="fas fa-list me-2"></i>Prescription History</h5>
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty prescriptions}">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead class="table-dark">
                            <tr>
                                <th>Date</th>
                                <th>Medication</th>
                                <th>Dosage</th>
                                <th>Frequency</th>
                                <th>Duration</th>
                                <th>Prescribing Doctor</th>
                                <th>Status</th>
                                <th>Instructions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="prescription" items="${prescriptions}">
                                <tr>
                                    <td>${prescription.prescriptionDate}</td>
                                    <td>
                                        <strong>${prescription.medicationName}</strong>
                                    </td>
                                    <td>${prescription.dosage}</td>
                                    <td>${prescription.frequency}</td>
                                    <td>${prescription.duration}</td>
                                    <td>${prescription.doctor.name}</td>
                                    <td>
                                            <span class="badge bg-${prescription.status == 'ACTIVE' ? 'success' : 'secondary'}">
                                                    ${prescription.status}
                                            </span>
                                    </td>
                                    <td>
                                        <c:if test="${not empty prescription.instructions}">
                                            <button class="btn btn-sm btn-outline-info"
                                                    data-bs-toggle="tooltip"
                                                    title="${prescription.instructions}">
                                                <i class="fas fa-info-circle"></i>
                                            </button>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-4">
                        <i class="fas fa-prescription fa-3x text-muted mb-3"></i>
                        <h4>No Prescriptions</h4>
                        <p class="text-muted">You don't have any prescriptions yet.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Active Prescriptions -->
    <c:if test="${activePrescriptionsCount > 0}">
        <div class="card mt-4 border-success">
            <div class="card-header bg-success text-white">
                <h5 class="mb-0"><i class="fas fa-exclamation-circle me-2"></i>Current Active Prescriptions</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <c:forEach var="prescription" items="${prescriptions}">
                        <c:if test="${prescription.status == 'ACTIVE'}">
                            <div class="col-md-6 mb-3">
                                <div class="card">
                                    <div class="card-body">
                                        <h6 class="card-title text-success">${prescription.medicationName}</h6>
                                        <p class="card-text">
                                            <strong>Dosage:</strong> ${prescription.dosage}<br>
                                            <strong>Frequency:</strong> ${prescription.frequency}<br>
                                            <strong>Duration:</strong> ${prescription.duration}<br>
                                            <strong>Doctor:</strong> ${prescription.doctor.name}
                                        </p>
                                        <c:if test="${not empty prescription.instructions}">
                                            <div class="alert alert-info py-2">
                                                <small><strong>Instructions:</strong> ${prescription.instructions}</small>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </div>
    </c:if>

    <!-- Important Notes -->
    <div class="alert alert-warning mt-4">
        <h6><i class="fas fa-exclamation-triangle me-2"></i>Important Information</h6>
        <ul class="mb-0">
            <li>Always take medications as prescribed by your doctor</li>
            <li>Complete the full course of antibiotics even if you feel better</li>
            <li>Contact your doctor immediately if you experience any side effects</li>
            <li>Do not share your medications with others</li>
        </ul>
    </div>
</div>

<script>
    // Initialize tooltips
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl)
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>