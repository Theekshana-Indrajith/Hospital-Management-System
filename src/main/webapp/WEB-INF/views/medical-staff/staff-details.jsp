<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Staff Details - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand">🏥 HMS</a>
        <div class="navbar-nav">
            <a class="nav-link" href="/medical-staff/dashboard">Dashboard</a>
            <a class="nav-link" href="/medical-staff/departments">Departments</a>
            <a class="nav-link" href="/medical-staff/doctors">Doctors</a>
            <a class="nav-link active" href="/medical-staff/staff">Staff</a>
            <a class="nav-link" href="/medical-staff/shifts">Shifts</a>
            <a class="nav-link" href="/admin/dashboard">Admin Dashboard</a>
        </div>
        <div class="navbar-nav ms-auto">
            <span class="navbar-text">Welcome, Administrator!</span>
            <a class="nav-link" href="/logout">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center">
        <h1><i class="fas fa-user me-2"></i>Staff Details</h1>
        <div>
            <a href="/medical-staff/staff" class="btn btn-secondary">
                <i class="fas fa-arrow-left me-1"></i>Back to Staff
            </a>
        </div>
    </div>

    <!-- Staff Information -->
    <div class="row mt-4">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">Personal Information</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>Full Name:</strong> ${staff.firstName} ${staff.lastName}</p>
                            <p><strong>Staff Type:</strong>
                                <span class="badge
                                    ${staff.staffType == 'NURSE' ? 'bg-info' :
                                      staff.staffType == 'RECEPTIONIST' ? 'bg-warning' :
                                      staff.staffType == 'LAB_TECH' ? 'bg-success' : 'bg-secondary'}">
                                    ${staff.staffType}
                                </span>
                            </p>
                            <p><strong>Department:</strong>
                                <c:choose>
                                    <c:when test="${staff.department != null}">
                                        <span class="badge bg-primary">${staff.department.name}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">No Department Assigned</span>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Date of Birth:</strong> ${staff.dateOfBirth}</p>
                            <p><strong>Gender:</strong> ${staff.gender}</p>
                            <p><strong>Status:</strong>
                                <span class="badge ${staff.isActive ? 'bg-success' : 'bg-danger'}">
                                    ${staff.isActive ? 'Active' : 'Inactive'}
                                </span>
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Contact Information -->
            <div class="card mt-3">
                <div class="card-header">
                    <h5 class="mb-0">Contact Information</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>Contact Number:</strong> ${staff.contactNumber}</p>
                            <p><strong>Email:</strong> ${staff.email}</p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Qualification:</strong> ${staff.qualification}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
<%--           --%>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>