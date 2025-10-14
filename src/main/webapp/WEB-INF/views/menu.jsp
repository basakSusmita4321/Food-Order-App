<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="common/header.jsp">
    <jsp:param name="title" value="Menu - Food Order App"/>
</jsp:include>

<div class="container my-5">
    <h2 class="text-center mb-4">Our Menu</h2>
    
    <!-- Search and Filter Section -->
    <div class="row mb-4">
        <div class="col-md-6">
            <form action="/menu" method="get" class="d-flex">
                <input type="text" class="form-control me-2" name="search" placeholder="Search food items..." 
                       value="${searchKeyword}">
                <button type="submit" class="btn btn-primary">
                    <i class="bi bi-search"></i> Search
                </button>
            </form>
        </div>
        <div class="col-md-6">
            <div class="btn-group w-100" role="group">
                <a href="/menu" class="btn ${selectedCategory == null ? 'btn-primary' : 'btn-outline-primary'}">All</a>
                <a href="/menu?category=Starters" class="btn ${selectedCategory == 'Starters' ? 'btn-primary' : 'btn-outline-primary'}">Starters</a>
                <a href="/menu?category=Main Course" class="btn ${selectedCategory == 'Main Course' ? 'btn-primary' : 'btn-outline-primary'}">Main Course</a>
                <a href="/menu?category=Desserts" class="btn ${selectedCategory == 'Desserts' ? 'btn-primary' : 'btn-outline-primary'}">Desserts</a>
                <a href="/menu?category=Beverages" class="btn ${selectedCategory == 'Beverages' ? 'btn-primary' : 'btn-outline-primary'}">Beverages</a>
            </div>
        </div>
    </div>
    
    <!-- Food Items Grid -->
    <div class="row">
        <c:choose>
            <c:when test="${empty foodItems}">
                <div class="col-12">
                    <div class="alert alert-info text-center">
                        <i class="bi bi-info-circle"></i> No food items found.
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${foodItems}" var="item">
                    <div class="col-md-4 mb-4">
                        <div class="card h-100 shadow-sm">
                            <c:choose>
                                <c:when test="${item.imageUrl != null && !item.imageUrl.isEmpty()}">
                                    <img src="${item.imageUrl}" class="card-img-top" alt="${item.name}" 
                                         style="height: 250px; object-fit: cover;">
                                </c:when>
                                <c:otherwise>
                                    <img src="https://via.placeholder.com/400x250?text=${item.name}" 
                                         class="card-img-top" alt="${item.name}">
                                </c:otherwise>
                            </c:choose>
                            
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <h5 class="card-title mb-0">${item.name}</h5>
                                    <c:if test="${item.vegetarian}">
                                        <span class="badge bg-success">
                                            <i class="bi bi-circle-fill"></i> Veg
                                        </span>
                                    </c:if>
                                </div>
                                <p class="text-muted small mb-2">
                                    <i class="bi bi-tag"></i> ${item.category}
                                </p>
                                <p class="card-text">${item.description}</p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="h4 text-primary mb-0">₹${item.price}</span>
                                    <c:choose>
                                        <c:when test="${!item.available}">
                                            <span class="badge bg-danger">Not Available</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-success">Available</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            
                            <c:if test="${item.available}">
                                <div class="card-footer bg-white border-0">
                                    <c:choose>
                                        <c:when test="${sessionScope.user != null}">
                                            <form action="/cart/add" method="post">
                                                <input type="hidden" name="foodItemId" value="${item.id}">
                                                <div class="input-group">
                                                    <input type="number" class="form-control" name="quantity" 
                                                           value="1" min="1" max="10">
                                                    <button type="submit" class="btn btn-primary">
                                                        <i class="bi bi-cart-plus"></i> Add
                                                    </button>
                                                </div>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="/login" class="btn btn-primary w-100">
                                                <i class="bi bi-cart-plus"></i> Login to Order
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="common/footer.jsp"/>