<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <title>User Management - HMS</title>--%>
<%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">--%>
<%--    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">--%>
<%--</head>--%>
<%--<body>--%>
<%--<nav class="navbar navbar-expand-lg navbar-dark bg-danger">--%>
<%--    <div class="container">--%>
<%--        <a class="navbar-brand" href="/">🏥 HMS</a>--%>
<%--        <div class="navbar-nav">--%>
<%--            <a class="nav-link" href="/admin/dashboard">Dashboard</a>--%>
<%--            <a class="nav-link active" href="/admin/users">User Management</a>--%>
<%--            <a class="nav-link" href="/admin/doctors">Doctor Management</a>--%>
<%--            <a class="nav-link" href="/admin/patients">Patient Management</a>--%>
<%--            <a class="nav-link" href="/medical-staff/dashboard">Staff & Departments</a>--%>
<%--&lt;%&ndash;            <a class="nav-link" href="/wards">Wards</a>&ndash;%&gt;--%>
<%--&lt;%&ndash;            <a class="nav-link" href="/beds">Beds</a>&ndash;%&gt;--%>
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
<%--        <h1><i class="fas fa-users me-2"></i>User Management</h1>--%>
<%--        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">--%>
<%--            <i class="fas fa-plus me-1"></i>Add New User--%>
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

<%--    <!-- User Statistics -->--%>
<%--    <div class="row mb-4">--%>
<%--        <div class="col-md-3">--%>
<%--            <div class="card text-center">--%>
<%--                <div class="card-body">--%>
<%--                    <h5 class="card-title">Total Users</h5>--%>
<%--                    <h3 class="text-primary">${users.size()}</h3>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col-md-3">--%>
<%--            <div class="card text-center">--%>
<%--                <div class="card-body">--%>
<%--                    <h5 class="card-title">Admins</h5>--%>
<%--                    <h3 class="text-danger">--%>
<%--                        <c:set var="adminCount" value="${users.stream().filter(u -> u.role == 'ADMIN').count()}"/>--%>
<%--                        ${adminCount}--%>
<%--                    </h3>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col-md-3">--%>
<%--            <div class="card text-center">--%>
<%--                <div class="card-body">--%>
<%--                    <h5 class="card-title">Doctors</h5>--%>
<%--                    <h3 class="text-success">--%>
<%--                        <c:set var="doctorCount" value="${users.stream().filter(u -> u.role == 'DOCTOR').count()}"/>--%>
<%--                        ${doctorCount}--%>
<%--                    </h3>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col-md-3">--%>
<%--            <div class="card text-center">--%>
<%--                <div class="card-body">--%>
<%--                    <h5 class="card-title">Patients</h5>--%>
<%--                    <h3 class="text-info">--%>
<%--                        <c:set var="patientCount" value="${users.stream().filter(u -> u.role == 'PATIENT').count()}"/>--%>
<%--                        ${patientCount}--%>
<%--                    </h3>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>

<%--    <!-- Users Table -->--%>
<%--    <div class="card">--%>
<%--        <div class="card-header">--%>
<%--            <h5 class="mb-0"><i class="fas fa-list me-2"></i>All System Users</h5>--%>
<%--        </div>--%>
<%--        <div class="card-body">--%>
<%--            <div class="table-responsive">--%>
<%--                <table class="table table-striped table-hover">--%>
<%--                    <thead class="table-dark">--%>
<%--                    <tr>--%>
<%--                        <th>ID</th>--%>
<%--                        <th>Username</th>--%>
<%--                        <th>Email</th>--%>
<%--                        <th>Role</th>--%>
<%--                        <th>Profile ID</th>--%>
<%--                        <th>Status</th>--%>
<%--                        <th>Actions</th>--%>
<%--                    </tr>--%>
<%--                    </thead>--%>
<%--                    <tbody>--%>
<%--                    <c:forEach var="user" items="${users}">--%>
<%--                        <tr>--%>
<%--                            <td>${user.id}</td>--%>
<%--                            <td>--%>
<%--                                <strong>${user.username}</strong>--%>
<%--                                <c:if test="${user.username == 'admin'}">--%>
<%--                                    <span class="badge bg-warning ms-1">System</span>--%>
<%--                                </c:if>--%>
<%--                            </td>--%>
<%--                            <td>${user.email}</td>--%>
<%--                            <td>--%>
<%--                                    <span class="badge--%>
<%--                                        <c:choose>--%>
<%--                                            <c:when test="${user.role == 'ADMIN'}">bg-danger</c:when>--%>
<%--                                            <c:when test="${user.role == 'DOCTOR'}">bg-success</c:when>--%>
<%--                                            <c:when test="${user.role == 'STAFF'}">bg-info</c:when>--%>
<%--                                            <c:when test="${user.role == 'PATIENT'}">bg-primary</c:when>--%>
<%--                                            <c:otherwise>bg-secondary</c:otherwise>--%>
<%--                                        </c:choose>">--%>
<%--                                            ${user.role}--%>
<%--                                    </span>--%>
<%--                            </td>--%>
<%--                            <td>${user.profileId}</td>--%>
<%--                            <td>--%>
<%--                                <span class="badge bg-success">Active</span>--%>
<%--                            </td>--%>
<%--                            <td>--%>
<%--                                <div class="btn-group btn-group-sm">--%>
<%--                                    <button class="btn btn-outline-primary"--%>
<%--                                            onclick="editUser(${user.id}, '${user.username}', '${user.email}', '${user.role}')">--%>
<%--                                        <i class="fas fa-edit"></i>--%>
<%--                                    </button>--%>
<%--                                    <c:if test="${user.username != 'admin'}">--%>
<%--                                        <button class="btn btn-outline-danger"--%>
<%--                                                onclick="confirmDelete(${user.id}, '${user.username}')">--%>
<%--                                            <i class="fas fa-trash"></i>--%>
<%--                                        </button>--%>
<%--                                    </c:if>--%>
<%--                                    <button class="btn btn-outline-warning"--%>
<%--                                            onclick="resetPassword(${user.id}, '${user.username}')">--%>
<%--                                        <i class="fas fa-key"></i>--%>
<%--                                    </button>--%>
<%--                                </div>--%>
<%--                            </td>--%>
<%--                        </tr>--%>
<%--                    </c:forEach>--%>
<%--                    </tbody>--%>
<%--                </table>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>

<%--<!-- Add User Modal -->--%>
<%--<div class="modal fade" id="addUserModal" tabindex="-1">--%>
<%--    <div class="modal-dialog">--%>
<%--        <div class="modal-content">--%>
<%--            <div class="modal-header bg-primary text-white">--%>
<%--                <h5 class="modal-title">Add New User</h5>--%>
<%--                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>--%>
<%--            </div>--%>
<%--            <form action="/admin/users/create" method="post">--%>
<%--                <div class="modal-body">--%>
<%--                    <div class="mb-3">--%>
<%--                        <label class="form-label">Username</label>--%>
<%--                        <input type="text" class="form-control" name="username" required--%>
<%--                               placeholder="Enter username">--%>
<%--                    </div>--%>
<%--                    <div class="mb-3">--%>
<%--                        <label class="form-label">Email</label>--%>
<%--                        <input type="email" class="form-control" name="email" required--%>
<%--                               placeholder="Enter email">--%>
<%--                    </div>--%>
<%--                    <div class="mb-3">--%>
<%--                        <label class="form-label">Password</label>--%>
<%--                        <input type="password" class="form-control" name="password" required--%>
<%--                               placeholder="Enter password">--%>
<%--                    </div>--%>
<%--                    <div class="mb-3">--%>
<%--                        <label class="form-label">Role</label>--%>
<%--                        <select class="form-control" name="role" required>--%>
<%--                            <option value="">Select Role</option>--%>
<%--                            <option value="ADMIN">Administrator</option>--%>
<%--                            <option value="DOCTOR">Doctor</option>--%>
<%--                            <option value="STAFF">Staff</option>--%>
<%--                            <option value="PATIENT">Patient</option>--%>
<%--                        </select>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="modal-footer">--%>
<%--                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>--%>
<%--                    <button type="submit" class="btn btn-primary">Create User</button>--%>
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
<%--    function confirmDelete(userId, username) {--%>
<%--        if (confirm('Are you sure you want to delete user "' + username + '"?')) {--%>
<%--            // In real implementation, make AJAX call to delete user--%>
<%--            alert('Delete functionality would be implemented here for user ID: ' + userId);--%>
<%--        }--%>
<%--    }--%>

<%--    function editUser(id, username, email, role) {--%>
<%--        alert('Edit user: ' + username + '\nEmail: ' + email + '\nRole: ' + role);--%>
<%--        // In real implementation, open edit modal with pre-filled data--%>
<%--    }--%>

<%--    function resetPassword(userId, username) {--%>
<%--        const newPassword = prompt('Enter new password for ' + username + ':');--%>
<%--        if (newPassword) {--%>
<%--            // In real implementation, make AJAX call to reset password--%>
<%--            alert('Password reset functionality would be implemented here');--%>
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