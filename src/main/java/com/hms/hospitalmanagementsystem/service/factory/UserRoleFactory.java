package com.hms.hospitalmanagementsystem.service.factory;

import com.hms.hospitalmanagementsystem.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

@Component
public class UserRoleFactory {

    private final Map<String, UserRoleStrategy> strategies = new HashMap<>();

    @Autowired
    public UserRoleFactory(DoctorRoleStrategy doctorStrategy,
                           PatientRoleStrategy patientStrategy,
                           AdminRoleStrategy adminStrategy,
                           StaffRoleStrategy staffStrategy,
                           WardManagerRoleStrategy wardManagerStrategy,
                           ReceptionistRoleStrategy receptionistStrategy,
                           LabTechnicianRoleStrategy labTechnicianStrategy) {
        strategies.put("DOCTOR", doctorStrategy);
        strategies.put("PATIENT", patientStrategy);
        strategies.put("ADMIN", adminStrategy);
        strategies.put("STAFF", staffStrategy);
        strategies.put("WARD_MANAGER", wardManagerStrategy);
        strategies.put("RECEPTIONIST", receptionistStrategy);
        strategies.put("LAB_TECHNICIAN", labTechnicianStrategy);
        strategies.put("LAB_TECH", labTechnicianStrategy); // Add this line for the short name
    }

    /**
     * Get the appropriate strategy based on user role
     */
    public UserRoleStrategy getStrategy(User user) {
        if (user == null || user.getRole() == null) {
            throw new IllegalArgumentException("User or user role cannot be null");
        }

        UserRoleStrategy strategy = strategies.get(user.getRole().toUpperCase());
        if (strategy == null) {
            throw new IllegalArgumentException("No strategy found for role: " + user.getRole());
        }

        return strategy;
    }

    /**
     * Get strategy by role name
     */
    public UserRoleStrategy getStrategyByRole(String role) {
        UserRoleStrategy strategy = strategies.get(role.toUpperCase());
        if (strategy == null) {
            throw new IllegalArgumentException("No strategy found for role: " + role);
        }
        return strategy;
    }

    /**
     * Get dashboard URL for user
     */
    public String getDashboardUrl(User user) {
        return getStrategy(user).getDashboardUrl(user);
    }

    /**
     * Get welcome message for user
     */
    public String getWelcomeMessage(User user) {
        return getStrategy(user).getWelcomeMessage(user);
    }

    /**
     * Perform role-specific actions
     */
    public void performRoleActions(User user) {
        getStrategy(user).performRoleSpecificActions(user);
    }

    /**
     * Create profile entity for user
     */
    public Object createProfileEntity(User user, Object profileData) {
        return getStrategy(user).createProfileEntity(user, profileData);
    }

    /**
     * Initialize user profile
     */
    public void initializeProfile(User user) {
        getStrategy(user).initializeProfile(user);
    }

    /**
     * Get profile details
     */
    public String getProfileDetails(User user) {
        return getStrategy(user).getProfileDetails(user);
    }
}