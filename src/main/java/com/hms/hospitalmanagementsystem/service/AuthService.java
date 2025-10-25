package com.hms.hospitalmanagementsystem.service;

import com.hms.hospitalmanagementsystem.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import java.util.Optional;

@Service
public class AuthService {

    @Autowired
    private UserService userService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public boolean authenticate(String username, String password) {
        System.out.println("=== AUTHENTICATION ATTEMPT ===");
        System.out.println("Username: " + username);
        System.out.println("Password: " + password);

        Optional<User> userOptional = userService.findByUsername(username);

        if (userOptional.isEmpty()) {
            System.out.println("❌ USER NOT FOUND IN DATABASE");
            System.out.println("Available users in database:");
            // This would require a method to list all users, but for now just log
            System.out.println("=== AUTHENTICATION FAILED ===");
            return false;
        }

        User user = userOptional.get();
        System.out.println("✅ User found: " + user.getUsername());
        System.out.println("User role: " + user.getRole());
        System.out.println("Stored password hash: " + user.getPassword());

        boolean passwordMatches = passwordEncoder.matches(password, user.getPassword());
        System.out.println("Password matches: " + passwordMatches);

        if (passwordMatches) {
            System.out.println("✅ AUTHENTICATION SUCCESSFUL");
        } else {
            System.out.println("❌ AUTHENTICATION FAILED - Password mismatch");
            System.out.println("Trying plain text comparison for debugging:");
            System.out.println("Plain text match: " + password.equals(user.getPassword()));
        }

        System.out.println("=== AUTHENTICATION COMPLETED ===");
        return passwordMatches;
    }

    public String getUserRole(String username) {
        Optional<User> userOptional = userService.findByUsername(username);
        if (userOptional.isPresent()) {
            return userOptional.get().getRole();
        }
        return "UNKNOWN";
    }
}