package com.foodorderapp.service;

import com.foodorderapp.entity.Cart;
import com.foodorderapp.entity.FoodItem;
import com.foodorderapp.entity.User;
import com.foodorderapp.repository.CartRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Service
public class CartService {
    
    @Autowired
    private CartRepository cartRepository;
    
    public void addToCart(User user, FoodItem foodItem, Integer quantity) {
        Optional<Cart> existingCart = cartRepository.findByUserAndFoodItem(user, foodItem);
        
        if (existingCart.isPresent()) {
            Cart cart = existingCart.get();
            cart.setQuantity(cart.getQuantity() + quantity);
            cartRepository.save(cart);
        } else {
            Cart cart = new Cart();
            cart.setUser(user);
            cart.setFoodItem(foodItem);
            cart.setQuantity(quantity);
            cartRepository.save(cart);
        }
    }
    
    public List<Cart> getCartItems(User user) {
        return cartRepository.findByUser(user);
    }
    
    public void updateCartItemQuantity(Long cartId, Integer quantity) {
        Optional<Cart> cart = cartRepository.findById(cartId);
        if (cart.isPresent()) {
            cart.get().setQuantity(quantity);
            cartRepository.save(cart.get());
        }
    }
    
    public void removeFromCart(Long cartId) {
        cartRepository.deleteById(cartId);
    }
    
    @Transactional
    public void clearCart(User user) {
        cartRepository.deleteByUser(user);
    }
    
    public BigDecimal getCartTotal(User user) {
        List<Cart> cartItems = cartRepository.findByUser(user);
        BigDecimal total = BigDecimal.ZERO;
        
        for (Cart cart : cartItems) {
            BigDecimal itemTotal = cart.getFoodItem().getPrice()
                .multiply(BigDecimal.valueOf(cart.getQuantity()));
            total = total.add(itemTotal);
        }
        
        return total;
    }
    
    public long getCartItemCount(User user) {
        return cartRepository.countByUser(user);
    }
}