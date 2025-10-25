<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Edit Ward - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .form-control:focus, .form-select:focus {
            border-color: #2ecc71;
            box-shadow: 0 0 0 0.2rem rgba(46, 204, 113, 0.25);
        }
        .btn-primary {
            background: linear-gradient(135deg, #2ecc71 0%, #27ae60 100%);
            border: none;
            border-radius: 25px;
            font-weight: 600;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(46, 204, 113, 0.3);
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-info">
    <div class="container">
        <a class="navbar-brand" href="">🏥 HMS - Ward Management</a>
        <div class="navbar-nav">
            <a class="nav-link" href="/ward-manager/dashboard">Dashboard</a>
            <a class="nav-link" href="/ward-manager/wards">← Back to Wards</a>
        </div>
        <div class="navbar-nav ms-auto">
            <span class="navbar-text">Welcome, ${username} (Ward Manager)</span>
            <a class="nav-link" href="/logout">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-8">

            <!-- Success/Error Messages -->
            <c:if test="${not empty param.success}">
                <div class="alert alert-success alert-dismissible fade show">
                    <i class="fas fa-check-circle me-2"></i><strong>Success!</strong> ${param.success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <c:if test="${not empty param.error}">
                <div class="alert alert-danger alert-dismissible fade show">
                    <i class="fas fa-exclamation-triangle me-2"></i><strong>Error!</strong> ${param.error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="card">
                <div class="card-header bg-warning text-white">
                    <h4 class="mb-0"><i class="fas fa-edit me-2"></i>Edit Ward - ${ward.wardNumber}</h4>
                </div>
                <div class="card-body">
                    <!-- Use individual @RequestParam instead of @ModelAttribute -->
                    <form action="/ward-manager/wards/update/${ward.id}" method="post">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Ward Number</label>
                                    <input type="text" name="wardNumber" class="form-control" value="${ward.wardNumber}" required readonly>
                                    <small class="text-muted">Ward number cannot be changed</small>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Ward Type *</label>
                                    <select name="wardType" class="form-select" required>
                                        <option value="GENERAL" ${ward.wardType == 'GENERAL' ? 'selected' : ''}>General</option>
                                        <option value="ICU" ${ward.wardType == 'ICU' ? 'selected' : ''}>ICU</option>
                                        <option value="PEDIATRIC" ${ward.wardType == 'PEDIATRIC' ? 'selected' : ''}>Pediatric</option>
                                        <option value="SURGICAL" ${ward.wardType == 'SURGICAL' ? 'selected' : ''}>Surgical</option>
                                        <option value="MATERNITY" ${ward.wardType == 'MATERNITY' ? 'selected' : ''}>Maternity</option>
                                        <option value="CARDIAC" ${ward.wardType == 'CARDIAC' ? 'selected' : ''}>Cardiac</option>
                                        <option value="NEUROLOGY" ${ward.wardType == 'NEUROLOGY' ? 'selected' : ''}>Neurology</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Department *</label>
                                    <select name="departmentId" class="form-select" required>
                                        <option value="">Select Department</option>
                                        <c:forEach var="dept" items="${departments}">
                                            <option value="${dept.id}" ${ward.department.id == dept.id ? 'selected' : ''}>
                                                    ${dept.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Charge Per Day (Rs.) *</label>
                                    <input type="number" step="0.01" name="chargePerDay" class="form-control"
                                           value="<fmt:formatNumber value="${ward.chargePerDay}" pattern="0.00"/>" min="0" required>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Total Beds *</label>
                                    <input type="number" name="totalBeds" class="form-control"
                                           value="${ward.totalBeds}" min="1" required
                                           onchange="validateAvailableBeds()">
                                    <small class="text-muted">Changing total beds will affect available beds count</small>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Available Beds *</label>
                                    <input type="number" name="availableBeds" class="form-control"
                                           value="${ward.availableBeds}" min="0"
                                           id="availableBedsInput" required
                                           onchange="validateAvailableBeds()">
                                    <small class="text-muted">Cannot exceed total beds</small>
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea name="description" class="form-control" rows="3"
                                      placeholder="Ward description, location, and special features...">${ward.description}</textarea>
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="/ward-manager/wards" class="btn btn-secondary me-md-2">
                                <i class="fas fa-times me-1"></i>Cancel
                            </a>
                            <button type="submit" class="btn btn-primary" id="submitBtn">
                                <i class="fas fa-save me-1"></i>Update Ward
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Ward Statistics -->
            <div class="card mt-4">
                <div class="card-header bg-info text-white">
                    <h5 class="mb-0"><i class="fas fa-chart-bar me-2"></i>Ward Statistics</h5>
                </div>
                <div class="card-body">
                    <div class="row text-center">
                        <div class="col-md-4">
                            <h6>Total Beds</h6>
                            <h4 class="text-primary">${ward.totalBeds}</h4>
                        </div>
                        <div class="col-md-4">
                            <h6>Available Beds</h6>
                            <h4 class="text-success">${ward.availableBeds}</h4>
                        </div>
                        <div class="col-md-4">
                            <h6>Occupancy Rate</h6>
                            <h4 class="text-warning">
                                <fmt:formatNumber value="${(ward.totalBeds - ward.availableBeds) / ward.totalBeds * 100}" pattern="0.0"/>%
                            </h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Validate that available beds don't exceed total beds
    function validateAvailableBeds() {
        const totalBeds = parseInt(document.querySelector('input[name="totalBeds"]').value) || 0;
        const availableBedsInput = document.getElementById('availableBedsInput');
        let availableBeds = parseInt(availableBedsInput.value) || 0;

        if (availableBeds > totalBeds) {
            alert(`Available beds (${availableBeds}) cannot exceed total beds (${totalBeds}). Setting to maximum.`);
            availableBedsInput.value = totalBeds;
        }

        if (availableBeds < 0) {
            alert('Available beds cannot be negative. Setting to 0.');
            availableBedsInput.value = 0;
        }

        // Update max attribute
        availableBedsInput.max = totalBeds;
    }

    // Form validation before submission
    document.querySelector('form').addEventListener('submit', function(e) {
        const totalBeds = parseInt(document.querySelector('input[name="totalBeds"]').value) || 0;
        const availableBeds = parseInt(document.querySelector('input[name="availableBeds"]').value) || 0;

        if (availableBeds > totalBeds) {
            e.preventDefault();
            alert('Error: Available beds cannot exceed total beds. Please fix this before submitting.');
            return false;
        }

        if (availableBeds < 0) {
            e.preventDefault();
            alert('Error: Available beds cannot be negative. Please fix this before submitting.');
            return false;
        }

        console.log('Submitting form with:', {
            totalBeds: totalBeds,
            availableBeds: availableBeds
        });
    });

    // Auto-hide alerts after 5 seconds
    setTimeout(() => {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        });
    }, 5000);
</script>
</body>
</html>