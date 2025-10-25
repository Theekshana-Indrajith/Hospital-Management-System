package com.hms.hospitalmanagementsystem.controller;

import com.hms.hospitalmanagementsystem.entity.LabTest;
import com.hms.hospitalmanagementsystem.service.LabTestService;
import com.hms.hospitalmanagementsystem.service.PatientService;
import com.hms.hospitalmanagementsystem.service.DoctorService;
import com.hms.hospitalmanagementsystem.service.MedicalStaffService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/lab-tests")
public class LabTestController {

    @Autowired
    private LabTestService labTestService;

    @Autowired
    private PatientService patientService;

    @Autowired
    private DoctorService doctorService;

    @Autowired
    private MedicalStaffService medicalStaffService;

    // View all lab tests (Admin/Doctor)
    @GetMapping
    public String listLabTests(HttpSession session, Model model) {
        if (!validateMedicalStaff(session)) return "redirect:/access-denied";

        List<LabTest> labTests = labTestService.getAllLabTests();
        model.addAttribute("labTests", labTests);
        model.addAttribute("pageTitle", "Laboratory Tests Management");
        return "lab-tests/list";
    }

    // Request new lab test form
    @GetMapping("/request")
    public String showRequestTestForm(HttpSession session, Model model) {
        if (!validateDoctor(session)) return "redirect:/access-denied";

        model.addAttribute("patients", patientService.getAllPatients());
        model.addAttribute("labTest", new LabTest());
        return "lab-tests/request-test";
    }

    // Submit lab test request
    @PostMapping("/request")
    public String requestLabTest(@RequestParam Long patientId,
                                 @RequestParam String testName,
                                 @RequestParam String testType,
                                 @RequestParam String priority,
                                 @RequestParam(required = false) String description,
                                 @RequestParam(required = false) String instructions,
                                 HttpSession session) {
        if (!validateDoctor(session)) return "redirect:/access-denied";

        Long doctorId = getCurrentDoctorId(session); // Get doctor ID from session
        try {
            LabTest labTest = labTestService.requestLabTest(patientId, doctorId, testName, testType, priority);
            if (description != null) labTest.setDescription(description);
            if (instructions != null) labTest.setInstructions(instructions);
            labTestService.saveLabTest(labTest);

            return "redirect:/lab-tests?success=Lab test requested successfully";
        } catch (Exception e) {
            return "redirect:/lab-tests/request?error=Failed to request lab test";
        }
    }

    // View test details
    @GetMapping("/details/{testId}")
    public String viewTestDetails(@PathVariable Long testId, HttpSession session, Model model) {
        if (!validateMedicalStaff(session)) return "redirect:/access-denied";

        LabTest labTest = labTestService.getLabTestById(testId);
        model.addAttribute("labTest", labTest);
        return "lab-tests/test-details";
    }

    // Assign technician to test (Admin)
    @PostMapping("/assign-technician/{testId}")
    public String assignTechnician(@PathVariable Long testId,
                                   @RequestParam Long technicianId,
                                   HttpSession session) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        try {
            labTestService.assignLabTechnician(testId, technicianId);
            return "redirect:/lab-tests?success=Technician assigned successfully";
        } catch (Exception e) {
            return "redirect:/lab-tests?error=Failed to assign technician";
        }
    }

    // View patient's lab tests
    @GetMapping("/patient/{patientId}")
    public String viewPatientTests(@PathVariable Long patientId, HttpSession session, Model model) {
        if (!validateMedicalStaff(session)) return "redirect:/access-denied";

        List<LabTest> patientTests = labTestService.getTestsByPatient(patientId);
        model.addAttribute("tests", patientTests);
        model.addAttribute("patient", patientService.getPatientById(patientId));
        return "lab-tests/patient-tests";
    }

    // View abnormal results
    @GetMapping("/abnormal")
    public String viewAbnormalResults(HttpSession session, Model model) {
        if (!validateMedicalStaff(session)) return "redirect:/access-denied";

        List<LabTest> abnormalTests = labTestService.getAbnormalResults();
        model.addAttribute("tests", abnormalTests);
        model.addAttribute("pageTitle", "Abnormal Test Results");
        return "lab-tests/abnormal-results";
    }

    // Helper methods for validation
    private boolean validateMedicalStaff(HttpSession session) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        return username != null && ("DOCTOR".equals(role) || "ADMIN".equals(role) || "LAB_TECH".equals(role));
    }

    private boolean validateDoctor(HttpSession session) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        return username != null && "DOCTOR".equals(role);
    }

    private boolean validateAdmin(HttpSession session) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        return username != null && "ADMIN".equals(role);
    }

    private Long getCurrentDoctorId(HttpSession session) {
        // In real implementation, get doctor ID from session
        // For demo, return first doctor ID
        return 1L;
    }
}