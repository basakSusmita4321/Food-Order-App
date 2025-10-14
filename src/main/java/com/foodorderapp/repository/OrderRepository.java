package com.foodorderapp.repository;

import com.foodorderapp.entity.Order;
import com.foodorderapp.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByUserOrderByOrderDateDesc(User user);
    List<Order> findAllByOrderByOrderDateDesc();
    List<Order> findByStatus(Order.OrderStatus status);
}