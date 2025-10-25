<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Admit Patient - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand">🏥 HMS</a>
        <div class="navbar-nav">
            <a class="nav-link" href="/admissions">← Back to Admissions</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <h4>Admit Patient</h4>
                </div>
                <div class="card-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <form action="/admissions/admit" method="post">
                        <!-- Patient Selection -->
                        <div class="mb-4">
                            <h5>1. Select Patient</h5>
                            <select name="patientId" class="form-select" required>
                                <option value="">Select a Patient</option>
                                <c:forEach var="patient" items="${patients}">
                                    <option value="${patient.id}">
                                            ${patient.firstName} ${patient.lastName}
                                        (ID: ${patient.id}, ${patient.gender}, ${patient.contactNumber})
                                    </option>
                                </c:forEach>
                            </select>
                            <small class="text-muted">Choose the patient to admit</small>
                        </div>

                        <!-- Ward Selection -->
                        <div class="mb-4">
                            <h5>2. Select Ward</h5>
                            <div class="row">
                                <c:forEach var="ward" items="${wards}">
                                    <div class="col-md-6 mb-2">
                                        <div class="form-check">
                                            <input class="form-check-input ward-radio" type="radio" name="wardId"
                                                   value="${ward.id}" id="ward${ward.id}"
                                                   data-available-beds="${ward.availableBeds}">
                                            <label class="form-check-label" for="ward${ward.id}">
                                                <strong>${ward.wardNumber}</strong> - ${ward.wardType}<br>
                                                <small class="text-muted">
                                                    Available beds: ${ward.availableBeds}/${ward.totalBeds} |
                                                    Rs. ${ward.chargePerDay}/day
                                                </small>
                                            </label>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- Bed Selection -->
                        <div class="mb-4" id="bedSelection" style="display: none;">
                            <h5>3. Select Bed</h5>
                            <div id="bedOptions" class="row">
                                <!-- Bed options will be loaded via AJAX -->
                            </div>
                        </div>

                        <!-- Admission Details -->
                        <div class="mb-4">
                            <h5>4. Admission Details</h5>
                            <div class="mb-3">
                                <label class="form-label">Reason for Admission</label>
                                <textarea name="reason" class="form-control" rows="3"
                                          placeholder="Enter the reason for admission..." required></textarea>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Doctor's Notes (Optional)</label>
                                <textarea name="doctorNotes" class="form-control" rows="2"
                                          placeholder="Any additional notes..."></textarea>
                            </div>
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="/admissions" class="btn btn-secondary me-md-2">Cancel</a>
                            <button type="submit" class="btn btn-primary" id="submitBtn" disabled>Admit Patient</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // JavaScript to handle ward and bed selection
    document.addEventListener('DOMContentLoaded', function() {
        const wardRadios = document.querySelectorAll('.ward-radio');
        const bedSelection = document.getElementById('bedSelection');
        const submitBtn = document.getElementById('submitBtn');

        wardRadios.forEach(radio => {
            radio.addEventListener('change', function() {
                if (this.checked) {
                    const wardId = this.value;
                    const availableBeds = this.getAttribute('data-available-beds');

                    if (availableBeds > 0) {
                        // Load available beds for this ward
                        fetch('/beds/available/' + wardId)
                            .then(response => response.json())
                            .then(beds => {
                                const bedOptions = document.getElementById('bedOptions');
                                bedOptions.innerHTML = '';

                                beds.forEach(bed => {
                                    const bedDiv = document.createElement('div');
                                    bedDiv.className = 'col-md-4 mb-2';
                                    bedDiv.innerHTML = `
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="bedId"
                                               value="\${bed.id}" id="bed\${bed.id}" required>
                                        <label class="form-check-label" for="bed\${bed.id}">
                                            <strong>\${bed.bedNumber}</strong><br>
                                            <small class="text-muted">Ward: \${bed.ward.wardNumber}</small>
                                        </label>
                                    </div>
                                `;
                                    bedOptions.appendChild(bedDiv);
                                });

                                bedSelection.style.display = 'block';
                                submitBtn.disabled = false;
                            });
                    } else {
                        bedSelection.style.display = 'none';
                        submitBtn.disabled = true;
                        alert('Selected ward has no available beds!');
                    }
                }
            });
        });
    });
</script>
</body>
</html>