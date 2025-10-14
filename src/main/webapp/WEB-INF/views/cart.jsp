<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="common/header.jsp">
    <jsp:param name="title" value="Shopping Cart - Food Order App"/>
</jsp:include>

<div class="container my-5">
    <h2 class="mb-4">
        <i class="bi bi-cart3"></i> Shopping Cart
    </h2>
    
    <c:choose>
        <c:when test="${empty cartItems}">
            <div class="alert alert-info text-center">
                <i class="bi bi-cart-x" style="font-size: 3rem;"></i>
                <h4 class="mt-3">Your cart is empty!</h4>
                <p>Add some delicious items from our menu.</p>
                <a href="/menu" class="btn btn-primary mt-3">
                    <i class="bi bi-shop"></i> Browse Menu
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row">
                <div class="col-md-8">
                    <c:forEach items="${cartItems}" var="cartItem">
                        <div class="card mb-3 shadow-sm">
                            <div class="card-body">
                                <div class="row align-items-center">
                                    <div class="col-md-2">
                                        <c:choose>
                                            <c:when test="${cartItem.foodItem.imageUrl != null && !cartItem.foodItem.imageUrl.isEmpty()}">
                                                <img src="${cartItem.foodItem.imageUrl}" 
                                                     class="img-fluid rounded" alt="${cartItem.foodItem.name}">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="https://via.placeholder.com/100" 
                                                     class="img-fluid rounded" alt="${cartItem.foodItem.name}">
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="col-md-4">
                                        <h5>${cartItem.foodItem.name}</h5>
                                        <p class="text-muted mb-0">₹${cartItem.foodItem.price} each</p>
                                    </div>
                                    <div class="col-md-3">
                                        <form action="/cart/update/${cartItem.id}" method="post" class="d-flex align-items-center">
                                            <label class="me-2">Qty:</label>
                                            <input type="number" class="form-control form-control-sm w-50 me-2" 
                                                   name="quantity" value="${cartItem.quantity}" min="1" max="10">
                                            <button type="submit" class="btn btn-sm btn-outline-primary">
                                                <i class="bi bi-arrow-repeat"></i>
                                            </button>
                                        </form>
                                    </div>
                                    <div class="col-md-2">
                                        <h5 class="text-primary mb-0">
                                            ₹<fmt:formatNumber value="${cartItem.foodItem.price * cartItem.quantity}" 
                                                              pattern="#,##0.00"/>
                                        </h5>
                                    </div>
                                    <div class="col-md-1">
                                        <a href="/cart/remove/${cartItem.id}" class="btn btn-sm btn-outline-danger" 
                                           onclick="return confirm('Remove this item from cart?')">
                                            <i class="bi bi-trash"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    
                    <div class="d-flex justify-content-between">
                        <a href="/menu" class="btn btn-outline-primary">
                            <i class="bi bi-arrow-left"></i> Continue Shopping
                        </a>
                        <a href="/cart/clear" class="btn btn-outline-danger" 
                           onclick="return confirm('Clear all items from cart?')">
                            <i class="bi bi-trash"></i> Clear Cart
                        </a>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="card shadow-sm">
                        <div class="card-header bg-primary text-white">
                            <h5 class="mb-0">Order Summary</h5>
                        </div>
                        <div class="card-body">
                            <div class="d-flex justify-content-between mb-2">
                                <span>Subtotal:</span>
                                <span>₹<fmt:formatNumber value="${cartTotal}" pattern="#,##0.00"/></span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Delivery Fee:</span>
                                <span>₹40.00</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Tax (5%):</span>
                                <span>₹<fmt:formatNumber value="${cartTotal * 0.05}" pattern="#,##0.00"/></span>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between mb-3">
                                <strong>Total:</strong>
                                <strong class="text-primary">
                                    ₹<fmt:formatNumber value="${cartTotal + 40 + (cartTotal * 0.05)}" 
                                                      pattern="#,##0.00"/>
                                </strong>
                            </div>
                            <a href="/order/checkout" class="btn btn-primary w-100 btn-lg">
                                <i class="bi bi-credit-card"></i> Proceed to Checkout
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="common/footer.jsp"/>