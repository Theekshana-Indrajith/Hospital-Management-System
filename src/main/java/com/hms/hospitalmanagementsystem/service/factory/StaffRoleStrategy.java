package com.hms.hospitalmanagementsystem.service.factory;

import com.hms.hospitalmanagementsystem.entity.User;
import com.hms.hospitalmanagementsystem.entity.Staff;
import com.hms.hospitalmanagementsystem.entity.Department;
import com.hms.hospitalmanagementsystem.repository.StaffRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.util.Optional;

@Component
public class StaffRoleStrategy implements UserRoleStrategy {

    @Autowired
    private StaffRepository staffRepository;

    @Override
    public String getDashboardUrl(User user) {
        return "/staff/dashboard";
    }

    @Override
    public String getWelcomeMessage(User user) {
        // ✅ UPDATED: Use profileId to find staff
        if (user.getProfileId() != null) {
            Optional<Staff> staffOpt = staffRepository.findByProfileId(user.getProfileId());
            if (staffOpt.isPresent()) {
                Staff staff = staffOpt.get();
                return "Welcome " + staff.getFullName() + " (" + staff.getStaffType() + ") to Staff Portal";
            }
        }
        return "Welcome Staff " + user.getUsername() + " to Staff Portal";
    }

    @Override
    public void performRoleSpecificActions(User user) {
        // ✅ UPDATED: Use profileId to find staff
        Optional<Staff> staffOpt = Optional.empty();
        if (user.getProfileId() != null) {
            staffOpt = staffRepository.findByProfileId(user.getProfileId());
        }

        System.out.println("📋 Staff Actions for: " + user.getUsername());
        System.out.println("   - Managing appointments");
        System.out.println("   - Processing billing");
        System.out.println("   - Updating patient records");

        if (staffOpt.isPresent()) {
            Staff staff = staffOpt.get();
            System.out.println("   - Staff Type: " + staff.getStaffType());
            System.out.println("   - Department: " + (staff.getDepartment() != null ? staff.getDepartment().getName() : "N/A"));
            System.out.println("   - Shift: " + staff.getAssignedShift());
        }
    }

    @Override
    public Object createProfileEntity(User user, Object profileData) {
        if (!(profileData instanceof StaffCreationData)) {
            throw new IllegalArgumentException("Staff profile data required");
        }

        StaffCreationData data = (StaffCreationData) profileData;
        Staff staff = new Staff();
        staff.setFirstName(data.getFirstName());
        staff.setLastName(data.getLastName());
        staff.setStaffType(data.getStaffType());
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

        // ✅ UPDATED: The profileId will be set after saving the staff entity
        // user.setProfileId(staff.getId()); // This will be handled in UserService

        return staff;
    }

    @Override
    public void initializeProfile(User user) {
        System.out.println("📋 Initializing staff profile for user: " + user.getUsername());
        // Additional staff-specific initialization
    }

    @Override
    public String getProfileDetails(User user) {
        // ✅ UPDATED: Use profileId to find staff
        if (user.getProfileId() != null) {
            Optional<Staff> staffOpt = staffRepository.findByProfileId(user.getProfileId());
            if (staffOpt.isPresent()) {
                Staff staff = staffOpt.get();
                return String.format("Staff: %s | %s | %s | Dept: %s",
                        staff.getFullName(),
                        staff.getStaffType(),
                        staff.getEmployeeId(),
                        staff.getDepartment() != null ? staff.getDepartment().getName() : "N/A");
            }
        }
        return "Staff profile not found";
    }

    // Staff-specific business methods based on staff type
    public void manageAppointments(Staff staff) {
        if (staff.isReceptionist() || staff.canHandleAppointments()) {
            System.out.println("📅 Receptionist managing appointments");
        }
    }

    public void processBilling(Staff staff) {
        if (staff.isReceptionist()) {
            System.out.println("💰 Processing patient billing and payments");
        }
    }

    public void handleLabWork(Staff staff) {
        if (staff.isLabTech()) {
            System.out.println("🔬 Lab technician processing lab tests");
        }
    }

    public void manageWard(Staff staff) {
        if (staff.isWardManager()) {
            System.out.println("🏥 Ward manager overseeing patient care");
        }
    }

    // Data transfer object for staff creation
    public static class StaffCreationData {
        private String firstName;
        private String lastName;
        private String staffType;
        private LocalDate dateOfBirth;
        private String gender;
        private String contactNumber;
        private String email;
        private String qualification;
        private Department department;
        private String assignedShift;
        private String shiftStartTime;
        private String shiftEndTime;
        private String employeeId;

        // Constructors
        public StaffCreationData() {}

        public StaffCreationData(String firstName, String lastName, String staffType,
                                 LocalDate dateOfBirth, String gender, String contactNumber,
                                 String email, String qualification, Department department) {
            this.firstName = firstName;
            this.lastName = lastName;
            this.staffType = staffType;
            this.dateOfBirth = dateOfBirth;
            this.gender = gender;
            this.contactNumber = contactNumber;
            this.email = email;
            this.qualification = qualification;
            this.department = department;
        }

        // Getters and setters
        public String getFirstName() { return firstName; }
        public void setFirstName(String firstName) { this.firstName = firstName; }
        public String getLastName() { return lastName; }
        public void setLastName(String lastName) { this.lastName = lastName; }
        public String getStaffType() { return staffType; }
        public void setStaffType(String staffType) { this.staffType = staffType; }
        public LocalDate getDateOfBirth() { return dateOfBirth; }
        public void setDateOfBirth(LocalDate dateOfBirth) { this.dateOfBirth = dateOfBirth; }
        public String getGender() { return gender; }
        public void setGender(String gender) { this.gender = gender; }
        public String getContactNumber() { return contactNumber; }
        public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }
        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }
        public String getQualification() { return qualification; }
        public void setQualification(String qualification) { this.qualification = qualification; }
        public Department getDepartment() { return department; }
        public void setDepartment(Department department) { this.department = department; }
        public String getAssignedShift() { return assignedShift; }
        public void setAssignedShift(String assignedShift) { this.assignedShift = assignedShift; }
        public String getShiftStartTime() { return shiftStartTime; }
        public void setShiftStartTime(String shiftStartTime) { this.shiftStartTime = shiftStartTime; }
        public String getShiftEndTime() { return shiftEndTime; }
        public void setShiftEndTime(String shiftEndTime) { this.shiftEndTime = shiftEndTime; }
        public String getEmployeeId() { return employeeId; }
        public void setEmployeeId(String employeeId) { this.employeeId = employeeId; }
    }
}