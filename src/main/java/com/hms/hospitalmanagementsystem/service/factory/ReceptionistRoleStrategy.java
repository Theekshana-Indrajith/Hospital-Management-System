package com.hms.hospitalmanagementsystem.service.factory;

import com.hms.hospitalmanagementsystem.entity.User;
import com.hms.hospitalmanagementsystem.entity.Staff;
import com.hms.hospitalmanagementsystem.repository.StaffRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Optional;

@Component
public class ReceptionistRoleStrategy implements UserRoleStrategy {

    @Autowired
    private StaffRepository staffRepository;

    @Override
    public String getDashboardUrl(User user) {
        return "/receptionist/dashboard";
    }

    @Override
    public String getWelcomeMessage(User user) {
        if (user.getProfileId() != null) {
            Optional<Staff> staffOpt = staffRepository.findByProfileId(user.getProfileId());
            if (staffOpt.isPresent()) {
                Staff staff = staffOpt.get();
                return "Welcome " + staff.getFullName() + " (Receptionist) to Reception Dashboard";
            }
        }
        return "Welcome Receptionist " + user.getUsername() + " to Reception Dashboard";
    }

    @Override
    public void performRoleSpecificActions(User user) {
        Optional<Staff> staffOpt = Optional.empty();
        if (user.getProfileId() != null) {
            staffOpt = staffRepository.findByProfileId(user.getProfileId());
        }

        System.out.println("📋 Receptionist Actions for: " + user.getUsername());
        System.out.println("   - Managing patient appointments");
        System.out.println("   - Handling patient registration");
        System.out.println("   - Processing billing and payments");
        System.out.println("   - Managing front desk operations");

        if (staffOpt.isPresent()) {
            Staff staff = staffOpt.get();
            System.out.println("   - Department: " + (staff.getDepartment() != null ? staff.getDepartment().getName() : "N/A"));
            System.out.println("   - Shift: " + staff.getAssignedShift());
        }
    }

    @Override
    public Object createProfileEntity(User user, Object profileData) {
        StaffRoleStrategy.StaffCreationData data = (StaffRoleStrategy.StaffCreationData) profileData;
        Staff staff = new Staff();
        staff.setFirstName(data.getFirstName());
        staff.setLastName(data.getLastName());
        staff.setStaffType("RECEPTIONIST"); // Force staff type to RECEPTIONIST
        staff.setDateOfBirth(data.getDateOfBirth());
        staff.setGender(data.getGender());
        staff.setContactNumber(data.getContactNumber());
        staff.setEmail(data.getEmail());
        staff.setQualification(data.getQualification());
        staff.setDepartment(data.getDepartment());
        staff.setAssignedShift(data.getAssignedShift());
        staff.setShiftStartTime(data.getShiftStartTime());
        staff.setShiftEndTime(data.getShiftEndTime());
        staff.setEmployeeId(data.getEmployeeId());

        return staff;
    }

    @Override
    public void initializeProfile(User user) {
        System.out.println("📋 Initializing receptionist profile for user: " + user.getUsername());
        // Receptionist specific initialization
    }

    @Override
    public String getProfileDetails(User user) {
        if (user.getProfileId() != null) {
            Optional<Staff> staffOpt = staffRepository.findByProfileId(user.getProfileId());
            if (staffOpt.isPresent()) {
                Staff staff = staffOpt.get();
                return String.format("Receptionist: %s | Dept: %s | Employee ID: %s",
                        staff.getFullName(),
                        staff.getDepartment() != null ? staff.getDepartment().getName() : "N/A",
                        staff.getEmployeeId());
            }
        }
        return "Receptionist profile not found";
    }
}