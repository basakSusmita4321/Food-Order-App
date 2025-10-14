package com.foodorderapp.controller;

import com.foodorderapp.entity.User;
import com.foodorderapp.entity.FoodItem;
import com.foodorderapp.service.CartService;
import com.foodorderapp.service.FoodItemService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/cart")
public class CartController {
    
    @Autowired
    private CartService cartService;
    
    @Autowired
    private FoodItemService foodItemService;
    
    @GetMapping
    public String viewCart(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        
        model.addAttribute("cartItems", cartService.getCartItems(user));
        model.addAttribute("cartTotal", cartService.getCartTotal(user));
        model.addAttribute("cartCount", cartService.getCartItemCount(user));
        
        return "cart";
    }
    
    @PostMapping("/add")
    public String addToCart(@RequestParam Long foodItemId,
                           @RequestParam(defaultValue = "1") Integer quantity,
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        
        FoodItem foodItem = foodItemService.getFoodItemById(foodItemId)
            .orElseThrow(() -> new RuntimeException("Food item not found!"));
        
        cartService.addToCart(user, foodItem, quantity);
        redirectAttributes.addFlashAttribute("success", "Item added to cart!");
        
        return "redirect:/menu";
    }
    
    @PostMapping("/update/{cartId}")
    public String updateCart(@PathVariable Long cartId,
                            @RequestParam Integer quantity,
                            RedirectAttributes redirectAttributes) {
        cartService.updateCartItemQuantity(cartId, quantity);
        redirectAttributes.addFlashAttribute("success", "Cart updated!");
        return "redirect:/cart";
    }
    
    @GetMapping("/remove/{cartId}")
    public String removeFromCart(@PathVariable Long cartId,
                                 RedirectAttributes redirectAttributes) {
        cartService.removeFromCart(cartId);
        redirectAttributes.addFlashAttribute("success", "Item removed from cart!");
        return "redirect:/cart";
    }
    
    @GetMapping("/clear")
    public String clearCart(HttpSession session, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        
        cartService.clearCart(user);
        redirectAttributes.addFlashAttribute("success", "Cart cleared!");
        return "redirect:/cart";
    }
}