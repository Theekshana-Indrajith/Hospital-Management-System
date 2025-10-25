<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>All Prescriptions - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-success">
    <div class="container">
        <a class="navbar-brand" href="">🏥 HMS</a>
        <div class="navbar-nav">
            <a class="nav-link" href="/doctor/dashboard">Dashboard</a>
            <a class="nav-link" href="/prescriptions/add">Add Prescription</a>
            <a class="nav-link active" href="/prescriptions">View Prescriptions</a>
            <a class="nav-link" href="/doctor/patients">Patients</a>
        </div>
        <div class="navbar-nav ms-auto">
            <span class="navbar-text">Dr. ${username}</span>
            <a class="nav-link" href="/logout">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center">
        <h1><i class="fas fa-prescription me-2"></i>All Prescriptions</h1>
        <a href="/prescriptions/add" class="btn btn-success">
            <i class="fas fa-plus me-1"></i>Add New Prescription
        </a>
    </div>

    <!-- Success/Error Messages -->
    <c:if test="${not empty param.success}">
        <div class="alert alert-success alert-dismissible fade show mt-3" role="alert">
                ${param.success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty param.error}">
        <div class="alert alert-danger alert-dismissible fade show mt-3" role="alert">
                ${param.error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Prescriptions Table -->
    <div class="card mt-4">
        <div class="card-header bg-light">
            <h5 class="mb-0"><i class="fas fa-list me-2"></i>Prescriptions List</h5>
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty prescriptions}">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Patient</th>
                                <th>Medication</th>
                                <th>Dosage</th>
                                <th>Frequency</th>
                                <th>Duration</th>
                                <th>Status</th>
                                <th>Date</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="prescription" items="${prescriptions}">
                                <tr>
                                    <td>#${prescription.id}</td>
                                    <td>
                                        <strong>${prescription.patient.firstName} ${prescription.patient.lastName}</strong>
                                        <br><small class="text-muted">ID: ${prescription.patient.id}</small>
                                    </td>
                                    <td>${prescription.medicationName}</td>
                                    <td>${prescription.dosage}</td>
                                    <td>${prescription.frequency}</td>
                                    <td>${prescription.duration}</td>
                                    <td>
                                            <span class="badge bg-${prescription.status == 'ACTIVE' ? 'success' : 'secondary'}">
                                                    ${prescription.status}
                                            </span>
                                    </td>
                                    <td>${prescription.prescriptionDate}</td>
                                    <td>
                                        <div class="btn-group btn-group-sm">
                                            <a href="/prescriptions/patient/${prescription.patient.id}"
                                               class="btn btn-info">
                                                <i class="fas fa-eye me-1"></i>View
                                            </a>
                                            <c:if test="${prescription.status == 'ACTIVE'}">
                                                <form action="/prescriptions/update-status" method="post" class="d-inline">
                                                    <input type="hidden" name="prescriptionId" value="${prescription.id}">
                                                    <input type="hidden" name="status" value="COMPLETED">
                                                    <button type="submit" class="btn btn-success">
                                                        <i class="fas fa-check me-1"></i>Complete
                                                    </button>
                                                </form>
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
                        <i class="fas fa-prescription fa-3x text-muted mb-3"></i>
                        <h4>No Prescriptions Found</h4>
                        <p class="text-muted">No prescriptions have been created yet.</p>
                        <a href="/prescriptions/add" class="btn btn-success">
                            <i class="fas fa-plus me-1"></i>Create First Prescription
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Statistics -->
    <div class="row mt-4">
        <div class="col-md-3">
            <div class="card text-center bg-primary text-white">
                <div class="card-body">
                    <h5>Total</h5>
                    <h3>${prescriptions.size()}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center bg-success text-white">
                <div class="card-body">
                    <h5>Active</h5>
                    <h3>
                        <c:set var="activeCount" value="0" />
                        <c:forEach var="prescription" items="${prescriptions}">
                            <c:if test="${prescription.status == 'ACTIVE'}">
                                <c:set var="activeCount" value="${activeCount + 1}" />
                            </c:if>
                        </c:forEach>
                        ${activeCount}
                    </h3>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center bg-info text-white">
                <div class="card-body">
                    <h5>Completed</h5>
                    <h3>
                        <c:set var="completedCount" value="0" />
                        <c:forEach var="prescription" items="${prescriptions}">
                            <c:if test="${prescription.status == 'COMPLETED'}">
                                <c:set var="completedCount" value="${completedCount + 1}" />
                            </c:if>
                        </c:forEach>
                        ${completedCount}
                    </h3>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center bg-warning text-white">
                <div class="card-body">
                    <h5>Patients</h5>
                    <h3>
                        <c:set var="patientIds" value="" />
                        <c:forEach var="prescription" items="${prescriptions}">
                            <c:if test="${not patientIds.contains(prescription.patient.id.toString())}">
                                <c:set var="patientIds" value="${patientIds},${prescription.patient.id}" />
                            </c:if>
                        </c:forEach>
                        ${patientIds.split(',').length - 1}
                    </h3>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>