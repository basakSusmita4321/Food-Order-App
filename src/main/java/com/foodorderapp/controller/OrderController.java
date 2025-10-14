package com.foodorderapp.controller;

import com.foodorderapp.entity.User;
import com.foodorderapp.entity.Order;
import com.foodorderapp.service.OrderService;
import com.foodorderapp.service.CartService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/order")
public class OrderController {
    
    @Autowired
    private OrderService orderService;
    
    @Autowired
    private CartService cartService;
    
    @GetMapping("/checkout")
    public String checkoutPage(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        
        model.addAttribute("cartItems", cartService.getCartItems(user));
        model.addAttribute("cartTotal", cartService.getCartTotal(user));
        model.addAttribute("user", user);
        
        return "checkout";
    }
    
    @PostMapping("/place")
    public String placeOrder(@RequestParam String deliveryAddress,
                            @RequestParam String phone,
                            @RequestParam(required = false) String specialInstructions,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        
        try {
            Order order = orderService.createOrder(user, deliveryAddress, phone, specialInstructions);
            redirectAttributes.addFlashAttribute("success", "Order placed successfully! Order ID: " + order.getId());
            return "redirect:/order/confirmation/" + order.getId();
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/cart";
        }
    }
    
    @GetMapping("/confirmation/{orderId}")
    public String orderConfirmation(@PathVariable Long orderId, 
                                   Model model, 
                                   HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        
        Order order = orderService.getOrderById(orderId)
            .orElseThrow(() -> new RuntimeException("Order not found!"));
        
        model.addAttribute("order", order);
        return "order-confirmation";
    }
    
    @GetMapping("/history")
    public String orderHistory(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        
        model.addAttribute("orders", orderService.getUserOrders(user));
        model.addAttribute("cartCount", cartService.getCartItemCount(user));
        
        return "order-history";
    }
    
    @GetMapping("/details/{orderId}")
    public String orderDetails(@PathVariable Long orderId, 
                              Model model, 
                              HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        
        Order order = orderService.getOrderById(orderId)
            .orElseThrow(() -> new RuntimeException("Order not found!"));
        
        model.addAttribute("order", order);
        model.addAttribute("cartCount", cartService.getCartItemCount(user));
        
        return "order-details";
    }
}