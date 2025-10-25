<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Bed Management - HMS</title>
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
            <a class="nav-link active" href="/beds">Beds</a>
            <a class="nav-link" href="/admissions">Admissions</a>
            <a class="nav-link" href="/appointments">Appointments</a>
        </div>
        <div class="navbar-nav ms-auto">
            <a class="nav-link" href="/logout">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <h1>Bed Management</h1>

    <!-- Bed Status Summary -->
    <div class="row mb-4">
        <div class="col-md-3">
            <div class="card text-center bg-success text-white">
                <div class="card-body">
                    <h5 class="card-title">Available</h5>
                    <c:set var="availableBeds" value="${beds.stream().filter(b -> b.status == 'AVAILABLE').count()}"/>
                    <h3>${availableBeds}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center bg-danger text-white">
                <div class="card-body">
                    <h5 class="card-title">Occupied</h5>
                    <c:set var="occupiedBeds" value="${beds.stream().filter(b -> b.status == 'OCCUPIED').count()}"/>
                    <h3>${occupiedBeds}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center bg-warning text-white">
                <div class="card-body">
                    <h5 class="card-title">Maintenance</h5>
                    <c:set var="maintenanceBeds" value="${beds.stream().filter(b -> b.status == 'MAINTENANCE').count()}"/>
                    <h3>${maintenanceBeds}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center bg-info text-white">
                <div class="card-body">
                    <h5 class="card-title">Cleaning</h5>
                    <c:set var="cleaningBeds" value="${beds.stream().filter(b -> b.status == 'CLEANING').count()}"/>
                    <h3>${cleaningBeds}</h3>
                </div>
            </div>
        </div>
    </div>

    <!-- Add Bed Form -->
    <div class="card mb-4">
        <div class="card-header">
            <h5>Add New Bed</h5>
        </div>
        <div class="card-body">
            <form action="/beds/add" method="post">
                <div class="row">
                    <div class="col-md-4">
                        <select name="wardId" class="form-control mb-2" required>
                            <option value="">Select Ward</option>
                            <c:forEach var="ward" items="${wards}">
                                <option value="${ward.id}">${ward.wardNumber} - ${ward.wardType}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <input type="text" name="bedNumber" class="form-control mb-2" placeholder="Bed Number" required>
                    </div>
                    <div class="col-md-2">
                        <select name="status" class="form-control mb-2" required>
                            <option value="AVAILABLE">Available</option>
                            <option value="MAINTENANCE">Maintenance</option>
                            <option value="CLEANING">Cleaning</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-success w-100">Add Bed</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Beds List -->
    <div class="card">
        <div class="card-header d-flex justify-content-between align-items-center">
            <h5>All Beds</h5>
            <div>
                <a href="/beds/status/AVAILABLE" class="btn btn-sm btn-success me-1">Available</a>
                <a href="/beds/status/OCCUPIED" class="btn btn-sm btn-danger me-1">Occupied</a>
                <a href="/beds/status/MAINTENANCE" class="btn btn-sm btn-warning me-1">Maintenance</a>
                <a href="/beds/status/CLEANING" class="btn btn-sm btn-info">Cleaning</a>
            </div>
        </div>
        <div class="card-body">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Bed Number</th>
                    <th>Ward</th>
                    <th>Status</th>
                    <th>Patient</th>
                    <th>Admission Date</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="bed" items="${beds}">
                    <tr>
                        <td>${bed.id}</td>
                        <td><strong>${bed.bedNumber}</strong></td>
                        <td>
                                ${bed.ward.wardNumber}
                            <small class="text-muted">(${bed.ward.wardType})</small>
                        </td>
                        <td>
                            <span class="badge
                                <c:choose>
                                    <c:when test="${bed.status == 'AVAILABLE'}">bg-success</c:when>
                                    <c:when test="${bed.status == 'OCCUPIED'}">bg-danger</c:when>
                                    <c:when test="${bed.status == 'MAINTENANCE'}">bg-warning</c:when>
                                    <c:when test="${bed.status == 'CLEANING'}">bg-info</c:when>
                                    <c:otherwise>bg-secondary</c:otherwise>
                                </c:choose>">
                                    ${bed.status}
                            </span>
                        </td>
                        <td>
                            <c:if test="${bed.patient != null}">
                                ${bed.patient.firstName} ${bed.patient.lastName}
                            </c:if>
                            <c:if test="${bed.patient == null}">
                                <span class="text-muted">-</span>
                            </c:if>
                        </td>
                        <td>
                            <c:if test="${bed.admissionDate != null}">
                                <small>${bed.admissionDate}</small>
                            </c:if>
                            <c:if test="${bed.admissionDate == null}">
                                <span class="text-muted">-</span>
                            </c:if>
                        </td>
                        <td>
                            <div class="btn-group" role="group">
                                <c:if test="${bed.status == 'AVAILABLE'}">
                                    <a href="/admissions/admit?bedId=${bed.id}" class="btn btn-sm btn-primary">Admit Patient</a>
                                </c:if>
                                <c:if test="${bed.status == 'OCCUPIED'}">
                                    <a href="/beds/discharge/${bed.id}" class="btn btn-sm btn-success"
                                       onclick="return confirm('Discharge patient from ${bed.bedNumber}?')">Discharge</a>
                                </c:if>
                                <a href="/beds/ward/${bed.ward.id}" class="btn btn-sm btn-info">View Ward</a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>