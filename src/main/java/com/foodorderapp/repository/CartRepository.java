package com.foodorderapp.repository;

import com.foodorderapp.entity.Cart;
import com.foodorderapp.entity.User;
import com.foodorderapp.entity.FoodItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface CartRepository extends JpaRepository<Cart, Long> {
    List<Cart> findByUser(User user);
    Optional<Cart> findByUserAndFoodItem(User user, FoodItem foodItem);
    void deleteByUser(User user);
    long countByUser(User user);
}