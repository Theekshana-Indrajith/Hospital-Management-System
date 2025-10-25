<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Financial Report - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap');

        /* Use the same CSS variables as dashboard */
        :root {
            --primary-gradient: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            --success-gradient: linear-gradient(135deg, #00b4db 0%, #0083b0 100%);
            --danger-gradient: linear-gradient(135deg, #ff416c 0%, #ff4b2b 100%);
            --warning-gradient: linear-gradient(135deg, #f7971e 0%, #ffd200 100%);
            --info-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --dark-gradient: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            --light-bg: rgba(255, 255, 255, 0.95);
            --shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }

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
        }

        /* Navigation - Same as dashboard */
        .navbar {
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.98) 0%, rgba(248, 249, 250, 0.98) 100%) !important;
            backdrop-filter: blur(15px);
            box-shadow: 0 4px 30px rgba(30, 60, 114, 0.1);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            padding: 15px 0;
            border-bottom: 1px solid rgba(30, 60, 114, 0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .navbar.scrolled {
            background: linear-gradient(135deg, rgba(255, 255, 255, 1) 0%, rgba(248, 249, 250, 1) 100%) !important;
            padding: 10px 0;
            box-shadow: 0 8px 40px rgba(30, 60, 114, 0.15);
            border-bottom: 2px solid rgba(30, 60, 114, 0.2);
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
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
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
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
            background: linear-gradient(135deg, rgba(30, 60, 114, 0.1), rgba(42, 82, 152, 0.1));
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
            background: linear-gradient(90deg, #1e3c72, #2a5298);
            border-radius: 2px;
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }

        .nav-link:hover,
        .nav-link.active {
            color: #1e3c72 !important;
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

        .navbar-text {
            font-weight: 600;
            color: #2c3e50 !important;
            padding: 8px 20px;
            margin: 0 5px;
            border-radius: 8px;
            background: linear-gradient(135deg, rgba(30, 60, 114, 0.1), rgba(42, 82, 152, 0.1));
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
        }

        .navbar-text:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(30, 60, 114, 0.2);
        }

        .navbar-text i {
            margin-right: 0.5rem;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        /* Card Styling */
        .card {
            border: none;
            border-radius: 15px;
            background: var(--light-bg);
            backdrop-filter: blur(12px);
            box-shadow: var(--shadow);
            transition: transform 0.4s ease, box-shadow 0.4s ease;
            margin-bottom: 1.5rem;
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

        /* Financial Summary Cards */
        .card.bg-primary {
            background: var(--primary-gradient) !important;
            border: none;
        }

        .card.bg-info {
            background: var(--info-gradient) !important;
            border: none;
        }

        .card.bg-warning {
            background: var(--warning-gradient) !important;
            border: none;
        }

        .card.bg-secondary {
            background: linear-gradient(135deg, #6c757d 0%, #868e96 100%) !important;
            border: none;
        }

        .card.bg-success {
            background: var(--success-gradient) !important;
            border: none;
        }

        /* Button Styling */
        .btn-primary {
            background: var(--primary-gradient);
            border: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(30, 60, 114, 0.3);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #6c757d 0%, #868e96 100%);
            border: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(108, 117, 125, 0.3);
        }

        /* Alert Styling */
        .alert {
            border-radius: 12px;
            box-shadow: var(--shadow);
            position: relative;
            overflow: hidden;
            background: var(--light-bg);
            backdrop-filter: blur(10px);
        }

        .alert-warning::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 6px;
            height: 100%;
            background: var(--warning-gradient);
        }

        /* Table Styling */
        .table-responsive {
            border-radius: 12px;
            overflow: hidden;
        }

        .table {
            margin-bottom: 0;
            border-radius: 12px;
            overflow: hidden;
        }

        .table th {
            background: var(--primary-gradient);
            color: white;
            border: none;
            padding: 1rem;
            font-weight: 600;
        }

        .table td {
            padding: 1rem;
            vertical-align: middle;
            border-color: rgba(30, 60, 114, 0.1);
        }

        .table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(30, 60, 114, 0.05);
        }

        .table-hover tbody tr:hover {
            background-color: rgba(30, 60, 114, 0.1);
        }

        /* Progress Bar Styling */
        .progress {
            background-color: rgba(30, 60, 114, 0.1);
            border-radius: 10px;
            overflow: hidden;
        }

        .progress-bar {
            background: var(--primary-gradient);
            border-radius: 10px;
            font-weight: 600;
            font-size: 0.8rem;
        }

        /* Border boxes for revenue summary */
        .border.rounded {
            border: 2px solid rgba(30, 60, 114, 0.1) !important;
            border-radius: 12px !important;
            transition: all 0.3s ease;
        }

        .border.rounded:hover {
            border-color: rgba(30, 60, 114, 0.3) !important;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        /* Footer Styling */
        footer {
            background: var(--dark-gradient) !important;
            color: #fff;
            position: relative;
            overflow: hidden;
            margin-top: 3rem;
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

        /* Responsive Design */
        @media (max-width: 768px) {
            .navbar-brand {
                font-size: 1.3rem;
            }

            .nav-link {
                padding: 0.7rem 1.2rem !important;
                font-size: 0.9rem;
            }

            .card {
                margin-bottom: 1rem;
            }
        }
    </style>
</head>
<body>
<!-- Enhanced Navigation Bar -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center">
            <i class="fas fa-hospital-alt"></i>
            <span>Aurora Health Hospital</span>
        </a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item">
                    <span class="navbar-text">
                        <i class="fas fa-user-circle"></i>Welcome, ${username} (Administrator)
                    </span>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header bg-success text-white">
                    <h4 class="mb-0"><i class="fas fa-money-bill-wave me-2"></i>Financial Report - ${report.reportPeriod}</h4>
                </div>
                <div class="card-body">
                    <c:if test="${not empty report.error}">
                        <div class="alert alert-warning">
                            <i class="fas fa-exclamation-triangle me-2"></i>${report.error}
                        </div>
                    </c:if>

                    <!-- Financial Summary Cards -->
                    <div class="row mb-4">
                        <div class="col-md-3">
                            <div class="card text-white bg-primary">
                                <div class="card-body text-center">
                                    <h5>Total Revenue</h5>
                                    <h3>Rs. <fmt:formatNumber value="${report.totalRevenue}" pattern="#,##0.00"/></h3>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card text-white bg-info">
                                <div class="card-body text-center">
                                    <h5>Appointment Revenue</h5>
                                    <h3>Rs. <fmt:formatNumber value="${report.appointmentRevenue}" pattern="#,##0.00"/></h3>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card text-white bg-warning">
                                <div class="card-body text-center">
                                    <h5>Admission Revenue</h5>
                                    <h3>Rs. <fmt:formatNumber value="${report.admissionRevenue}" pattern="#,##0.00"/></h3>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card text-white bg-secondary">
                                <div class="card-body text-center">
                                    <h5>Paid Appointments</h5>
                                    <h3>${report.paidAppointmentsCount}</h3>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Revenue Breakdown -->
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-header bg-info text-white">
                                    <h5 class="mb-0"><i class="fas fa-chart-pie me-2"></i>Revenue Breakdown</h5>
                                </div>
                                <div class="card-body">
                                    <div class="mb-3">
                                        <strong>Appointment Revenue:</strong>
                                        <span class="float-end">Rs. <fmt:formatNumber value="${report.appointmentRevenue}" pattern="#,##0.00"/></span>
                                    </div>
                                    <div class="mb-3">
                                        <strong>Admission Revenue:</strong>
                                        <span class="float-end">Rs. <fmt:formatNumber value="${report.admissionRevenue}" pattern="#,##0.00"/></span>
                                    </div>
                                    <hr>
                                    <div class="mb-3">
                                        <strong>Total Revenue:</strong>
                                        <span class="float-end text-success fw-bold">Rs. <fmt:formatNumber value="${report.totalRevenue}" pattern="#,##0.00"/></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-header bg-warning text-white">
                                    <h5 class="mb-0"><i class="fas fa-calendar me-2"></i>Report Period</h5>
                                </div>
                                <div class="card-body">
                                    <div class="mb-3">
                                        <strong>Start Date:</strong>
                                        <span class="float-end">${report.startDate}</span>
                                    </div>
                                    <div class="mb-3">
                                        <strong>End Date:</strong>
                                        <span class="float-end">${report.endDate}</span>
                                    </div>
                                    <div class="mb-3">
                                        <strong>Duration:</strong>
                                        <span class="float-end">30 Days</span>
                                    </div>
                                    <div class="mb-3">
                                        <strong>Generated On:</strong>
                                        <span class="float-end">${report.generatedDate}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Payment Method Statistics -->
                    <c:if test="${not empty report.paymentMethodStats}">
                        <div class="row mb-4">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header bg-primary text-white">
                                        <h5 class="mb-0"><i class="fas fa-credit-card me-2"></i>Payment Method Distribution</h5>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-striped">
                                                <thead>
                                                <tr>
                                                    <th>Payment Method</th>
                                                    <th>Number of Transactions</th>
                                                    <th>Total Amount</th>
                                                    <th>Percentage</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <c:forEach items="${report.paymentMethodStats}" var="payment">
                                                    <tr>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${payment.key == 'CASH'}"><i class="fas fa-money-bill me-2"></i>Cash</c:when>
                                                                <c:when test="${payment.key == 'CARD'}"><i class="fas fa-credit-card me-2"></i>Card</c:when>
                                                                <c:when test="${payment.key == 'ONLINE'}"><i class="fas fa-globe me-2"></i>Online</c:when>
                                                                <c:when test="${payment.key == 'INSURANCE'}"><i class="fas fa-shield-alt me-2"></i>Insurance</c:when>
                                                                <c:otherwise><i class="fas fa-question me-2"></i>${payment.key}</c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>${payment.value.count}</td>
                                                        <td>Rs. <fmt:formatNumber value="${payment.value.amount}" pattern="#,##0.00"/></td>
                                                        <td>
                                                            <div class="progress" style="height: 20px;">
                                                                <div class="progress-bar" style="width: ${payment.value.percentage}%">
                                                                        ${payment.value.percentage}%
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Daily Revenue Trend -->
                    <div class="row mb-4">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-header bg-success text-white">
                                    <h5 class="mb-0"><i class="fas fa-chart-line me-2"></i>Revenue Summary</h5>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="text-center p-3 border rounded">
                                                <h6 class="text-muted">Average Daily Revenue</h6>
                                                <h4 class="text-primary">Rs. <fmt:formatNumber value="${report.totalRevenue / 30}" pattern="#,##0.00"/></h4>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="text-center p-3 border rounded">
                                                <h6 class="text-muted">Revenue per Appointment</h6>
                                                <h4 class="text-info">Rs. <fmt:formatNumber value="${report.paidAppointmentsCount > 0 ? report.appointmentRevenue / report.paidAppointmentsCount : 0}" pattern="#,##0.00"/></h4>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="text-center p-3 border rounded">
                                                <h6 class="text-muted">Monthly Projection</h6>
                                                <h4 class="text-success">Rs. <fmt:formatNumber value="${report.totalRevenue}" pattern="#,##0.00"/></h4>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col-md-12">
                            <a href="/admin/reports" class="btn btn-secondary">
                                <i class="fas fa-arrow-left me-2"></i>Back to Reports
                            </a>
                            <button onclick="window.print()" class="btn btn-primary">
                                <i class="fas fa-print me-2"></i>Print Report
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

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