package com.hms.hospitalmanagementsystem.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import com.hms.hospitalmanagementsystem.service.UserService;

@Controller
public class DashboardController {

    @Autowired
    private UserService userService;

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null) {
            return "redirect:/login";
        }

        model.addAttribute("username", username);
        model.addAttribute("role", role);

        // Simple statistics that won't cause errors
        switch (role) {
            case "ADMIN":
                model.addAttribute("userCount", userService.getAllUsersCount());
                model.addAttribute("patientCount", 25); // Placeholder
                model.addAttribute("doctorCount", 8);   // Placeholder
                model.addAttribute("occupiedBedCount", 12); // Placeholder
                break;
            case "DOCTOR":
                model.addAttribute("todayAppointments", 5);
                model.addAttribute("currentPatients", 8);
                model.addAttribute("pendingTests", 3);
                model.addAttribute("urgentCases", 2);
                break;
            case "PATIENT":
                model.addAttribute("upcomingAppointments", 2);
                model.addAttribute("medicalRecords", 3);
                model.addAttribute("activePrescriptions", 1);
                model.addAttribute("pendingResults", 0);
                break;
            // DashboardController.java - Update staff case in dashboard method
            case "STAFF": // This is for nurses
                model.addAttribute("todayAppointments", 15);
                model.addAttribute("pendingAdmissions", 4);
                model.addAttribute("pendingBills", 7);
                model.addAttribute("availableBeds", 18);

                // Add nurse-specific statistics
                model.addAttribute("medicationsToAdminister", 8);
                model.addAttribute("todayShiftsCount", 5);
                model.addAttribute("bedsCleaning", 3);
                model.addAttribute("dischargesPending", 1);
                break;


        }

        return "dashboard";
    }

    @GetMapping("/access-denied")
    public String accessDenied() {
        return "access-denied";
    }
}