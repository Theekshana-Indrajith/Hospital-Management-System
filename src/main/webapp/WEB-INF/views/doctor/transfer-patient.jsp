<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Transfer Patient - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-success">
    <div class="container">
        <a class="navbar-brand">🏥 HMS</a>
        <div class="navbar-nav">
            <a class="nav-link" href="/doctor/dashboard">Dashboard</a>
            <a class="nav-link" href="/doctor/admissions/manage">Admissions</a>
            <a class="nav-link active" href="#">Transfer Patient</a>
        </div>
        <div class="navbar-nav ms-auto">
            <span class="navbar-text">Welcome, Dr. ${username}!</span>
            <a class="nav-link" href="/logout">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header bg-warning text-white">
                    <h5 class="mb-0"><i class="fas fa-exchange-alt me-2"></i>Transfer Patient</h5>
                </div>
                <div class="card-body">
                    <c:if test="${not empty param.error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <strong>Error:</strong> ${param.error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <!-- Current Admission Info -->
                    <div class="alert alert-info">
                        <h6><i class="fas fa-info-circle me-2"></i>Current Admission Details</h6>
                        <div class="row mt-2">
                            <div class="col-md-6">
                                <strong>Patient:</strong> ${admission.patient.firstName} ${admission.patient.lastName}<br>
                                <strong>Current Ward:</strong> ${admission.ward.wardNumber}<br>
                                <strong>Current Bed:</strong> ${admission.bed.bedNumber}
                            </div>
                            <div class="col-md-6">
                                <strong>Admission Date:</strong> ${admission.admissionDate}<br>
                                <strong>Diagnosis:</strong> ${admission.diagnosis}<br>
                                <strong>Status:</strong> <span class="badge bg-success">${admission.status}</span>
                            </div>
                        </div>
                    </div>

                    <form action="/doctor/admissions/transfer/${admission.id}" method="post">
                        <!-- Transfer Details -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <h6 class="border-bottom pb-2"><i class="fas fa-bed me-2"></i>Transfer Destination</h6>
                            </div>
                            <div class="col-md-6">
                                <label for="newWardId" class="form-label">New Ward *</label>
                                <select class="form-select" id="newWardId" name="newWardId" required
                                        onchange="updateTransferBeds(this.value)">
                                    <option value="">Select new ward...</option>
                                    <c:forEach var="ward" items="${wards}">
                                        <c:if test="${ward.id != admission.ward.id}">
                                            <option value="${ward.id}"
                                                    data-available-beds="${ward.availableBeds}">
                                                    ${ward.wardNumber} (${ward.wardType}) - ${ward.availableBeds} beds available
                                            </option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                                <div class="form-text">Select destination ward for transfer</div>
                            </div>
                            <div class="col-md-6">
                                <label for="newBedId" class="form-label">New Bed *</label>
                                <select class="form-select" id="newBedId" name="newBedId" required>
                                    <option value="">Select ward first...</option>
                                </select>
                                <div class="form-text" id="transferBedStatus">Available beds will appear here</div>
                            </div>
                        </div>

                        <!-- Transfer Reason -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <label for="transferReason" class="form-label">Transfer Reason *</label>
                                <textarea class="form-control" id="transferReason" name="transferReason"
                                          rows="3" placeholder="Explain the reason for transferring this patient..."
                                          required></textarea>
                                <div class="form-text">Medical or administrative reasons for the transfer</div>
                            </div>
                        </div>

                        <!-- Additional Notes -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <label for="additionalNotes" class="form-label">Additional Notes</label>
                                <textarea class="form-control" id="additionalNotes" name="additionalNotes"
                                          rows="2" placeholder="Any special instructions or considerations for the transfer..."></textarea>
                            </div>
                        </div>

                        <!-- Form Actions -->
                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="/doctor/admissions/manage" class="btn btn-outline-secondary me-2">
                                <i class="fas fa-times me-1"></i>Cancel Transfer
                            </a>
                            <button type="submit" class="btn btn-warning">
                                <i class="fas fa-exchange-alt me-1"></i>Transfer Patient
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Transfer Guidelines -->
            <div class="card mt-4">
                <div class="card-header bg-light">
                    <h6 class="mb-0"><i class="fas fa-clipboard-list me-2"></i>Transfer Guidelines</h6>
                </div>
                <div class="card-body">
                    <ul class="list-unstyled mb-0">
                        <li><i class="fas fa-check text-success me-2"></i>Ensure the destination ward is appropriate for patient's condition</li>
                        <li><i class="fas fa-check text-success me-2"></i>Verify bed availability before transferring</li>
                        <li><i class="fas fa-check text-success me-2"></i>Update patient records with transfer details</li>
                        <li><i class="fas fa-check text-success me-2"></i>Notify nursing staff about the transfer</li>
                        <li><i class="fas fa-check text-success me-2"></i>Ensure proper handover of patient care</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Bed update function for transfer
    function updateTransferBeds(wardId) {
        const bedSelect = document.getElementById('newBedId');
        const bedStatus = document.getElementById('transferBedStatus');

        bedSelect.innerHTML = '<option value="">Loading beds...</option>';
        bedSelect.disabled = true;

        if (!wardId) {
            bedSelect.innerHTML = '<option value="">Select ward first...</option>';
            bedStatus.textContent = 'Available beds will appear here';
            return;
        }

        // Simulate API call to get beds for selected ward
        setTimeout(() => {
            let bedOptions = '<option value="">Select a bed...</option>';
            const selectedWard = document.querySelector(`#newWardId option[value="${wardId}"]`);
            const availableBeds = selectedWard ? selectedWard.getAttribute('data-available-beds') : 0;

            if (availableBeds > 0) {
                for (let i = 1; i <= availableBeds; i++) {
                    bedOptions += `<option value="\${i}">Bed \${i} - Available</option>`;
                }
                bedStatus.textContent = `${availableBeds} beds available in this ward`;
                bedStatus.className = 'form-text text-success';
            } else {
                bedOptions = '<option value="">No beds available</option>';
                bedStatus.textContent = 'No available beds in this ward. Please select another ward.';
                bedStatus.className = 'form-text text-danger';
            }

            bedSelect.innerHTML = bedOptions;
            bedSelect.disabled = availableBeds === 0;
        }, 500);
    }
</script>
</body>
</html>