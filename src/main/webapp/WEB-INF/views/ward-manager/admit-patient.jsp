<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Admit Patient - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-info">
    <div class="container">
        <a class="navbar-brand">🏥 HMS - Ward Management</a>
        <div class="navbar-nav">
            <a class="nav-link" href="/ward-manager/dashboard">Dashboard</a>
            <a class="nav-link" href="/ward-manager/admissions">← Back to Admissions</a>
            <a class="nav-link active" href="/ward-manager/admissions/admit">Admit Patient</a>
        </div>
        <div class="navbar-nav ms-auto">
            <span class="navbar-text">Welcome, ${username} (Ward Manager)</span>
            <a class="nav-link" href="/logout">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="card">
                <div class="card-header bg-success text-white">
                    <h4 class="mb-0"><i class="fas fa-user-plus me-2"></i>Admit Patient to Ward</h4>
                </div>
                <div class="card-body">
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

                    <form action="/ward-manager/admissions/admit" method="post" id="admissionForm">
                        <!-- Patient Selection -->
                        <div class="mb-4">
                            <h5 class="border-bottom pb-2"><i class="fas fa-user me-2"></i>Select Patient</h5>
                            <div class="mb-3">
                                <label class="form-label">Patient *</label>
                                <select name="patientId" class="form-select" required id="patientSelect">
                                    <option value="">Select a Patient</option>
                                    <c:forEach var="patient" items="${patients}">
                                        <option value="${patient.id}">
                                                ${patient.firstName} ${patient.lastName} (${patient.contactNumber})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <!-- Ward and Bed Selection -->
                        <div class="mb-4">
                            <h5 class="border-bottom pb-2"><i class="fas fa-procedures me-2"></i>Select Ward & Bed</h5>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Ward *</label>
                                        <select name="wardId" class="form-select" required id="wardSelect">
                                            <option value="">Select a Ward</option>
                                            <c:forEach var="ward" items="${availableWards}">
                                                <option value="${ward.id}">
                                                        ${ward.wardNumber} - ${ward.wardType} (${ward.availableBeds} beds available)
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Available Bed *</label>
                                        <select name="bedId" class="form-select" required id="bedSelect" disabled>
                                            <option value="">First select a ward</option>
                                        </select>
                                        <div class="form-text" id="bedHelpText">Please select a ward to see available beds</div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Admission Details -->
                        <div class="mb-4">
                            <h5 class="border-bottom pb-2"><i class="fas fa-file-medical me-2"></i>Admission Details</h5>
                            <div class="mb-3">
                                <label class="form-label">Reason for Admission *</label>
                                <textarea name="reason" class="form-control" rows="3"
                                          placeholder="Enter the reason for admission..." required></textarea>
                            </div>
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="/ward-manager/admissions" class="btn btn-secondary me-md-2">
                                <i class="fas fa-times me-1"></i>Cancel
                            </a>
                            <button type="submit" class="btn btn-success" id="submitBtn">
                                <i class="fas fa-user-plus me-1"></i>Admit Patient
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Load beds when ward is selected
    document.getElementById('wardSelect').addEventListener('change', function() {
        const wardId = this.value;
        const bedSelect = document.getElementById('bedSelect');
        const bedHelpText = document.getElementById('bedHelpText');

        console.log('Ward selected:', wardId);

        if (wardId) {
            // Show loading
            bedSelect.innerHTML = '<option value="">Loading available beds...</option>';
            bedSelect.disabled = true;
            bedHelpText.textContent = 'Loading available beds...';
            bedHelpText.className = 'form-text text-info';

            // Fetch available beds from API
            fetch('/api/beds/available/' + wardId)
                .then(response => {
                    console.log('API Response status:', response.status);
                    if (!response.ok) {
                        throw new Error('Server returned: ' + response.status);
                    }
                    return response.json();
                })
                .then(beds => {
                    console.log('Received beds data:', beds);

                    if (beds && Array.isArray(beds) && beds.length > 0) {
                        bedSelect.innerHTML = '<option value="">Select a bed</option>';
                        beds.forEach(bed => {
                            const option = document.createElement('option');
                            option.value = bed.id;
                            option.textContent = bed.bedNumber + ' (Available)';
                            bedSelect.appendChild(option);
                        });
                        bedSelect.disabled = false;
                        bedHelpText.textContent = '✓ ' + beds.length + ' available bed(s) found';
                        bedHelpText.className = 'form-text text-success';
                    } else {
                        bedSelect.innerHTML = '<option value="">No available beds</option>';
                        bedSelect.disabled = true;
                        bedHelpText.textContent = '⚠ No available beds in this ward';
                        bedHelpText.className = 'form-text text-warning';
                    }
                })
                .catch(error => {
                    console.error('Error fetching beds:', error);
                    bedSelect.innerHTML = '<option value="">Error loading beds</option>';
                    bedSelect.disabled = true;
                    bedHelpText.textContent = '❌ Error: ' + error.message;
                    bedHelpText.className = 'form-text text-danger';
                });
        } else {
            bedSelect.innerHTML = '<option value="">First select a ward</option>';
            bedSelect.disabled = true;
            bedHelpText.textContent = 'Please select a ward to see available beds';
            bedHelpText.className = 'form-text';
        }
    });

    // Form validation
    document.getElementById('admissionForm').addEventListener('submit', function(e) {
        const bedSelect = document.getElementById('bedSelect');
        if (bedSelect.disabled || !bedSelect.value) {
            e.preventDefault();
            alert('Please select an available bed before submitting');
            bedSelect.focus();
        }
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