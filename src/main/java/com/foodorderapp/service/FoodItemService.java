package com.foodorderapp.service;

import com.foodorderapp.entity.FoodItem;
import com.foodorderapp.repository.FoodItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class FoodItemService {
    
    @Autowired
    private FoodItemRepository foodItemRepository;
    
    public FoodItem saveFoodItem(FoodItem foodItem) {
        return foodItemRepository.save(foodItem);
    }
    
    public List<FoodItem> getAllFoodItems() {
        return foodItemRepository.findAll();
    }
    
    public List<FoodItem> getAvailableFoodItems() {
        return foodItemRepository.findByAvailableTrue();
    }
    
    public Optional<FoodItem> getFoodItemById(Long id) {
        return foodItemRepository.findById(id);
    }
    
    public List<FoodItem> getFoodItemsByCategory(String category) {
        return foodItemRepository.findByCategoryAndAvailableTrue(category);
    }
    
    public List<FoodItem> searchFoodItems(String keyword) {
        return foodItemRepository.findByNameContainingIgnoreCase(keyword);
    }
    
    public FoodItem updateFoodItem(FoodItem foodItem) {
        return foodItemRepository.save(foodItem);
    }
    
    public void deleteFoodItem(Long id) {
        foodItemRepository.deleteById(id);
    }
}