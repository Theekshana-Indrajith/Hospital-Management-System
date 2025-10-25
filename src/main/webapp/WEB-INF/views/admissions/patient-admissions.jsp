<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${patient.firstName}'s Admissions - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand">🏥 HMS</a>
        <div class="navbar-nav">
            <a class="nav-link" href="/admissions">← Back to Admissions</a>
            <a class="nav-link" href="/patients">All Patients</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <!-- Patient Header -->
    <div class="card mb-4">
        <div class="card-body">
            <div class="row">
                <div class="col-md-8">
                    <h3>${patient.firstName} ${patient.lastName}</h3>
                    <p class="text-muted">
                        Patient ID: ${patient.id} |
                        Gender: ${patient.gender} |
                        DOB: ${patient.dateOfBirth} |
                        Contact: ${patient.contactNumber}
                    </p>
                </div>
                <div class="col-md-4 text-end">
                    <div class="badge bg-primary fs-6">Total Admissions: ${admissions.size()}</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Admissions History -->
    <div class="card">
        <div class="card-header">
            <h5>Admission History</h5>
        </div>
        <div class="card-body">
            <c:if test="${empty admissions}">
                <div class="alert alert-info text-center">
                    <h5>No admission history</h5>
                    <p>This patient has no previous admissions.</p>
                    <a href="/admissions/admit?patientId=${patient.id}" class="btn btn-primary">Admit Patient</a>
                </div>
            </c:if>

            <c:if test="${not empty admissions}">
                <div class="timeline">
                    <c:forEach var="admission" items="${admissions}">
                        <div class="timeline-item mb-4">
                            <div class="card">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h6 class="mb-0">
                                        Admission #${admission.id}
                                        <span class="badge
                                            <c:choose>
                                                <c:when test="${admission.status == 'ADMITTED'}">bg-success</c:when>
                                                <c:when test="${admission.status == 'DISCHARGED'}">bg-secondary</c:when>
                                                <c:when test="${admission.status == 'TRANSFERRED'}">bg-info</c:when>
                                            </c:choose>">
                                                ${admission.status}
                                        </span>
                                    </h6>
                                    <small class="text-muted">${admission.admissionDate}</small>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <strong>Location:</strong><br>
                                            <span class="text-muted">
                                                Ward: ${admission.ward.wardNumber} (${admission.ward.wardType})<br>
                                                Bed: ${admission.bed.bedNumber}<br>
                                                Charge: Rs. ${admission.ward.chargePerDay}/day
                                            </span>
                                        </div>
                                        <div class="col-md-6">
                                            <strong>Details:</strong><br>
                                            <span class="text-muted">
                                                Reason: ${admission.reason}<br>
                                                <c:if test="${admission.dischargeDate != null}">
                                                    Discharge: ${admission.dischargeDate}<br>
                                                </c:if>
                                                <c:if test="${admission.doctorNotes != null}">
                                                    Notes: ${admission.doctorNotes}
                                                </c:if>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-footer">
                                    <c:if test="${admission.status == 'ADMITTED'}">
                                        <a href="/admissions/discharge/${admission.id}" class="btn btn-sm btn-warning"
                                           onclick="return confirm('Discharge ${patient.firstName}?')">Discharge</a>
                                    </c:if>
                                    <a href="/beds/ward/${admission.ward.id}" class="btn btn-sm btn-info">View Ward</a>
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