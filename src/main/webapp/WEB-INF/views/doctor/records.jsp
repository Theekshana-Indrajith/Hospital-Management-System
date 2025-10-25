<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Medical Records - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-success">
    <div class="container">
        <a class="navbar-brand">🏥 HMS</a>
        <div class="navbar-nav">
            <a class="nav-link" href="/doctor/dashboard">Dashboard</a>
            <a class="nav-link" href="/appointments/doctor-schedule">My Schedule</a>
            <a class="nav-link" href="/doctor/patients">Patients</a>
            <a class="nav-link" href="/doctor/admissions">Admissions</a>
            <a class="nav-link active" href="/doctor/records">Medical Records</a>
        </div>
        <div class="navbar-nav ms-auto">
            <a class="nav-link" href="/logout">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <h1>Medical Records System</h1>

    <div class="row mb-4">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    <div class="row text-center">
                        <div class="col-md-3">
                            <h4 class="text-primary">1,247</h4>
                            <small>Total Records</small>
                        </div>
                        <div class="col-md-3">
                            <h4 class="text-success">342</h4>
                            <small>Active Patients</small>
                        </div>
                        <div class="col-md-3">
                            <h4 class="text-warning">89</h4>
                            <small>Pending Lab Results</small>
                        </div>
                        <div class="col-md-3">
                            <h4 class="text-info">56</h4>
                            <small>New This Month</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-4">
            <!-- Search Panel -->
            <div class="card mb-4">
                <div class="card-header">
                    <h6>Search Records</h6>
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <label class="form-label">Patient Name</label>
                        <input type="text" class="form-control" placeholder="Enter patient name">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Patient ID</label>
                        <input type="text" class="form-control" placeholder="Enter patient ID">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Date Range</label>
                        <div class="input-group">
                            <input type="date" class="form-control">
                            <span class="input-group-text">to</span>
                            <input type="date" class="form-control">
                        </div>
                    </div>
                    <button class="btn btn-primary w-100">Search Records</button>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="card">
                <div class="card-header">
                    <h6>Quick Actions</h6>
                </div>
                <div class="card-body">
                    <div class="d-grid gap-2">
                        <button class="btn btn-outline-primary">New Medical Record</button>
                        <button class="btn btn-outline-success">Lab Results</button>
                        <button class="btn btn-outline-info">Prescription History</button>
                        <button class="btn btn-outline-warning">Medical Reports</button>
                        <button class="btn btn-outline-danger">Emergency Access</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-8">
            <!-- Recent Records -->
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5>Recent Medical Records</h5>
                    <div class="btn-group">
                        <button class="btn btn-sm btn-outline-primary active">All</button>
                        <button class="btn btn-sm btn-outline-success">Today</button>
                        <button class="btn btn-sm btn-outline-info">This Week</button>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th>Patient</th>
                                <th>Record Date</th>
                                <th>Type</th>
                                <th>Doctor</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>
                                    <strong>John Smith</strong><br>
                                    <small class="text-muted">ID: #P1001</small>
                                </td>
                                <td>2024-01-15</td>
                                <td>Consultation</td>
                                <td>Dr. Kamal Perera</td>
                                <td><span class="badge bg-success">Completed</span></td>
                                <td>
                                    <button class="btn btn-sm btn-info">View</button>
                                    <button class="btn btn-sm btn-warning">Edit</button>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <strong>Mary Johnson</strong><br>
                                    <small class="text-muted">ID: #P1002</small>
                                </td>
                                <td>2024-01-14</td>
                                <td>Lab Results</td>
                                <td>Dr. Nimali Fernando</td>
                                <td><span class="badge bg-warning">Pending Review</span></td>
                                <td>
                                    <button class="btn btn-sm btn-info">View</button>
                                    <button class="btn btn-sm btn-success">Approve</button>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <strong>David Brown</strong><br>
                                    <small class="text-muted">ID: #P1003</small>
                                </td>
                                <td>2024-01-13</td>
                                <td>Prescription</td>
                                <td>Dr. Sunil Rathnayake</td>
                                <td><span class="badge bg-primary">Active</span></td>
                                <td>
                                    <button class="btn btn-sm btn-info">View</button>
                                    <button class="btn btn-sm btn-danger">Cancel</button>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <strong>Sarah Wilson</strong><br>
                                    <small class="text-muted">ID: #P1004</small>
                                </td>
                                <td>2024-01-12</td>
                                <td>Surgery Report</td>
                                <td>Dr. Priya Silva</td>
                                <td><span class="badge bg-success">Completed</span></td>
                                <td>
                                    <button class="btn btn-sm btn-info">View</button>
                                    <button class="btn btn-sm btn-secondary">Print</button>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Record Statistics -->
            <div class="row mt-4">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h6>Record Types</h6>
                        </div>
                        <div class="card-body">
                            <div class="d-flex justify-content-between mb-2">
                                <span>Consultations:</span>
                                <strong>456</strong>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Lab Results:</span>
                                <strong>234</strong>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Prescriptions:</span>
                                <strong>189</strong>
                            </div>
                            <div class="d-flex justify-content-between">
                                <span>Surgery Reports:</span>
                                <strong>67</strong>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h6>Monthly Activity</h6>
                        </div>
                        <div class="card-body">
                            <div class="d-flex justify-content-between mb-2">
                                <span>January 2024:</span>
                                <strong>156 records</strong>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>December 2023:</span>
                                <strong>142 records</strong>
                            </div>
                            <div class="d-flex justify-content-between">
                                <span>November 2023:</span>
                                <strong>128 records</strong>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
