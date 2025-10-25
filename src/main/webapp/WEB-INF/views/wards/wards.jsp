<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Ward Management - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="">🏥 HMS</a>
        <div class="navbar-nav">
            <a class="nav-link" href="/">Home</a>
            <a class="nav-link" href="/patients">Patients</a>
            <a class="nav-link active" href="/wards">Wards</a>
            <a class="nav-link" href="/beds">Beds</a>
            <a class="nav-link" href="/admissions">Admissions</a>
            <a class="nav-link" href="/appointments">Appointments</a>
        </div>
        <div class="navbar-nav ms-auto">
            <span class="navbar-text">Welcome, ${username}!</span>
            <a class="nav-link" href="/logout">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <h1><i class="fas fa-procedures me-2"></i>Ward Management</h1>

    <!-- Success/Error Messages -->
    <c:if test="${not empty param.success}">
        <div class="alert alert-success alert-dismissible fade show">
            <strong>Success!</strong> ${param.success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:if test="${not empty param.error}">
        <div class="alert alert-danger alert-dismissible fade show">
            <strong>Error!</strong> ${param.error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Ward Statistics -->
    <div class="row mb-4">
        <div class="col-md-3">
            <div class="card text-center">
                <div class="card-body">
                    <h5 class="card-title">Total Wards</h5>
                    <h3 class="text-primary">${wards.size()}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center">
                <div class="card-body">
                    <h5 class="card-title">Total Beds</h5>
                    <c:set var="totalBeds" value="0"/>
                    <c:forEach var="ward" items="${wards}">
                        <c:set var="totalBeds" value="${totalBeds + ward.totalBeds}"/>
                    </c:forEach>
                    <h3 class="text-success">${totalBeds}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center">
                <div class="card-body">
                    <h5 class="card-title">Available Beds</h5>
                    <c:set var="availableBeds" value="0"/>
                    <c:forEach var="ward" items="${wards}">
                        <c:set var="availableBeds" value="${availableBeds + ward.availableBeds}"/>
                    </c:forEach>
                    <h3 class="text-info">${availableBeds}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center">
                <div class="card-body">
                    <h5 class="card-title">Occupancy Rate</h5>
                    <c:set var="occupancyRate" value="${totalBeds > 0 ? (totalBeds - availableBeds) / totalBeds * 100 : 0}"/>
                    <h3 class="text-warning"><fmt:formatNumber value="${occupancyRate}" pattern="0.0"/>%</h3>
                </div>
            </div>
        </div>
    </div>

    <!-- Add Ward Form -->
    <div class="card mb-4">
        <div class="card-header bg-success text-white">
            <h5 class="mb-0"><i class="fas fa-plus-circle me-2"></i>Add New Ward</h5>
        </div>
        <div class="card-body">
            <form action="/wards/add" method="post">
                <div class="row g-3">
                    <div class="col-md-2">
                        <label class="form-label">Ward Number</label>
                        <input type="text" name="wardNumber" class="form-control" placeholder="W-101" required>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">Ward Type</label>
                        <select name="wardType" class="form-select" required>
                            <option value="">Select Type</option>
                            <option value="GENERAL">General</option>
                            <option value="ICU">ICU</option>
                            <option value="PEDIATRIC">Pediatric</option>
                            <option value="SURGICAL">Surgical</option>
                            <option value="MATERNITY">Maternity</option>
                            <option value="CARDIAC">Cardiac</option>
                            <option value="NEUROLOGY">Neurology</option>
                            <option value="ONCOLOGY">Oncology</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">Department</label>
                        <select name="departmentId" class="form-select" required>
                            <option value="">Select Department</option>
                            <c:forEach var="dept" items="${departments}">
                                <option value="${dept.id}">${dept.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">Total Beds</label>
                        <input type="number" name="totalBeds" class="form-control" placeholder="20" min="1" required>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">Charge/Day (Rs.)</label>
                        <input type="number" step="0.01" name="chargePerDay" class="form-control" placeholder="150.00" min="0" required>
                    </div>
                    <div class="col-md-2 d-flex align-items-end">
                        <button type="submit" class="btn btn-success w-100">
                            <i class="fas fa-save me-1"></i>Add Ward
                        </button>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-md-12">
                        <label class="form-label">Description</label>
                        <textarea name="description" class="form-control" placeholder="Ward description and location..." rows="2"></textarea>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Wards List -->
    <div class="card">
        <div class="card-header d-flex justify-content-between align-items-center">
            <h5 class="mb-0"><i class="fas fa-list me-2"></i>Wards List</h5>
            <div>
                <a href="/wards/available" class="btn btn-info btn-sm me-2">
                    <i class="fas fa-bed me-1"></i>Available Wards
                </a>
                <a href="/medical-staff/shifts" class="btn btn-primary btn-sm">
                    <i class="fas fa-calendar-alt me-1"></i>Manage Shifts
                </a>
            </div>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Ward Number</th>
                        <th>Department</th>
                        <th>Type</th>
                        <th>Description</th>
                        <th>Total Beds</th>
                        <th>Available</th>
                        <th>Charge/Day</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="ward" items="${wards}">
                        <tr>
                            <td>${ward.id}</td>
                            <td><strong>${ward.wardNumber}</strong></td>
                            <td>
                                <span class="badge bg-secondary">${ward.department.name}</span>
                            </td>
                            <td>
                                <span class="badge
                                    <c:choose>
                                        <c:when test="${ward.wardType == 'ICU'}">bg-danger</c:when>
                                        <c:when test="${ward.wardType == 'GENERAL'}">bg-primary</c:when>
                                        <c:when test="${ward.wardType == 'PEDIATRIC'}">bg-info</c:when>
                                        <c:when test="${ward.wardType == 'SURGICAL'}">bg-warning</c:when>
                                        <c:when test="${ward.wardType == 'MATERNITY'}">bg-pink</c:when>
                                        <c:otherwise>bg-dark</c:otherwise>
                                    </c:choose>">
                                        ${ward.wardType}
                                </span>
                            </td>
                            <td>${ward.description}</td>
                            <td>${ward.totalBeds}</td>
                            <td>
                                <span class="badge ${ward.availableBeds > 0 ? 'bg-success' : 'bg-danger'}">
                                        ${ward.availableBeds}
                                </span>
                            </td>
                            <td>Rs. <fmt:formatNumber value="${ward.chargePerDay}" pattern="0.00"/></td>
                            <td>
                                <div class="btn-group btn-group-sm" role="group">
                                    <a href="/wards/edit/${ward.id}" class="btn btn-warning" title="Edit Ward">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a href="/beds/ward/${ward.id}" class="btn btn-info" title="View Beds">
                                        <i class="fas fa-bed"></i>
                                    </a>
                                    <a href="/medical-staff/shifts/ward/${ward.id}" class="btn btn-primary" title="Manage Shifts">
                                        <i class="fas fa-calendar"></i>
                                    </a>
                                    <a href="/wards/delete/${ward.id}" class="btn btn-danger"
                                       onclick="return confirm('Delete ward ${ward.wardNumber}? This will delete all associated beds and shifts!')"
                                       title="Delete Ward">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty wards}">
                        <tr>
                            <td colspan="9" class="text-center text-muted py-4">
                                <i class="fas fa-procedures fa-3x mb-3"></i>
                                <p>No wards found. <a href="/wards" class="btn btn-sm btn-success">Add the first ward</a></p>
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>