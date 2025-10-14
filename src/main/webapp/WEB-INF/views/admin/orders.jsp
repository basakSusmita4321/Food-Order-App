<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Manage Orders - Admin"/>
</jsp:include>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>
            <i class="bi bi-receipt"></i> Manage Orders
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
                            <th>Order ID</th>
                            <th>Customer</th>
                            <th>Date & Time</th>
                            <th>Items</th>
                            <th>Total Amount</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${orders}" var="order">
                            <tr>
                                <td><strong>#${order.id}</strong></td>
                                <td>
                                    <div>
                                        <strong>${order.user.fullName}</strong><br>
                                        <small class="text-muted">${order.user.email}</small>
                                    </div>
                                </td>
                                <td>
                                    <fmt:formatDate value="${order.orderDate}" pattern="dd MMM yyyy"/>
                                    <br>
                                    <small class="text-muted">
                                        <fmt:formatDate value="${order.orderDate}" pattern="hh:mm a"/>
                                    </small>
                                </td>
                                <td>${order.orderItems.size()} items</td>
                                <td><strong>₹<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></strong></td>
                                <td>
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
                                </td>
                                <td>
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-sm btn-outline-primary dropdown-toggle" 
                                                data-bs-toggle="dropdown">
                                            Update Status
                                        </button>
                                        <ul class="dropdown-menu">
                                            <li>
                                                <form action="/admin/orders/update-status/${order.id}" method="post" class="d-inline">
                                                    <input type="hidden" name="status" value="CONFIRMED">
                                                    <button type="submit" class="dropdown-item">
                                                        <i class="bi bi-check-circle text-info"></i> Confirmed
                                                    </button>
                                                </form>
                                            </li>
                                            <li>
                                                <form action="/admin/orders/update-status/${order.id}" method="post" class="d-inline">
                                                    <input type="hidden" name="status" value="PREPARING">
                                                    <button type="submit" class="dropdown-item">
                                                        <i class="bi bi-egg-fried text-primary"></i> Preparing
                                                    </button>
                                                </form>
                                            </li>
                                            <li>
                                                <form action="/admin/orders/update-status/${order.id}" method="post" class="d-inline">
                                                    <input type="hidden" name="status" value="OUT_FOR_DELIVERY">
                                                    <button type="submit" class="dropdown-item">
                                                        <i class="bi bi-truck text-secondary"></i> Out for Delivery
                                                    </button>
                                                </form>
                                            </li>
                                            <li>
                                                <form action="/admin/orders/update-status/${order.id}" method="post" class="d-inline">
                                                    <input type="hidden" name="status" value="DELIVERED">
                                                    <button type="submit" class="dropdown-item">
                                                        <i class="bi bi-check-all text-success"></i> Delivered
                                                    </button>
                                                </form>
                                            </li>
                                            <li><hr class="dropdown-divider"></li>
                                            <li>
                                                <form action="/admin/orders/update-status/${order.id}" method="post" class="d-inline">
                                                    <input type="hidden" name="status" value="CANCELLED">
                                                    <button type="submit" class="dropdown-item text-danger">
                                                        <i class="bi bi-x-circle"></i> Cancel
                                                    </button>
                                                </form>
                                            </li>
                                        </ul>
                                    </div>
                                </td>
                            </tr>
                            <tr class="table-light">
                                <td colspan="7">
                                    <small>
                                        <strong>Delivery Address:</strong> ${order.deliveryAddress} | 
                                        <strong>Phone:</strong> ${order.phone}
                                        <c:if test="${order.specialInstructions != null && !order.specialInstructions.isEmpty()}">
                                            | <strong>Special Instructions:</strong> ${order.specialInstructions}
                                        </c:if>
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