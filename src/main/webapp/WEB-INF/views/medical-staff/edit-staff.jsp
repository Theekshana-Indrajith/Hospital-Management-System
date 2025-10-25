<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Edit Staff - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand">🏥 HMS</a>
        <div class="navbar-nav">
            <a class="nav-link" href="/medical-staff/dashboard">Dashboard</a>
            <a class="nav-link" href="/medical-staff/departments">Departments</a>
            <a class="nav-link" href="/medical-staff/doctors">Doctors</a>
            <a class="nav-link active" href="/medical-staff/staff">Staff</a>
            <a class="nav-link" href="/medical-staff/shifts">Shifts</a>
            <a class="nav-link" href="/admin/dashboard">Admin Dashboard</a>
        </div>
        <div class="navbar-nav ms-auto">
            <span class="navbar-text">Welcome, Administrator!</span>
            <a class="nav-link" href="/logout">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center">
        <h1><i class="fas fa-user-edit me-2"></i>Edit Staff Member</h1>
        <a href="/medical-staff/staff" class="btn btn-secondary">
            <i class="fas fa-arrow-left me-1"></i>Back to Staff
        </a>
    </div>

    <!-- Edit Staff Form -->
    <div class="card mt-4">
        <div class="card-header bg-warning text-white">
            <h5 class="mb-0"><i class="fas fa-user me-2"></i>Edit ${staffMember.firstName} ${staffMember.lastName}</h5>
        </div>
        <div class="card-body">
            <form method="post" action="/medical-staff/staff/update/${staffMember.id}">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">First Name *</label>
                        <input type="text" name="firstName" class="form-control" value="${staffMember.firstName}" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Last Name *</label>
                        <input type="text" name="lastName" class="form-control" value="${staffMember.lastName}" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Staff Type *</label>
                        <select name="staffType" class="form-select" required>
                            <option value="NURSE" ${staffMember.staffType == 'NURSE' ? 'selected' : ''}>Nurse</option>
                            <option value="RECEPTIONIST" ${staffMember.staffType == 'RECEPTIONIST' ? 'selected' : ''}>Receptionist</option>
                            <option value="LAB_TECH" ${staffMember.staffType == 'LAB_TECH' ? 'selected' : ''}>Lab Technician</option>
                            <option value="WARD_MANAGER" ${staffMember.staffType == 'WARD_MANAGER' ? 'selected' : ''}>Ward Manager</option>
                            <option value="ADMIN" ${staffMember.staffType == 'ADMIN' ? 'selected' : ''}>Administrative Staff</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Department</label>
                        <select name="department.id" class="form-select">
                            <option value="">Select Department</option>
                            <c:forEach var="dept" items="${departments}">
                                <option value="${dept.id}"
                                    ${staffMember.department != null && staffMember.department.id == dept.id ? 'selected' : ''}>
                                        ${dept.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Date of Birth</label>
                        <input type="date" name="dateOfBirth" class="form-control" value="${staffMember.dateOfBirth}">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Gender</label>
                        <select name="gender" class="form-select">
                            <option value="">Select Gender</option>
                            <option value="Male" ${staffMember.gender == 'Male' ? 'selected' : ''}>Male</option>
                            <option value="Female" ${staffMember.gender == 'Female' ? 'selected' : ''}>Female</option>
                            <option value="Other" ${staffMember.gender == 'Other' ? 'selected' : ''}>Other</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Contact Number</label>
                        <input type="text" name="contactNumber" class="form-control" value="${staffMember.contactNumber}">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-control" value="${staffMember.email}">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Qualification</label>
                        <input type="text" name="qualification" class="form-control" value="${staffMember.qualification}">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Assigned Shift</label>
                        <select name="assignedShift" class="form-select">
                            <option value="">Select Shift</option>
                            <option value="MORNING" ${staffMember.assignedShift == 'MORNING' ? 'selected' : ''}>Morning Shift</option>
                            <option value="EVENING" ${staffMember.assignedShift == 'EVENING' ? 'selected' : ''}>Evening Shift</option>
                            <option value="NIGHT" ${staffMember.assignedShift == 'NIGHT' ? 'selected' : ''}>Night Shift</option>
                            <option value="ROTATING" ${staffMember.assignedShift == 'ROTATING' ? 'selected' : ''}>Rotating Shift</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Working Days</label>
                        <input type="text" name="workingDays" class="form-control"
                               value="${empty staffMember.workingDays ? 'MON-FRI' : staffMember.workingDays}">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Status</label>
                        <select name="isActive" class="form-select">
                            <option value="true" ${staffMember.isActive ? 'selected' : ''}>Active</option>
                            <option value="false" ${!staffMember.isActive ? 'selected' : ''}>Inactive</option>
                        </select>
                    </div>
                </div>
                <div class="mt-3">
                    <button type="submit" class="btn btn-warning">
                        <i class="fas fa-save me-1"></i>Update Staff Member
                    </button>
                    <a href="/medical-staff/staff" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>