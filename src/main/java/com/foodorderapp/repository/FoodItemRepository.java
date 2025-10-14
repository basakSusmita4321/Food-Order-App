package com.foodorderapp.repository;

import com.foodorderapp.entity.FoodItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface FoodItemRepository extends JpaRepository<FoodItem, Long> {
    List<FoodItem> findByCategory(String category);
    List<FoodItem> findByAvailableTrue();
    List<FoodItem> findByCategoryAndAvailableTrue(String category);
    List<FoodItem> findByNameContainingIgnoreCase(String name);
}