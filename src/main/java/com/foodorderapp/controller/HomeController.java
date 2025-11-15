package com.foodorderapp.controller;

import com.foodorderapp.entity.FoodItem;
import com.foodorderapp.entity.User;
import com.foodorderapp.service.FoodItemService;
import com.foodorderapp.service.CartService;
import jakarta.servlet.http.HttpSession;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
    
    @Autowired
    private FoodItemService foodItemService;
    
    @Autowired
    private CartService cartService;
    
    @GetMapping("/")
    public String home(Model model, HttpSession session) {
    	List<FoodItem> availableFoodItems = foodItemService.getAvailableFoodItems();
        model.addAttribute("foodItems", availableFoodItems);
        
        User user = (User) session.getAttribute("user");
        if (user != null) {
            model.addAttribute("cartCount", cartService.getCartItemCount(user));
        }
        
        return "home";
    }
    
    @GetMapping("/about")
    public String about() {
        return "about";
    }
    
    @GetMapping("/contact")
    public String contact() {
        return "contact";
    }
}