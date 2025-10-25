package com.hms.hospitalmanagementsystem.service.factory;

import com.hms.hospitalmanagementsystem.entity.User;
import org.springframework.stereotype.Component;

@Component
public class AdminRoleStrategy implements UserRoleStrategy {

    @Override
    public String getDashboardUrl(User user) {
        return "/admin/dashboard";
    }

    @Override
    public String getWelcomeMessage(User user) {
        return "Welcome Administrator " + user.getUsername() + " to System Management";
    }

    @Override
    public void performRoleSpecificActions(User user) {
        System.out.println("⚙️ Admin Actions for: " + user.getUsername());
        System.out.println("   - Managing system users");
        System.out.println("   - Configuring system settings");
        System.out.println("   - Generating reports");
        System.out.println("   - Managing departments and staff");
    }

    @Override
    public Object createProfileEntity(User user, Object profileData) {
        // Admin typically doesn't have a separate profile entity
        System.out.println("👔 Admin profile created for user: " + user.getUsername());
        return null;
    }

    @Override
    public void initializeProfile(User user) {
        System.out.println("⚙️ Initializing admin permissions for user: " + user.getUsername());
        // Admin-specific initialization (permissions, access rights, etc.)
    }

    @Override
    public String getProfileDetails(User user) {
        return "System Administrator - Full System Access";
    }

    // Admin-specific business methods
    public void manageSystemUsers() {
        System.out.println("👥 Admin managing all system users and permissions");
    }

    public void generateSystemReport() {
        System.out.println("📈 Admin generating comprehensive system report");
    }

    public void configureSystemSettings() {
        System.out.println("🔧 Admin configuring system settings and parameters");
    }
}