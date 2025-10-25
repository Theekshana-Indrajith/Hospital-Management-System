<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Current Admissions - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand">🏥 HMS</a>
        <div class="navbar-nav">
            <a class="nav-link" href="/admissions">← All Admissions</a>
            <a class="nav-link active" href="/admissions/current">Current Admissions</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <h1>Current Admissions</h1>

    <!-- Current Admissions Summary -->
    <div class="row mb-4">
        <div class="col-md-12">
            <div class="card bg-light">
                <div class="card-body text-center">
                    <h4>Currently Admitted Patients: ${admissions.size()}</h4>
                    <p class="text-muted">Patients currently staying in the hospital</p>
                </div>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-header d-flex justify-content-between align-items-center">
            <h5>Active Admissions</h5>
            <a href="/admissions/admit" class="btn btn-success btn-sm">Admit New Patient</a>
        </div>
        <div class="card-body">
            <c:if test="${empty admissions}">
                <div class="alert alert-success text-center">
                    <h5>No current admissions</h5>
                    <p>All patients have been discharged. The hospital is currently empty.</p>
                    <a href="/admissions/admit" class="btn btn-primary">Admit First Patient</a>
                </div>
            </c:if>

            <c:if test="${not empty admissions}">
                <div class="row">
                    <c:forEach var="admission" items="${admissions}">
                        <div class="col-md-6 mb-4">
                            <div class="card h-100">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h6 class="mb-0">${admission.patient.firstName} ${admission.patient.lastName}</h6>
                                    <span class="badge bg-success">ADMITTED</span>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <strong>Patient Info:</strong><br>
                                            <small class="text-muted">
                                                ID: ${admission.patient.id}<br>
                                                Gender: ${admission.patient.gender}<br>
                                                Contact: ${admission.patient.contactNumber}
                                            </small>
                                        </div>
                                        <div class="col-md-6">
                                            <strong>Location:</strong><br>
                                            <small class="text-muted">
                                                Ward: ${admission.ward.wardNumber}<br>
                                                Bed: ${admission.bed.bedNumber}<br>
                                                Type: ${admission.ward.wardType}
                                            </small>
                                        </div>
                                    </div>
                                    <div class="mt-3">
                                        <strong>Admission Details:</strong><br>
                                        <small class="text-muted">
                                            Date: ${admission.admissionDate}<br>
                                            Reason: ${admission.reason}<br>
                                            Duration:
                                            <c:set var="admissionTime" value="${admission.admissionDate}"/>
                                            <c:set var="currentTime" value="<%= java.time.LocalDateTime.now() %>"/>
                                            <c:set var="duration" value="${java.time.Duration.between(admissionTime, currentTime)}"/>
                                                ${duration.toDays()} days, ${duration.toHours() % 24} hours
                                        </small>
                                    </div>
                                </div>
                                <div class="card-footer">
                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                        <a href="/admissions/discharge/${admission.id}" class="btn btn-warning btn-sm"
                                           onclick="return confirm('Discharge ${admission.patient.firstName}?')">Discharge</a>
                                        <a href="/admissions/patient/${admission.patient.id}" class="btn btn-info btn-sm">History</a>
                                        <a href="/beds/ward/${admission.ward.id}" class="btn btn-primary btn-sm">Ward View</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>