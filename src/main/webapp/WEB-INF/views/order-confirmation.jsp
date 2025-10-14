<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="common/header.jsp">
    <jsp:param name="title" value="Order Confirmation - Food Order App"/>
</jsp:include>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-sm">
                <div class="card-body text-center py-5">
                    <i class="bi bi-check-circle-fill text-success" style="font-size: 5rem;"></i>
                    <h2 class="mt-4">Order Placed Successfully!</h2>
                    <p class="lead">Thank you for your order. Your food is being prepared.</p>
                    
                    <div class="alert alert-info mt-4">
                        <h4>Order ID: #${order.id}</h4>
                        <p class="mb-0">Order Date: <fmt:formatDate value="${order.orderDate}" 
                                                                     pattern="dd MMM yyyy, hh:mm a"/></p>
                    </div>
                    
                    <div class="card mt-4">
                        <div class="card-header bg-light">
                            <h5 class="mb-0">Order Details</h5>
                        </div>
                        <div class="card-body text-start">
                            <div class="row mb-3">
                                <div class="col-6">
                                    <strong>Delivery Address:</strong>
                                    <p class="mb-0">${order.deliveryAddress}</p>
                                </div>
                                <div class="col-6">
                                    <strong>Phone:</strong>
                                    <p class="mb-0">${order.phone}</p>
                                </div>
                            </div>
                            
                            <hr>
                            
                            <h6>Order Items:</h6>
                            <c:forEach items="${order.orderItems}" var="item">
                                <div class="d-flex justify-content-between mb-2">
                                    <span>${item.foodItem.name} x ${item.quantity}</span>
                                    <span>₹<fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00"/></span>
                                </div>
                            </c:forEach>
                            
                            <hr>
                            
                            <div class="d-flex justify-content-between">
                                <strong>Total Amount:</strong>
                                <strong class="text-primary">₹<fmt:formatNumber value="${order.totalAmount}" 
                                                                                pattern="#,##0.00"/></strong>
                            </div>
                        </div>
                    </div>
                    
                    <div class="mt-4">
                        <a href="/order/history" class="btn btn-primary me-2">
                            <i class="bi bi-clock-history"></i> View Order History
                        </a>
                        <a href="/menu" class="btn btn-outline-primary">
                            <i class="bi bi-shop"></i> Order More
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp"/>