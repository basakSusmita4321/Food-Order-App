package com.foodorderapp.controller;

import com.foodorderapp.entity.User;
import com.foodorderapp.entity.FoodItem;
import com.foodorderapp.entity.Order;
import com.foodorderapp.service.UserService;
import com.foodorderapp.service.FoodItemService;
import com.foodorderapp.service.OrderService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;

@Controller
@RequestMapping("/admin")
public class AdminController {
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private FoodItemService foodItemService;
    
    @Autowired
    private OrderService orderService;
    
    // Check admin access
    private boolean isAdmin(HttpSession session) {
        User user = (User) session.getAttribute("user");
        return user != null && user.getRole() == User.Role.ADMIN;
    }
    
    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/login";
        }
        
        model.addAttribute("totalUsers", userService.getAllUsers().size());
        model.addAttribute("totalFoodItems", foodItemService.getAllFoodItems().size());
        model.addAttribute("totalOrders", orderService.getAllOrders().size());
        model.addAttribute("pendingOrders", orderService.getOrdersByStatus(Order.OrderStatus.PENDING).size());
        
        return "admin/dashboard";
    }
    
    // Food Item Management
    @GetMapping("/food-items")
    public String manageFoodItems(Model model, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/login";
        }
        
        model.addAttribute("foodItems", foodItemService.getAllFoodItems());
        return "admin/food-items";
    }
    
    @GetMapping("/food-items/add")
    public String addFoodItemPage(HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/login";
        }
        return "admin/add-food-item";
    }
    
    @PostMapping("/food-items/add")
    public String addFoodItem(@RequestParam String name,
                             @RequestParam String description,
                             @RequestParam BigDecimal price,
                             RedirectAttributes redirectAttributes,
                             HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/login";
        }
        
        FoodItem foodItem = new FoodItem();
        foodItem.setName(name);
        foodItem.setDescription(description);
        foodItem.setPrice(price);
        
        foodItemService.saveFoodItem(foodItem);
        redirectAttributes.addFlashAttribute("success", "Food item added successfully!");
        
        return "redirect:/admin/food-items";
    }
    
    @GetMapping("/food-items/edit/{id}")
    public String editFoodItemPage(@PathVariable Long id, Model model, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/login";
        }
        
        FoodItem foodItem = foodItemService.getFoodItemById(id)
            .orElseThrow(() -> new RuntimeException("Food item not found!"));
        
        model.addAttribute("foodItem", foodItem);
        return "admin/edit-food-item";
    }
    
    @PostMapping("/food-items/edit/{id}")
    public String editFoodItem(@PathVariable Long id,
                              @RequestParam String name,
                              @RequestParam String description,
                              @RequestParam BigDecimal price,
                              RedirectAttributes redirectAttributes,
                              HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/login";
        }
        
        FoodItem foodItem = foodItemService.getFoodItemById(id)
            .orElseThrow(() -> new RuntimeException("Food item not found!"));
        
        foodItem.setName(name);
        foodItem.setDescription(description);
        foodItem.setPrice(price);
        
        foodItemService.updateFoodItem(foodItem);
        redirectAttributes.addFlashAttribute("success", "Food item updated successfully!");
        
        return "redirect:/admin/food-items";
    }
    
    @GetMapping("/food-items/delete/{id}")
    public String deleteFoodItem(@PathVariable Long id, 
                                RedirectAttributes redirectAttributes,
                                HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/login";
        }
        
        foodItemService.deleteFoodItem(id);
        redirectAttributes.addFlashAttribute("success", "Food item deleted successfully!");
        
        return "redirect:/admin/food-items";
    }
    
    // Order Management
    @GetMapping("/orders")
    public String manageOrders(Model model, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/login";
        }
        
        model.addAttribute("orders", orderService.getAllOrders());
        return "admin/orders";
    }
    
    @PostMapping("/orders/update-status/{orderId}")
    public String updateOrderStatus(@PathVariable Long orderId,
                                   @RequestParam Order.OrderStatus status,
                                   RedirectAttributes redirectAttributes,
                                   HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/login";
        }
        
        orderService.updateOrderStatus(orderId, status);
        redirectAttributes.addFlashAttribute("success", "Order status updated successfully!");
        
        return "redirect:/admin/orders";
    }
    
    // User Management
    @GetMapping("/users")
    public String manageUsers(Model model, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/login";
        }
        
        model.addAttribute("users", userService.getAllUsers());
        return "admin/users";
    }
}