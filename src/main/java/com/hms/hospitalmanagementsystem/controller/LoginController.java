package com.hms.hospitalmanagementsystem.controller;

import com.hms.hospitalmanagementsystem.entity.User;
import com.hms.hospitalmanagementsystem.repository.UserRepository;
import com.hms.hospitalmanagementsystem.service.AuthService;
import com.hms.hospitalmanagementsystem.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class LoginController {

    @Autowired
    private AuthService authService;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserService userService;

    // ==================== LOGIN METHODS ====================

    @GetMapping("/login")
    public String showLoginPage(@RequestParam(value = "error", required = false) String error,
                                @RequestParam(value = "success", required = false) String success,
                                @RequestParam(value = "logout", required = false) String logout,
                                Model model) {
        if (error != null) {
            model.addAttribute("error", "Invalid username or password!");
        }
        if (success != null) {
            model.addAttribute("success", "Registration successful! Please login.");
        }
        if (logout != null) {
            model.addAttribute("msg", "You have been logged out successfully.");
        }
        return "login";
    }

    @PostMapping("/login")
    public String handleLogin(@RequestParam String username,
                              @RequestParam String password,
                              HttpSession session,
                              Model model) {

        System.out.println("DEBUG: Login attempt for: " + username);

        if (authService.authenticate(username, password)) {
            String role = authService.getUserRole(username);
            session.setAttribute("username", username);
            session.setAttribute("role", role);

            // Get user details for session
            User user = userService.findByUsername(username).orElse(null);
            if (user != null) {
                session.setAttribute("userId", user.getId());
                session.setAttribute("userEmail", user.getEmail());
                session.setAttribute("profileId", user.getProfileId());

                // Get welcome message using factory pattern
                String welcomeMessage = userService.getWelcomeMessage(user.getId());
                session.setAttribute("welcomeMessage", welcomeMessage);
            }

            System.out.println("DEBUG: Login successful. Role: " + role);
            System.out.println("DEBUG: Welcome Message: " + session.getAttribute("welcomeMessage"));

            // Redirect based on role using factory pattern URLs
            return redirectToDashboard(role, session);
        } else {
            System.out.println("DEBUG: Login failed for: " + username);
            return "redirect:/login?error=true";
        }
    }

    /**
     * Redirect to appropriate dashboard based on role
     */
    private String redirectToDashboard(String role, HttpSession session) {
        switch (role.toUpperCase()) {
            case "ADMIN":
                session.setAttribute("dashboardUrl", "/admin/dashboard");
                return "redirect:/admin/dashboard";
            case "DOCTOR":
                session.setAttribute("dashboardUrl", "/doctor/dashboard");
                return "redirect:/doctor/dashboard";
            case "PATIENT":
                session.setAttribute("dashboardUrl", "/patient/dashboard");
                return "redirect:/patient/dashboard";
            case "STAFF":
                session.setAttribute("dashboardUrl", "/staff/dashboard");
                return "redirect:/staff/dashboard";
            case "LAB_TECH":
                session.setAttribute("dashboardUrl", "/lab-technician/dashboard");
                return "redirect:/lab-technician/dashboard";
            case "WARD_MANAGER":
                session.setAttribute("dashboardUrl", "/ward-manager/dashboard");
                return "redirect:/ward-manager/dashboard";
            case "RECEPTIONIST":
                session.setAttribute("dashboardUrl", "/receptionist/dashboard");
                return "redirect:/receptionist/dashboard";
            case "NURSE":
                session.setAttribute("dashboardUrl", "/nurse/dashboard");
                return "redirect:/nurse/dashboard";
            default:
                session.setAttribute("dashboardUrl", "/dashboard");
                return "redirect:/dashboard"; // This will go to DashboardController
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        // Clean up all session data
        session.removeAttribute("username");
        session.removeAttribute("role");
        session.removeAttribute("userId");
        session.removeAttribute("userEmail");
        session.removeAttribute("profileId");
        session.removeAttribute("welcomeMessage");
        session.removeAttribute("dashboardUrl");

        // Clean up role-specific session data
        session.removeAttribute("doctorId");
        session.removeAttribute("doctorName");
        session.removeAttribute("patientId");
        session.removeAttribute("staffId");

        session.invalidate();
        return "redirect:/login?logout=true";
    }

    // ==================== DEBUG & UTILITY METHODS ====================

    @GetMapping("/debug/users")
    @ResponseBody
    public String debugUsers() {
        // This will show all users and their roles
        StringBuilder sb = new StringBuilder();
        sb.append("=== DEBUG: ALL USERS ===\n");

        List<User> users = userRepository.findAll();
        for (User user : users) {
            sb.append(String.format("ID: %d, Username: %s, Role: %s, Email: %s, ProfileID: %s%n",
                    user.getId(), user.getUsername(), user.getRole(), user.getEmail(), user.getProfileId()));
        }

        return sb.toString();
    }

    // ==================== API ENDPOINTS ====================

    /**
     * API: Get user dashboard info
     */
    @GetMapping("/api/user/{userId}/dashboard-info")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getDashboardInfo(@PathVariable Long userId, HttpSession session) {
        try {
            String dashboardUrl = userService.getUserDashboardUrl(userId);
            String welcomeMessage = userService.getWelcomeMessage(userId);
            String profileDetails = userService.getUserProfileDetails(userId);

            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("userId", userId);
            response.put("dashboardUrl", dashboardUrl);
            response.put("welcomeMessage", welcomeMessage);
            response.put("profileDetails", profileDetails);
            response.put("sessionUsername", session.getAttribute("username"));
            response.put("sessionRole", session.getAttribute("role"));

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            return ResponseEntity.badRequest().body(createErrorResponse(e.getMessage()));
        }
    }

    /**
     * API: Perform role-specific actions
     */
    @PostMapping("/api/user/{userId}/perform-actions")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> performRoleActions(@PathVariable Long userId) {
        try {
            userService.performRoleSpecificActions(userId);

            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("message", "Role-specific actions performed successfully");
            response.put("userId", userId);

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            return ResponseEntity.badRequest().body(createErrorResponse(e.getMessage()));
        }
    }

    /**
     * API: Get users by role
     */
    @GetMapping("/api/users/role/{role}")
    @ResponseBody
    public ResponseEntity<List<User>> getUsersByRole(@PathVariable String role) {
        try {
            List<User> users = userService.getUsersByRole(role);
            return ResponseEntity.ok(users);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    /**
     * Get current user session info
     */
    @GetMapping("/api/session-info")
    @ResponseBody
    public Map<String, Object> getSessionInfo(HttpSession session) {
        Map<String, Object> sessionInfo = new HashMap<>();
        sessionInfo.put("username", session.getAttribute("username"));
        sessionInfo.put("role", session.getAttribute("role"));
        sessionInfo.put("userId", session.getAttribute("userId"));
        sessionInfo.put("userEmail", session.getAttribute("userEmail"));
        sessionInfo.put("profileId", session.getAttribute("profileId"));
        sessionInfo.put("welcomeMessage", session.getAttribute("welcomeMessage"));
        sessionInfo.put("dashboardUrl", session.getAttribute("dashboardUrl"));
        sessionInfo.put("authenticated", session.getAttribute("username") != null);

        return sessionInfo;
    }

    // ==================== HELPER METHODS ====================

    private Map<String, Object> createSuccessResponse(String message, User user) {
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("message", message);
        response.put("user", createUserResponse(user));
        return response;
    }

    private Map<String, Object> createUserResponse(User user) {
        Map<String, Object> userResponse = new HashMap<>();
        userResponse.put("id", user.getId());
        userResponse.put("username", user.getUsername());
        userResponse.put("email", user.getEmail());
        userResponse.put("role", user.getRole());
        userResponse.put("profileId", user.getProfileId());
        return userResponse;
    }

    private Map<String, Object> createErrorResponse(String message) {
        Map<String, Object> errorResponse = new HashMap<>();
        errorResponse.put("success", false);
        errorResponse.put("message", message);
        return errorResponse;
    }
}