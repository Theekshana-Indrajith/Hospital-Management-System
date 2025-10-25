<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <title>Appointment Schedule - HMS</title>--%>
<%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">--%>
<%--</head>--%>
<%--<body>--%>
<%--<nav class="navbar navbar-expand-lg navbar-dark bg-success">--%>
<%--    <div class="container">--%>
<%--        <a class="navbar-brand" href="/">🏥 HMS</a>--%>
<%--        <div class="navbar-nav">--%>
<%--            <a class="nav-link" href="/doctor/dashboard">Dashboard</a>--%>
<%--            <a class="nav-link active" href="/appointments/doctor-schedule">My Schedule</a>--%>
<%--            <a class="nav-link" href="/doctor/patients">Patients</a>--%>
<%--            <a class="nav-link" href="/doctor/appointments">All Appointments</a>--%>
<%--        </div>--%>
<%--        <div class="navbar-nav ms-auto">--%>
<%--            <a class="nav-link" href="/logout">Logout</a>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</nav>--%>

<%--<div class="container mt-5">--%>
<%--    <h1>My Appointment Schedule</h1>--%>

<%--    <c:if test="${not empty updated}">--%>
<%--        <div class="alert alert-success">Appointment status updated successfully!</div>--%>
<%--    </c:if>--%>

<%--    <div class="row">--%>
<%--        <div class="col-md-12">--%>
<%--            <div class="card">--%>
<%--                <div class="card-header">--%>
<%--                    <h5>Today's Appointments</h5>--%>
<%--                </div>--%>
<%--                <div class="card-body">--%>
<%--                    <c:if test="${empty appointments}">--%>
<%--                        <div class="alert alert-info text-center">--%>
<%--                            <h5>No appointments scheduled for today</h5>--%>
<%--                            <p>You have a clear schedule today.</p>--%>
<%--                        </div>--%>
<%--                    </c:if>--%>

<%--                    <c:if test="${not empty appointments}">--%>
<%--                        <div class="table-responsive">--%>
<%--                            <table class="table table-striped">--%>
<%--                                <thead>--%>
<%--                                <tr>--%>
<%--                                    <th>Time</th>--%>
<%--                                    <th>Patient</th>--%>
<%--                                    <th>Contact</th>--%>
<%--                                    <th>Reason</th>--%>
<%--                                    <th>Status</th>--%>
<%--                                    <th>Actions</th>--%>
<%--                                </tr>--%>
<%--                                </thead>--%>
<%--                                <tbody>--%>
<%--                                <c:forEach var="appointment" items="${appointments}">--%>
<%--                                    <tr>--%>
<%--                                        <td>--%>
<%--                                            <strong>${appointment.appointmentDateTime.toLocalTime()}</strong><br>--%>
<%--                                            <small>${appointment.appointmentDateTime.toLocalDate()}</small>--%>
<%--                                        </td>--%>
<%--                                        <td>--%>
<%--                                            <strong>${appointment.patient.firstName} ${appointment.patient.lastName}</strong><br>--%>
<%--                                            <small class="text-muted">ID: ${appointment.patient.id}</small>--%>
<%--                                        </td>--%>
<%--                                        <td>${appointment.patient.contactNumber}</td>--%>
<%--                                        <td>${appointment.reason}</td>--%>
<%--                                        <td>--%>
<%--                                                <span class="badge--%>
<%--                                                    <c:choose>--%>
<%--                                                        <c:when test="${appointment.status == 'SCHEDULED'}">bg-primary</c:when>--%>
<%--                                                        <c:when test="${appointment.status == 'COMPLETED'}">bg-success</c:when>--%>
<%--                                                        <c:when test="${appointment.status == 'CANCELLED'}">bg-danger</c:when>--%>
<%--                                                        <c:when test="${appointment.status == 'IN_PROGRESS'}">bg-warning</c:when>--%>
<%--                                                        <c:otherwise>bg-secondary</c:otherwise>--%>
<%--                                                    </c:choose>">--%>
<%--                                                        ${appointment.status}--%>
<%--                                                </span>--%>
<%--                                        </td>--%>
<%--                                        <td>--%>
<%--                                            <div class="btn-group" role="group">--%>
<%--                                                <a href="/doctor/patient/${appointment.patient.id}"--%>
<%--                                                   class="btn btn-sm btn-info">View Patient</a>--%>

<%--                                                <c:if test="${appointment.status == 'SCHEDULED'}">--%>
<%--                                                    <form action="/appointments/update-status" method="post" class="d-inline">--%>
<%--                                                        <input type="hidden" name="appointmentId" value="${appointment.id}">--%>
<%--                                                        <input type="hidden" name="status" value="IN_PROGRESS">--%>
<%--                                                        <button type="submit" class="btn btn-sm btn-warning">Start</button>--%>
<%--                                                    </form>--%>
<%--                                                </c:if>--%>

<%--                                                <c:if test="${appointment.status == 'IN_PROGRESS'}">--%>
<%--                                                    <form action="/appointments/update-status" method="post" class="d-inline">--%>
<%--                                                        <input type="hidden" name="appointmentId" value="${appointment.id}">--%>
<%--                                                        <input type="hidden" name="status" value="COMPLETED">--%>
<%--                                                        <button type="submit" class="btn btn-sm btn-success">Complete</button>--%>
<%--                                                    </form>--%>
<%--                                                </c:if>--%>
<%--                                            </div>--%>
<%--                                        </td>--%>
<%--                                    </tr>--%>
<%--                                </c:forEach>--%>
<%--                                </tbody>--%>
<%--                            </table>--%>
<%--                        </div>--%>
<%--                    </c:if>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>

<%--    <!-- Appointment Statistics -->--%>
<%--    <div class="row mt-4">--%>
<%--        <div class="col-md-3">--%>
<%--            <div class="card text-center bg-primary text-white">--%>
<%--                <div class="card-body">--%>
<%--                    <h5>Scheduled</h5>--%>
<%--                    <h3>${appointments.stream().filter(a -> a.status == 'SCHEDULED').count()}</h3>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col-md-3">--%>
<%--            <div class="card text-center bg-warning text-white">--%>
<%--                <div class="card-body">--%>
<%--                    <h5>In Progress</h5>--%>
<%--                    <h3>${appointments.stream().filter(a -> a.status == 'IN_PROGRESS').count()}</h3>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col-md-3">--%>
<%--            <div class="card text-center bg-success text-white">--%>
<%--                <div class="card-body">--%>
<%--                    <h5>Completed</h5>--%>
<%--                    <h3>${appointments.stream().filter(a -> a.status == 'COMPLETED').count()}</h3>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col-md-3">--%>
<%--            <div class="card text-center bg-danger text-white">--%>
<%--                <div class="card-body">--%>
<%--                    <h5>Cancelled</h5>--%>
<%--                    <h3>${appointments.stream().filter(a -> a.status == 'CANCELLED').count()}</h3>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>
<%--<!-- Footer -->--%>
<%--<footer class="py-5 text-white fade-in">--%>
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
<%--</body>--%>
<%--</html>--%>