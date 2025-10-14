<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Manage Food Items - Admin"/>
</jsp:include>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>
            <i class="bi bi-shop"></i> Manage Food Items
        </h2>
        <div>
            <a href="/admin/dashboard" class="btn btn-outline-secondary me-2">
                <i class="bi bi-arrow-left"></i> Dashboard
            </a>
            <a href="/admin/food-items/add" class="btn btn-primary">
                <i class="bi bi-plus-circle"></i> Add New Item
            </a>
        </div>
    </div>
    
    <div class="card shadow-sm">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Image</th>
                            <th>Name</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Type</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${foodItems}" var="item">
                            <tr>
                                <td>${item.id}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${item.imageUrl != null && !item.imageUrl.isEmpty()}">
                                            <img src="${item.imageUrl}" alt="${item.name}" 
                                                 style="width: 50px; height: 50px; object-fit: cover;" 
                                                 class="rounded">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="bg-secondary rounded" style="width: 50px; height: 50px;"></div>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td><strong>${item.name}</strong></td>
                                <td>${item.category}</td>
                                <td>₹${item.price}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${item.vegetarian}">
                                            <span class="badge bg-success">Veg</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger">Non-Veg</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${item.available}">
                                            <span class="badge bg-success">Available</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">Unavailable</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="/admin/food-items/edit/${item.id}" 
                                       class="btn btn-sm btn-outline-primary" title="Edit">
                                        <i class="bi bi-pencil"></i>
                                    </a>
                                    <a href="/admin/food-items/delete/${item.id}" 
                                       class="btn btn-sm btn-outline-danger" 
                                       onclick="return confirm('Are you sure you want to delete this item?')" 
                                       title="Delete">
                                        <i class="bi bi-trash"></i>
                                    </a>
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