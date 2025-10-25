<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Available Wards - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="">🏥 HMS</a>
        <div class="navbar-nav">
            <a class="nav-link" href="/wards">← Back to All Wards</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <h1>Available Wards with Beds</h1>

    <div class="card">
        <div class="card-header">
            <h5>Wards with Available Beds</h5>
        </div>
        <div class="card-body">
            <c:if test="${empty wards}">
                <div class="alert alert-warning text-center">
                    <h5>No wards with available beds found</h5>
                    <p>All wards are currently full or under maintenance.</p>
                </div>
            </c:if>

            <c:if test="${not empty wards}">
                <div class="row">
                    <c:forEach var="ward" items="${wards}">
                        <div class="col-md-6 mb-4">
                            <div class="card h-100">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h6 class="mb-0">${ward.wardNumber} - ${ward.wardType}</h6>
                                    <span class="badge bg-success">${ward.availableBeds} beds available</span>
                                </div>
                                <div class="card-body">
                                    <p class="card-text">${ward.description}</p>
                                    <div class="ward-details">
                                        <small class="text-muted">
                                            <strong>Total Beds:</strong> ${ward.totalBeds}<br>
                                            <strong>Charge per Day:</strong> Rs. ${ward.chargePerDay}<br>
                                            <strong>Occupancy Rate:</strong>
                                            <fmt:formatNumber value="${(ward.totalBeds - ward.availableBeds) / ward.totalBeds * 100}" pattern="0.0"/>%
                                        </small>
                                    </div>
                                </div>
                                <div class="card-footer">
                                    <a href="/beds/ward/${ward.id}" class="btn btn-sm btn-primary w-100">
                                        View Available Beds
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>