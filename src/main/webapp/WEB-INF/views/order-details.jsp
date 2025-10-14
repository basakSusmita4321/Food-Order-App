<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="common/header.jsp">
    <jsp:param name="title" value="Order Details - Food Order App"/>
</jsp:include>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>
            <i class="bi bi-receipt"></i> Order #${order.id}
        </h2>
        <a href="/order/history" class="btn btn-outline-secondary">
            <i class="bi bi-arrow-left"></i> Back to Orders
        </a>
    </div>
    
    <div class="row">
        <div class="col-md-8">
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">Order Information</h5>
                </div>
                <div class="card-body">
                    <div class="row mb-3">
                        <div class="col-6">
                            <strong>Order Date:</strong>
                            <p><fmt:formatDate value="${order.orderDate}" pattern="dd MMM yyyy, hh:mm a"/></p>
                        </div>
                        <div class="col-6">
                            <strong>Status:</strong>
                            <p>
                                <c:choose>
                                    <c:when test="${order.status == 'PENDING'}">
                                        <span class="badge bg-warning text-dark">Pending</span>
                                    </c:when>
                                    <c:when test="${order.status == 'CONFIRMED'}">
                                        <span class="badge bg-info">Confirmed</span>
                                    </c:when>
                                    <c:when test="${order.status == 'PREPARING'}">
                                        <span class="badge bg-primary">Preparing</span>
                                    </c:when>
                                    <c:when test="${order.status == 'OUT_FOR_DELIVERY'}">
                                        <span class="badge bg-secondary">Out for Delivery</span>
                                    </c:when>
                                    <c:when test="${order.status == 'DELIVERED'}">
                                        <span class="badge bg-success">Delivered</span>
                                    </c:when>
                                    <c:when test="${order.status == 'CANCELLED'}">
                                        <span class="badge bg-danger">Cancelled</span>
                                    </c:when>
                                </c:choose>
                            </p>
                        </div>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-12">
                            <strong>Delivery Address:</strong>
                            <p>${order.deliveryAddress}</p>
                        </div>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-6">
                            <strong>Phone:</strong>
                            <p>${order.phone}</p>
                        </div>
                        <c:if test="${order.specialInstructions != null && !order.specialInstructions.isEmpty()}">
                            <div class="col-6">
                                <strong>Special Instructions:</strong>
                                <p>${order.specialInstructions}</p>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
            
            <div class="card shadow-sm">
                <div class="card-header bg-secondary text-white">
                    <h5 class="mb-0">Order Items</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Item</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th class="text-end">Subtotal</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${order.orderItems}" var="item">
                                    <tr>
                                        <td>
                                            <strong>${item.foodItem.name}</strong>
                                            <c:if test="${item.foodItem.vegetarian}">
                                                <span class="badge bg-success">Veg</span>
                                            </c:if>
                                        </td>
                                        <td>₹<fmt:formatNumber value="${item.price}" pattern="#,##0.00"/></td>
                                        <td>${item.quantity}</td>
                                        <td class="text-end">₹<fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00"/></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-header bg-success text-white">
                    <h5 class="mb-0">Order Summary</h5>
                </div>
                <div class="card-body">
                    <div class="d-flex justify-content-between mb-2">
                        <span>Total Amount:</span>
                        <strong class="text-primary h4">₹<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></strong>
                    </div>
                    <hr>
                    <div class="alert alert-info">
                        <i class="bi bi-info-circle"></i> 
                        <small>
                            <c:choose>
                                <c:when test="${order.status == 'PENDING'}">
                                    Your order is being processed.
                                </c:when>
                                <c:when test="${order.status == 'CONFIRMED'}">
                                    Your order has been confirmed and will be prepared soon.
                                </c:when>
                                <c:when test="${order.status == 'PREPARING'}">
                                    Your food is being prepared with care!
                                </c:when>
                                <c:when test="${order.status == 'OUT_FOR_DELIVERY'}">
                                    Your order is on the way!
                                </c:when>
                                <c:when test="${order.status == 'DELIVERED'}">
                                    Your order has been delivered. Enjoy your meal!
                                </c:when>
                                <c:when test="${order.status == 'CANCELLED'}">
                                    This order has been cancelled.
                                </c:when>
                            </c:choose>
                        </small>
                    </div>
                    
                    <c:if test="${order.status == 'DELIVERED'}">
                        <a href="/menu" class="btn btn-primary w-100">
                            <i class="bi bi-arrow-repeat"></i> Order Again
                        </a>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp"/>