<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Manage Users - Admin"/>
</jsp:include>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>
            <i class="bi bi-people"></i> Manage Users
        </h2>
        <a href="/admin/dashboard" class="btn btn-outline-secondary">
            <i class="bi bi-arrow-left"></i> Dashboard
        </a>
    </div>
    
    <div class="card shadow-sm">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Address</th>
                            <th>Role</th>
                            <th>Status</th>
                            <th>Registered Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${users}" var="user">
                            <tr>
                                <td>${user.id}</td>
                                <td><strong>${user.fullName}</strong></td>
                                <td>${user.email}</td>
                                <td>${user.phone}</td>
                                <td>
                                    <small class="text-muted">
                                        ${user.address.length() > 30 ? user.address.substring(0, 30).concat('...') : user.address}
                                    </small>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${user.role == 'ADMIN'}">
                                            <span class="badge bg-danger">
                                                <i class="bi bi-shield-fill"></i> Admin
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-primary">
                                                <i class="bi bi-person"></i> User
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${user.active}">
                                            <span class="badge bg-success">Active</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">Inactive</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <small>
                                        <fmt:formatDate value="${user.createdAt}" pattern="dd MMM yyyy"/>
                                    </small>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>