<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <title>System Settings - HMS</title>--%>
<%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">--%>
<%--    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">--%>
<%--</head>--%>
<%--<body>--%>
<%--<nav class="navbar navbar-expand-lg navbar-dark bg-danger">--%>
<%--    <div class="container">--%>
<%--        <a class="navbar-brand" href="/">🏥 HMS</a>--%>
<%--        <div class="navbar-nav">--%>
<%--            <a class="nav-link" href="/admin/dashboard">Dashboard</a>--%>
<%--            <a class="nav-link" href="/admin/users">User Management</a>--%>
<%--            <a class="nav-link" href="/admin/doctors">Doctor Management</a>--%>
<%--            <a class="nav-link" href="/admin/patients">Patient Management</a>--%>
<%--            <a class="nav-link" href="/medical-staff/dashboard">Staff & Departments</a>--%>
<%--&lt;%&ndash;            <a class="nav-link" href="/wards">Wards</a>&ndash;%&gt;--%>
<%--&lt;%&ndash;            <a class="nav-link" href="/beds">Beds</a>&ndash;%&gt;--%>
<%--            <a class="nav-link" href="/admin/reports">Reports</a>--%>
<%--            <a class="nav-link active" href="/admin/settings">Settings</a>--%>
<%--        </div>--%>
<%--        <div class="navbar-nav ms-auto">--%>
<%--            <span class="navbar-text">Welcome, Administrator!</span>--%>
<%--            <a class="nav-link" href="/logout">Logout</a>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</nav>--%>

<%--<div class="container mt-4">--%>
<%--    <h1><i class="fas fa-cogs me-2"></i>System Settings</h1>--%>

<%--    <!-- Success Message -->--%>
<%--    <c:if test="${not empty param.success}">--%>
<%--        <div class="alert alert-success alert-dismissible fade show">--%>
<%--            <strong>Success!</strong> ${param.success}--%>
<%--            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>--%>
<%--        </div>--%>
<%--    </c:if>--%>

<%--    <div class="row">--%>
<%--        <!-- Navigation Sidebar -->--%>
<%--        <div class="col-md-3">--%>
<%--            <div class="list-group">--%>
<%--                <a href="#general" class="list-group-item list-group-item-action active"--%>
<%--                   data-bs-toggle="list">General Settings</a>--%>
<%--                <a href="#security" class="list-group-item list-group-item-action"--%>
<%--                   data-bs-toggle="list">Security</a>--%>
<%--                <a href="#notifications" class="list-group-item list-group-item-action"--%>
<%--                   data-bs-toggle="list">Notifications</a>--%>
<%--                <a href="#backup" class="list-group-item list-group-item-action"--%>
<%--                   data-bs-toggle="list">Backup & Restore</a>--%>
<%--                <a href="#maintenance" class="list-group-item list-group-item-action"--%>
<%--                   data-bs-toggle="list">Maintenance</a>--%>
<%--            </div>--%>
<%--        </div>--%>

<%--        <!-- Settings Content -->--%>
<%--        <div class="col-md-9">--%>
<%--            <div class="tab-content">--%>
<%--                <!-- General Settings -->--%>
<%--                <div class="tab-pane fade show active" id="general">--%>
<%--                    <div class="card">--%>
<%--                        <div class="card-header">--%>
<%--                            <h5 class="mb-0">General System Settings</h5>--%>
<%--                        </div>--%>
<%--                        <div class="card-body">--%>
<%--                            <form>--%>
<%--                                <div class="row">--%>
<%--                                    <div class="col-md-6">--%>
<%--                                        <div class="mb-3">--%>
<%--                                            <label class="form-label">Hospital Name</label>--%>
<%--                                            <input type="text" class="form-control" value="General Hospital"--%>
<%--                                                   placeholder="Enter hospital name">--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                    <div class="col-md-6">--%>
<%--                                        <div class="mb-3">--%>
<%--                                            <label class="form-label">Hospital Code</label>--%>
<%--                                            <input type="text" class="form-control" value="GH-001"--%>
<%--                                                   placeholder="Hospital code">--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                                <div class="mb-3">--%>
<%--                                    <label class="form-label">Hospital Address</label>--%>
<%--                                    <textarea class="form-control" rows="3">123 Hospital Road, Medical City</textarea>--%>
<%--                                </div>--%>
<%--                                <div class="row">--%>
<%--                                    <div class="col-md-6">--%>
<%--                                        <div class="mb-3">--%>
<%--                                            <label class="form-label">Contact Number</label>--%>
<%--                                            <input type="text" class="form-control" value="+94 11 234 5678">--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                    <div class="col-md-6">--%>
<%--                                        <div class="mb-3">--%>
<%--                                            <label class="form-label">Email Address</label>--%>
<%--                                            <input type="email" class="form-control" value="info@hospital.com">--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                                <div class="mb-3">--%>
<%--                                    <label class="form-label">Timezone</label>--%>
<%--                                    <select class="form-control">--%>
<%--                                        <option>Asia/Colombo (GMT+5:30)</option>--%>
<%--                                        <option>UTC</option>--%>
<%--                                    </select>--%>
<%--                                </div>--%>
<%--                                <button type="submit" class="btn btn-primary">Save General Settings</button>--%>
<%--                            </form>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>

<%--                <!-- Security Settings -->--%>
<%--                <div class="tab-pane fade" id="security">--%>
<%--                    <div class="card">--%>
<%--                        <div class="card-header">--%>
<%--                            <h5 class="mb-0">Security Settings</h5>--%>
<%--                        </div>--%>
<%--                        <div class="card-body">--%>
<%--                            <form>--%>
<%--                                <div class="mb-3">--%>
<%--                                    <label class="form-label">Password Policy</label>--%>
<%--                                    <div class="form-check">--%>
<%--                                        <input class="form-check-input" type="checkbox" id="strongPasswords" checked>--%>
<%--                                        <label class="form-check-label" for="strongPasswords">--%>
<%--                                            Require strong passwords--%>
<%--                                        </label>--%>
<%--                                    </div>--%>
<%--                                    <div class="form-check">--%>
<%--                                        <input class="form-check-input" type="checkbox" id="passwordExpiry">--%>
<%--                                        <label class="form-check-label" for="passwordExpiry">--%>
<%--                                            Enable password expiry (90 days)--%>
<%--                                        </label>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                                <div class="mb-3">--%>
<%--                                    <label class="form-label">Session Timeout</label>--%>
<%--                                    <select class="form-control">--%>
<%--                                        <option>15 minutes</option>--%>
<%--                                        <option selected>30 minutes</option>--%>
<%--                                        <option>1 hour</option>--%>
<%--                                        <option>2 hours</option>--%>
<%--                                    </select>--%>
<%--                                </div>--%>
<%--                                <div class="mb-3">--%>
<%--                                    <label class="form-label">Login Attempts</label>--%>
<%--                                    <input type="number" class="form-control" value="3"--%>
<%--                                           placeholder="Maximum login attempts">--%>
<%--                                </div>--%>
<%--                                <div class="mb-3">--%>
<%--                                    <label class="form-label">Two-Factor Authentication</label>--%>
<%--                                    <div class="form-check">--%>
<%--                                        <input class="form-check-input" type="checkbox" id="2fa">--%>
<%--                                        <label class="form-check-label" for="2fa">--%>
<%--                                            Enable 2FA for administrators--%>
<%--                                        </label>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                                <button type="submit" class="btn btn-primary">Save Security Settings</button>--%>
<%--                            </form>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>

<%--                <!-- Notification Settings -->--%>
<%--                <div class="tab-pane fade" id="notifications">--%>
<%--                    <div class="card">--%>
<%--                        <div class="card-header">--%>
<%--                            <h5 class="mb-0">Notification Settings</h5>--%>
<%--                        </div>--%>
<%--                        <div class="card-body">--%>
<%--                            <form>--%>
<%--                                <div class="mb-3">--%>
<%--                                    <h6>Email Notifications</h6>--%>
<%--                                    <div class="form-check">--%>
<%--                                        <input class="form-check-input" type="checkbox" id="emailAppointments" checked>--%>
<%--                                        <label class="form-check-label" for="emailAppointments">--%>
<%--                                            Appointment reminders--%>
<%--                                        </label>--%>
<%--                                    </div>--%>
<%--                                    <div class="form-check">--%>
<%--                                        <input class="form-check-input" type="checkbox" id="emailAdmissions" checked>--%>
<%--                                        <label class="form-check-label" for="emailAdmissions">--%>
<%--                                            Admission notifications--%>
<%--                                        </label>--%>
<%--                                    </div>--%>
<%--                                    <div class="form-check">--%>
<%--                                        <input class="form-check-input" type="checkbox" id="emailSystem">--%>
<%--                                        <label class="form-check-label" for="emailSystem">--%>
<%--                                            System alerts--%>
<%--                                        </label>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                                <div class="mb-3">--%>
<%--                                    <h6>SMS Notifications</h6>--%>
<%--                                    <div class="form-check">--%>
<%--                                        <input class="form-check-input" type="checkbox" id="smsAppointments">--%>
<%--                                        <label class="form-check-label" for="smsAppointments">--%>
<%--                                            Appointment reminders--%>
<%--                                        </label>--%>
<%--                                    </div>--%>
<%--                                    <div class="form-check">--%>
<%--                                        <input class="form-check-input" type="checkbox" id="smsEmergency">--%>
<%--                                        <label class="form-check-label" for="smsEmergency">--%>
<%--                                            Emergency alerts--%>
<%--                                        </label>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                                <button type="submit" class="btn btn-primary">Save Notification Settings</button>--%>
<%--                            </form>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>

<%--                <!-- Backup & Restore -->--%>
<%--                <div class="tab-pane fade" id="backup">--%>
<%--                    <div class="card">--%>
<%--                        <div class="card-header">--%>
<%--                            <h5 class="mb-0">Backup & Restore</h5>--%>
<%--                        </div>--%>
<%--                        <div class="card-body">--%>
<%--                            <div class="mb-4">--%>
<%--                                <h6>Database Backup</h6>--%>
<%--                                <p class="text-muted">Last backup: 2025-01-15 02:00 AM</p>--%>
<%--                                <button class="btn btn-success me-2">--%>
<%--                                    <i class="fas fa-download me-1"></i>Create Backup Now--%>
<%--                                </button>--%>
<%--                                <button class="btn btn-outline-secondary">--%>
<%--                                    <i class="fas fa-cog me-1"></i>Backup Settings--%>
<%--                                </button>--%>
<%--                            </div>--%>
<%--                            <div class="mb-4">--%>
<%--                                <h6>Restore Database</h6>--%>
<%--                                <div class="input-group mb-3">--%>
<%--                                    <input type="file" class="form-control" accept=".sql,.backup">--%>
<%--                                    <button class="btn btn-warning">Restore</button>--%>
<%--                                </div>--%>
<%--                                <small class="text-muted">Select a backup file to restore the database</small>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>

<%--                <!-- Maintenance -->--%>
<%--                <div class="tab-pane fade" id="maintenance">--%>
<%--                    <div class="card">--%>
<%--                        <div class="card-header">--%>
<%--                            <h5 class="mb-0">System Maintenance</h5>--%>
<%--                        </div>--%>
<%--                        <div class="card-body">--%>
<%--                            <div class="alert alert-warning">--%>
<%--                                <i class="fas fa-exclamation-triangle me-2"></i>--%>
<%--                                <strong>Warning:</strong> These actions may affect system availability.--%>
<%--                            </div>--%>
<%--                            <div class="mb-3">--%>
<%--                                <button class="btn btn-outline-primary me-2">--%>
<%--                                    <i class="fas fa-sync me-1"></i>Clear Cache--%>
<%--                                </button>--%>
<%--                                <button class="btn btn-outline-info me-2">--%>
<%--                                    <i class="fas fa-database me-1"></i>Optimize Database--%>
<%--                                </button>--%>
<%--                                <button class="btn btn-outline-success me-2">--%>
<%--                                    <i class="fas fa-chart-bar me-1"></i>Update Statistics--%>
<%--                                </button>--%>
<%--                            </div>--%>
<%--                            <div class="mb-3">--%>
<%--                                <h6>System Logs</h6>--%>
<%--                                <button class="btn btn-outline-secondary me-2">--%>
<%--                                    <i class="fas fa-file-alt me-1"></i>View Logs--%>
<%--                                </button>--%>
<%--                                <button class="btn btn-outline-danger">--%>
<%--                                    <i class="fas fa-trash me-1"></i>Clear Logs--%>
<%--                                </button>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
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
<%--    // Auto-hide alerts--%>
<%--    setTimeout(() => {--%>
<%--        const alerts = document.querySelectorAll('.alert');--%>
<%--        alerts.forEach(alert => {--%>
<%--            if (alert.classList.contains('alert-dismissible')) {--%>
<%--                const bsAlert = new bootstrap.Alert(alert);--%>
<%--                bsAlert.close();--%>
<%--            }--%>
<%--        });--%>
<%--    }, 5000);--%>
<%--</script>--%>
<%--</body>--%>
<%--</html>--%>