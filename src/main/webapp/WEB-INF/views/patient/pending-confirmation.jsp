<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Appointment Pending - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<!-- Navigation and header same as manual-confirmation.jsp -->

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card border-warning">
                <div class="card-header bg-warning text-white text-center">
                    <h3 class="mb-0"><i class="fas fa-clock me-2"></i>Appointment Pending Doctor Confirmation</h3>
                </div>
                <div class="card-body">
                    <div class="text-center mb-4">
                        <i class="fas fa-clock fa-4x text-warning mb-3"></i>
                        <h4 class="text-warning">Waiting for Doctor Approval</h4>
                        <p class="text-muted">Your appointment request has been sent to the doctor for confirmation</p>
                    </div>

                    <!-- Appointment Details -->
                    <div class="appointment-details mb-4 p-4 rounded">
                        <h5 class="mb-3"><i class="fas fa-calendar-alt me-2"></i>Appointment Details</h5>
                        <div class="row">
                            <div class="col-md-6">
                                <p class="mb-2"><strong>Appointment ID:</strong> A${appointment.id}</p>
                                <p class="mb-2"><strong>Patient Name:</strong> ${patient.firstName} ${patient.lastName}</p>
                            </div>
                            <div class="col-md-6">
                                <p class="mb-2"><strong>Doctor:</strong> Dr. ${appointment.doctor.name}</p>
                                <p class="mb-2"><strong>Date & Time:</strong> ${formattedDateTime}</p>
                            </div>
                        </div>
                        <div class="mt-3">
                            <strong>Reason:</strong>
                            <p class="mb-0 text-muted">${appointment.reason}</p>
                        </div>
                    </div>

                    <!-- Status Information -->
                    <div class="alert alert-info">
                        <h6><i class="fas fa-info-circle me-2"></i>What happens next?</h6>
                        <ul class="mb-0">
                            <li>Your appointment request has been sent to Dr. ${appointment.doctor.name}</li>
                            <li>The doctor will review and confirm your appointment shortly</li>
                            <li>You will receive notification once the appointment is confirmed</li>
                            <li>If approved, your appointment will be scheduled as requested</li>
                        </ul>
                    </div>

                    <!-- Action Buttons -->
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                        <a href="/patient/appointments" class="btn btn-primary me-md-2">
                            <i class="fas fa-list me-1"></i>View My Appointments
                        </a>
                        <a href="/patient/appointments/book" class="btn btn-outline-success">
                            <i class="fas fa-plus me-1"></i>Book Another Appointment
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>