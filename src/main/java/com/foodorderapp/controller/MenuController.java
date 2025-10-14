package com.foodorderapp.controller;

import com.foodorderapp.entity.User;
import com.foodorderapp.service.FoodItemService;
import com.foodorderapp.service.CartService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MenuController {
    
    @Autowired
    private FoodItemService foodItemService;
    
    @Autowired
    private CartService cartService;
    
    @GetMapping("/menu")
    public String menu(@RequestParam(required = false) String category,
                       @RequestParam(required = false) String search,
                       Model model,
                       HttpSession session) {
        
        if (search != null && !search.isEmpty()) {
            model.addAttribute("foodItems", foodItemService.searchFoodItems(search));
            model.addAttribute("searchKeyword", search);
        } else if (category != null && !category.isEmpty()) {
            model.addAttribute("foodItems", foodItemService.getFoodItemsByCategory(category));
            model.addAttribute("selectedCategory", category);
        } else {
            model.addAttribute("foodItems", foodItemService.getAvailableFoodItems());
        }
        
        User user = (User) session.getAttribute("user");
        if (user != null) {
            model.addAttribute("cartCount", cartService.getCartItemCount(user));
        }
        
        return "menu";
    }
}