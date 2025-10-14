package com.foodorderapp.controller;

import com.foodorderapp.entity.User;
import com.foodorderapp.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;

@Controller
public class AuthController {
    
    @Autowired
    private UserService userService;
    
    @GetMapping("/login")
    public String loginPage(HttpSession session) {
        if (session.getAttribute("user") != null) {
            return "redirect:/";
        }
        return "login";
    }
    
    @PostMapping("/login")
    public String login(@RequestParam String email, 
                       @RequestParam String password,
                       HttpSession session,
                       RedirectAttributes redirectAttributes) {
        Optional<User> user = userService.login(email, password);
        
        if (user.isPresent()) {
            session.setAttribute("user", user.get());
            
            if (user.get().getRole() == User.Role.ADMIN) {
                return "redirect:/admin/dashboard";
            }
            return "redirect:/";
        }
        
        redirectAttributes.addFlashAttribute("error", "Invalid email or password!");
        return "redirect:/login";
    }
    
    @GetMapping("/register")
    public String registerPage(HttpSession session) {
        if (session.getAttribute("user") != null) {
            return "redirect:/";
        }
        return "register";
    }
    
    @PostMapping("/register")
    public String register(@RequestParam String email,
                          @RequestParam String password,
                          @RequestParam String fullName,
                          @RequestParam String phone,
                          @RequestParam String address,
                          RedirectAttributes redirectAttributes) {
        try {
            User user = new User();
            user.setEmail(email);
            user.setPassword(password); // In production, hash this!
            user.setFullName(fullName);
            user.setPhone(phone);
            user.setAddress(address);
            user.setRole(User.Role.USER);
            
            userService.registerUser(user);
            redirectAttributes.addFlashAttribute("success", "Registration successful! Please login.");
            return "redirect:/login";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/register";
        }
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}