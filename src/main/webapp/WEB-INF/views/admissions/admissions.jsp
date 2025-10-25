<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Admissions - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand">🏥 HMS</a>
        <div class="navbar-nav">
            <a class="nav-link" href="/">Home</a>
            <a class="nav-link" href="/patients">Patients</a>
            <a class="nav-link" href="/wards">Wards</a>
            <a class="nav-link" href="/beds">Beds</a>
            <a class="nav-link active" href="/admissions">Admissions</a>
            <a class="nav-link" href="/appointments">Appointments</a>
        </div>
        <div class="navbar-nav ms-auto">
            <a class="nav-link" href="/logout">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <h1>Patient Admissions</h1>

    <!-- Quick Actions -->
    <div class="row mb-4">
        <div class="col-md-4">
            <div class="card text-center bg-primary text-white">
                <div class="card-body">
                    <h5 class="card-title">Current Admissions</h5>
                    <c:set var="currentAdmissions" value="${admissions.stream().filter(a -> a.status == 'ADMITTED').count()}"/>
                    <h3>${currentAdmissions}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card text-center bg-success text-white">
                <div class="card-body">
                    <h5 class="card-title">Total Admissions</h5>
                    <h3>${admissions.size()}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card text-center bg-info text-white">
                <div class="card-body">
                    <h5 class="card-title">Actions</h5>
                    <div class="d-grid gap-2">
                        <a href="/admissions/admit" class="btn btn-light btn-sm">Admit Patient</a>
                        <a href="/admissions/current" class="btn btn-light btn-sm">Current Admissions</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Admissions List -->
    <div class="card">
        <div class="card-header d-flex justify-content-between align-items-center">
            <h5>All Admissions</h5>
            <div>
                <a href="/admissions/current" class="btn btn-sm btn-primary">View Current</a>
                <a href="/admissions/admit" class="btn btn-sm btn-success">New Admission</a>
            </div>
        </div>
        <div class="card-body">
            <c:if test="${empty admissions}">
                <div class="alert alert-info text-center">
                    <h5>No admissions found</h5>
                    <p>There are no admission records in the system.</p>
                    <a href="/admissions/admit" class="btn btn-primary">Admit First Patient</a>
                </div>
            </c:if>

            <c:if test="${not empty admissions}">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>Admission ID</th>
                        <th>Patient</th>
                        <th>Ward & Bed</th>
                        <th>Admission Date</th>
                        <th>Discharge Date</th>
                        <th>Status</th>
                        <th>Reason</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="admission" items="${admissions}">
                        <tr>
                            <td><strong>#${admission.id}</strong></td>
                            <td>
                                <strong>${admission.patient.firstName} ${admission.patient.lastName}</strong><br>
                                <small class="text-muted">ID: ${admission.patient.id}</small>
                            </td>
                            <td>
                                    ${admission.ward.wardNumber} - ${admission.bed.bedNumber}<br>
                                <small class="text-muted">${admission.ward.wardType}</small>
                            </td>
                            <td>${admission.admissionDate}</td>
                            <td>
                                <c:if test="${admission.dischargeDate != null}">
                                    ${admission.dischargeDate}
                                </c:if>
                                <c:if test="${admission.dischargeDate == null}">
                                    <span class="text-muted">-</span>
                                </c:if>
                            </td>
                            <td>
                                <span class="badge
                                    <c:choose>
                                        <c:when test="${admission.status == 'ADMITTED'}">bg-success</c:when>
                                        <c:when test="${admission.status == 'DISCHARGED'}">bg-secondary</c:when>
                                        <c:when test="${admission.status == 'TRANSFERRED'}">bg-info</c:when>
                                        <c:otherwise>bg-warning</c:otherwise>
                                    </c:choose>">
                                        ${admission.status}
                                </span>
                            </td>
                            <td>${admission.reason}</td>
                            <td>
                                <div class="btn-group" role="group">
                                    <c:if test="${admission.status == 'ADMITTED'}">
                                        <a href="/admissions/discharge/${admission.id}" class="btn btn-sm btn-warning"
                                           onclick="return confirm('Discharge ${admission.patient.firstName} from ${admission.bed.bedNumber}?')">Discharge</a>
                                    </c:if>
                                    <a href="/admissions/patient/${admission.patient.id}" class="btn btn-sm btn-info">History</a>
                                    <a href="/beds/ward/${admission.ward.id}" class="btn btn-sm btn-primary">Ward</a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>