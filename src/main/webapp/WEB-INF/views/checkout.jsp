<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="common/header.jsp">
    <jsp:param name="title" value="Checkout - Food Order App"/>
</jsp:include>

<div class="container my-5">
    <h2 class="mb-4">
        <i class="bi bi-credit-card"></i> Checkout
    </h2>
    
    <div class="row">
        <div class="col-md-7">
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">Delivery Information</h5>
                </div>
                <div class="card-body">
                    <form action="/order/place" method="post" id="checkoutForm">
                        <div class="mb-3">
                            <label for="fullName" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="fullName" 
                                   value="${user.fullName}" readonly>
                        </div>
                        
                        <div class="mb-3">
                            <label for="phone" class="form-label">Phone Number</label>
                            <input type="tel" class="form-control" id="phone" name="phone" 
                                   value="${user.phone}" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="deliveryAddress" class="form-label">Delivery Address</label>
                            <textarea class="form-control" id="deliveryAddress" name="deliveryAddress" 
                                      rows="3" required>${user.address}</textarea>
                        </div>
                        
                        <div class="mb-3">
                            <label for="specialInstructions" class="form-label">Special Instructions (Optional)</label>
                            <textarea class="form-control" id="specialInstructions" 
                                      name="specialInstructions" rows="2" 
                                      placeholder="Any special requests or dietary requirements..."></textarea>
                        </div>
                    </form>
                </div>
            </div>
            
            <div class="card shadow-sm">
                <div class="card-header bg-secondary text-white">
                    <h5 class="mb-0">Payment Method</h5>
                </div>
                <div class="card-body">
                    <div class="form-check mb-3">
                        <input class="form-check-input" type="radio" name="paymentMethod" 
                               id="cod" value="cod" checked>
                        <label class="form-check-label" for="cod">
                            <i class="bi bi-cash-coin"></i> Cash on Delivery
                        </label>
                    </div>
                    <div class="form-check mb-3">
                        <input class="form-check-input" type="radio" name="paymentMethod" 
                               id="card" value="card" disabled>
                        <label class="form-check-label text-muted" for="card">
                            <i class="bi bi-credit-card"></i> Credit/Debit Card (Coming Soon)
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="paymentMethod" 
                               id="upi" value="upi" disabled>
                        <label class="form-check-label text-muted" for="upi">
                            <i class="bi bi-phone"></i> UPI (Coming Soon)
                        </label>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-md-5">
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-info text-white">
                    <h5 class="mb-0">Order Summary</h5>
                </div>
                <div class="card-body">
                    <c:forEach items="${cartItems}" var="cartItem">
                        <div class="d-flex justify-content-between mb-2">
                            <span>${cartItem.foodItem.name} x ${cartItem.quantity}</span>
                            <span>₹<fmt:formatNumber value="${cartItem.foodItem.price * cartItem.quantity}" 
                                                    pattern="#,##0.00"/></span>
                        </div>
                    </c:forEach>
                    <hr>
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
                        <strong>Total Amount:</strong>
                        <strong class="text-primary h4">
                            ₹<fmt:formatNumber value="${cartTotal + 40 + (cartTotal * 0.05)}" 
                                              pattern="#,##0.00"/>
                        </strong>
                    </div>
                    
                    <button type="submit" form="checkoutForm" class="btn btn-success w-100 btn-lg">
                        <i class="bi bi-check-circle"></i> Place Order
                    </button>
                    <a href="/cart" class="btn btn-outline-secondary w-100 mt-2">
                        <i class="bi bi-arrow-left"></i> Back to Cart
                    </a>
                </div>
            </div>
            
            <div class="alert alert-info">
                <i class="bi bi-info-circle"></i> 
                <small>Your order will be delivered within 30-45 minutes.</small>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp"/>