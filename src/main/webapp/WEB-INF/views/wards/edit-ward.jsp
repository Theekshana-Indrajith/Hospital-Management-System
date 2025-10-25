<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Edit Ward - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="">🏥 HMS</a>
        <div class="navbar-nav">
            <a class="nav-link" href="/wards">← Back to Wards</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <h4>Edit Ward</h4>
                </div>
                <div class="card-body">
                    <form action="/wards/update/${ward.id}" method="post">
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
                                    <label class="form-label">Ward Type</label>
                                    <select name="wardType" class="form-control" required>
                                        <option value="GENERAL" ${ward.wardType == 'GENERAL' ? 'selected' : ''}>General</option>
                                        <option value="ICU" ${ward.wardType == 'ICU' ? 'selected' : ''}>ICU</option>
                                        <option value="PEDIATRIC" ${ward.wardType == 'PEDIATRIC' ? 'selected' : ''}>Pediatric</option>
                                        <option value="SURGICAL" ${ward.wardType == 'SURGICAL' ? 'selected' : ''}>Surgical</option>
                                        <option value="MATERNITY" ${ward.wardType == 'MATERNITY' ? 'selected' : ''}>Maternity</option>
                                        <option value="CARDIAC" ${ward.wardType == 'CARDIAC' ? 'selected' : ''}>Cardiac</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="form-label">Total Beds</label>
                                    <input type="number" name="totalBeds" class="form-control" value="${ward.totalBeds}" min="1" required>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="form-label">Available Beds</label>
                                    <input type="number" name="availableBeds" class="form-control" value="${ward.availableBeds}" min="0" required>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="form-label">Charge Per Day (Rs.)</label>
                                    <input type="number" step="0.01" name="chargePerDay" class="form-control" value="${ward.chargePerDay}" min="0" required>
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea name="description" class="form-control" rows="3">${ward.description}</textarea>
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="/wards" class="btn btn-secondary me-md-2">Cancel</a>
                            <button type="submit" class="btn btn-primary">Update Ward</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>