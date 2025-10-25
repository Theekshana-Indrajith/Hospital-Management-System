package com.hms.hospitalmanagementsystem.service.factory;

import com.hms.hospitalmanagementsystem.entity.User;
import com.hms.hospitalmanagementsystem.entity.Patient;
import com.hms.hospitalmanagementsystem.entity.Doctor;
import com.hms.hospitalmanagementsystem.entity.Staff;

public interface UserRoleStrategy {

    // Core strategy methods
    String getDashboardUrl(User user);
    String getWelcomeMessage(User user);
    void performRoleSpecificActions(User user);

    // Entity-specific methods
    Object createProfileEntity(User user, Object profileData);
    void initializeProfile(User user);
    String getProfileDetails(User user);
}