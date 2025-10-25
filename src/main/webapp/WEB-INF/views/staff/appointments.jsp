<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Appointment Management - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-info">
    <div class="container">
        <a class="navbar-brand" href="">🏥 HMS</a>
        <div class="navbar-nav">
            <a class="nav-link" href="/staff/dashboard">Dashboard</a>
            <a class="nav-link active" href="/staff/appointments">Appointments</a>
            <a class="nav-link" href="/staff/admissions">Admissions</a>
            <a class="nav-link" href="/staff/wards">Wards</a>
            <a class="nav-link" href="/staff/patients">Patients</a>
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
    <h1><i class="fas fa-calendar-alt me-2"></i>Appointment Management</h1>

    <!-- Appointment Statistics -->
    <div class="row mt-4">
        <div class="col-md-3">
            <div class="card text-center bg-primary text-white">
                <div class="card-body">
                    <h5>Scheduled Today</h5>
                    <h3>15</h3>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center bg-success text-white">
                <div class="card-body">
                    <h5>Completed Today</h5>
                    <h3>8</h3>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center bg-warning text-white">
                <div class="card-body">
                    <h5>Pending</h5>
                    <h3>5</h3>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center bg-danger text-white">
                <div class="card-body">
                    <h5>Cancelled</h5>
                    <h3>2</h3>
                </div>
            </div>
        </div>
    </div>

    <!-- Appointment Actions -->
    <div class="card mt-4">
        <div class="card-header d-flex justify-content-between align-items-center">
            <h5 class="mb-0">Today's Appointments</h5>
            <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addAppointmentModal">
                <i class="fas fa-plus me-1"></i>New Appointment
            </button>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                    <tr>
                        <th>Time</th>
                        <th>Patient</th>
                        <th>Doctor</th>
                        <th>Reason</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>09:00 AM</td>
                        <td>John Smith</td>
                        <td>Dr. Kamal Perera</td>
                        <td>Regular Checkup</td>
                        <td><span class="badge bg-success">Confirmed</span></td>
                        <td>
                            <button class="btn btn-sm btn-outline-primary">Edit</button>
                            <button class="btn btn-sm btn-outline-danger">Cancel</button>
                        </td>
                    </tr>
                    <tr>
                        <td>10:30 AM</td>
                        <td>Mary Johnson</td>
                        <td>Dr. Nimali Fernando</td>
                        <td>Consultation</td>
                        <td><span class="badge bg-warning">Pending</span></td>
                        <td>
                            <button class="btn btn-sm btn-outline-primary">Edit</button>
                            <button class="btn btn-sm btn-outline-success">Confirm</button>
                        </td>
                    </tr>
                    <tr>
                        <td>02:00 PM</td>
                        <td>David Brown</td>
                        <td>Dr. Sunil Rathnayake</td>
                        <td>Follow-up</td>
                        <td><span class="badge bg-info">Scheduled</span></td>
                        <td>
                            <button class="btn btn-sm btn-outline-primary">Edit</button>
                            <button class="btn btn-sm btn-outline-warning">Reschedule</button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Upcoming Appointments -->
    <div class="card mt-4">
        <div class="card-header">
            <h5>Upcoming Appointments (Next 7 Days)</h5>
        </div>
        <div class="card-body">
            <div class="list-group">
                <div class="list-group-item d-flex justify-content-between align-items-center">
                    <div>
                        <strong>Tomorrow, 10:00 AM</strong> - John Smith with Dr. Kamal Perera
                        <br><small class="text-muted">Cardiology Consultation</small>
                    </div>
                    <span class="badge bg-primary rounded-pill">Confirmed</span>
                </div>
                <div class="list-group-item d-flex justify-content-between align-items-center">
                    <div>
                        <strong>Day after tomorrow, 11:30 AM</strong> - Sarah Wilson with Dr. Priya Silva
                        <br><small class="text-muted">Dermatology Checkup</small>
                    </div>
                    <span class="badge bg-warning rounded-pill">Pending</span>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Replace the modal form with this REAL form -->
<div class="modal fade" id="addAppointmentModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-success text-white">
                <h5 class="modal-title">Schedule New Appointment</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="/staff/appointments/create" method="post">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Select Patient</label>
                                <select class="form-control" name="patientId" required>
                                    <option value="">Choose Patient</option>
                                    <c:forEach var="patient" items="${patients}">
                                        <option value="${patient.id}">${patient.firstName} ${patient.lastName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Select Doctor</label>
                                <select class="form-control" name="doctorId" required>
                                    <option value="">Choose Doctor</option>
                                    <c:forEach var="doctor" items="${doctors}">
                                        <option value="${doctor.id}">${doctor.name} (${doctor.specialization})</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Appointment Date *</label>
                                <input type="date" class="form-control" name="appointmentDate" required
                                       min="<%= java.time.LocalDate.now() %>">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Appointment Time *</label>
                                <input type="time" class="form-control" name="appointmentTime" required>
                            </div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Reason for Appointment</label>
                        <textarea class="form-control" name="reason" rows="3" placeholder="Enter appointment reason" required></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success">Schedule Appointment</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Update appointments table to show REAL data -->
<tbody>
<c:forEach var="appointment" items="${appointments}">
    <tr>
        <td>${appointment.appointmentDateTime}</td>
        <td>${appointment.patient.firstName} ${appointment.patient.lastName}</td>
        <td>${appointment.doctor.name}</td>
        <td>${appointment.reason}</td>
        <td>
                <span class="badge
                    <c:choose>
                        <c:when test="${appointment.status == 'SCHEDULED'}">bg-info</c:when>
                        <c:when test="${appointment.status == 'COMPLETED'}">bg-success</c:when>
                        <c:when test="${appointment.status == 'CANCELLED'}">bg-danger</c:when>
                        <c:otherwise>bg-warning</c:otherwise>
                    </c:choose>">
                        ${appointment.status}
                </span>
        </td>
        <td>
            <form action="/staff/appointments/update-status" method="post" class="d-inline">
                <input type="hidden" name="appointmentId" value="${appointment.id}">
                <input type="hidden" name="status" value="COMPLETED">
                <button type="submit" class="btn btn-sm btn-outline-success">Complete</button>
            </form>
            <form action="/staff/appointments/update-status" method="post" class="d-inline">
                <input type="hidden" name="appointmentId" value="${appointment.id}">
                <input type="hidden" name="status" value="CANCELLED">
                <button type="submit" class="btn btn-sm btn-outline-danger">Cancel</button>
            </form>
        </td>
    </tr>
</c:forEach>
</tbody>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>