<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Monthly Schedule - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .calendar-day {
            height: 120px;
            border: 1px solid #dee2e6;
            padding: 5px;
            position: relative;
        }
        .other-month {
            background-color: #f8f9fa;
            color: #6c757d;
        }
        .today {
            background-color: #e7f3ff;
            border: 2px solid #007bff;
        }
        .has-shifts {
            background-color: #f0f8ff;
        }
        .shift-badge {
            font-size: 0.7em;
            margin: 1px;
            display: block;
        }
        .calendar-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="">🏥 HMS</a>
        <div class="navbar-nav">
            <a class="nav-link" href="/staff/dashboard">Dashboard</a>
            <a class="nav-link" href="/staff/schedule">← Back to Weekly View</a>
            <a class="nav-link active" href="/staff/schedule/month">Monthly Schedule</a>
        </div>
        <div class="navbar-nav ms-auto">
            <span class="navbar-text">Welcome, ${username} (Staff)</span>
            <a class="nav-link" href="/logout">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h1><i class="fas fa-calendar me-2"></i>Monthly Schedule</h1>
            <p class="text-muted mb-0">
                <strong>${staff.firstName} ${staff.lastName}</strong> |
                ${monthStart.month.toString()} ${selectedYear}
            </p>
        </div>
        <div class="text-end">
            <!-- Month Navigation -->
            <div class="btn-group me-2">
                <c:set var="prevMonth" value="${monthStart.minusMonths(1)}"/>
                <a href="/staff/schedule/month?year=${prevMonth.year}&month=${prevMonth.monthValue}"
                   class="btn btn-outline-primary">
                    <i class="fas fa-chevron-left"></i> Prev
                </a>

                <a href="/staff/schedule/month" class="btn btn-outline-primary">Current Month</a>

                <c:set var="nextMonth" value="${monthStart.plusMonths(1)}"/>
                <a href="/staff/schedule/month?year=${nextMonth.year}&month=${nextMonth.monthValue}"
                   class="btn btn-outline-primary">
                    Next <i class="fas fa-chevron-right"></i>
                </a>
            </div>

            <div class="btn-group">
                <a href="/staff/schedule" class="btn btn-outline-primary">Weekly View</a>
                <a href="/staff/schedule/month" class="btn btn-primary active">Monthly View</a>
            </div>
        </div>
    </div>

    <!-- Monthly Calendar -->
    <div class="card">
        <div class="card-header calendar-header">
            <h5 class="mb-0 text-center">
                <i class="fas fa-calendar-alt me-2"></i>
                ${monthStart.month.toString()} ${selectedYear} -
                ${monthlySchedule.size()} Scheduled Shifts
            </h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-bordered mb-0">
                    <thead class="table-dark">
                    <tr>
                        <th class="text-center">Sunday</th>
                        <th class="text-center">Monday</th>
                        <th class="text-center">Tuesday</th>
                        <th class="text-center">Wednesday</th>
                        <th class="text-center">Thursday</th>
                        <th class="text-center">Friday</th>
                        <th class="text-center">Saturday</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:set var="firstDay" value="${monthStart.withDayOfMonth(1)}"/>
                    <c:set var="dayOfWeek" value="${firstDay.dayOfWeek.value}"/>
                    <c:set var="daysInMonth" value="${monthStart.lengthOfMonth()}"/>

                    <c:forEach var="week" begin="0" end="5">
                        <tr>
                            <c:forEach var="day" begin="0" end="6">
                                <c:set var="currentDate" value="${firstDay.plusDays(week * 7 + day - (dayOfWeek % 7))}"/>
                                <c:set var="isCurrentMonth" value="${currentDate.month.value == monthStart.month.value}"/>
                                <c:set var="isToday" value="${currentDate.equals(today)}"/>

                                <td class="calendar-day ${isCurrentMonth ? '' : 'other-month'} ${isToday ? 'today' : ''} ${isCurrentMonth && hasShiftsForDate(currentDate) ? 'has-shifts' : ''}">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <strong class="${isToday ? 'text-primary' : ''}">
                                                ${currentDate.dayOfMonth}
                                        </strong>
                                        <c:if test="${isToday}">
                                            <span class="badge bg-primary">Today</span>
                                        </c:if>
                                    </div>

                                    <c:if test="${isCurrentMonth}">
                                        <c:forEach var="shift" items="${monthlySchedule}">
                                            <c:if test="${shift.scheduleDate.equals(currentDate)}">
                                                    <span class="badge shift-badge
                                                        <c:choose>
                                                            <c:when test="${shift.shiftType == 'MORNING'}">bg-success</c:when>
                                                            <c:when test="${shift.shiftType == 'EVENING'}">bg-warning</c:when>
                                                            <c:when test="${shift.shiftType == 'NIGHT'}">bg-purple</c:when>
                                                            <c:otherwise>bg-secondary</c:otherwise>
                                                        </c:choose>"
                                                          title="${shift.shiftType} - ${shift.ward.wardNumber}">
                                                            ${shift.shiftType.charAt(0)}
                                                    </span>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                </td>
                            </c:forEach>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Shift Details -->
    <div class="card mt-4">
        <div class="card-header bg-info text-white">
            <h5 class="mb-0"><i class="fas fa-list me-2"></i>Shift Details - ${monthStart.month.toString()} ${selectedYear}</h5>
        </div>
        <div class="card-body">
            <c:if test="${empty monthlySchedule}">
                <div class="alert alert-info text-center">
                    <i class="fas fa-calendar-times fa-2x mb-3"></i>
                    <h5>No Shifts Scheduled</h5>
                    <p>You have no shifts scheduled for ${monthStart.month.toString()} ${selectedYear}.</p>
                </div>
            </c:if>

            <c:if test="${not empty monthlySchedule}">
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead class="table-dark">
                        <tr>
                            <th>Date</th>
                            <th>Day</th>
                            <th>Shift Type</th>
                            <th>Time</th>
                            <th>Ward</th>
                            <th>Status</th>
                            <th>Notes</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="shift" items="${monthlySchedule}">
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
                                                <c:when test="${shift.shiftType == 'MORNING'}">bg-success</c:when>
                                                <c:when test="${shift.shiftType == 'EVENING'}">bg-warning</c:when>
                                                <c:when test="${shift.shiftType == 'NIGHT'}">bg-purple</c:when>
                                                <c:otherwise>bg-secondary</c:otherwise>
                                            </c:choose>">
                                                ${shift.shiftType}
                                        </span>
                                </td>
                                <td>
                                    <c:if test="${shift.startTime != null && shift.endTime != null}">
                                        ${shift.startTime} - ${shift.endTime}
                                    </c:if>
                                    <c:if test="${shift.startTime == null || shift.endTime == null}">
                                        <span class="text-muted">Not specified</span>
                                    </c:if>
                                </td>
                                <td>
                                        ${shift.ward.wardNumber} - ${shift.ward.wardType}
                                </td>
                                <td>
                                        <span class="badge
                                            <c:choose>
                                                <c:when test="${shift.status == 'SCHEDULED'}">bg-info</c:when>
                                                <c:when test="${shift.status == 'ACTIVE'}">bg-success</c:when>
                                                <c:when test="${shift.status == 'COMPLETED'}">bg-secondary</c:when>
                                                <c:when test="${shift.status == 'CANCELLED'}">bg-danger</c:when>
                                                <c:otherwise>bg-warning</c:otherwise>
                                            </c:choose>">
                                                ${shift.status}
                                        </span>
                                </td>
                                <td>
                                    <c:if test="${not empty shift.notes}">
                                        <i class="fas fa-sticky-note text-muted" title="${shift.notes}"></i>
                                    </c:if>
                                    <c:if test="${empty shift.notes}">
                                        <span class="text-muted">-</span>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Statistics -->
    <div class="row mt-4">
        <div class="col-md-3">
            <div class="card text-center bg-primary text-white">
                <div class="card-body">
                    <h5>Total Shifts</h5>
                    <h3>${monthlySchedule.size()}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center bg-success text-white">
                <div class="card-body">
                    <h5>Morning</h5>
                    <h3>
                        <c:set var="morningCount" value="0"/>
                        <c:forEach var="shift" items="${monthlySchedule}">
                            <c:if test="${shift.shiftType == 'MORNING'}">
                                <c:set var="morningCount" value="${morningCount + 1}"/>
                            </c:if>
                        </c:forEach>
                        ${morningCount}
                    </h3>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center bg-warning text-white">
                <div class="card-body">
                    <h5>Evening</h5>
                    <h3>
                        <c:set var="eveningCount" value="0"/>
                        <c:forEach var="shift" items="${monthlySchedule}">
                            <c:if test="${shift.shiftType == 'EVENING'}">
                                <c:set var="eveningCount" value="${eveningCount + 1}"/>
                            </c:if>
                        </c:forEach>
                        ${eveningCount}
                    </h3>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center bg-purple text-white">
                <div class="card-body">
                    <h5>Night</h5>
                    <h3>
                        <c:set var="nightCount" value="0"/>
                        <c:forEach var="shift" items="${monthlySchedule}">
                            <c:if test="${shift.shiftType == 'NIGHT'}">
                                <c:set var="nightCount" value="${nightCount + 1}"/>
                            </c:if>
                        </c:forEach>
                        ${nightCount}
                    </h3>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Function to check if a date has shifts (used in JSP)
    function hasShiftsForDate(date) {
        // This would be implemented with actual data checking
        return true; // Simplified for example
    }

    // Print functionality
    function printSchedule() {
        window.print();
    }

    // Auto-hide alerts
    setTimeout(() => {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        });
    }, 5000);
</script>

<style>
    .bg-purple {
        background-color: #6f42c1 !important;
    }
    @media print {
        .navbar, .btn, .alert {
            display: none !important;
        }
        .card {
            border: 1px solid #000 !important;
        }
    }
</style>
</body>
</html>