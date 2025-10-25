// MedicalStaffController.java
package com.hms.hospitalmanagementsystem.controller;

import com.hms.hospitalmanagementsystem.entity.*;
import com.hms.hospitalmanagementsystem.service.MedicalStaffService;
import com.hms.hospitalmanagementsystem.service.ShiftService;
import com.hms.hospitalmanagementsystem.service.UserService;
import com.hms.hospitalmanagementsystem.service.WardService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/medical-staff")
public class MedicalStaffController {

    @Autowired
    private MedicalStaffService medicalStaffService;
    @Autowired
    private ShiftService shiftService;
    @Autowired
    private WardService wardService;

    @Autowired
    private UserService userService;

    // Department Management
    @GetMapping("/departments")
    public String listDepartments(HttpSession session, Model model) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        List<Department> departments = medicalStaffService.getAllDepartments();
        model.addAttribute("departments", departments);
        model.addAttribute("department", new Department());
        return "medical-staff/departments";
    }

    @PostMapping("/departments/create")
    public String createDepartment(@ModelAttribute Department department, HttpSession session) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        medicalStaffService.saveDepartment(department);
        return "redirect:/medical-staff/departments?success=Department created successfully";
    }

    // Department Edit Form
    @GetMapping("/departments/edit/{id}")
    public String editDepartmentForm(@PathVariable Long id, HttpSession session, Model model) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        Department department = medicalStaffService.getDepartmentById(id);
        if (department != null) {
            model.addAttribute("department", department);
            return "medical-staff/edit-department";
        }
        return "redirect:/medical-staff/departments?error=Department not found";
    }

    // Department Update
    @PostMapping("/departments/update/{id}")
    public String updateDepartment(@PathVariable Long id, @ModelAttribute Department department,
                                   HttpSession session) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        try {
            department.setId(id);
            medicalStaffService.saveDepartment(department);
            return "redirect:/medical-staff/departments?success=Department updated successfully";
        } catch (Exception e) {
            return "redirect:/medical-staff/departments?error=Failed to update department";
        }
    }

    // Doctor Management
    @GetMapping("/doctors")
    public String listDoctors(HttpSession session, Model model) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        List<Doctor> doctors = medicalStaffService.getAllDoctors();
        List<Department> departments = medicalStaffService.getAllDepartments();

        model.addAttribute("doctors", doctors);
        model.addAttribute("departments", departments);
        return "medical-staff/doctors";
    }

    @PostMapping("/doctors/assign-department")
    public String assignDoctorToDepartment(@RequestParam Long doctorId,
                                           @RequestParam Long departmentId,
                                           HttpSession session) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        medicalStaffService.assignDoctorToDepartment(doctorId, departmentId);
        return "redirect:/medical-staff/doctors?success=Doctor assigned to department";
    }

    // Staff Management
    @GetMapping("/staff")
    public String listStaff(HttpSession session, Model model) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        List<Staff> staff = medicalStaffService.getAllStaff();
        List<Department> departments = medicalStaffService.getAllDepartments();

        model.addAttribute("staff", staff);
        model.addAttribute("departments", departments);
        model.addAttribute("staffMember", new Staff());
        return "medical-staff/staff";
    }

    @PostMapping("/staff/create")
    public String createStaff(@ModelAttribute Staff staff, HttpSession session) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        medicalStaffService.saveStaff(staff);
        return "redirect:/medical-staff/staff?success=Staff member added successfully";
    }

    // Staff Edit Form
    @GetMapping("/staff/edit/{id}")
    public String editStaffForm(@PathVariable Long id, HttpSession session, Model model) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        Staff staff = medicalStaffService.getStaffById(id);
        if (staff != null) {
            model.addAttribute("staffMember", staff);
            model.addAttribute("departments", medicalStaffService.getAllDepartments());
            return "medical-staff/edit-staff";
        }
        return "redirect:/medical-staff/staff?error=Staff member not found";
    }

    // Staff Update
    @PostMapping("/staff/update/{id}")
    public String updateStaff(@PathVariable Long id, @ModelAttribute Staff staff,
                              HttpSession session) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        try {
            staff.setId(id);
            medicalStaffService.saveStaff(staff);
            return "redirect:/medical-staff/staff?success=Staff member updated successfully";
        } catch (Exception e) {
            return "redirect:/medical-staff/staff?error=Failed to update staff member";
        }
    }

    // Staff Delete/Deactivate
    @GetMapping("/staff/delete/{id}")
    public String deactivateStaff(@PathVariable Long id, HttpSession session) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        try {
            medicalStaffService.deactivateStaff(id);
            return "redirect:/medical-staff/staff?success=Staff member deactivated successfully";
        } catch (Exception e) {
            return "redirect:/medical-staff/staff?error=Failed to deactivate staff member: " + e.getMessage();
        }
    }

    // Staff Status Toggle - Active/Inactive
    @PostMapping("/staff/toggle-status/{id}")
    public String toggleStaffStatus(@PathVariable Long id,
                                    @RequestParam Boolean isActive,
                                    HttpSession session) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        try {
            Staff staff = medicalStaffService.getStaffById(id);
            if (staff == null) {
                return "redirect:/medical-staff/staff?error=Staff member not found";
            }

            staff.setIsActive(isActive);
            medicalStaffService.saveStaff(staff);

            String status = isActive ? "activated" : "deactivated";
            return "redirect:/medical-staff/staff?success=Staff member " + status + " successfully";

        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/medical-staff/staff?error=Failed to update staff status: " + e.getMessage();
        }
    }

    // Staff View Details
    @GetMapping("/staff/view/{id}")
    public String viewStaff(@PathVariable Long id, HttpSession session, Model model) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        Staff staff = medicalStaffService.getStaffById(id);
        if (staff != null) {
            model.addAttribute("staff", staff);
            return "medical-staff/staff-details";
        }
        return "redirect:/medical-staff/staff?error=Staff member not found";
    }

    // Dashboard
    @GetMapping("/dashboard")
    public String medicalStaffDashboard(HttpSession session, Model model) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        long totalDoctors = medicalStaffService.getTotalDoctors();
        long totalStaff = medicalStaffService.getTotalActiveStaff();
        long nursesCount = medicalStaffService.getStaffCountByType("NURSE");
        long receptionistsCount = medicalStaffService.getStaffCountByType("RECEPTIONIST");

        model.addAttribute("totalDoctors", totalDoctors);
        model.addAttribute("totalStaff", totalStaff);
        model.addAttribute("nursesCount", nursesCount);
        model.addAttribute("receptionistsCount", receptionistsCount);
        model.addAttribute("departments", medicalStaffService.getDepartmentsWithDoctors());

        return "medical-staff/dashboard";
    }

    private boolean validateAdmin(HttpSession session) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        return username != null && "ADMIN".equals(role);
    }

    @GetMapping("/shifts")
    public String shiftsDashboard(HttpSession session, Model model) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        try {
            // Get basic statistics
            Map<String, Object> shiftStats = new HashMap<>();
            try {
                shiftStats = shiftService.getTodayShiftStatistics();
            } catch (Exception e) {
                shiftStats.put("totalShifts", 0L);
                shiftStats.put("scheduledShifts", 0L);
                shiftStats.put("completedShifts", 0L);
                shiftStats.put("activeShifts", 0L);
                shiftStats.put("nightShifts", 0L);
            }

            // Get basic ward and staff lists
            List<Ward> wards = wardService.getAllWards();
            List<Staff> allStaff = medicalStaffService.getAllStaff();

            // Add data to model
            model.addAttribute("wards", wards != null ? wards : new ArrayList<>());
            model.addAttribute("allStaff", allStaff != null ? allStaff : new ArrayList<>());
            model.addAttribute("totalShifts", shiftStats.get("totalShifts"));
            model.addAttribute("scheduledShifts", shiftStats.get("scheduledShifts"));
            model.addAttribute("completedShifts", shiftStats.get("completedShifts"));
            model.addAttribute("activeShifts", shiftStats.get("activeShifts"));
            model.addAttribute("nightShifts", shiftStats.get("nightShifts"));
            model.addAttribute("username", session.getAttribute("username"));

        } catch (Exception e) {
            // Fallback data
            model.addAttribute("wards", new ArrayList<Ward>());
            model.addAttribute("allStaff", new ArrayList<Staff>());
            model.addAttribute("totalShifts", 0);
            model.addAttribute("scheduledShifts", 0);
            model.addAttribute("completedShifts", 0);
            model.addAttribute("activeShifts", 0);
            model.addAttribute("nightShifts", 0);
        }

        return "medical-staff/shifts-dashboard";
    }

    @PostMapping("/staff/create-with-user")
    public String createStaffWithUser(@ModelAttribute Staff staff,
                                      @RequestParam(required = false) String createUserAccount,
                                      @RequestParam(required = false) String username,
                                      @RequestParam(required = false) String password,
                                      HttpSession session) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        try {
            // First save the staff member
            Staff savedStaff = medicalStaffService.saveStaff(staff);

            // If create user account is selected
            if ("on".equals(createUserAccount) && username != null && !username.trim().isEmpty()) {
                // Create user account linked to this staff member
                User staffUser = new User();
                staffUser.setUsername(username.trim());
                staffUser.setEmail(staff.getEmail());

                // Use provided password or default based on staff type
                String userPassword = (password != null && !password.trim().isEmpty()) ?
                        password : getDefaultPassword(staff.getStaffType());

                staffUser.setPassword(userPassword);

                // Map staff type to user role
                String userRole = mapStaffTypeToUserRole(staff.getStaffType());
                staffUser.setRole(userRole);

                staffUser.setProfileId(savedStaff.getId()); // Link to the staff's ID

                userService.registerUser(staffUser);

                return "redirect:/medical-staff/staff?success=Staff member and user account created successfully! Username: " + username.trim() + ", Password: " + userPassword;
            } else {
                return "redirect:/medical-staff/staff?success=Staff member created successfully. Staff ID: " + savedStaff.getId();
            }

        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/medical-staff/staff?error=Failed to create staff member: " + e.getMessage();
        }
    }

    // Helper method to map staff type to user role
    private String mapStaffTypeToUserRole(String staffType) {
        switch (staffType) {
            case "NURSE":
                return "STAFF"; // Nurses use STAFF role
            case "RECEPTIONIST":
                return "RECEPTIONIST";
            case "LAB_TECH":
                return "LAB_TECH";
            case "WARD_MANAGER":
                return "STAFF"; // Ward managers also use STAFF role
            default:
                return "STAFF";
        }
    }

    // Helper method to generate default passwords
    private String getDefaultPassword(String staffType) {
        switch (staffType) {
            case "NURSE":
                return "nurse123";
            case "RECEPTIONIST":
                return "receptionist123";
            case "LAB_TECH":
                return "labtech123";
            case "WARD_MANAGER":
                return "wardmanager123";
            default:
                return "staff123";
        }
    }

    // Ward Shift Management
    @GetMapping("/shifts/ward/{wardId}")
    public String viewWardShifts(@PathVariable Long wardId,
                                 @RequestParam(required = false) String date,
                                 HttpSession session, Model model) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        try {
            Ward ward = wardService.getWardById(wardId);
            if (ward == null) {
                return "redirect:/medical-staff/shifts?error=Ward not found";
            }

            LocalDate selectedDate = (date != null) ? LocalDate.parse(date) : LocalDate.now();
            List<ShiftSchedule> shifts = shiftService.getWardSchedules(wardId, selectedDate);
            List<Staff> staffList = medicalStaffService.getAllStaff();

            model.addAttribute("ward", ward);
            model.addAttribute("shifts", shifts);
            model.addAttribute("staffList", staffList);
            model.addAttribute("selectedDate", selectedDate);
            model.addAttribute("selectedDateString", selectedDate.toString());
            model.addAttribute("username", session.getAttribute("username"));

            return "medical-staff/ward-shifts";

        } catch (Exception e) {
            return "redirect:/medical-staff/shifts?error=Error loading ward shifts: " + e.getMessage();
        }
    }

    // Assign Shift to Staff
    @PostMapping("/shifts/assign")
    public String assignShift(@RequestParam Long staffId,
                              @RequestParam Long wardId,
                              @RequestParam String shiftType,
                              @RequestParam String scheduleDate,
                              @RequestParam(required = false) String notes,
                              HttpSession session) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        try {
            LocalDate date = LocalDate.parse(scheduleDate);
            ShiftSchedule shift = shiftService.scheduleShift(staffId, wardId, date, shiftType, notes);

            return "redirect:/medical-staff/shifts/ward/" + wardId + "?date=" + scheduleDate + "&success=Shift assigned successfully";
        } catch (Exception e) {
            return "redirect:/medical-staff/shifts/ward/" + wardId + "?error=Failed to assign shift: " + e.getMessage();
        }
    }

    // Update Shift Status
    @PostMapping("/shifts/update-status")
    public String updateShiftStatus(@RequestParam Long scheduleId,
                                    @RequestParam String status,
                                    HttpSession session) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        try {
            shiftService.updateShiftStatus(scheduleId, status);
            return "redirect:/medical-staff/shifts?success=Shift status updated successfully";
        } catch (Exception e) {
            return "redirect:/medical-staff/shifts?error=Failed to update shift status: " + e.getMessage();
        }
    }

    // Generate Weekly Schedule
    @PostMapping("/shifts/generate-weekly")
    public String generateWeeklySchedule(@RequestParam Long wardId,
                                         HttpSession session) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        try {
            shiftService.generateWeeklySchedule(wardId, LocalDate.now());
            return "redirect:/medical-staff/shifts/ward/" + wardId + "?success=Weekly schedule generated successfully";
        } catch (Exception e) {
            return "redirect:/medical-staff/shifts/ward/" + wardId + "?error=Failed to generate weekly schedule: " + e.getMessage();
        }
    }

    // Staff Schedule View
    @GetMapping("/shifts/staff/{staffId}")
    public String viewStaffSchedule(@PathVariable Long staffId,
                                    @RequestParam(required = false) String startDate,
                                    @RequestParam(required = false) String endDate,
                                    HttpSession session, Model model) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        try {
            Staff staff = medicalStaffService.getStaffById(staffId);
            if (staff == null) {
                return "redirect:/medical-staff/shifts?error=Staff not found";
            }

            LocalDate start = (startDate != null) ? LocalDate.parse(startDate) : LocalDate.now();
            LocalDate end = (endDate != null) ? LocalDate.parse(endDate) : LocalDate.now().plusDays(7);

            List<ShiftSchedule> shifts = shiftService.getStaffSchedule(staffId, start, end);

            model.addAttribute("staff", staff);
            model.addAttribute("shifts", shifts);
            model.addAttribute("startDate", start);
            model.addAttribute("endDate", end);
            model.addAttribute("username", session.getAttribute("username"));

            return "medical-staff/staff-schedule";

        } catch (Exception e) {
            return "redirect:/medical-staff/shifts?error=Error loading staff schedule: " + e.getMessage();
        }
    }

    // Delete Shift
    @GetMapping("/shifts/delete/{shiftId}")
    public String deleteShift(@PathVariable Long shiftId, HttpSession session) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        try {
            shiftService.deleteShift(shiftId);
            return "redirect:/medical-staff/shifts?success=Shift deleted successfully";
        } catch (Exception e) {
            return "redirect:/medical-staff/shifts?error=Failed to delete shift: " + e.getMessage();
        }
    }
}