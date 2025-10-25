<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Admissions Management - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-info">
    <div class="container">
        <a class="navbar-brand" href="">🏥 HMS</a>
        <div class="navbar-nav">
            <a class="nav-link" href="/staff/dashboard">Dashboard</a>
            <a class="nav-link" href="/staff/appointments">Appointments</a>
            <a class="nav-link active" href="/staff/admissions">Admissions</a>
            <a class="nav-link" href="/staff/wards">Wards</a>
            <a class="nav-link" href="/staff/patients">Patients</a>
            <a class="nav-link" href="/staff/prescriptions">Prescriptions</a>
        </div>
        <div class="navbar-nav ms-auto">
            <span class="navbar-text">Welcome, ${username}!</span>
            <a class="nav-link" href="/logout">Logout</a>
        </div>
    </div>
</nav>

<!-- Success/Error Messages -->
<c:if test="${not empty param.success}">
    <div class="alert alert-success alert-dismissible fade show mt-3">
        <strong>Success!</strong> ${param.success}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>
<c:if test="${not empty param.error}">
    <div class="alert alert-danger alert-dismissible fade show mt-3">
        <strong>Error!</strong> ${param.error}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<div class="container mt-4">
    <h1><i class="fas fa-hospital-user me-2"></i>Admissions Management</h1>

    <!-- Admission Statistics -->
    <div class="row mt-4">
        <div class="col-md-3">
            <div class="card text-center bg-primary text-white">
                <div class="card-body">
                    <h5>Current Admissions</h5>
                    <h3>8</h3>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center bg-success text-white">
                <div class="card-body">
                    <h5>Available Beds</h5>
                    <h3>12</h3>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center bg-warning text-white">
                <div class="card-body">
                    <h5>Pending Discharge</h5>
                    <h3>3</h3>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center bg-info text-white">
                <div class="card-body">
                    <h5>Today's Admissions</h5>
                    <h3>2</h3>
                </div>
            </div>
        </div>
    </div>

    <!-- Replace the quick admission form with this REAL form -->
    <div class="card mt-4">
        <div class="card-header">
            <h5>Admit Patient</h5>
        </div>
        <div class="card-body">
            <form action="/staff/admissions/admit" method="post">
                <div class="row">
                    <div class="col-md-4">
                        <div class="mb-3">
                            <label class="form-label">Select Patient *</label>
                            <select class="form-control" name="patientId" required>
                                <option value="">Choose Patient</option>
                                <c:forEach var="patient" items="${patients}">
                                    <option value="${patient.id}">${patient.firstName} ${patient.lastName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="mb-3">
                            <label class="form-label">Select Ward *</label>
                            <select class="form-control" name="wardId" required>
                                <option value="">Choose Ward</option>
                                <c:forEach var="ward" items="${wards}">
                                    <option value="${ward.id}">${ward.wardNumber} (${ward.wardType}) - ${ward.availableBeds} beds available</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="mb-3">
                            <label class="form-label">Admission Reason *</label>
                            <input type="text" class="form-control" name="reason" placeholder="Enter admission reason" required>
                        </div>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary">Admit Patient</button>
            </form>
        </div>
    </div>

    <!-- Update admissions table to show REAL data -->
    <tbody>
    <c:forEach var="admission" items="${currentAdmissions}">
        <tr>
            <td><strong>${admission.patient.firstName} ${admission.patient.lastName}</strong><br><small>ID: P${admission.patient.id}</small></td>
            <td>
                <c:if test="${admission.admissionDate != null}">
                    ${admission.admissionDate.toLocalDate()}
                </c:if>
            </td>
            <td>${admission.ward.wardNumber} (${admission.ward.wardType})</td>
            <td>${admission.bed.bedNumber}</td>
            <td>${admission.reason}</td>
            <td><span class="badge bg-success">${admission.status}</span></td>
            <td>
                <form action="/staff/admissions/discharge" method="post" class="d-inline">
                    <input type="hidden" name="admissionId" value="${admission.id}">
                    <button type="submit" class="btn btn-sm btn-outline-success">Discharge</button>
                </form>
            </td>
        </tr>
    </c:forEach>
    <c:if test="${empty currentAdmissions}">
        <tr>
            <td colspan="7" class="text-center text-muted">No current admissions found</td>
        </tr>
    </c:if>
    </tbody>

    <!-- Quick Admission Form -->
    <div class="card mt-4">
        <div class="card-header">
            <h5>Quick Patient Admission</h5>
        </div>
        <div class="card-body">
            <form>
                <div class="row">
                    <div class="col-md-4">
                        <div class="mb-3">
                            <label class="form-label">Patient ID/Name</label>
                            <input type="text" class="form-control" placeholder="Search patient...">
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="mb-3">
                            <label class="form-label">Select Ward</label>
                            <select class="form-control">
                                <option value="">Choose Ward</option>
                                <option value="1">W-101 (General Ward)</option>
                                <option value="2">W-201 (ICU)</option>
                                <option value="3">W-301 (Pediatric)</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="mb-3">
                            <label class="form-label">Available Beds</label>
                            <select class="form-control">
                                <option value="">Select Bed</option>
                                <option value="1">W-101-B3</option>
                                <option value="2">W-101-B7</option>
                                <option value="3">W-101-B12</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="mb-3">
                    <label class="form-label">Admission Reason</label>
                    <textarea class="form-control" rows="2" placeholder="Enter admission reason"></textarea>
                </div>
                <button type="submit" class="btn btn-primary">Admit Patient</button>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>