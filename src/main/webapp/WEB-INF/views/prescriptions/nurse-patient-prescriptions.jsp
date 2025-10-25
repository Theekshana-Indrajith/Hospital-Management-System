<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Patient Prescriptions - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-info">
    <div class="container">
        <a class="navbar-brand" href="">🏥 HMS</a>
        <div class="navbar-nav">
            <a class="nav-link" href="/staff/dashboard">Dashboard</a>
            <a class="nav-link active" href="#">Patient Prescriptions</a>
            <a class="nav-link" href="/staff/patients">Patients</a>
        </div>
        <div class="navbar-nav ms-auto">
            <span class="navbar-text">Welcome, ${username}!</span>
            <a class="nav-link" href="/logout">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center">
        <h1><i class="fas fa-prescription me-2"></i>Prescriptions for ${patient.firstName} ${patient.lastName}</h1>
        <a href="/staff/patients" class="btn btn-secondary">
            <i class="fas fa-arrow-left me-1"></i>Back to Patients
        </a>
    </div>

    <!-- Patient Information -->
    <div class="card mt-4">
        <div class="card-header bg-light">
            <h5 class="mb-0"><i class="fas fa-info-circle me-2"></i>Patient Information</h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-3">
                    <strong>Patient ID:</strong> ${patient.id}
                </div>
                <div class="col-md-3">
                    <strong>Name:</strong> ${patient.firstName} ${patient.lastName}
                </div>
                <div class="col-md-3">
                    <strong>Date of Birth:</strong> ${patient.dateOfBirth}
                </div>
                <div class="col-md-3">
                    <strong>Contact:</strong> ${patient.contactNumber}
                </div>
            </div>
        </div>
    </div>

    <!-- Prescriptions -->
    <div class="card mt-4">
        <div class="card-header">
            <h5 class="mb-0"><i class="fas fa-pills me-2"></i>Medication Administration</h5>
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty prescriptions}">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead class="table-dark">
                            <tr>
                                <th>Medication</th>
                                <th>Dosage</th>
                                <th>Frequency</th>
                                <th>Duration</th>
                                <th>Prescribing Doctor</th>
                                <th>Status</th>
                                <th>Instructions</th>
                                <th>Last Administered</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="prescription" items="${prescriptions}">
                                <tr>
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
                                            <small>${prescription.instructions}</small>
                                        </c:if>
                                    </td>
                                    <td>
                                        <span class="text-muted">-</span>
                                    </td>
                                    <td>
                                        <c:if test="${prescription.status == 'ACTIVE'}">
                                            <button class="btn btn-success btn-sm">
                                                <i class="fas fa-syringe me-1"></i>Administer
                                            </button>
                                            <form action="/prescriptions/update-status" method="post" class="d-inline">
                                                <input type="hidden" name="prescriptionId" value="${prescription.id}">
                                                <input type="hidden" name="status" value="COMPLETED">
                                                <button type="submit" class="btn btn-warning btn-sm">
                                                    <i class="fas fa-check me-1"></i>Complete
                                                </button>
                                            </form>
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
                        <p class="text-muted">This patient doesn't have any prescriptions.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Medication Administration Log -->
    <div class="card mt-4">
        <div class="card-header bg-success text-white">
            <h5 class="mb-0"><i class="fas fa-clipboard-list me-2"></i>Medication Administration Log</h5>
        </div>
        <div class="card-body">
            <div class="alert alert-info">
                <i class="fas fa-info-circle me-2"></i>
                Use this section to log medication administration and track patient compliance.
            </div>
            <!-- Administration log would be implemented here -->
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>