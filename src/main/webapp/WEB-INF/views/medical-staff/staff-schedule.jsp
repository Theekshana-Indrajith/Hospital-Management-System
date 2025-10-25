<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Staff Schedule - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .shift-time { font-family: monospace; font-size: 0.9em; }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand">🏥 HMS</a>
        <div class="navbar-nav">
            <a class="nav-link" href="/medical-staff/dashboard">Dashboard</a>
            <a class="nav-link" href="/medical-staff/staff">Staff</a>
            <a class="nav-link active" href="/medical-staff/shifts">Shifts</a>
            <a class="nav-link" href="/admin/dashboard">Admin Dashboard</a>
        </div>
        <div class="navbar-nav ms-auto">
            <span class="navbar-text">Welcome, ${username}!</span>
            <a class="nav-link" href="/logout">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center">
        <h1><i class="fas fa-calendar-alt me-2"></i>Schedule for ${staff.firstName} ${staff.lastName}</h1>
        <a href="/medical-staff/shifts" class="btn btn-secondary">
            <i class="fas fa-arrow-left me-1"></i>Back to Shifts
        </a>
    </div>

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

    <!-- Date Range Selection -->
    <div class="card mt-3">
        <div class="card-body">
            <form method="get" class="row g-3">
                <div class="col-md-4">
                    <label class="form-label">Start Date:</label>
                    <input type="date" name="startDate" class="form-control"
                           value="${startDate}" required>
                </div>
                <div class="col-md-4">
                    <label class="form-label">End Date:</label>
                    <input type="date" name="endDate" class="form-control"
                           value="${endDate}" required>
                </div>
                <div class="col-md-4 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary w-100">
                        <i class="fas fa-filter me-1"></i>Filter
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Staff Information -->
    <div class="row mt-4">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">Staff Information</h5>
                </div>
                <div class="card-body">
                    <p><strong>Name:</strong> ${staff.firstName} ${staff.lastName}</p>
                    <p><strong>Position:</strong> <span class="badge bg-info">${staff.staffType}</span></p>
                    <p><strong>Department:</strong>
                        <c:choose>
                            <c:when test="${not empty staff.department}">
                                ${staff.department.name}
                            </c:when>
                            <c:otherwise>
                                <span class="text-muted">Not assigned</span>
                            </c:otherwise>
                        </c:choose>
                    </p>
                    <p><strong>Assigned Shift:</strong>
                        <c:choose>
                            <c:when test="${not empty staff.assignedShift}">
                                <span class="badge bg-primary">${staff.assignedShift}</span>
                            </c:when>
                            <c:otherwise>
                                <span class="text-muted">Not set</span>
                            </c:otherwise>
                        </c:choose>
                    </p>
                    <p><strong>Working Days:</strong>
                        <c:choose>
                            <c:when test="${not empty staff.workingDays}">
                                ${staff.workingDays}
                            </c:when>
                            <c:otherwise>
                                <span class="text-muted">Not set</span>
                            </c:otherwise>
                        </c:choose>
                    </p>
                    <p><strong>Contact:</strong> ${staff.contactNumber} | ${staff.email}</p>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">Schedule Summary (${startDate} to ${endDate})</h5>
                </div>
                <div class="card-body">
                    <c:set var="scheduledCount" value="0" />
                    <c:set var="activeCount" value="0" />
                    <c:set var="completedCount" value="0" />

                    <c:forEach var="shift" items="${shifts}">
                        <c:choose>
                            <c:when test="${shift.status == 'SCHEDULED'}">
                                <c:set var="scheduledCount" value="${scheduledCount + 1}" />
                            </c:when>
                            <c:when test="${shift.status == 'ACTIVE'}">
                                <c:set var="activeCount" value="${activeCount + 1}" />
                            </c:when>
                            <c:when test="${shift.status == 'COMPLETED'}">
                                <c:set var="completedCount" value="${completedCount + 1}" />
                            </c:when>
                        </c:choose>
                    </c:forEach>

                    <p><strong>Total Shifts:</strong> ${shifts.size()}</p>
                    <p><strong>Scheduled:</strong>
                        <span class="badge bg-warning">${scheduledCount}</span>
                    </p>
                    <p><strong>Active:</strong>
                        <span class="badge bg-success">${activeCount}</span>
                    </p>
                    <p><strong>Completed:</strong>
                        <span class="badge bg-secondary">${completedCount}</span>
                    </p>
                    <p><strong>Upcoming Next:</strong>
                        <c:if test="${not empty shifts}">
                            <c:set var="nextShift" value="${shifts[0]}" />
                            <c:forEach var="shift" items="${shifts}">
                                <c:if test="${shift.status == 'SCHEDULED' && (nextShift.status != 'SCHEDULED' || shift.scheduleDate.time < nextShift.scheduleDate.time)}">
                                    <c:set var="nextShift" value="${shift}" />
                                </c:if>
                            </c:forEach>
                            <c:if test="${nextShift.status == 'SCHEDULED'}">
                                <fmt:formatDate value="${nextShift.scheduleDate}" pattern="MMM d"/> - ${nextShift.shiftType}
                            </c:if>
                        </c:if>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- Schedule Calendar View -->
    <div class="card mt-4">
        <div class="card-header d-flex justify-content-between align-items-center">
            <h5 class="mb-0">Shift Schedule Details</h5>
            <span class="badge bg-primary">${shifts.size()} shifts found</span>
        </div>
        <div class="card-body">
            <c:if test="${not empty shifts}">
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead class="table-light">
                        <tr>
                            <th>Date</th>
                            <th>Day</th>
                            <th>Shift Type</th>
                            <th>Ward</th>
                            <th>Time</th>
                            <th>Status</th>
                            <th>Notes</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="shift" items="${shifts}">
                            <tr>
                                <td>
                                    <strong>
                                        <fmt:formatDate value="${shift.scheduleDate}" pattern="MMM d, yyyy"/>
                                    </strong>
                                </td>
                                <td>
                                    <fmt:formatDate value="${shift.scheduleDate}" pattern="EEEE"/>
                                </td>
                                <td>
                                    <span class="badge
                                        <c:choose>
                                            <c:when test="${shift.shiftType == 'MORNING'}">bg-warning</c:when>
                                            <c:when test="${shift.shiftType == 'EVENING'}">bg-primary</c:when>
                                            <c:when test="${shift.shiftType == 'NIGHT'}">bg-dark</c:when>
                                            <c:otherwise>bg-secondary</c:otherwise>
                                        </c:choose>">
                                            ${shift.shiftType}
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty shift.ward}">
                                            ${shift.ward.wardNumber} - ${shift.ward.wardType}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Not assigned</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="shift-time">
                                    <c:choose>
                                        <c:when test="${not empty shift.startTime && not empty shift.endTime}">
                                            ${shift.startTime} - ${shift.endTime}
                                        </c:when>
                                        <c:otherwise>
                                            <c:choose>
                                                <c:when test="${shift.shiftType == 'MORNING'}">06:00 - 14:00</c:when>
                                                <c:when test="${shift.shiftType == 'EVENING'}">14:00 - 22:00</c:when>
                                                <c:when test="${shift.shiftType == 'NIGHT'}">22:00 - 06:00</c:when>
                                                <c:otherwise>Not set</c:otherwise>
                                            </c:choose>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <span class="badge
                                        <c:choose>
                                            <c:when test="${shift.status == 'SCHEDULED'}">bg-warning</c:when>
                                            <c:when test="${shift.status == 'ACTIVE'}">bg-success</c:when>
                                            <c:when test="${shift.status == 'COMPLETED'}">bg-secondary</c:when>
                                            <c:otherwise>bg-danger</c:otherwise>
                                        </c:choose>">
                                            ${shift.status}
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty shift.notes}">
                                            <small>${shift.notes}</small>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">-</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="btn-group btn-group-sm">
                                        <form method="post" action="/medical-staff/shifts/update-status" class="d-inline">
                                            <input type="hidden" name="scheduleId" value="${shift.id}">
                                            <input type="hidden" name="status" value="ACTIVE">
                                            <button type="submit" class="btn btn-success btn-sm"
                                                ${shift.status != 'SCHEDULED' ? 'disabled' : ''}
                                                    title="Start Shift">
                                                <i class="fas fa-play"></i>
                                            </button>
                                        </form>
                                        <form method="post" action="/medical-staff/shifts/update-status" class="d-inline">
                                            <input type="hidden" name="scheduleId" value="${shift.id}">
                                            <input type="hidden" name="status" value="COMPLETED">
                                            <button type="submit" class="btn btn-secondary btn-sm"
                                                ${shift.status != 'ACTIVE' ? 'disabled' : ''}
                                                    title="Complete Shift">
                                                <i class="fas fa-check"></i>
                                            </button>
                                        </form>
                                        <a href="/medical-staff/shifts/delete/${shift.id}"
                                           class="btn btn-danger btn-sm"
                                           onclick="return confirm('Are you sure you want to delete this shift?')"
                                           title="Delete Shift">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
            <c:if test="${empty shifts}">
                <div class="text-center text-muted py-5">
                    <i class="fas fa-calendar-times fa-3x mb-3"></i>
                    <h5>No shifts scheduled for this period</h5>
                    <p class="mb-0">No shifts found between ${startDate} and ${endDate}</p>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="card mt-4">
        <div class="card-body text-center">
            <div class="btn-group">
                <a href="/medical-staff/shifts/ward/new?staffId=${staff.id}" class="btn btn-primary">
                    <i class="fas fa-plus me-1"></i>Assign New Shift
                </a>
                <a href="/medical-staff/staff/edit/${staff.id}" class="btn btn-outline-primary">
                    <i class="fas fa-edit me-1"></i>Edit Staff Profile
                </a>
                <a href="/medical-staff/staff" class="btn btn-outline-secondary">
                    <i class="fas fa-users me-1"></i>View All Staff
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>