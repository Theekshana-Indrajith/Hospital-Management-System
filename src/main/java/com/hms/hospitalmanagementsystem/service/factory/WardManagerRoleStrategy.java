package com.hms.hospitalmanagementsystem.service.factory;

import com.hms.hospitalmanagementsystem.entity.User;
import com.hms.hospitalmanagementsystem.entity.Staff;
import com.hms.hospitalmanagementsystem.repository.StaffRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Optional;

@Component
public class WardManagerRoleStrategy implements UserRoleStrategy {

    @Autowired
    private StaffRepository staffRepository;

    @Override
    public String getDashboardUrl(User user) {
        return "/ward-manager/dashboard";
    }

    @Override
    public String getWelcomeMessage(User user) {
        if (user.getProfileId() != null) {
            Optional<Staff> staffOpt = staffRepository.findByProfileId(user.getProfileId());
            if (staffOpt.isPresent()) {
                Staff staff = staffOpt.get();
                return "Welcome " + staff.getFullName() + " (Ward Manager) to Ward Management Dashboard";
            }
        }
        return "Welcome Ward Manager " + user.getUsername() + " to Ward Management Dashboard";
    }

    @Override
    public void performRoleSpecificActions(User user) {
        Optional<Staff> staffOpt = Optional.empty();
        if (user.getProfileId() != null) {
            staffOpt = staffRepository.findByProfileId(user.getProfileId());
        }

        System.out.println("🏥 Ward Manager Actions for: " + user.getUsername());
        System.out.println("   - Managing ward operations");
        System.out.println("   - Assigning beds to patients");
        System.out.println("   - Overseeing patient care");
        System.out.println("   - Managing nursing staff");

        if (staffOpt.isPresent()) {
            Staff staff = staffOpt.get();
            System.out.println("   - Ward: " + (staff.getDepartment() != null ? staff.getDepartment().getName() : "N/A"));
        }
    }

    @Override
    public Object createProfileEntity(User user, Object profileData) {
        // Use the same StaffCreationData as StaffRoleStrategy
        StaffRoleStrategy.StaffCreationData data = (StaffRoleStrategy.StaffCreationData) profileData;
        Staff staff = new Staff();
        staff.setFirstName(data.getFirstName());
        staff.setLastName(data.getLastName());
        staff.setStaffType("WARD_MANAGER"); // Force staff type to WARD_MANAGER
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
        System.out.println("🏥 Initializing ward manager profile for user: " + user.getUsername());
        // Ward manager specific initialization
    }

    @Override
    public String getProfileDetails(User user) {
        if (user.getProfileId() != null) {
            Optional<Staff> staffOpt = staffRepository.findByProfileId(user.getProfileId());
            if (staffOpt.isPresent()) {
                Staff staff = staffOpt.get();
                return String.format("Ward Manager: %s | Dept: %s | Employee ID: %s",
                        staff.getFullName(),
                        staff.getDepartment() != null ? staff.getDepartment().getName() : "N/A",
                        staff.getEmployeeId());
            }
        }
        return "Ward Manager profile not found";
    }
}