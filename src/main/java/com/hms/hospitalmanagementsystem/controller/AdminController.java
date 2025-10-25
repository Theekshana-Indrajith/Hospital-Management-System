package com.hms.hospitalmanagementsystem.controller;

import com.hms.hospitalmanagementsystem.entity.*;
import com.hms.hospitalmanagementsystem.repository.UserRepository;
import com.hms.hospitalmanagementsystem.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired private AdminService adminService;
    @Autowired private UserService userService;
    @Autowired private PatientService patientService;
    @Autowired private DoctorService doctorService;
    @Autowired private WardService wardService;
    @Autowired private UserRepository userRepository;
    @Autowired private ReportService reportService;

    @GetMapping("/dashboard")
    public String adminDashboard(HttpSession session, Model model) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        Map<String, Object> stats = adminService.getSystemStatistics();
        Map<String, Object> financials = adminService.getFinancialReport();
        Map<String, Object> appointments = adminService.getAppointmentStatistics();
        Map<String, Object> occupancy = adminService.getWardOccupancy();

        model.addAttribute("username", session.getAttribute("username"));
        model.addAttribute("role", session.getAttribute("role"));
        model.addAttribute("stats", stats);
        model.addAttribute("financials", financials);
        model.addAttribute("appointments", appointments);
        model.addAttribute("occupancy", occupancy);

        return "admin/dashboard";
    }

    // Report Management Endpoints - View Only
    @GetMapping("/reports")
    public String adminReports(HttpSession session, Model model) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        Map<String, Object> systemUsage = reportService.generateSystemUsageReport();
        Map<String, Object> quickStats = reportService.getQuickStats();
        Map<String, Object> wardOccupancy = adminService.getWardOccupancy();
        Map<String, Object> financialReport = reportService.generateFinancialReport(); // No parameters
        Map<String, Object> patientReport = reportService.generatePatientStatisticsReport(); // No parameters
        Map<String, Object> appointmentReport = reportService.generateAppointmentAnalysisReport(); // No parameters
        Map<String, Object> doctorReport = reportService.generateDoctorPerformanceReport(); // No parameters

        model.addAttribute("username", session.getAttribute("username"));
        model.addAttribute("role", session.getAttribute("role"));
        model.addAttribute("systemUsage", systemUsage);
        model.addAttribute("quickStats", quickStats);
        model.addAttribute("wardOccupancy", wardOccupancy);
        model.addAttribute("financialReport", financialReport);
        model.addAttribute("patientReport", patientReport);
        model.addAttribute("appointmentReport", appointmentReport);
        model.addAttribute("doctorReport", doctorReport);
        model.addAttribute("pageTitle", "Reports Dashboard");

        return "admin/reports";
    }

    @GetMapping("/reports/financial")
    public String financialReport(HttpSession session, Model model) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        Map<String, Object> report = reportService.generateFinancialReport(); // No parameters

        model.addAttribute("username", session.getAttribute("username"));
        model.addAttribute("role", session.getAttribute("role"));
        model.addAttribute("report", report);
        model.addAttribute("pageTitle", "Financial Report");

        return "admin/financial-report";
    }

    @GetMapping("/reports/patients")
    public String patientReport(HttpSession session, Model model) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        Map<String, Object> report = reportService.generatePatientStatisticsReport(); // No parameters

        model.addAttribute("username", session.getAttribute("username"));
        model.addAttribute("role", session.getAttribute("role"));
        model.addAttribute("report", report);
        model.addAttribute("pageTitle", "Patient Statistics Report");

        return "admin/patient-report";
    }

    @GetMapping("/reports/wards")
    public String wardReport(HttpSession session, Model model) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        Map<String, Object> report = reportService.generateWardOccupancyReport();

        model.addAttribute("username", session.getAttribute("username"));
        model.addAttribute("role", session.getAttribute("role"));
        model.addAttribute("report", report);
        model.addAttribute("pageTitle", "Ward Occupancy Report");

        return "admin/ward-report";
    }



    // Complete User Management
    @GetMapping("/users")
    public String manageUsers(HttpSession session, Model model) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        model.addAttribute("users", userService.getAllUsers());
        model.addAttribute("pageTitle", "User Management");
        return "admin/users";
    }

    @PostMapping("/users/create")
    public String createUser(@RequestParam String username, @RequestParam String email,
                             @RequestParam String password, @RequestParam String role,
                             @RequestParam(required = false) Long profileId,
                             HttpSession session) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        try {
            User user = new User();
            user.setUsername(username);
            user.setEmail(email);
            user.setPassword(password);
            user.setRole(role.toUpperCase());
            user.setProfileId(profileId != null ? profileId : 0L);

            userService.registerUser(user);
            return "redirect:/admin/users?success=User created successfully";
        } catch (Exception e) {
            return "redirect:/admin/users?error=Failed to create user";
        }
    }

    // Complete Doctor Management
    @GetMapping("/doctors")
    public String manageDoctors(HttpSession session, Model model) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        model.addAttribute("doctors", doctorService.getAllDoctors());
        model.addAttribute("pageTitle", "Doctor Management");
        return "admin/doctors";
    }

    @PostMapping("/doctors/create")
    public String createDoctor(@RequestParam String name,
                               @RequestParam String specialization,
                               @RequestParam String contactNumber,
                               @RequestParam String email,
                               @RequestParam String roomNumber,
                               @RequestParam(required = false) String createUser,
                               @RequestParam(required = false) String username,
                               @RequestParam(required = false) String password,
                               HttpSession session) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        try {
            Doctor doctor = new Doctor();
            doctor.setName(name);
            doctor.setSpecialization(specialization);
            doctor.setContactNumber(contactNumber);
            doctor.setEmail(email);
            doctor.setRoomNumber(roomNumber);
            doctor.setIsActive(true);

            Doctor savedDoctor = doctorService.saveDoctor(doctor);

            if ("on".equals(createUser) && username != null && !username.trim().isEmpty()) {
                User doctorUser = new User();
                doctorUser.setUsername(username.trim());
                doctorUser.setEmail(email);
                doctorUser.setPassword(password != null ? password : "doctor123");
                doctorUser.setRole("DOCTOR");
                doctorUser.setProfileId(savedDoctor.getId());

                userService.registerUser(doctorUser);

                return "redirect:/admin/doctors?success=Doctor and user account created successfully. Doctor ID: " + savedDoctor.getId();
            } else {
                return "redirect:/admin/doctors?success=Doctor created successfully. Doctor ID: " + savedDoctor.getId();
            }

        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/admin/doctors?error=Failed to create doctor: " + e.getMessage();
        }
    }

    @PostMapping("/doctors/create-with-model")
    public String createDoctorWithModel(@ModelAttribute Doctor doctor,
                                        @RequestParam(required = false) String createUser,
                                        @RequestParam(required = false) String username,
                                        @RequestParam(required = false) String password,
                                        HttpSession session) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        try {
            doctor.setIsActive(true);
            Doctor savedDoctor = doctorService.saveDoctor(doctor);

            if ("on".equals(createUser) && username != null && !username.trim().isEmpty()) {
                User doctorUser = new User();
                doctorUser.setUsername(username.trim());
                doctorUser.setEmail(doctor.getEmail());
                doctorUser.setPassword(password != null ? password : "doctor123");
                doctorUser.setRole("DOCTOR");
                doctorUser.setProfileId(savedDoctor.getId());

                userService.registerUser(doctorUser);

                return "redirect:/admin/doctors?success=Doctor and user account created successfully";
            }

            return "redirect:/admin/doctors?success=Doctor created successfully";

        } catch (Exception e) {
            return "redirect:/admin/doctors?error=Failed to create doctor: " + e.getMessage();
        }
    }



    private boolean validateAdmin(HttpSession session) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        return username != null && "ADMIN".equals(role);
    }

    @PostMapping("/doctors/create-with-user")
    public String createDoctorWithUser(@ModelAttribute Doctor doctor,
                                       @RequestParam String username,
                                       @RequestParam String password,
                                       HttpSession session) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        try {
            Doctor savedDoctor = doctorService.saveDoctor(doctor);

            User doctorUser = new User();
            doctorUser.setUsername(username);
            doctorUser.setEmail(doctor.getEmail());
            doctorUser.setPassword(password);
            doctorUser.setRole("DOCTOR");
            doctorUser.setProfileId(savedDoctor.getId());

            userService.registerUser(doctorUser);

            return "redirect:/admin/doctors?success=Doctor and user account created successfully";
        } catch (Exception e) {
            return "redirect:/admin/doctors?error=Failed to create doctor: " + e.getMessage();
        }
    }

    // Doctor Edit Methods
    @GetMapping("/doctors/edit/{id}")
    public String editDoctorForm(@PathVariable Long id, HttpSession session, Model model) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        try {
            Doctor doctor = doctorService.getDoctorById(id);
            if (doctor == null) {
                return "redirect:/admin/doctors?error=Doctor not found";
            }

            model.addAttribute("doctor", doctor);
            model.addAttribute("pageTitle", "Edit Doctor");
            return "admin/edit-doctor";
        } catch (Exception e) {
            return "redirect:/admin/doctors?error=Failed to load doctor: " + e.getMessage();
        }
    }

    @PostMapping("/doctors/update/{id}")
    public String updateDoctor(@PathVariable Long id,
                               @RequestParam String name,
                               @RequestParam String specialization,
                               @RequestParam String contactNumber,
                               @RequestParam String email,
                               @RequestParam String roomNumber,
                               @RequestParam(required = false) String isActive, // Change to String
                               HttpSession session) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        try {
            Doctor doctor = doctorService.getDoctorById(id);
            if (doctor == null) {
                return "redirect:/admin/doctors?error=Doctor not found";
            }

            doctor.setName(name);
            doctor.setSpecialization(specialization);
            doctor.setContactNumber(contactNumber);
            doctor.setEmail(email);
            doctor.setRoomNumber(roomNumber);

            // Properly handle the isActive parameter
            if (isActive != null) {
                doctor.setIsActive("on".equalsIgnoreCase(isActive));
            } else {
                doctor.setIsActive(false); // Default to false if not provided
            }

            Doctor updatedDoctor = doctorService.saveDoctor(doctor);
            return "redirect:/admin/doctors?success=Doctor updated successfully";
        } catch (Exception e) {
            return "redirect:/admin/doctors?error=Failed to update doctor: " + e.getMessage();
        }
    }
    @PostMapping("/doctors/delete/{id}")
    public String deleteDoctor(@PathVariable Long id, HttpSession session) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        try {
            List<User> doctorUsers = userService.getUsersByRole("DOCTOR");
            for (User user : doctorUsers) {
                if (user.getProfileId() != null && user.getProfileId().equals(id)) {
                    userRepository.delete(user);
                    break;
                }
            }

            doctorService.deleteDoctor(id);
            return "redirect:/admin/doctors?success=Doctor deleted successfully";
        } catch (Exception e) {
            return "redirect:/admin/doctors?error=Failed to delete doctor: " + e.getMessage();
        }
    }

}