<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<%@ page import="java.time.LocalDate" %>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <title>Department Shifts - HMS</title>--%>
<%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">--%>
<%--    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">--%>
<%--</head>--%>
<%--<body>--%>
<%--<nav class="navbar navbar-expand-lg navbar-dark bg-primary">--%>
<%--    <div class="container">--%>
<%--        <a class="navbar-brand" href="/">🏥 HMS</a>--%>
<%--        <div class="navbar-nav">--%>
<%--            <a class="nav-link" href="/medical-staff/dashboard">Dashboard</a>--%>
<%--            <a class="nav-link" href="/medical-staff/departments">Departments</a>--%>
<%--            <a class="nav-link" href="/medical-staff/doctors">Doctors</a>--%>
<%--            <a class="nav-link" href="/medical-staff/staff">Staff</a>--%>
<%--            <a class="nav-link active" href="/medical-staff/shifts">Shifts</a>--%>
<%--            <a class="nav-link" href="/admin/dashboard">Admin Dashboard</a>--%>
<%--        </div>--%>
<%--        <div class="navbar-nav ms-auto">--%>
<%--            <span class="navbar-text">Welcome, Administrator!</span>--%>
<%--            <a class="nav-link" href="/logout">Logout</a>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</nav>--%>

<%--<div class="container mt-4">--%>
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

<%--    <div class="d-flex justify-content-between align-items-center">--%>
<%--        <h1><i class="fas fa-calendar me-2"></i>${department.name} - Shift Management</h1>--%>
<%--        <div>--%>
<%--            <a href="/medical-staff/shifts" class="btn btn-secondary">--%>
<%--                <i class="fas fa-arrow-left me-1"></i>Back to Shifts--%>
<%--            </a>--%>
<%--        </div>--%>
<%--    </div>--%>

<%--    <!-- Date Selection -->--%>
<%--    <div class="card mt-3">--%>
<%--        <div class="card-body">--%>
<%--            <form method="get" class="row g-3">--%>
<%--                <div class="col-md-4">--%>
<%--                    <label for="date" class="form-label">Select Date:</label>--%>
<%--                    <input type="date" class="form-control" id="date" name="date"--%>
<%--                           value="${selectedDateString}" onchange="this.form.submit()">--%>
<%--                </div>--%>
<%--                <div class="col-md-8 d-flex align-items-end">--%>
<%--                    <div class="btn-group">--%>
<%--                        <%--%>
<%--                            // Generate dates for the next 7 days using pure Java--%>
<%--                            LocalDate today = LocalDate.now();--%>
<%--                            for (int i = 0; i < 7; i++) {--%>
<%--                                LocalDate dayDate = today.plusDays(i);--%>
<%--                                String dayName = dayDate.getDayOfWeek().toString().substring(0, 3);--%>
<%--                                boolean isActive = i == 0; // Today is active by default--%>
<%--                        %>--%>
<%--                        <a href="/medical-staff/shifts/department/${department.id}?date=<%= dayDate %>"--%>
<%--                           class="btn btn-outline-primary <%= isActive ? "active" : "" %>">--%>
<%--                            <%= dayName %>--%>
<%--                        </a>--%>
<%--                        <%--%>
<%--                            }--%>
<%--                        %>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </form>--%>
<%--        </div>--%>
<%--    </div>--%>

<%--    <!-- Shift Assignment Form -->--%>
<%--    <div class="card mt-4">--%>
<%--        <div class="card-header bg-success text-white">--%>
<%--            <h5 class="mb-0"><i class="fas fa-plus-circle me-2"></i>Assign New Shift</h5>--%>
<%--        </div>--%>
<%--        <div class="card-body">--%>
<%--            <form method="post" action="/medical-staff/shifts/assign">--%>
<%--                <div class="row g-3">--%>
<%--                    <div class="col-md-3">--%>
<%--                        <label class="form-label">Staff Member</label>--%>
<%--                        <select name="staffId" class="form-select" required>--%>
<%--                            <option value="">Select Staff</option>--%>
<%--                            <c:forEach var="staff" items="${staffList}">--%>
<%--                                <option value="${staff.id}">${staff.firstName} ${staff.lastName} (${staff.staffType})</option>--%>
<%--                            </c:forEach>--%>
<%--                        </select>--%>
<%--                    </div>--%>
<%--                    <div class="col-md-3">--%>
<%--                        <label class="form-label">Shift Type</label>--%>
<%--                        <select name="shiftType" class="form-select" required>--%>
<%--                            <option value="">Select Shift</option>--%>
<%--                            <c:forEach var="shiftType" items="${shiftTypes}">--%>
<%--                                <option value="${shiftType}">${shiftType}</option>--%>
<%--                            </c:forEach>--%>
<%--                        </select>--%>
<%--                    </div>--%>
<%--                    <div class="col-md-3">--%>
<%--                        <label class="form-label">Date</label>--%>
<%--                        <input type="date" name="scheduleDate" class="form-control"--%>
<%--                               value="${selectedDateString}" required>--%>
<%--                    </div>--%>
<%--                    <div class="col-md-3">--%>
<%--                        <label class="form-label">Notes (Optional)</label>--%>
<%--                        <input type="text" name="notes" class="form-control" placeholder="Additional notes">--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <input type="hidden" name="departmentId" value="${department.id}">--%>
<%--                <div class="mt-3">--%>
<%--                    <button type="submit" class="btn btn-primary">--%>
<%--                        <i class="fas fa-save me-1"></i>Assign Shift--%>
<%--                    </button>--%>
<%--                    <button type="button" class="btn btn-warning" onclick="generateWeeklySchedule()">--%>
<%--                        <i class="fas fa-calendar-week me-1"></i>Generate Weekly Schedule--%>
<%--                    </button>--%>
<%--                </div>--%>
<%--            </form>--%>
<%--        </div>--%>
<%--    </div>--%>

<%--    <!-- Current Shifts Table -->--%>
<%--    <div class="card mt-4">--%>
<%--        <div class="card-header">--%>
<%--            <h5 class="mb-0"><i class="fas fa-list me-2"></i>Scheduled Shifts for--%>
<%--                <%--%>
<%--                    // Get the selected date safely--%>
<%--                    LocalDate selectedDate = (LocalDate) request.getAttribute("selectedDate");--%>
<%--                    LocalDate displayDate = (selectedDate != null) ? selectedDate : LocalDate.now();--%>

<%--                    String[] days = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};--%>
<%--                    String[] months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};--%>

<%--                    String formattedDate = days[displayDate.getDayOfWeek().getValue() - 1] + ", " +--%>
<%--                            months[displayDate.getMonthValue() - 1] + " " +--%>
<%--                            displayDate.getDayOfMonth() + ", " +--%>
<%--                            displayDate.getYear();--%>
<%--                    out.print(formattedDate);--%>
<%--                %>--%>
<%--            </h5>--%>
<%--        </div>--%>
<%--        <div class="card-body">--%>
<%--            <div class="table-responsive">--%>
<%--                <table class="table table-striped">--%>
<%--                    <thead>--%>
<%--                    <tr>--%>
<%--                        <th>Staff Name</th>--%>
<%--                        <th>Position</th>--%>
<%--                        <th>Shift Type</th>--%>
<%--                        <th>Start Time</th>--%>
<%--                        <th>End Time</th>--%>
<%--                        <th>Status</th>--%>
<%--                        <th>Actions</th>--%>
<%--                    </tr>--%>
<%--                    </thead>--%>
<%--                    <tbody>--%>
<%--                    <c:forEach var="shift" items="${shifts}">--%>
<%--                        <tr>--%>
<%--                            <td>${shift.staff.firstName} ${shift.staff.lastName}</td>--%>
<%--                            <td><span class="badge bg-info">${shift.staff.staffType}</span></td>--%>
<%--                            <td><span class="badge bg-primary">${shift.shiftType}</span></td>--%>
<%--                            <td>${shift.startTime}</td>--%>
<%--                            <td>${shift.endTime}</td>--%>
<%--                            <td>--%>
<%--                                    <span class="badge--%>
<%--                                        ${shift.status == 'SCHEDULED' ? 'bg-warning' :--%>
<%--                                          shift.status == 'ACTIVE' ? 'bg-success' :--%>
<%--                                          shift.status == 'COMPLETED' ? 'bg-secondary' : 'bg-danger'}">--%>
<%--                                            ${shift.status}--%>
<%--                                    </span>--%>
<%--                            </td>--%>
<%--                            <td>--%>
<%--                                <div class="btn-group btn-group-sm">--%>
<%--                                    <form method="post" action="/medical-staff/shifts/update-status" class="d-inline">--%>
<%--                                        <input type="hidden" name="scheduleId" value="${shift.id}">--%>
<%--                                        <input type="hidden" name="status" value="ACTIVE">--%>
<%--                                        <button type="submit" class="btn btn-success btn-sm"--%>
<%--                                            ${shift.status != 'SCHEDULED' ? 'disabled' : ''}>--%>
<%--                                            <i class="fas fa-play"></i>--%>
<%--                                        </button>--%>
<%--                                    </form>--%>
<%--                                    <form method="post" action="/medical-staff/shifts/update-status" class="d-inline">--%>
<%--                                        <input type="hidden" name="scheduleId" value="${shift.id}">--%>
<%--                                        <input type="hidden" name="status" value="COMPLETED">--%>
<%--                                        <button type="submit" class="btn btn-secondary btn-sm"--%>
<%--                                            ${shift.status != 'ACTIVE' ? 'disabled' : ''}>--%>
<%--                                            <i class="fas fa-check"></i>--%>
<%--                                        </button>--%>
<%--                                    </form>--%>
<%--                                    <a href="/medical-staff/shifts/delete/${shift.id}"--%>
<%--                                       class="btn btn-danger btn-sm"--%>
<%--                                       onclick="return confirm('Are you sure you want to delete this shift?')">--%>
<%--                                        <i class="fas fa-trash"></i>--%>
<%--                                    </a>--%>
<%--                                </div>--%>
<%--                            </td>--%>
<%--                        </tr>--%>
<%--                    </c:forEach>--%>
<%--                    <c:if test="${empty shifts}">--%>
<%--                        <tr>--%>
<%--                            <td colspan="7" class="text-center text-muted">--%>
<%--                                <i class="fas fa-calendar-times fa-2x mb-2"></i><br>--%>
<%--                                No shifts scheduled for this date.--%>
<%--                            </td>--%>
<%--                        </tr>--%>
<%--                    </c:if>--%>
<%--                    </tbody>--%>
<%--                </table>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>

<%--<script>--%>
<%--    function generateWeeklySchedule() {--%>
<%--        if(confirm('Generate weekly schedule for ${department.name}? This will create shifts for the next 7 days.')) {--%>
<%--            fetch('/medical-staff/shifts/generate-weekly', {--%>
<%--                method: 'POST',--%>
<%--                headers: {--%>
<%--                    'Content-Type': 'application/x-www-form-urlencoded',--%>
<%--                },--%>
<%--                body: 'departmentId=${department.id}'--%>
<%--            }).then(response => {--%>
<%--                if(response.ok) {--%>
<%--                    window.location.reload();--%>
<%--                }--%>
<%--            });--%>
<%--        }--%>
<%--    }--%>
<%--</script>--%>

<%--<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>--%>
<%--</body>--%>
<%--</html>--%>