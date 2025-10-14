<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Admin Dashboard - Food Order App"/>
</jsp:include>

<div class="container my-5">
    <h2 class="mb-4">
        <i class="bi bi-speedometer2"></i> Admin Dashboard
    </h2>
    
    <!-- Statistics Cards -->
    <div class="row mb-5">
        <div class="col-md-3 mb-3">
            <div class="card bg-primary text-white shadow">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h6 class="text-uppercase">Total Users</h6>
                            <h2 class="mb-0">${totalUsers}</h2>
                        </div>
                        <div>
                            <i class="bi bi-people" style="font-size: 3rem; opacity: 0.5;"></i>
                        </div>
                    </div>
                </div>
                <div class="card-footer bg-primary border-0">
                    <a href="/admin/users" class="text-white text-decoration-none">
                        View All <i class="bi bi-arrow-right"></i>
                    </a>
                </div>
            </div>
        </div>
        
        <div class="col-md-3 mb-3">
            <div class="card bg-success text-white shadow">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h6 class="text-uppercase">Food Items</h6>
                            <h2 class="mb-0">${totalFoodItems}</h2>
                        </div>
                        <div>
                            <i class="bi bi-shop" style="font-size: 3rem; opacity: 0.5;"></i>
                        </div>
                    </div>
                </div>
                <div class="card-footer bg-success border-0">
                    <a href="/admin/food-items" class="text-white text-decoration-none">
                        Manage Items <i class="bi bi-arrow-right"></i>
                    </a>
                </div>
            </div>
        </div>
        
        <div class="col-md-3 mb-3">
            <div class="card bg-info text-white shadow">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h6 class="text-uppercase">Total Orders</h6>
                            <h2 class="mb-0">${totalOrders}</h2>
                        </div>
                        <div>
                            <i class="bi bi-receipt" style="font-size: 3rem; opacity: 0.5;"></i>
                        </div>
                    </div>
                </div>
                <div class="card-footer bg-info border-0">
                    <a href="/admin/orders" class="text-white text-decoration-none">
                        View All <i class="bi bi-arrow-right"></i>
                    </a>
                </div>
            </div>
        </div>
        
        <div class="col-md-3 mb-3">
            <div class="card bg-warning text-dark shadow">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h6 class="text-uppercase">Pending Orders</h6>
                            <h2 class="mb-0">${pendingOrders}</h2>
                        </div>
                        <div>
                            <i class="bi bi-clock-history" style="font-size: 3rem; opacity: 0.5;"></i>
                        </div>
                    </div>
                </div>
                <div class="card-footer bg-warning border-0">
                    <a href="/admin/orders" class="text-dark text-decoration-none">
                        View Pending <i class="bi bi-arrow-right"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Quick Actions -->
    <div class="row">
        <div class="col-md-12">
            <div class="card shadow-sm">
                <div class="card-header bg-dark text-white">
                    <h5 class="mb-0">Quick Actions</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <a href="/admin/food-items/add" class="btn btn-primary w-100 btn-lg">
                                <i class="bi bi-plus-circle"></i><br>
                                Add Food Item
                            </a>
                        </div>
                        <div class="col-md-3 mb-3">
                            <a href="/admin/food-items" class="btn btn-success w-100 btn-lg">
                                <i class="bi bi-list"></i><br>
                                Manage Menu
                            </a>
                        </div>
                        <div class="col-md-3 mb-3">
                            <a href="/admin/orders" class="btn btn-info w-100 btn-lg">
                                <i class="bi bi-receipt-cutoff"></i><br>
                                View Orders
                            </a>
                        </div>
                        <div class="col-md-3 mb-3">
                            <a href="/admin/users" class="btn btn-warning w-100 btn-lg">
                                <i class="bi bi-people"></i><br>
                                Manage Users
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>