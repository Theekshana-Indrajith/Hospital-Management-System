<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Reports - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

        .nav-link.active {
            color: #1e3c72 !important;
            transform: translateY(-2px);
        }

        .nav-link.active::before {
            opacity: 1;
        }

        .nav-link.active::after {
            width: 80%;
        }

        /* Page Header */
        .page-header {
            position: relative;
            background-image: url('https://images.unsplash.com/photo-1559757148-5c350d0d3c56?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            padding: 2rem 1rem;
            border-radius: 15px;
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(30, 60, 114, 0.7);
            z-index: 0;
        }

        .page-header > * {
            position: relative;
            z-index: 1;
            color: #fff;
        }

        .page-header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            color: #fff;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);
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
            height: 100%;
        }

        .card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
        }

        .report-card {
            background: white;
            border-left: 4px solid #1e3c72;
            transition: all 0.3s ease;
        }

        .report-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }

        .report-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }

        .financial { background: var(--success-gradient); color: white; }
        .patient { background: var(--primary-gradient); color: white; }
        .appointment { background: var(--info-gradient); color: white; }
        .ward { background: var(--warning-gradient); color: white; }
        .doctor { background: var(--danger-gradient); color: white; }
        .system { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; }

        .btn-report {
            background: var(--primary-gradient);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .btn-report:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(30, 60, 114, 0.3);
            color: white;
        }

        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            border-top: 4px solid #1e3c72;
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: #1e3c72;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            font-size: 0.9rem;
            color: #6c757d;
            font-weight: 600;
        }

        /* Footer */
        footer {
            background: var(--dark-gradient) !important;
            color: #fff;
            position: relative;
            overflow: hidden;
            margin-top: 3rem;
        }
    </style>
</head>
<body>
<!-- Navigation Bar - Same as dashboard -->
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
                    <a class="nav-link" href="/admin/dashboard">
                        <i class="fas fa-th-large"></i>Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/admin/doctors">
                        <i class="fas fa-user-md"></i>Doctor Management
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/medical-staff/dashboard">
                        <i class="fas fa-users"></i>Staff & Departments
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="/admin/reports">
                        <i class="fas fa-chart-bar"></i>Reports
                    </a>
                </li>

            </ul>
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item">
                    <span class="navbar-text">
                        <i class="fas fa-user-circle"></i>Welcome, ${username} (Administrator)
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
    <!-- Page Header -->
    <div class="page-header mb-4">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h1 class="mb-1">Reports Dashboard</h1>
                <p class="text-muted">Comprehensive analytics and reporting for hospital management</p>
            </div>
        </div>
    </div>

    <!-- Quick Stats -->
    <div class="row mb-4">
        <div class="col-md-3 mb-3">
            <div class="stat-card">
                <div class="stat-number">${systemUsage.totalPatients}</div>
                <div class="stat-label">Total Patients</div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="stat-card">
                <div class="stat-number">${quickStats.totalDoctors}</div>
                <div class="stat-label">Total Doctors</div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="stat-card">
                <div class="stat-number">${systemUsage.totalAppointments}</div>
                <div class="stat-label">Total Appointments</div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="stat-card">
                <div class="stat-number">${quickStats.currentAdmissions}</div>
                <div class="stat-label">Current Admissions</div>
            </div>
        </div>
    </div>

    <!-- Report Summary Cards -->
    <div class="row mb-4">
        <div class="col-md-4 mb-3">
            <div class="card text-white bg-success">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h5>Total Revenue (Last 30 Days)</h5>
                            <h3>Rs. ${financialReport.totalRevenue}</h3>
                        </div>
                        <div class="align-self-center">
                            <i class="fas fa-money-bill-wave fa-2x"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="card text-white bg-primary">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h5>New Patients (Last 30 Days)</h5>
                            <h3>${patientReport.newPatientsCount}</h3>
                        </div>
                        <div class="align-self-center">
                            <i class="fas fa-procedures fa-2x"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="card text-white bg-info">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h5>Appointments (Last 30 Days)</h5>
                            <h3>${appointmentReport.totalAppointments}</h3>
                        </div>
                        <div class="align-self-center">
                            <i class="fas fa-calendar-check fa-2x"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Report Categories -->
    <div class="row">
        <!-- Financial Reports -->
        <div class="col-md-4 mb-4">
            <div class="card report-card">
                <div class="card-body">
                    <div class="report-icon financial">
                        <i class="fas fa-money-bill-wave"></i>
                    </div>
                    <h5 class="card-title">Financial Reports</h5>
                    <p class="card-text">Revenue analysis, payment tracking, and financial performance metrics.</p>
                    <div class="mt-3">
                        <a href="/admin/reports/financial" class="btn btn-report w-100">
                            <i class="fas fa-chart-line me-2"></i>View Financial Report
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Patient Reports -->
        <div class="col-md-4 mb-4">
            <div class="card report-card">
                <div class="card-body">
                    <div class="report-icon patient">
                        <i class="fas fa-procedures"></i>
                    </div>
                    <h5 class="card-title">Patient Reports</h5>
                    <p class="card-text">Patient demographics, registration trends, and medical statistics.</p>
                    <div class="mt-3">
                        <a href="/admin/reports/patients" class="btn btn-report w-100">
                            <i class="fas fa-chart-pie me-2"></i>View Patient Report
                        </a>
                    </div>
                </div>
            </div>
        </div>


        <!-- Ward Reports -->
        <div class="col-md-4 mb-4">
            <div class="card report-card">
                <div class="card-body">
                    <div class="report-icon ward">
                        <i class="fas fa-bed"></i>
                    </div>
                    <h5 class="card-title">Ward Reports</h5>
                    <p class="card-text">Bed occupancy rates, ward utilization, and admission patterns.</p>
                    <div class="mt-3">
                        <a href="/admin/reports/wards" class="btn btn-report w-100">
                            <i class="fas fa-chart-area me-2"></i>View Ward Report
                        </a>
                    </div>
                </div>
            </div>
        </div>


    </div>

    <!-- Recent Activity / Quick Charts -->
    <div class="row mt-4">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="fas fa-chart-pie me-2"></i>User Distribution</h5>
                </div>
                <div class="card-body">
                    <canvas id="userDistributionChart" width="400" height="200"></canvas>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card">
                <div class="card-header bg-success text-white">
                    <h5 class="mb-0"><i class="fas fa-chart-bar me-2"></i>Ward Occupancy</h5>
                </div>
                <div class="card-body">
                    <canvas id="wardOccupancyChart" width="400" height="200"></canvas>
                </div>
            </div>
        </div>
    </div>
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

    // User Distribution Chart
    const userCtx = document.getElementById('userDistributionChart').getContext('2d');

    // Get the actual data values from backend
    const adminCount = ${systemUsage.adminUsers};
    const doctorCount = ${systemUsage.doctorUsers};
    const patientCount = ${systemUsage.patientUsers};
    const staffCount = ${systemUsage.staffUsers};

    const userChartData = [adminCount, doctorCount, patientCount, staffCount];
    const totalUsers = adminCount + doctorCount + patientCount + staffCount; // Fixed this line

    console.log('User Distribution Data:', {
        adminCount, doctorCount, patientCount, staffCount, totalUsers
    });

    const userChart = new Chart(userCtx, {
        type: 'pie',
        data: {
            labels: ['Admins', 'Doctors', 'Patients', 'Staff'],
            datasets: [{
                data: userChartData,
                backgroundColor: [
                    '#1e3c72',
                    '#00b4db',
                    '#667eea',
                    '#f7971e'
                ],
                borderWidth: 2,
                borderColor: '#fff'
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'bottom'
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            const label = context.label || '';
                            const value = context.raw || 0;
                            const total = userChartData.reduce((a, b) => a + b, 0);
                            const percentage = total > 0 ? Math.round((value / total) * 100) : 0;
                            return `${label}: ${value} (${percentage}%)`;
                        }
                    }
                }
            }
        }
    });

    // Ward Occupancy Chart
    const wardCtx = document.getElementById('wardOccupancyChart').getContext('2d');

    // Get ward data from the model
    const wardLabels = [];
    const wardOccupancyData = [];

    <c:forEach items="${wardOccupancy}" var="ward">
    wardLabels.push("${ward.key}");
    wardOccupancyData.push(parseFloat("${ward.value.occupancyRate}".replace('%', '')));
    </c:forEach>

    const wardChart = new Chart(wardCtx, {
        type: 'bar',
        data: {
            labels: wardLabels,
            datasets: [{
                label: 'Occupancy Rate (%)',
                data: wardOccupancyData,
                backgroundColor: [
                    'rgba(30, 60, 114, 0.8)',
                    'rgba(0, 180, 219, 0.8)',
                    'rgba(102, 126, 234, 0.8)',
                    'rgba(247, 151, 30, 0.8)',
                    'rgba(255, 65, 108, 0.8)',
                    'rgba(75, 192, 192, 0.8)',
                    'rgba(153, 102, 255, 0.8)'
                ].slice(0, wardLabels.length),
                borderColor: [
                    '#1e3c72',
                    '#00b4db',
                    '#667eea',
                    '#f7971e',
                    '#ff416c',
                    '#4bc0c0',
                    '#9966ff'
                ].slice(0, wardLabels.length),
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true,
                    max: 100,
                    title: {
                        display: true,
                        text: 'Occupancy Rate (%)'
                    }
                },
                x: {
                    ticks: {
                        maxRotation: 45,
                        minRotation: 45
                    }
                }
            }
        }
    });
</script>
</body>
</html>