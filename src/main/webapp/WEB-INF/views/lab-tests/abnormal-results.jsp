<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Abnormal Results - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-danger">
    <div class="container">
        <a class="navbar-brand" >🏥 HMS</a>
        <div class="navbar-nav">
            <a class="nav-link" href="/lab-tests">All Tests</a>
            <a class="nav-link active" href="/lab-tests/abnormal">Abnormal Results</a>
        </div>
        <div class="navbar-nav ms-auto">
            <span class="navbar-text">${username}</span>
            <a class="nav-link" href="/logout">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center">
        <h1><i class="fas fa-exclamation-triangle me-2"></i>${pageTitle}</h1>
        <div class="alert alert-warning mb-0">
            <i class="fas fa-bell me-2"></i>Requires Medical Attention
        </div>
    </div>

    <c:choose>
        <c:when test="${not empty tests}">
            <div class="card mt-4">
                <div class="card-header bg-danger text-white">
                    <h5 class="mb-0"><i class="fas fa-list me-2"></i>Abnormal Test Results</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead class="table-dark">
                            <tr>
                                <th>Test ID</th>
                                <th>Patient</th>
                                <th>Test Name</th>
                                <th>Type</th>
                                <th>Requesting Doctor</th>
                                <th>Completed Date</th>
                                <th>Findings</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="test" items="${tests}">
                                <tr class="table-warning">
                                    <td>#${test.id}</td>
                                    <td>
                                        <strong>${test.patient.firstName} ${test.patient.lastName}</strong>
                                        <br><small class="text-muted">ID: ${test.patient.id}</small>
                                    </td>
                                    <td>${test.testName}</td>
                                    <td>
                                        <span class="badge bg-info">${test.testType}</span>
                                    </td>
                                    <td>${test.doctor.name}</td>
                                    <td>${test.completedDate}</td>
                                    <td>
                                            <span class="text-danger">
                                                <i class="fas fa-exclamation-triangle me-1"></i>
                                                ${test.findings}
                                            </span>
                                    </td>
                                    <td>
                                        <a href="/lab-tests/details/${test.id}" class="btn btn-info btn-sm">
                                            <i class="fas fa-eye me-1"></i>View
                                        </a>
                                        <c:if test="${role == 'DOCTOR'}">
                                            <a href="/doctor/patient/${test.patient.id}" class="btn btn-warning btn-sm">
                                                <i class="fas fa-user-md me-1"></i>Patient
                                            </a>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="card mt-4">
                <div class="card-body text-center py-5">
                    <i class="fas fa-check-circle fa-4x text-success mb-3"></i>
                    <h3>No Abnormal Results</h3>
                    <p class="text-muted">All test results are within normal ranges.</p>
                    <a href="/lab-tests" class="btn btn-primary">View All Tests</a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>