<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Patient Tests - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand">🏥 HMS</a>
        <div class="navbar-nav">
            <a class="nav-link" href="/lab-tests">All Tests</a>
            <a class="nav-link active" href="#">Patient Tests</a>
        </div>
        <div class="navbar-nav ms-auto">
            <span class="navbar-text">${username}</span>
            <a class="nav-link" href="/logout">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center">
        <h1><i class="fas fa-user me-2"></i>Laboratory Tests for ${patient.firstName} ${patient.lastName}</h1>
        <a href="/lab-tests" class="btn btn-secondary">
            <i class="fas fa-arrow-left me-1"></i>Back to All Tests
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
                    <strong>Gender:</strong> ${patient.gender}
                </div>
                <div class="col-md-3">
                    <strong>Date of Birth:</strong> ${patient.dateOfBirth}
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-md-6">
                    <strong>Contact:</strong> ${patient.contactNumber}
                </div>
                <div class="col-md-6">
                    <strong>Email:</strong> ${patient.email}
                </div>
            </div>
        </div>
    </div>

    <!-- Patient Tests -->
    <div class="card mt-4">
        <div class="card-header">
            <h5 class="mb-0"><i class="fas fa-vial me-2"></i>Laboratory Test History</h5>
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty tests}">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead class="table-dark">
                            <tr>
                                <th>Test ID</th>
                                <th>Test Name</th>
                                <th>Type</th>
                                <th>Priority</th>
                                <th>Status</th>
                                <th>Requested Date</th>
                                <th>Completed Date</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="test" items="${tests}">
                                <tr>
                                    <td>#${test.id}</td>
                                    <td>${test.testName}</td>
                                    <td>
                                        <span class="badge bg-info">${test.testType}</span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${test.priority == 'URGENT'}">
                                                <span class="badge bg-danger">URGENT</span>
                                            </c:when>
                                            <c:when test="${test.priority == 'STAT'}">
                                                <span class="badge bg-warning">STAT</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">NORMAL</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${test.status == 'REQUESTED'}">
                                                <span class="badge bg-warning">REQUESTED</span>
                                            </c:when>
                                            <c:when test="${test.status == 'IN_PROGRESS'}">
                                                <span class="badge bg-primary">IN PROGRESS</span>
                                            </c:when>
                                            <c:when test="${test.status == 'COMPLETED'}">
                                                <c:choose>
                                                    <c:when test="${test.isAbnormal}">
                                                        <span class="badge bg-danger">COMPLETED - ABNORMAL</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-success">COMPLETED - NORMAL</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">${test.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${test.requestedDate}</td>
                                    <td>
                                        <c:if test="${not empty test.completedDate}">
                                            ${test.completedDate}
                                        </c:if>
                                        <c:if test="${empty test.completedDate}">
                                            <span class="text-muted">-</span>
                                        </c:if>
                                    </td>
                                    <td>
                                        <a href="/lab-tests/details/${test.id}" class="btn btn-info btn-sm">
                                            <i class="fas fa-eye me-1"></i>View
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-4">
                        <i class="fas fa-vial fa-3x text-muted mb-3"></i>
                        <h4>No Laboratory Tests</h4>
                        <p class="text-muted">This patient doesn't have any laboratory tests yet.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>