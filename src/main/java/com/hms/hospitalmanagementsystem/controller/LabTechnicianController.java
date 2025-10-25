package com.hms.hospitalmanagementsystem.controller;

import com.hms.hospitalmanagementsystem.entity.LabTest;
import com.hms.hospitalmanagementsystem.entity.Staff;
import com.hms.hospitalmanagementsystem.service.LabTestService;
import com.hms.hospitalmanagementsystem.service.MedicalStaffService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/lab-technician")
public class LabTechnicianController {

    @Autowired
    private LabTestService labTestService;

    @Autowired
    private MedicalStaffService medicalStaffService;

    @GetMapping("/dashboard")
    public String labTechnicianDashboard(HttpSession session, Model model) {
        if (!validateLabTechnician(session)) return "redirect:/access-denied";

        Long technicianId = getCurrentTechnicianId(session);

        // Get assigned tests for the technician
        List<LabTest> assignedTests = labTestService.getTestsByTechnician(technicianId);
        long totalTests = assignedTests.size();

        // Get available pending tests (unassigned)
        List<LabTest> availablePendingTestsList = labTestService.getPendingTests().stream()
                .filter(test -> test.getLabTechnician() == null) // Only unassigned tests
                .collect(Collectors.toList());
        long availablePendingTests = availablePendingTestsList.size();

        long completedToday = labTestService.getTodayCompletedTests();
        long abnormalResults = labTestService.getAbnormalResults().size();

        model.addAttribute("username", session.getAttribute("username"));
        model.addAttribute("totalTests", totalTests);
        model.addAttribute("availablePendingTests", availablePendingTests);
        model.addAttribute("availablePendingTestsList", availablePendingTestsList);
        model.addAttribute("completedToday", completedToday);
        model.addAttribute("abnormalResults", abnormalResults);
        model.addAttribute("assignedTests", assignedTests);

        return "lab-technician/dashboard";
    }    // View assigned tests
    @GetMapping("/tests")
    public String viewAssignedTests(HttpSession session, Model model) {
        if (!validateLabTechnician(session)) return "redirect:/access-denied";

        Long technicianId = getCurrentTechnicianId(session);
        List<LabTest> assignedTests = labTestService.getTestsByTechnician(technicianId);

        model.addAttribute("tests", assignedTests);
        model.addAttribute("pageTitle", "My Assigned Tests");
        return "lab-technician/tests";
    }

    // View pending tests (available for assignment)
    @GetMapping("/tests/pending")
    public String viewPendingTests(HttpSession session, Model model) {
        if (!validateLabTechnician(session)) return "redirect:/access-denied";

        List<LabTest> pendingTests = labTestService.getPendingTests().stream()
                .filter(test -> test.getLabTechnician() == null) // Only unassigned tests
                .collect(Collectors.toList());

        model.addAttribute("tests", pendingTests);
        model.addAttribute("pageTitle", "Pending Tests Available for Assignment");
        return "lab-technician/pending-tests";
    }

    // Assign test to myself
    @PostMapping("/tests/assign/{testId}")
    public String assignTestToMe(@PathVariable Long testId, HttpSession session) {
        if (!validateLabTechnician(session)) return "redirect:/access-denied";

        Long technicianId = getCurrentTechnicianId(session);
        try {
            labTestService.assignLabTechnician(testId, technicianId);
            return "redirect:/lab-technician/tests?success=Test assigned successfully";
        } catch (Exception e) {
            return "redirect:/lab-technician/tests/pending?error=Failed to assign test";
        }
    }

    // Update test results form
    @GetMapping("/tests/update-results/{testId}")
    public String showUpdateResultsForm(@PathVariable Long testId, HttpSession session, Model model) {
        if (!validateLabTechnician(session)) return "redirect:/access-denied";

        LabTest labTest = labTestService.getLabTestById(testId);
        if (labTest == null || !isTestAssignedToTechnician(labTest, session)) {
            return "redirect:/lab-technician/tests?error=Test not found or not assigned to you";
        }

        model.addAttribute("labTest", labTest);
        return "lab-technician/update-results";
    }

    // Submit test results
    @PostMapping("/tests/update-results/{testId}")
    public String updateTestResults(@PathVariable Long testId,
                                    @RequestParam String results,
                                    @RequestParam String normalRange,
                                    @RequestParam String units,
                                    @RequestParam String findings,
                                    @RequestParam String notes,
                                    HttpSession session) {
        if (!validateLabTechnician(session)) return "redirect:/access-denied";

        try {
            labTestService.updateTestResults(testId, results, normalRange, units, findings, notes);
            return "redirect:/lab-technician/tests?success=Results updated successfully";
        } catch (Exception e) {
            return "redirect:/lab-technician/tests/update-results/" + testId + "?error=Failed to update results";
        }
    }

    // Helper methods
    private boolean validateLabTechnician(HttpSession session) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        return username != null && "LAB_TECH".equals(role);
    }

    private Long getCurrentTechnicianId(HttpSession session) {
        // For demo, return first lab technician ID
        List<Staff> labTechnicians = medicalStaffService.getStaffByType("LAB_TECH");
        return labTechnicians.isEmpty() ? 1L : labTechnicians.get(0).getId();
    }

    private boolean isTestAssignedToTechnician(LabTest labTest, HttpSession session) {
        Long technicianId = getCurrentTechnicianId(session);
        return labTest.getLabTechnician() != null &&
                labTest.getLabTechnician().getId().equals(technicianId);
    }
}