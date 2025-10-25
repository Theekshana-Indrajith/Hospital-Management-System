<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <title>Current Admissions - HMS</title>--%>
<%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">--%>
<%--</head>--%>
<%--<body>--%>
<%--<nav class="navbar navbar-expand-lg navbar-dark bg-success">--%>
<%--    <div class="container">--%>
<%--        <a class="navbar-brand" href="/">🏥 HMS</a>--%>
<%--        <div class="navbar-nav">--%>
<%--            <a class="nav-link" href="/doctor/dashboard">Dashboard</a>--%>
<%--            <a class="nav-link" href="/appointments/doctor-schedule">My Schedule</a>--%>
<%--            <a class="nav-link" href="/doctor/patients">Patients</a>--%>
<%--            <a class="nav-link active" href="/doctor/admissions">Admissions</a>--%>
<%--            <a class="nav-link" href="/doctor/records">Medical Records</a>--%>
<%--        </div>--%>
<%--        <div class="navbar-nav ms-auto">--%>
<%--            <a class="nav-link" href="/logout">Logout</a>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</nav>--%>

<%--<div class="container mt-5">--%>
<%--    <h1>Current Admissions Under My Care</h1>--%>

<%--    <div class="row mb-4">--%>
<%--        <div class="col-md-3">--%>
<%--            <div class="card text-center bg-primary text-white">--%>
<%--                <div class="card-body">--%>
<%--                    <h5>Total Admissions</h5>--%>
<%--                    <h3>${admissions.size()}</h3>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col-md-3">--%>
<%--            <div class="card text-center bg-success text-white">--%>
<%--                <div class="card-body">--%>
<%--                    <h5>ICU Patients</h5>--%>
<%--                    <h3>${admissions.stream().filter(a -> a.ward.wardType == 'ICU').count()}</h3>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col-md-3">--%>
<%--            <div class="card text-center bg-warning text-white">--%>
<%--                <div class="card-body">--%>
<%--                    <h5>Critical Condition</h5>--%>
<%--                    <h3>2</h3>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col-md-3">--%>
<%--            <div class="card text-center bg-info text-white">--%>
<%--                <div class="card-body">--%>
<%--                    <h5>Ready for Discharge</h5>--%>
<%--                    <h3>1</h3>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>

<%--    <div class="card">--%>
<%--        <div class="card-header d-flex justify-content-between align-items-center">--%>
<%--            <h5>Admitted Patients</h5>--%>
<%--            <a href="/admissions/admit" class="btn btn-success btn-sm">Admit New Patient</a>--%>
<%--        </div>--%>
<%--        <div class="card-body">--%>
<%--            <c:if test="${empty admissions}">--%>
<%--                <div class="alert alert-success text-center">--%>
<%--                    <h5>No current admissions</h5>--%>
<%--                    <p>All patients under your care have been discharged.</p>--%>
<%--                </div>--%>
<%--            </c:if>--%>

<%--            <c:if test="${not empty admissions}">--%>
<%--                <div class="row">--%>
<%--                    <c:forEach var="admission" items="${admissions}">--%>
<%--                        <div class="col-md-6 mb-4">--%>
<%--                            <div class="card h-100">--%>
<%--                                <div class="card-header d-flex justify-content-between align-items-center">--%>
<%--                                    <h6 class="mb-0">${admission.patient.firstName} ${admission.patient.lastName}</h6>--%>
<%--                                    <span class="badge--%>
<%--                                        <c:choose>--%>
<%--                                            <c:when test="${admission.ward.wardType == 'ICU'}">bg-danger</c:when>--%>
<%--                                            <c:when test="${admission.ward.wardType == 'SURGICAL'}">bg-warning</c:when>--%>
<%--                                            <c:otherwise>bg-success</c:otherwise>--%>
<%--                                        </c:choose>">--%>
<%--                                            ${admission.ward.wardType}--%>
<%--                                    </span>--%>
<%--                                </div>--%>
<%--                                <div class="card-body">--%>
<%--                                    <div class="row">--%>
<%--                                        <div class="col-6">--%>
<%--                                            <strong>Patient Info:</strong><br>--%>
<%--                                            <small class="text-muted">--%>
<%--                                                ID: ${admission.patient.id}<br>--%>
<%--                                                Age:--%>
<%--                                                <c:if test="${admission.patient.dateOfBirth != null}">--%>
<%--                                                    <c:set var="birthYear" value="${admission.patient.dateOfBirth.year}"/>--%>
<%--                                                    <c:set var="currentYear" value="<%= java.time.Year.now().getValue() %>"/>--%>
<%--                                                    ${currentYear - birthYear} years--%>
<%--                                                </c:if><br>--%>
<%--                                                Gender: ${admission.patient.gender}--%>
<%--                                            </small>--%>
<%--                                        </div>--%>
<%--                                        <div class="col-6">--%>
<%--                                            <strong>Location:</strong><br>--%>
<%--                                            <small class="text-muted">--%>
<%--                                                Ward: ${admission.ward.wardNumber}<br>--%>
<%--                                                Bed: ${admission.bed.bedNumber}<br>--%>
<%--                                                Charge: Rs. ${admission.ward.chargePerDay}/day--%>
<%--                                            </small>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                    <div class="mt-3">--%>
<%--                                        <strong>Admission Details:</strong><br>--%>
<%--                                        <small class="text-muted">--%>
<%--                                            Date: ${admission.admissionDate}<br>--%>
<%--                                            Reason: ${admission.reason}<br>--%>
<%--                                            Duration:--%>
<%--                                            <c:set var="admissionTime" value="${admission.admissionDate}"/>--%>
<%--                                            <c:set var="currentTime" value="<%= java.time.LocalDateTime.now() %>"/>--%>
<%--                                            <c:set var="duration" value="${java.time.Duration.between(admissionTime, currentTime)}"/>--%>
<%--                                                ${duration.toDays()} days--%>
<%--                                        </small>--%>
<%--                                    </div>--%>
<%--                                    <div class="mt-3">--%>
<%--                                        <strong>Vital Signs:</strong><br>--%>
<%--                                        <small class="text-muted">--%>
<%--                                            BP: 120/80 | Pulse: 72 | Temp: 98.6°F<br>--%>
<%--                                            Last Checked: 2 hours ago--%>
<%--                                        </small>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                                <div class="card-footer">--%>
<%--                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">--%>
<%--                                        <a href="/doctor/patient/${admission.patient.id}" class="btn btn-info btn-sm me-1">View Patient</a>--%>
<%--                                        <a href="/admissions/discharge/${admission.id}" class="btn btn-warning btn-sm"--%>
<%--                                           onclick="return confirm('Discharge ${admission.patient.firstName}?')">Discharge</a>--%>
<%--                                        <button class="btn btn-primary btn-sm">Progress Notes</button>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </c:forEach>--%>
<%--                </div>--%>
<%--            </c:if>--%>
<%--        </div>--%>
<%--    </div>--%>

<%--    <!-- Admission Statistics Table -->--%>
<%--    <div class="card mt-4">--%>
<%--        <div class="card-header">--%>
<%--            <h5>Admission Statistics</h5>--%>
<%--        </div>--%>
<%--        <div class="card-body">--%>
<%--            <div class="table-responsive">--%>
<%--                <table class="table table-striped">--%>
<%--                    <thead>--%>
<%--                    <tr>--%>
<%--                        <th>Ward Type</th>--%>
<%--                        <th>Patient Count</th>--%>
<%--                        <th>Average Stay</th>--%>
<%--                        <th>Most Common Condition</th>--%>
<%--                        <th>Action</th>--%>
<%--                    </tr>--%>
<%--                    </thead>--%>
<%--                    <tbody>--%>
<%--                    <tr>--%>
<%--                        <td>ICU</td>--%>
<%--                        <td>${admissions.stream().filter(a -> a.ward.wardType == 'ICU').count()}</td>--%>
<%--                        <td>5.2 days</td>--%>
<%--                        <td>Post-Surgical</td>--%>
<%--                        <td><button class="btn btn-sm btn-info">View Ward</button></td>--%>
<%--                    </tr>--%>
<%--                    <tr>--%>
<%--                        <td>General</td>--%>
<%--                        <td>${admissions.stream().filter(a -> a.ward.wardType == 'GENERAL').count()}</td>--%>
<%--                        <td>3.1 days</td>--%>
<%--                        <td>Respiratory</td>--%>
<%--                        <td><button class="btn btn-sm btn-info">View Ward</button></td>--%>
<%--                    </tr>--%>
<%--                    <tr>--%>
<%--                        <td>Surgical</td>--%>
<%--                        <td>${admissions.stream().filter(a -> a.ward.wardType == 'SURGICAL').count()}</td>--%>
<%--                        <td>4.5 days</td>--%>
<%--                        <td>Post-Op Recovery</td>--%>
<%--                        <td><button class="btn btn-sm btn-info">View Ward</button></td>--%>
<%--                    </tr>--%>
<%--                    </tbody>--%>
<%--                </table>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>
<%--</body>--%>
<%--</html>--%>