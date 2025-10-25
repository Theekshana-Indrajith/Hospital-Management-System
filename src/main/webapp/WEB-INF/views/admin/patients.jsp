<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <title>Patient Management - HMS</title>--%>
<%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">--%>
<%--    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">--%>
<%--    <style>--%>
<%--        .bg-pink {--%>
<%--            background-color: #e83e8c !important;--%>
<%--        }--%>
<%--        .btn-primary {--%>
<%--            background-color: #0d6efd;--%>
<%--            border-color: #0d6efd;--%>
<%--        }--%>
<%--        .btn-primary:hover {--%>
<%--            background-color: #0b5ed7;--%>
<%--            border-color: #0a58ca;--%>
<%--        }--%>
<%--    </style>--%>
<%--</head>--%>
<%--<body>--%>
<%--<nav class="navbar navbar-expand-lg navbar-dark bg-danger">--%>
<%--    <div class="container">--%>
<%--        <a class="navbar-brand" href="/">🏥 HMS</a>--%>
<%--        <div class="navbar-nav">--%>
<%--            <a class="nav-link" href="/admin/dashboard">Dashboard</a>--%>
<%--            <a class="nav-link" href="/admin/users">User Management</a>--%>
<%--            <a class="nav-link" href="/admin/doctors">Doctor Management</a>--%>
<%--            <a class="nav-link active" href="/admin/patients">Patient Management</a>--%>
<%--            <a class="nav-link" href="/medical-staff/dashboard">Staff & Departments</a>--%>
<%--            <a class="nav-link" href="/admin/reports">Reports</a>--%>
<%--            <a class="nav-link" href="/admin/settings">Settings</a>--%>
<%--        </div>--%>
<%--        <div class="navbar-nav ms-auto">--%>
<%--            <span class="navbar-text">Welcome, Administrator!</span>--%>
<%--            <a class="nav-link" href="/logout">Logout</a>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</nav>--%>

<%--<div class="container mt-4">--%>
<%--    <div class="d-flex justify-content-between align-items-center mb-4">--%>
<%--        <h1><i class="fas fa-procedures me-2"></i>Patient Management</h1>--%>
<%--        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addPatientModal">--%>
<%--            <i class="fas fa-plus me-1"></i>Add New Patient--%>
<%--        </button>--%>
<%--    </div>--%>

<%--    <!-- Success/Error Messages -->--%>
<%--    <c:if test="${not empty param.success}">--%>
<%--        <div class="alert alert-success alert-dismissible fade show">--%>
<%--            <strong>Success!</strong> ${param.success}--%>
<%--            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>--%>
<%--        </div>--%>
<%--    </c:if>--%>

<%--    <c:if test="${not empty param.error}">--%>
<%--        <div class="alert alert-danger alert-dismissible fade show">--%>
<%--            <strong>Error!</strong> ${param.error}--%>
<%--            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>--%>
<%--        </div>--%>
<%--    </c:if>--%>

<%--    <!-- Patient Statistics -->--%>
<%--    <div class="row mb-4">--%>
<%--        <div class="col-md-3">--%>
<%--            <div class="card text-center">--%>
<%--                <div class="card-body">--%>
<%--                    <h5 class="card-title">Total Patients</h5>--%>
<%--                    <h3 class="text-primary">${patients.size()}</h3>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col-md-3">--%>
<%--            <div class="card text-center">--%>
<%--                <div class="card-body">--%>
<%--                    <h5 class="card-title">With Login</h5>--%>
<%--                    <h3 class="text-success">--%>
<%--                        <c:set var="patientsWithLogin" value="0"/>--%>
<%--                        <c:forEach var="patient" items="${patients}">--%>
<%--                            <c:if test="${not empty patient.email}">--%>
<%--                                <c:set var="patientsWithLogin" value="${patientsWithLogin + 1}"/>--%>
<%--                            </c:if>--%>
<%--                        </c:forEach>--%>
<%--                        ${patientsWithLogin}--%>
<%--                    </h3>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col-md-3">--%>
<%--            <div class="card text-center">--%>
<%--                <div class="card-body">--%>
<%--                    <h5 class="card-title">Male Patients</h5>--%>
<%--                    <h3 class="text-info">--%>
<%--                        <c:set var="malePatients" value="${patients.stream().filter(p -> p.gender == 'Male').count()}"/>--%>
<%--                        ${malePatients}--%>
<%--                    </h3>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col-md-3">--%>
<%--            <div class="card text-center">--%>
<%--                <div class="card-body">--%>
<%--                    <h5 class="card-title">Female Patients</h5>--%>
<%--                    <h3 class="text-pink">--%>
<%--                        <c:set var="femalePatients" value="${patients.stream().filter(p -> p.gender == 'Female').count()}"/>--%>
<%--                        ${femalePatients}--%>
<%--                    </h3>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>

<%--    <!-- Patients Table -->--%>
<%--    <div class="card">--%>
<%--        <div class="card-header">--%>
<%--            <h5 class="mb-0"><i class="fas fa-list me-2"></i>All Patients</h5>--%>
<%--        </div>--%>
<%--        <div class="card-body">--%>
<%--            <div class="table-responsive">--%>
<%--                <table class="table table-striped table-hover">--%>
<%--                    <thead class="table-dark">--%>
<%--                    <tr>--%>
<%--                        <th>ID</th>--%>
<%--                        <th>Patient Name</th>--%>
<%--                        <th>Gender</th>--%>
<%--                        <th>Date of Birth</th>--%>
<%--                        <th>Contact</th>--%>
<%--                        <th>Email</th>--%>
<%--                        <th>Address</th>--%>
<%--                        <th>Login Account</th>--%>
<%--                        <th>Actions</th>--%>
<%--                    </tr>--%>
<%--                    </thead>--%>
<%--                    <tbody>--%>
<%--                    <c:forEach var="patient" items="${patients}">--%>
<%--                        <tr>--%>
<%--                            <td>${patient.id}</td>--%>
<%--                            <td>--%>
<%--                                <strong>${patient.firstName} ${patient.lastName}</strong>--%>
<%--                            </td>--%>
<%--                            <td>--%>
<%--                                <span class="badge--%>
<%--                                    <c:choose>--%>
<%--                                        <c:when test="${patient.gender == 'Male'}">bg-primary</c:when>--%>
<%--                                        <c:when test="${patient.gender == 'Female'}">bg-pink</c:when>--%>
<%--                                        <c:otherwise>bg-secondary</c:otherwise>--%>
<%--                                    </c:choose>">--%>
<%--                                        ${patient.gender}--%>
<%--                                </span>--%>
<%--                            </td>--%>
<%--                            <td>${patient.dateOfBirth}</td>--%>
<%--                            <td>${patient.contactNumber}</td>--%>
<%--                            <td>${patient.email}</td>--%>
<%--                            <td>--%>
<%--                                <small class="text-muted">${patient.address}</small>--%>
<%--                            </td>--%>
<%--                            <td>--%>
<%--                                <c:choose>--%>
<%--                                    <c:when test="${not empty patient.email}">--%>
<%--                                        <span class="badge bg-success">Yes</span>--%>
<%--                                    </c:when>--%>
<%--                                    <c:otherwise>--%>
<%--                                        <span class="badge bg-secondary">No</span>--%>
<%--                                    </c:otherwise>--%>
<%--                                </c:choose>--%>
<%--                            </td>--%>
<%--                            <td>--%>
<%--                                <div class="btn-group btn-group-sm">--%>
<%--                                    <a href="/patient/profile?id=${patient.id}" class="btn btn-outline-primary">--%>
<%--                                        <i class="fas fa-eye"></i> View--%>
<%--                                    </a>--%>
<%--                                    <button class="btn btn-outline-warning"--%>
<%--                                            onclick="editPatient(${patient.id})">--%>
<%--                                        <i class="fas fa-edit"></i> Edit--%>
<%--                                    </button>--%>
<%--                                    <button class="btn btn-outline-danger"--%>
<%--                                            onclick="deletePatient(${patient.id}, '${patient.firstName} ${patient.lastName}')">--%>
<%--                                        <i class="fas fa-trash"></i> Delete--%>
<%--                                    </button>--%>
<%--                                    <a href="/admissions/admit?patientId=${patient.id}"--%>
<%--                                       class="btn btn-outline-success">--%>
<%--                                        <i class="fas fa-hospital"></i> Admit--%>
<%--                                    </a>--%>
<%--                                </div>--%>
<%--                            </td>--%>
<%--                        </tr>--%>
<%--                    </c:forEach>--%>
<%--                    <c:if test="${empty patients}">--%>
<%--                        <tr>--%>
<%--                            <td colspan="9" class="text-center text-muted py-4">--%>
<%--                                <i class="fas fa-procedures fa-2x mb-3"></i>--%>
<%--                                <p>No patients found. Click "Add New Patient" to get started.</p>--%>
<%--                            </td>--%>
<%--                        </tr>--%>
<%--                    </c:if>--%>
<%--                    </tbody>--%>
<%--                </table>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>

<%--<!-- Add Patient Modal -->--%>
<%--<div class="modal fade" id="addPatientModal" tabindex="-1" aria-labelledby="addPatientModalLabel" aria-hidden="true">--%>
<%--    <div class="modal-dialog modal-lg">--%>
<%--        <div class="modal-content">--%>
<%--            <div class="modal-header bg-primary text-white">--%>
<%--                <h5 class="modal-title" id="addPatientModalLabel">Add New Patient</h5>--%>
<%--                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>--%>
<%--            </div>--%>
<%--            <form action="/admin/patients/create" method="post">--%>
<%--                <div class="modal-body">--%>
<%--                    <div class="row">--%>
<%--                        <div class="col-md-6">--%>
<%--                            <div class="mb-3">--%>
<%--                                <label class="form-label">First Name *</label>--%>
<%--                                <input type="text" class="form-control" name="firstName" required--%>
<%--                                       placeholder="First Name">--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="col-md-6">--%>
<%--                            <div class="mb-3">--%>
<%--                                <label class="form-label">Last Name *</label>--%>
<%--                                <input type="text" class="form-control" name="lastName" required--%>
<%--                                       placeholder="Last Name">--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="row">--%>
<%--                        <div class="col-md-6">--%>
<%--                            <div class="mb-3">--%>
<%--                                <label class="form-label">Date of Birth</label>--%>
<%--                                <input type="date" class="form-control" name="dateOfBirth">--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="col-md-6">--%>
<%--                            <div class="mb-3">--%>
<%--                                <label class="form-label">Gender</label>--%>
<%--                                <select class="form-select" name="gender">--%>
<%--                                    <option value="">Select Gender</option>--%>
<%--                                    <option value="Male">Male</option>--%>
<%--                                    <option value="Female">Female</option>--%>
<%--                                    <option value="Other">Other</option>--%>
<%--                                </select>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="row">--%>
<%--                        <div class="col-md-6">--%>
<%--                            <div class="mb-3">--%>
<%--                                <label class="form-label">Contact Number</label>--%>
<%--                                <input type="tel" class="form-control" name="contactNumber"--%>
<%--                                       placeholder="+94 XX XXX XXXX">--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="col-md-6">--%>
<%--                            <div class="mb-3">--%>
<%--                                <label class="form-label">Email</label>--%>
<%--                                <input type="email" class="form-control" name="email"--%>
<%--                                       placeholder="patient@email.com">--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="mb-3">--%>
<%--                        <label class="form-label">Address</label>--%>
<%--                        <textarea class="form-control" name="address" rows="3" placeholder="Full address"></textarea>--%>
<%--                    </div>--%>

<%--                    <!-- User Account Creation -->--%>
<%--                    <div class="mb-3">--%>
<%--                        <div class="form-check form-switch">--%>
<%--                            <input class="form-check-input" type="checkbox" name="createUserAccount"--%>
<%--                                   id="createUserAccount" onchange="togglePatientUserFields()">--%>
<%--                            <label class="form-check-label" for="createUserAccount">--%>
<%--                                <strong>Create user account for patient portal access</strong>--%>
<%--                            </label>--%>
<%--                        </div>--%>
<%--                    </div>--%>

<%--                    <!-- User Account Fields (Hidden by default) -->--%>
<%--                    <div id="patientUserAccountFields" style="display: none;">--%>
<%--                        <hr>--%>
<%--                        <h6><i class="fas fa-user me-2"></i>Patient Login Account Details</h6>--%>
<%--                        <div class="row">--%>
<%--                            <div class="col-md-6">--%>
<%--                                <div class="mb-3">--%>
<%--                                    <label class="form-label">Username *</label>--%>
<%--                                    <input type="text" class="form-control" name="username"--%>
<%--                                           placeholder="e.g., johnpatient, sarahpatient">--%>
<%--                                    <div class="form-text">This will be used for patient login</div>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                            <div class="col-md-6">--%>
<%--                                <div class="mb-3">--%>
<%--                                    <label class="form-label">Password</label>--%>
<%--                                    <input type="password" class="form-control" name="password"--%>
<%--                                           placeholder="Enter password (optional)">--%>
<%--                                    <div class="form-text">Leave blank for default: patient123</div>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="modal-footer">--%>
<%--                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>--%>
<%--                    <button type="submit" class="btn btn-primary">Add Patient</button>--%>
<%--                </div>--%>
<%--            </form>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>
<%--<!-- Footer -->--%>
<%--<footer class="py-5 text-white">--%>
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
<%--<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>--%>
<%--<script>--%>
<%--    // Function to toggle patient user account fields--%>
<%--    function togglePatientUserFields() {--%>
<%--        const createUserCheckbox = document.getElementById('createUserAccount');--%>
<%--        const userAccountFields = document.getElementById('patientUserAccountFields');--%>

<%--        if (createUserCheckbox.checked) {--%>
<%--            userAccountFields.style.display = 'block';--%>
<%--            // Auto-generate username from email--%>
<%--            const emailInput = document.querySelector('input[name="email"]');--%>
<%--            const usernameInput = document.querySelector('input[name="username"]');--%>
<%--            if (emailInput && emailInput.value && (!usernameInput.value || usernameInput.value === '')) {--%>
<%--                const email = emailInput.value;--%>
<%--                const username = email.split('@')[0].replace(/[^a-zA-Z0-9]/g, '');--%>
<%--                usernameInput.value = username;--%>
<%--            }--%>
<%--        } else {--%>
<%--            userAccountFields.style.display = 'none';--%>
<%--        }--%>
<%--    }--%>

<%--    // Auto-generate username when email changes--%>
<%--    document.addEventListener('DOMContentLoaded', function() {--%>
<%--        const emailInput = document.querySelector('input[name="email"]');--%>
<%--        if (emailInput) {--%>
<%--            emailInput.addEventListener('blur', function() {--%>
<%--                const createUserCheckbox = document.getElementById('createUserAccount');--%>
<%--                const usernameInput = document.querySelector('input[name="username"]');--%>
<%--                if (createUserCheckbox.checked && emailInput.value && (!usernameInput.value || usernameInput.value === '')) {--%>
<%--                    const email = emailInput.value;--%>
<%--                    const username = email.split('@')[0].replace(/[^a-zA-Z0-9]/g, '');--%>
<%--                    usernameInput.value = username;--%>
<%--                }--%>
<%--            });--%>
<%--        }--%>
<%--    });--%>

<%--    function editPatient(patientId) {--%>
<%--        alert('Edit patient functionality for ID: ' + patientId);--%>
<%--        // In real implementation, open edit modal with patient data--%>
<%--    }--%>

<%--    function deletePatient(patientId, patientName) {--%>
<%--        if (confirm('Are you sure you want to delete ' + patientName + '?\n\nThis will also remove their login account if exists.')) {--%>
<%--            // Create a form and submit it to delete the patient--%>
<%--            const form = document.createElement('form');--%>
<%--            form.method = 'POST';--%>
<%--            form.action = '/admin/patients/delete/' + patientId;--%>

<%--            // Add CSRF token if needed--%>
<%--            const csrfInput = document.createElement('input');--%>
<%--            csrfInput.type = 'hidden';--%>
<%--            csrfInput.name = '_csrf';--%>
<%--            csrfInput.value = document.querySelector('input[name="_csrf"]')?.value || '';--%>
<%--            form.appendChild(csrfInput);--%>

<%--            document.body.appendChild(form);--%>
<%--            form.submit();--%>
<%--        }--%>
<%--    }--%>

<%--    // Auto-hide alerts after 5 seconds--%>
<%--    setTimeout(() => {--%>
<%--        const alerts = document.querySelectorAll('.alert');--%>
<%--        alerts.forEach(alert => {--%>
<%--            const bsAlert = new bootstrap.Alert(alert);--%>
<%--            bsAlert.close();--%>
<%--        });--%>
<%--    }, 5000);--%>
<%--</script>--%>
<%--</body>--%>
<%--</html>--%>