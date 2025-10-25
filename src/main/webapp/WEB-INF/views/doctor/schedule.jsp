<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>My Schedule - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap');

        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --danger-gradient: linear-gradient(135deg, #ff6b6b 0%, #ff8e8e 100%);
            --warning-gradient: linear-gradient(135deg, #ffd93d 0%, #ff9a3d 100%);
            --info-gradient: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            --dark-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --light-bg: rgba(255, 255, 255, 0.95);
            --shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }

        /* Global Reset and Base Styling */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            overflow-x: hidden;
            position: relative;
        }

        /* Enhanced Navigation - Matching Homepage Style */
        .navbar {
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.98) 0%, rgba(248, 249, 250, 0.98) 100%) !important;
            backdrop-filter: blur(15px);
            box-shadow: 0 4px 30px rgba(0, 123, 255, 0.1);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            padding: 15px 0;
            border-bottom: 1px solid rgba(102, 126, 234, 0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .navbar.scrolled {
            background: linear-gradient(135deg, rgba(255, 255, 255, 1) 0%, rgba(248, 249, 250, 1) 100%) !important;
            padding: 10px 0;
            box-shadow: 0 8px 40px rgba(102, 126, 234, 0.15);
            border-bottom: 2px solid rgba(102, 126, 234, 0.2);
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            transition: all 0.3s ease;
            letter-spacing: -0.5px;
            display: flex;
            align-items: center;
        }

        .navbar-brand:hover {
            transform: scale(1.05);
            filter: brightness(1.2);
        }

        .navbar-brand i {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: pulse 2s ease-in-out infinite;
            margin-right: 0.5rem;
            font-size: 1.4rem;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }

        .nav-link {
            position: relative;
            font-weight: 600;
            color: #2c3e50 !important;
            padding: 8px 20px !important;
            margin: 0 5px;
            transition: all 0.3s ease;
            border-radius: 8px;
            font-size: 0.95rem;
        }

        .nav-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
            border-radius: 8px;
            opacity: 0;
            transition: opacity 0.3s ease;
            z-index: -1;
        }

        .nav-link::after {
            content: '';
            position: absolute;
            bottom: 5px;
            left: 50%;
            width: 0;
            height: 3px;
            background: linear-gradient(90deg, #667eea, #764ba2);
            border-radius: 2px;
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }

        .nav-link:hover,
        .nav-link.active {
            color: #667eea !important;
            transform: translateY(-2px);
        }

        .nav-link:hover::before,
        .nav-link.active::before {
            opacity: 1;
        }

        .nav-link:hover::after,
        .nav-link.active::after {
            width: 80%;
        }

        .nav-link i {
            margin-right: 0.5rem;
            transition: transform 0.3s ease;
        }

        .nav-link:hover i {
            transform: scale(1.1);
        }

        .navbar-text {
            font-weight: 600;
            color: #2c3e50 !important;
            padding: 8px 20px;
            margin: 0 5px;
            border-radius: 8px;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
        }

        .navbar-text:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.2);
        }

        .navbar-text i {
            margin-right: 0.5rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .nav-link[href="/logout"] {
            background: linear-gradient(135deg, #ff6b6b 0%, #ff8e8e 100%);
            color: #fff !important;
            box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3);
            padding: 10px 25px !important;
        }

        .nav-link[href="/logout"]::before {
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
        }

        .nav-link[href="/logout"]::after {
            display: none;
        }

        .nav-link[href="/logout"]:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 25px rgba(255, 107, 107, 0.4);
            color: #fff !important;
        }

        .navbar-toggler {
            border: 2px solid #667eea;
            padding: 8px 12px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .navbar-toggler:hover {
            background: rgba(102, 126, 234, 0.1);
            transform: scale(1.05);
        }

        .navbar-toggler:focus {
            box-shadow: 0 0 0 0.25rem rgba(102, 126, 234, 0.25);
        }

        .navbar-toggler-icon {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba(102, 126, 234, 1)' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
        }

        /* Welcome Header Background Image */
        .welcome-header {
            position: relative;
            background-image: url('https://images.unsplash.com/photo-1559757148-5c350d0d3c56?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            padding: 2rem 1rem;
            border-radius: 15px;
            overflow: hidden;
            margin-bottom: 1.5rem;
        }

        .welcome-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(102, 126, 234, 0.7);
            z-index: 0;
        }

        .welcome-header > * {
            position: relative;
            z-index: 1;
            color: #fff;
        }

        .welcome-header h2 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            color: #fff;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);
        }

        .welcome-header p {
            font-size: 1.1rem;
            opacity: 0.9;
            color: #fff;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.5);
        }

        /* Rest of the existing CSS remains exactly the same */
        .schedule-table {
            width: 100%;
            border-collapse: collapse;
            background: var(--light-bg);
            border-radius: 15px;
            overflow: hidden;
            box-shadow: var(--shadow);
        }

        .schedule-table th,
        .schedule-table td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        }

        .schedule-table th {
            background: var(--success-gradient);
            color: #fff;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .schedule-table td {
            background: #fff;
            transition: background 0.3s ease;
        }

        .schedule-table tr:hover td {
            background: #f8f9fa;
        }

        .schedule-table .time-column {
            width: 10%;
            font-weight: 500;
            color: #333;
        }

        .schedule-table .appointment-cell {
            padding: 15px;
            vertical-align: top;
        }

        .schedule-table .appointment {
            background: #e3f2fd;
            border-left: 4px solid #2196f3;
            padding: 8px;
            margin: 5px 0;
            border-radius: 4px;
            display: inline-block;
        }

        .schedule-table .appointment .badge {
            margin-top: 5px;
            display: block;
        }

        .schedule-table .no-appointments {
            color: #6c757d;
            font-style: italic;
        }

        .card {
            border: none;
            border-radius: 15px;
            background: var(--light-bg);
            backdrop-filter: blur(12px);
            box-shadow: var(--shadow);
            transition: transform 0.4s ease, box-shadow 0.4s ease;
        }

        .card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--success-gradient);
            transform: scaleX(0);
            transition: transform 0.4s ease;
        }

        .card:hover::before {
            transform: scaleX(1);
        }

        .btn-success {
            background: var(--success-gradient);
            border: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-success:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(40, 167, 69, 0.3);
        }

        .btn-outline-success {
            border-color: rgba(40, 167, 69, 0.5);
            color: #28a745;
        }

        .btn-outline-success:hover {
            background: var(--success-gradient);
            color: #fff;
            border-color: var(--success-gradient);
        }

        footer {
            background: var(--dark-gradient) !important;
            color: #fff;
            position: relative;
            overflow: hidden;
        }

        footer::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"><path fill="rgba(255,255,255,0.05)" d="M0,96L48,112C96,128,192,160,288,160C384,160,480,128,576,112C672,96,768,96,864,112C960,128,1056,160,1152,160C1248,160,1344,128,1392,112L1440,96L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>');
            background-size: cover;
            animation: footerWave 10s ease-in-out infinite;
        }

        @keyframes footerWave {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-15px); }
        }

        @media (max-width: 991px) {
            .navbar-collapse {
                background: rgba(255, 255, 255, 0.98);
                backdrop-filter: blur(20px);
                border-radius: 15px;
                margin-top: 1rem;
                padding: 1.5rem;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            }

            .nav-link {
                margin: 0.3rem 0;
                text-align: left;
            }

            .navbar-text {
                margin: 0.5rem 0;
            }
        }

        @media (max-width: 768px) {
            .navbar-brand {
                font-size: 1.3rem;
            }

            .nav-link {
                padding: 0.7rem 1.2rem !important;
                font-size: 0.9rem;
            }

            .welcome-header h2 {
                font-size: 2rem;
            }

            .schedule-table th,
            .schedule-table td {
                padding: 8px;
                font-size: 0.9rem;
            }

            .schedule-table .time-column {
                width: 15%;
            }
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center">
            <i class="fas fa-hospital-alt"></i>
            <span>Aurora Health Hospital</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="/doctor/dashboard">
                        <i class="fas fa-th-large"></i>Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="/doctor/schedule">
                        <i class="fas fa-calendar-check"></i>Schedule
                    </a>
                </li>
                <!-- Add Pending Appointments Link -->
                <li class="nav-item">
                    <a class="nav-link" href="/doctor/patients">
                        <i class="fas fa-users"></i>Patients
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/prescriptions/add">
                        <i class="fas fa-prescription"></i>Prescriptions
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/lab-tests/request">
                        <i class="fas fa-flask"></i>Lab Tests
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/lab-tests">
                        <i class="fas fa-eye"></i>View Tests
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/doctor/admissions/manage">
                        <i class="fas fa-procedures"></i>Admissions
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/doctor/profile">
                        <i class="fas fa-user-md"></i>My Profile
                    </a>
                </li>

            </ul>
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item">
                    <span class="navbar-text">
                        <i class="fas fa-user-circle"></i>Welcome, Dr. ${username}!
                    </span>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/logout">
                        <i class="fas fa-sign-out-alt"></i>Logout
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <!-- Updated Welcome Section with Background Image -->
    <div class="welcome-header mb-4">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h2 class="mb-1">My Schedule - Dr. ${username}</h2>
                <p class="text-muted">${doctor.department.name}</p>
            </div>
            <div class="col-md-4 text-end">
                <div class="btn-group">
                    <a href="/doctor/schedule" class="btn btn-outline-light">
                        <i class="fas fa-calendar-alt me-2"></i>Today's Schedule
                    </a>
                    <a href="/doctor/appointments/pending" class="btn btn-light">
                        <i class="fas fa-clock me-2"></i>Pending Requests
                        <c:if test="${pendingCount > 0}">
                            <span class="badge bg-warning ms-1">${pendingCount}</span>
                        </c:if>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <c:choose>
        <c:when test="${param.view == 'week'}">
            <!-- WEEK VIEW -->
            <%
                // Get current week dates starting from today
                java.time.LocalDate today = java.time.LocalDate.now();
                java.time.LocalDate startOfWeek = today; // Start from today
                java.time.LocalDate endOfWeek = today.plusDays(6); // End 6 days later (total 7 days)

                pageContext.setAttribute("todayString", today.toString());
                pageContext.setAttribute("startOfWeek", startOfWeek);
                pageContext.setAttribute("endOfWeek", endOfWeek);
            %>

            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5>Weekly Schedule -
                        <fmt:formatDate value="<%= java.sql.Date.valueOf(startOfWeek) %>" pattern="MMM dd"/> to
                        <fmt:formatDate value="<%= java.sql.Date.valueOf(endOfWeek) %>" pattern="MMM dd, yyyy"/>
                    </h5>
                    <div>
                        <a href="?view=day" class="btn btn-sm btn-outline-primary">Switch to Day View</a>
                    </div>
                </div>
                <div class="card-body p-0">
                    <table class="schedule-table">
                        <thead>
                        <tr>
                            <th class="time-column">Time</th>
                            <c:forEach var="dayOffset" begin="0" end="6">
                                <c:set var="currentDay" value="${startOfWeek.plusDays(dayOffset)}" />
                                <th>
                                    <fmt:formatDate value="<%= java.sql.Date.valueOf(startOfWeek.plusDays((Integer)pageContext.getAttribute(\"dayOffset\"))) %>" pattern="EEE"/><br>
                                    <fmt:formatDate value="<%= java.sql.Date.valueOf(startOfWeek.plusDays((Integer)pageContext.getAttribute(\"dayOffset\"))) %>" pattern="MM/dd"/>
                                </th>
                            </c:forEach>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="hour" begin="16" end="21">
                            <c:forEach var="minute" begin="0" end="45" step="15">
                                <tr>
                                    <td class="time-column">
                                        <c:set var="startHour" value="${hour}" />
                                        <c:set var="startMinute" value="${minute}" />
                                        <c:set var="endHour" value="${minute == 45 ? hour + 1 : hour}" />
                                        <c:set var="endMinute" value="${minute == 45 ? 0 : minute + 15}" />
                                            ${startHour}:<fmt:formatNumber value="${startMinute}" minIntegerDigits="2"/> -
                                            ${endHour}:<fmt:formatNumber value="${endMinute}" minIntegerDigits="2"/>
                                    </td>
                                    <c:forEach var="dayOffset" begin="0" end="6">
                                        <c:set var="currentDay" value="${startOfWeek.plusDays(dayOffset)}" />
                                        <td class="appointment-cell">
                                            <c:set var="hasAppointment" value="false" />
                                            <c:forEach var="appointment" items="${appointments}">
                                                <c:if test="${appointment.appointmentDateTime.toLocalDate().equals(currentDay)}">
                                                    <c:set var="appointmentHour" value="${appointment.appointmentDateTime.hour}" />
                                                    <c:set var="appointmentMinute" value="${appointment.appointmentDateTime.minute}" />
                                                    <!-- Show appointment if it falls within this 15-minute slot -->
                                                    <c:if test="${appointmentHour == hour && appointmentMinute == minute}">
                                                        <c:set var="hasAppointment" value="true" />
                                                        <div class="appointment mb-2 p-2">
                                                            <strong>${appointment.patient.firstName} ${appointment.patient.lastName}</strong><br>
                                                            <small class="text-muted">
                                                                <!-- Fixed time formatting -->
                                                                <c:set var="appointmentTime" value="${appointment.appointmentDateTime}" />
                                                                    ${appointmentTime.hour}:<fmt:formatNumber value="${appointmentTime.minute}" minIntegerDigits="2"/>
                                                                    ${appointmentTime.hour >= 12 ? 'PM' : 'AM'}
                                                            </small><br>
                                                            <span class="badge
                                                        <c:choose>
                                                            <c:when test="${appointment.status == 'PENDING_DOCTOR'}">bg-warning</c:when>
                                                            <c:when test="${appointment.status == 'SCHEDULED'}">bg-primary</c:when>
                                                            <c:when test="${appointment.status == 'IN_PROGRESS'}">bg-info</c:when>
                                                            <c:when test="${appointment.status == 'COMPLETED'}">bg-success</c:when>
                                                            <c:when test="${appointment.status == 'CANCELLED'}">bg-danger</c:when>
                                                            <c:otherwise>bg-secondary</c:otherwise>
                                                        </c:choose>">
                                                                    ${appointment.status}
                                                            </span>
                                                            <br>
                                                            <small class="text-muted">
                                                                    ${appointment.reason}<br>
                                                                Payment:
                                                                <span class="badge
                                                            <c:choose>
                                                                <c:when test="${appointment.paymentStatus == 'PAID'}">bg-success</c:when>
                                                                <c:when test="${appointment.paymentStatus == 'PENDING'}">bg-warning</c:when>
                                                                <c:otherwise>bg-secondary</c:otherwise>
                                                            </c:choose>">
                                                                        ${appointment.paymentStatus}
                                                                </span>
                                                                <c:if test="${not empty appointment.paymentMethod}">
                                                                    (${appointment.paymentMethod})
                                                                </c:if>
                                                            </small>
                                                        </div>
                                                    </c:if>
                                                </c:if>
                                            </c:forEach>
                                            <c:if test="${!hasAppointment}">
                                                <span class="no-appointments">-</span>
                                            </c:if>
                                        </td>
                                    </c:forEach>
                                </tr>
                            </c:forEach>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:when>

        <c:otherwise>
            <!-- DAY VIEW (Default) -->
            <%
                // Get current date
                java.time.LocalDate currentLocalDate = java.time.LocalDate.now();
                pageContext.setAttribute("currentLocalDate", currentLocalDate);
            %>

            <div class="row">
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5>Today's Schedule -
                                <!-- Fixed date formatting -->
                                <fmt:formatDate value="<%= java.sql.Date.valueOf(currentLocalDate) %>" pattern="EEEE, MMMM dd, yyyy"/>
                            </h5>
                            <div>
                                <a href="?view=week" class="btn btn-sm btn-outline-primary">Switch to Week View</a>
                            </div>
                        </div>
                        <div class="card-body">
                            <table class="schedule-table">
                                <thead>
                                <tr>
                                    <th class="time-column">Time</th>
                                    <th>Appointments</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="hour" begin="16" end="21">
                                    <c:forEach var="minute" begin="0" end="45" step="15">
                                        <tr>
                                            <td class="time-column">
                                                <c:set var="startHour" value="${hour}" />
                                                <c:set var="startMinute" value="${minute}" />
                                                <c:set var="endHour" value="${minute == 45 ? hour + 1 : hour}" />
                                                <c:set var="endMinute" value="${minute == 45 ? 0 : minute + 15}" />
                                                    ${startHour}:<fmt:formatNumber value="${startMinute}" minIntegerDigits="2"/> -
                                                    ${endHour}:<fmt:formatNumber value="${endMinute}" minIntegerDigits="2"/>
                                            </td>
                                            <td class="appointment-cell">
                                                <c:set var="hasAppointment" value="false" />
                                                <c:forEach var="appointment" items="${appointments}">
                                                    <c:if test="${appointment.appointmentDateTime.toLocalDate().equals(currentLocalDate)}">
                                                        <c:set var="appointmentHour" value="${appointment.appointmentDateTime.hour}" />
                                                        <c:set var="appointmentMinute" value="${appointment.appointmentDateTime.minute}" />
                                                        <!-- Show appointment if it falls within this 15-minute slot -->
                                                        <c:if test="${appointmentHour == hour && appointmentMinute == minute}">
                                                            <c:set var="hasAppointment" value="true" />
                                                            <div class="appointment mb-3 p-3 border rounded">
                                                                <div class="d-flex justify-content-between align-items-start">
                                                                    <div class="flex-grow-1">
                                                                        <h6 class="mb-1">${appointment.patient.firstName} ${appointment.patient.lastName}</h6>
                                                                        <p class="mb-1 text-muted small">${appointment.reason}</p>
                                                                        <div class="d-flex flex-wrap gap-1 mt-2">
                                                                            <span class="badge
                                                                                <c:choose>
                                                                                    <c:when test="${appointment.status == 'PENDING_DOCTOR'}">bg-warning</c:when>
                                                                                    <c:when test="${appointment.status == 'SCHEDULED'}">bg-primary</c:when>
                                                                                    <c:when test="${appointment.status == 'IN_PROGRESS'}">bg-info</c:when>
                                                                                    <c:when test="${appointment.status == 'COMPLETED'}">bg-success</c:when>
                                                                                    <c:when test="${appointment.status == 'CANCELLED'}">bg-danger</c:when>
                                                                                    <c:otherwise>bg-secondary</c:otherwise>
                                                                                </c:choose>">
                                                                                    ${appointment.status}
                                                                            </span>
                                                                            <span class="badge
                                                                                <c:choose>
                                                                                    <c:when test="${appointment.paymentStatus == 'PAID'}">bg-success</c:when>
                                                                                    <c:when test="${appointment.paymentStatus == 'PENDING'}">bg-warning</c:when>
                                                                                    <c:otherwise>bg-secondary</c:otherwise>
                                                                                </c:choose>">
                                                                                    ${appointment.paymentStatus}
                                                                            </span>
                                                                            <c:if test="${not empty appointment.paymentMethod}">
                                                                                <span class="badge bg-info">${appointment.paymentMethod}</span>
                                                                            </c:if>
                                                                        </div>
                                                                        <div class="mt-2">
                                                                            <small class="text-muted">
                                                                                <i class="fas fa-clock me-1"></i>
                                                                                <!-- Fixed time formatting -->
                                                                                <c:set var="appointmentTime" value="${appointment.appointmentDateTime}" />
                                                                                    ${appointmentTime.hour}:<fmt:formatNumber value="${appointmentTime.minute}" minIntegerDigits="2"/>
                                                                                    ${appointmentTime.hour >= 12 ? 'PM' : 'AM'}
                                                                                <c:if test="${not empty appointment.doctor.roomNumber}">
                                                                                    | <i class="fas fa-door-open me-1"></i>Room ${appointment.doctor.roomNumber}
                                                                                </c:if>
                                                                            </small>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="mt-3">
                                                                    <c:if test="${appointment.status == 'PENDING_DOCTOR'}">
                                                                        <a href="/doctor/appointments/pending" class="btn btn-sm btn-warning me-1">
                                                                            <i class="fas fa-clock me-1"></i>Review Request
                                                                        </a>
                                                                    </c:if>
                                                                    <c:if test="${appointment.status == 'SCHEDULED'}">
                                                                        <form action="/appointments/update-status" method="post" class="d-inline me-1">
                                                                            <input type="hidden" name="appointmentId" value="${appointment.id}">
                                                                            <input type="hidden" name="status" value="IN_PROGRESS">
<%--                                                                            <button type="submit" class="btn btn-sm btn-warning">Start Appointment</button>--%>
                                                                        </form>
                                                                    </c:if>
                                                                    <c:if test="${appointment.status == 'IN_PROGRESS'}">
                                                                        <form action="/appointments/update-status" method="post" class="d-inline me-1">
                                                                            <input type="hidden" name="appointmentId" value="${appointment.id}">
                                                                            <input type="hidden" name="status" value="COMPLETED">
                                                                            <button type="submit" class="btn btn-sm btn-success">Complete</button>
                                                                        </form>
                                                                    </c:if>
                                                                    <a href="/doctor/patient/${appointment.patient.id}" class="btn btn-sm btn-info">
                                                                        <i class="fas fa-user me-1"></i>View Patient
                                                                    </a>
                                                                </div>
                                                            </div>
                                                        </c:if>
                                                    </c:if>
                                                </c:forEach>
                                                <c:if test="${!hasAppointment}">
                                                    <div class="text-center py-3 text-muted">
                                                        <i class="fas fa-calendar-times fa-2x mb-2"></i>
                                                        <div>No appointments scheduled</div>
                                                    </div>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <!-- Pending Requests Alert -->
                    <c:if test="${pendingCount > 0}">
                        <div class="card mb-4 border-warning">
                            <div class="card-header bg-warning text-dark">
                                <h6 class="mb-0">
                                    <i class="fas fa-exclamation-triangle me-2"></i>
                                    Pending Appointment Requests
                                </h6>
                            </div>
                            <div class="card-body">
                                <div class="alert alert-warning">
                                    <h6>You have ${pendingCount} pending appointment requests</h6>
                                    <p class="mb-2">Both online and manual payment requests are waiting for your approval.</p>
                                    <a href="/doctor/appointments/pending" class="btn btn-warning btn-sm">
                                        <i class="fas fa-clock me-1"></i>Review Pending Requests
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Upcoming Appointments -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <h6>Upcoming Appointments</h6>
                        </div>
                        <div class="card-body">
                            <c:if test="${empty appointments}">
                                <p class="text-muted">No upcoming appointments</p>
                            </c:if>
                            <c:if test="${not empty appointments}">
                                <c:forEach var="appointment" items="${appointments}" end="5">
                                    <div class="upcoming-item border-bottom pb-2 mb-2">
                                        <strong>
                                            <!-- Fixed time display -->
                                            <c:set var="appointmentTime" value="${appointment.appointmentDateTime}" />
                                                ${appointmentTime.hour}:<fmt:formatNumber value="${appointmentTime.minute}" minIntegerDigits="2"/>
                                                ${appointmentTime.hour >= 12 ? 'PM' : 'AM'}
                                        </strong><br>
                                        <small>${appointment.patient.firstName} ${appointment.patient.lastName}</small><br>
                                        <span class="badge bg-primary">${appointment.reason}</span>
                                        <span class="badge
                                            <c:choose>
                                                <c:when test="${appointment.status == 'PENDING_DOCTOR'}">bg-warning</c:when>
                                                <c:when test="${appointment.status == 'SCHEDULED'}">bg-primary</c:when>
                                                <c:when test="${appointment.status == 'IN_PROGRESS'}">bg-info</c:when>
                                                <c:when test="${appointment.status == 'COMPLETED'}">bg-success</c:when>
                                                <c:when test="${appointment.status == 'CANCELLED'}">bg-danger</c:when>
                                            </c:choose>">
                                                ${appointment.status}
                                        </span>
                                        <c:if test="${not empty appointment.paymentMethod}">
                                            <br><small class="text-muted">Paid via: ${appointment.paymentMethod}</small>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </c:if>
                        </div>
                    </div>

                    <!-- Schedule Statistics -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <h6>My Schedule Statistics</h6>
                        </div>
                        <div class="card-body">
                            <div class="schedule-stats">
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Total Appointments Today:</span>
                                    <strong>${fn:length(appointments)}</strong>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Pending Approval:</span>
                                    <strong>
                                        <c:set var="pendingCount" value="0" />
                                        <c:forEach var="appointment" items="${appointments}">
                                            <c:if test="${appointment.status == 'PENDING_DOCTOR'}">
                                                <c:set var="pendingCount" value="${pendingCount + 1}" />
                                            </c:if>
                                        </c:forEach>
                                            ${pendingCount}
                                    </strong>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Scheduled:</span>
                                    <strong>
                                        <c:set var="scheduledCount" value="0" />
                                        <c:forEach var="appointment" items="${appointments}">
                                            <c:if test="${appointment.status == 'SCHEDULED'}">
                                                <c:set var="scheduledCount" value="${scheduledCount + 1}" />
                                            </c:if>
                                        </c:forEach>
                                            ${scheduledCount}
                                    </strong>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span>In Progress:</span>
                                    <strong>
                                        <c:set var="inProgressCount" value="0" />
                                        <c:forEach var="appointment" items="${appointments}">
                                            <c:if test="${appointment.status == 'IN_PROGRESS'}">
                                                <c:set var="inProgressCount" value="${inProgressCount + 1}" />
                                            </c:if>
                                        </c:forEach>
                                            ${inProgressCount}
                                    </strong>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <span>Completed:</span>
                                    <strong>
                                        <c:set var="completedCount" value="0" />
                                        <c:forEach var="appointment" items="${appointments}">
                                            <c:if test="${appointment.status == 'COMPLETED'}">
                                                <c:set var="completedCount" value="${completedCount + 1}" />
                                            </c:if>
                                        </c:forEach>
                                            ${completedCount}
                                    </strong>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Quick Actions -->
                    <div class="card">
                        <div class="card-header">
                            <h6>Quick Actions</h6>
                        </div>
                        <div class="card-body">
                            <div class="d-grid gap-2">
                                <a href="/doctor/dashboard" class="btn btn-outline-primary">My Dashboard</a>
                                <a href="/doctor/patients" class="btn btn-outline-success">My Patients</a>
                                <a href="/doctor/admissions/manage" class="btn btn-outline-info">My Admissions</a>
                                <a href="/doctor/appointments/pending" class="btn btn-outline-warning">
                                    Pending Requests
                                    <c:if test="${pendingCount > 0}">
                                        <span class="badge bg-warning ms-1">${pendingCount}</span>
                                    </c:if>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- Footer -->
<footer class="py-5 text-white">
    <div class="container position-relative">
        <div class="row">
            <div class="col-lg-4 mb-4">
                <h5 class="fw-bold mb-3">
                    <i class="fas fa-hospital me-2"></i>Aurora Health Hospital
                </h5>
                <p class="text-light-emphasis">
                    Providing exceptional healthcare services with compassion and excellence.
                    Your health is our priority.
                </p>
            </div>
            <!-- Our Services -->
            <div class="col-lg-4 mb-4">
                <h6 class="footer-section-title">Our Services</h6>
                <div class="footer-feature">
                    <i class="fas fa-user-md"></i>
                    <div class="footer-feature-text">
                        <strong>Expert Care</strong>
                        <small>Board-certified physicians</small>
                    </div>
                </div>
                <div class="footer-feature">
                    <i class="fas fa-calendar-check"></i>
                    <div class="footer-feature-text">
                        <strong>Easy Appointments</strong>
                        <small>24/7 online booking system</small>
                    </div>
                </div>
                <div class="footer-feature">
                    <i class="fas fa-flask"></i>
                    <div class="footer-feature-text">
                        <strong>Modern Lab</strong>
                        <small>Advanced diagnostic facilities</small>
                    </div>
                </div>
                <div class="footer-feature">
                    <i class="fas fa-ambulance"></i>
                    <div class="footer-feature-text">
                        <strong>Emergency Care</strong>
                        <small>Round-the-clock availability</small>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 mb-4">
                <h6 class="fw-bold">Contact Info</h6>
                <ul class="list-unstyled text-light-emphasis">
                    <li><i class="fas fa-phone me-2"></i>Emergency: 011-2224455</li>
                    <li><i class="fas fa-envelope me-2"></i>info@aurorahealth.com</li>
                    <li><i class="fas fa-map-marker-alt me-2"></i>Colombo, Srilanka</li>
                    <!-- Facebook Link -->
                    <li class="mt-3">
                        <a href="https://facebook.com/theekshana.indrajith.311798"
                           target="_blank"
                           class="text-decoration-none text-light-emphasis">
                            <i class="fab fa-facebook me-2"></i>
                            <span>Follow us on Facebook</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
        <hr class="my-4">
        <div class="text-center">
            <p class="mb-0 text-light-emphasis">
                &copy; 2025 Aurora Health Hospital. All rights reserved. |
                <span class="text-warning">Compassionate Care • Advanced Medicine</span>
            </p>
        </div>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Navbar scroll effect
    window.addEventListener('scroll', function() {
        const navbar = document.querySelector('.navbar');
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });
</script>
</body>
</html>