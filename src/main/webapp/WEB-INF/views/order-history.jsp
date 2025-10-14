<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="common/header.jsp">
    <jsp:param name="title" value="Order History - Food Order App"/>
</jsp:include>

<div class="container my-5">
    <h2 class="mb-4">
        <i class="bi bi-clock-history"></i> My Order History
    </h2>
    
    <c:choose>
        <c:when test="${empty orders}">
            <div class="alert alert-info text-center">
                <i class="bi bi-inbox" style="font-size: 3rem;"></i>
                <h4 class="mt-3">No orders yet!</h4>
                <p>Start ordering delicious food from our menu.</p>
                <a href="/menu" class="btn btn-primary mt-3">
                    <i class="bi bi-shop"></i> Browse Menu
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row">
                <c:forEach items="${orders}" var="order">
                    <div class="col-12 mb-4">
                        <div class="card shadow-sm">
                            <div class="card-header bg-light">
                                <div class="row align-items-center">
                                    <div class="col-md-3">
                                        <strong>Order #${order.id}</strong>
                                    </div>
                                    <div class="col-md-3">
                                        <small class="text-muted">
                                            <i class="bi bi-calendar"></i> 
                                            <fmt:formatDate value="${order.orderDate}" pattern="dd MMM yyyy, hh:mm a"/>
                                        </small>
                                    </div>
                                    <div class="col-md-3">
                                        <c:choose>
                                            <c:when test="${order.status == 'PENDING'}">
                                                <span class="badge bg-warning text-dark">
                                                    <i class="bi bi-clock"></i> Pending
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 'CONFIRMED'}">
                                                <span class="badge bg-info">
                                                    <i class="bi bi-check-circle"></i> Confirmed
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 'PREPARING'}">
                                                <span class="badge bg-primary">
                                                    <i class="bi bi-egg-fried"></i> Preparing
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 'OUT_FOR_DELIVERY'}">
                                                <span class="badge bg-secondary">
                                                    <i class="bi bi-truck"></i> Out for Delivery
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 'DELIVERED'}">
                                                <span class="badge bg-success">
                                                    <i class="bi bi-check-all"></i> Delivered
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 'CANCELLED'}">
                                                <span class="badge bg-danger">
                                                    <i class="bi bi-x-circle"></i> Cancelled
                                                </span>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                    <div class="col-md-3 text-end">
                                        <strong class="text-primary">
                                            ₹<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/>
                                        </strong>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-8">
                                        <h6>Items:</h6>
                                        <ul class="list-unstyled">
                                            <c:forEach items="${order.orderItems}" var="item" begin="0" end="2">
                                                <li>
                                                    <i class="bi bi-dot"></i> ${item.foodItem.name} x ${item.quantity}
                                                </li>
                                            </c:forEach>
                                            <c:if test="${order.orderItems.size() > 3}">
                                                <li class="text-muted">
                                                    <i class="bi bi-three-dots"></i> and ${order.orderItems.size() - 3} more items
                                                </li>
                                            </c:if>
                                        </ul>
                                    </div>
                                    <div class="col-md-4 text-end">
                                        <a href="/order/details/${order.id}" class="btn btn-outline-primary">
                                            <i class="bi bi-eye"></i> View Details
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="common/footer.jsp"/>