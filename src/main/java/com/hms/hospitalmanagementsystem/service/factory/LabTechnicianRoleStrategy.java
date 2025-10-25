package com.hms.hospitalmanagementsystem.service.factory;

import com.hms.hospitalmanagementsystem.entity.User;
import com.hms.hospitalmanagementsystem.entity.Staff;
import com.hms.hospitalmanagementsystem.repository.StaffRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Optional;

@Component
public class LabTechnicianRoleStrategy implements UserRoleStrategy {

    @Autowired
    private StaffRepository staffRepository;

    @Override
    public String getDashboardUrl(User user) {
        return "/lab-technician/dashboard";
    }

    @Override
    public String getWelcomeMessage(User user) {
        if (user.getProfileId() != null) {
            Optional<Staff> staffOpt = staffRepository.findByProfileId(user.getProfileId());
            if (staffOpt.isPresent()) {
                Staff staff = staffOpt.get();
                return "Welcome " + staff.getFullName() + " (Lab Technician) to Laboratory Dashboard";
            }
        }
        return "Welcome Lab Technician " + user.getUsername() + " to Laboratory Dashboard";
    }

    @Override
    public void performRoleSpecificActions(User user) {
        Optional<Staff> staffOpt = Optional.empty();
        if (user.getProfileId() != null) {
            staffOpt = staffRepository.findByProfileId(user.getProfileId());
        }

        System.out.println("🔬 Lab Technician Actions for: " + user.getUsername());
        System.out.println("   - Processing lab tests and samples");
        System.out.println("   - Managing laboratory equipment");
        System.out.println("   - Analyzing test results");
        System.out.println("   - Generating lab reports");

        if (staffOpt.isPresent()) {
            Staff staff = staffOpt.get();
            System.out.println("   - Department: " + (staff.getDepartment() != null ? staff.getDepartment().getName() : "N/A"));
            System.out.println("   - Qualifications: " + staff.getQualification());
        }
    }

    @Override
    public Object createProfileEntity(User user, Object profileData) {
        StaffRoleStrategy.StaffCreationData data = (StaffRoleStrategy.StaffCreationData) profileData;
        Staff staff = new Staff();
        staff.setFirstName(data.getFirstName());
        staff.setLastName(data.getLastName());
        staff.setStaffType("LAB_TECHNICIAN"); // Force staff type to LAB_TECHNICIAN
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
        System.out.println("🔬 Initializing lab technician profile for user: " + user.getUsername());
        // Lab technician specific initialization
    }

    @Override
    public String getProfileDetails(User user) {
        if (user.getProfileId() != null) {
            Optional<Staff> staffOpt = staffRepository.findByProfileId(user.getProfileId());
            if (staffOpt.isPresent()) {
                Staff staff = staffOpt.get();
                return String.format("Lab Technician: %s | Dept: %s | Qualifications: %s",
                        staff.getFullName(),
                        staff.getDepartment() != null ? staff.getDepartment().getName() : "N/A",
                        staff.getQualification());
            }
        }
        return "Lab Technician profile not found";
    }
}