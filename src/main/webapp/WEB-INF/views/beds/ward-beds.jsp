<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${ward.wardNumber} Beds - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand">🏥 HMS</a>
        <div class="navbar-nav">
            <a class="nav-link" href="/wards">← Back to Wards</a>
            <a class="nav-link" href="/beds">All Beds</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h1>${ward.wardNumber} - ${ward.wardType}</h1>
            <p class="text-muted">${ward.description}</p>
        </div>
        <div class="text-end">
            <div class="badge bg-primary fs-6">Total Beds: ${ward.totalBeds}</div>
            <div class="badge bg-success fs-6">Available: ${ward.availableBeds}</div>
            <div class="badge bg-danger fs-6">Occupied: ${ward.totalBeds - ward.availableBeds}</div>
        </div>
    </div>

    <!-- Bed Grid Layout -->
    <div class="card">
        <div class="card-header">
            <h5>Bed Layout</h5>
        </div>
        <div class="card-body">
            <div class="row">
                <c:forEach var="bed" items="${beds}">
                    <div class="col-md-3 mb-3">
                        <div class="card
                            <c:choose>
                                <c:when test="${bed.status == 'AVAILABLE'}">border-success</c:when>
                                <c:when test="${bed.status == 'OCCUPIED'}">border-danger</c:when>
                                <c:when test="${bed.status == 'MAINTENANCE'}">border-warning</c:when>
                                <c:when test="${bed.status == 'CLEANING'}">border-info</c:when>
                            </c:choose>">
                            <div class="card-header text-center py-2">
                                <strong>${bed.bedNumber}</strong>
                            </div>
                            <div class="card-body text-center py-3">
                                <span class="badge
                                    <c:choose>
                                        <c:when test="${bed.status == 'AVAILABLE'}">bg-success</c:when>
                                        <c:when test="${bed.status == 'OCCUPIED'}">bg-danger</c:when>
                                        <c:when test="${bed.status == 'MAINTENANCE'}">bg-warning</c:when>
                                        <c:when test="${bed.status == 'CLEANING'}">bg-info</c:when>
                                    </c:choose>">
                                        ${bed.status}
                                </span>

                                <c:if test="${bed.patient != null}">
                                    <div class="mt-2">
                                        <small class="text-muted">Patient:</small><br>
                                        <strong>${bed.patient.firstName} ${bed.patient.lastName}</strong>
                                    </div>
                                    <div class="mt-1">
                                        <small class="text-muted">Since:</small><br>
                                        <small>${bed.admissionDate}</small>
                                    </div>
                                </c:if>

                                <c:if test="${bed.patient == null}">
                                    <div class="mt-2">
                                        <small class="text-muted">No patient assigned</small>
                                    </div>
                                </c:if>
                            </div>
                            <div class="card-footer text-center py-2">
                                <c:if test="${bed.status == 'AVAILABLE'}">
                                    <a href="/admissions/admit?bedId=${bed.id}" class="btn btn-sm btn-success w-100">Admit Patient</a>
                                </c:if>
                                <c:if test="${bed.status == 'OCCUPIED'}">
                                    <a href="/beds/discharge/${bed.id}" class="btn btn-sm btn-warning w-100"
                                       onclick="return confirm('Discharge patient from ${bed.bedNumber}?')">Discharge</a>
                                </c:if>
                                <c:if test="${bed.status == 'MAINTENANCE'}">
                                    <small class="text-muted">Under Maintenance</small>
                                </c:if>
                                <c:if test="${bed.status == 'CLEANING'}">
                                    <small class="text-muted">Being Cleaned</small>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <!-- Bed Statistics -->
    <div class="row mt-4">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <h6>Bed Statistics</h6>
                </div>
                <div class="card-body">
                    <div class="row text-center">
                        <div class="col-md-3">
                            <div class="text-success">
                                <h4>${beds.stream().filter(b -> b.status == 'AVAILABLE').count()}</h4>
                                <small>Available Beds</small>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="text-danger">
                                <h4>${beds.stream().filter(b -> b.status == 'OCCUPIED').count()}</h4>
                                <small>Occupied Beds</small>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="text-warning">
                                <h4>${beds.stream().filter(b -> b.status == 'MAINTENANCE').count()}</h4>
                                <small>Maintenance</small>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="text-info">
                                <h4>${beds.stream().filter(b -> b.status == 'CLEANING').count()}</h4>
                                <small>Cleaning</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>