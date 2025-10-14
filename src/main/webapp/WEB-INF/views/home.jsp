<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="common/header.jsp">
    <jsp:param name="title" value="Home - Food Order App"/>
</jsp:include>

<!-- Hero Section -->
<div class="bg-light py-5">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6">
                <h1 class="display-4 fw-bold">Delicious Food Delivered Fast!</h1>
                <p class="lead">Order your favorite meals from our extensive menu and get them delivered right to your doorstep.</p>
                <a href="/menu" class="btn btn-primary btn-lg mt-3">
                    <i class="bi bi-shop"></i> Browse Menu
                </a>
            </div>
            <div class="col-md-6">
                <img src="https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=600" 
                     class="img-fluid rounded shadow" alt="Food">
            </div>
        </div>
    </div>
</div>

<!-- Features Section -->
<div class="container my-5">
    <h2 class="text-center mb-5">Why Choose Us?</h2>
    <div class="row text-center">
        <div class="col-md-4 mb-4">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body">
                    <i class="bi bi-lightning-charge text-warning" style="font-size: 3rem;"></i>
                    <h4 class="card-title mt-3">Fast Delivery</h4>
                    <p class="card-text">Get your food delivered within 30 minutes or less!</p>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-4">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body">
                    <i class="bi bi-star-fill text-warning" style="font-size: 3rem;"></i>
                    <h4 class="card-title mt-3">Quality Food</h4>
                    <p class="card-text">Fresh ingredients and authentic recipes every time.</p>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-4">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body">
                    <i class="bi bi-credit-card text-warning" style="font-size: 3rem;"></i>
                    <h4 class="card-title mt-3">Easy Payment</h4>
                    <p class="card-text">Multiple payment options for your convenience.</p>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Featured Items -->
<div class="container my-5">
    <h2 class="text-center mb-5">Popular Items</h2>
    <div class="row">
        <c:forEach items="${foodItems}" var="item" begin="0" end="5">
            <div class="col-md-4 mb-4">
                <div class="card h-100 shadow-sm">
                    <c:choose>
                        <c:when test="${item.imageUrl != null && !item.imageUrl.isEmpty()}">
                            <img src="${item.imageUrl}" class="card-img-top" alt="${item.name}" style="height: 200px; object-fit: cover;">
                        </c:when>
                        <c:otherwise>
                            <img src="https://via.placeholder.com/400x200?text=${item.name}" class="card-img-top" alt="${item.name}">
                        </c:otherwise>
                    </c:choose>
                    <div class="card-body">
                        <h5 class="card-title">${item.name}</h5>
                        <p class="card-text text-muted">${item.description}</p>
                        <div class="d-flex justify-content-between align-items-center">
                            <span class="h5 text-primary mb-0">₹${item.price}</span>
                            <c:if test="${item.vegetarian}">
                                <span class="badge bg-success">Veg</span>
                            </c:if>
                        </div>
                    </div>
                    <div class="card-footer bg-white border-0">
                        <c:choose>
                            <c:when test="${sessionScope.user != null}">
                                <form action="/cart/add" method="post" class="d-inline">
                                    <input type="hidden" name="foodItemId" value="${item.id}">
                                    <button type="submit" class="btn btn-primary w-100">
                                        <i class="bi bi-cart-plus"></i> Add to Cart
                                    </button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <a href="/login" class="btn btn-primary w-100">
                                    <i class="bi bi-cart-plus"></i> Add to Cart
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <div class="text-center mt-4">
        <a href="/menu" class="btn btn-outline-primary btn-lg">View Full Menu</a>
    </div>
</div>

<jsp:include page="common/footer.jsp"/>