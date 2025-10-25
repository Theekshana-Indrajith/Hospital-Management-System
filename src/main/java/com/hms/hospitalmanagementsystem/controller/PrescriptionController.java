package com.hms.hospitalmanagementsystem.controller;

import com.hms.hospitalmanagementsystem.entity.Prescription;
import com.hms.hospitalmanagementsystem.service.PrescriptionService;
import com.hms.hospitalmanagementsystem.service.PatientService;
import com.hms.hospitalmanagementsystem.service.DoctorService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/prescriptions")
public class PrescriptionController {

    @Autowired
    private PrescriptionService prescriptionService;

    @Autowired
    private PatientService patientService;

    @Autowired
    private DoctorService doctorService;

    // Doctor: View all prescriptions - FIXED PATH
    @GetMapping
    public String listPrescriptions(HttpSession session, Model model) {
        if (!validateDoctor(session)) return "redirect:/access-denied";

        List<Prescription> prescriptions = prescriptionService.getAllPrescriptions();
        model.addAttribute("prescriptions", prescriptions);
        model.addAttribute("pageTitle", "All Prescriptions");
        return "prescriptions/list"; // This should match your JSP file name
    }

    // Doctor: Add prescription form
    @GetMapping("/add")
    public String showAddPrescriptionForm(HttpSession session, Model model) {
        if (!validateDoctor(session)) return "redirect:/access-denied";

        model.addAttribute("patients", patientService.getAllPatients());
        model.addAttribute("prescription", new Prescription());
        return "prescriptions/add-prescription";
    }

    // Doctor: Submit new prescription - FIXED REDIRECT
    @PostMapping("/add")
    public String addPrescription(@RequestParam Long patientId,
                                  @RequestParam String medicationName,
                                  @RequestParam String dosage,
                                  @RequestParam String frequency,
                                  @RequestParam String duration,
                                  @RequestParam(required = false) String instructions,
                                  HttpSession session, Model model) {

        if (!validateDoctor(session)) return "redirect:/access-denied";

        try {
            Long doctorId = getCurrentDoctorId(session);
            System.out.println("DEBUG: Creating prescription for patient: " + patientId + ", doctor: " + doctorId);

            Prescription prescription = prescriptionService.createPrescription(
                    patientId, doctorId, medicationName, dosage, frequency, duration, instructions);

            if (prescription != null) {
                System.out.println("DEBUG: Prescription created successfully: " + prescription.getId());

                // ✅ Instead of redirect, reload form with success message
                model.addAttribute("success", "Prescription added successfully!");
                model.addAttribute("patients", patientService.getAllPatients());
                model.addAttribute("prescription", new Prescription()); // reset form

                return "prescriptions/add-prescription";
            } else {
                model.addAttribute("error", "Failed to create prescription");
                model.addAttribute("patients", patientService.getAllPatients());
                return "prescriptions/add-prescription";
            }
        } catch (Exception e) {
            System.out.println("DEBUG: Error creating prescription: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Failed to add prescription: " + e.getMessage());
            model.addAttribute("patients", patientService.getAllPatients());
            return "prescriptions/add-prescription";
        }
    }

    // Doctor: View patient's prescriptions
    @GetMapping("/patient/{patientId}")
    public String viewPatientPrescriptions(@PathVariable Long patientId,
                                           HttpSession session, Model model) {
        if (!validateDoctor(session)) return "redirect:/access-denied";

        List<Prescription> prescriptions = prescriptionService.getPrescriptionsByPatient(patientId);
        model.addAttribute("prescriptions", prescriptions);
        model.addAttribute("patient", patientService.getPatientById(patientId));
        model.addAttribute("pageTitle", "Patient Prescriptions");
        return "prescriptions/patient-prescriptions";
    }

    // Patient: View own prescriptions
    @GetMapping("/my-prescriptions")
    public String viewMyPrescriptions(HttpSession session, Model model) {
        if (!validatePatient(session)) return "redirect:/access-denied";

        Long patientId = getCurrentPatientId(session);
        List<Prescription> prescriptions = prescriptionService.getPrescriptionsByPatient(patientId);

        // Calculate counts for statistics
        long activeCount = prescriptions.stream().filter(p -> "ACTIVE".equals(p.getStatus())).count();
        long completedCount = prescriptions.stream().filter(p -> "COMPLETED".equals(p.getStatus())).count();

        model.addAttribute("prescriptions", prescriptions);
        model.addAttribute("activePrescriptionsCount", activeCount);
        model.addAttribute("completedPrescriptionsCount", completedCount);
        model.addAttribute("totalPrescriptionsCount", prescriptions.size());
        model.addAttribute("pageTitle", "My Prescriptions");
        return "prescriptions/my-prescriptions";
    }

    // Staff Nurse: View patient prescriptions - FIXED ACCESS CONTROL
    @GetMapping("/nurse/patient/{patientId}")
    public String viewPatientPrescriptionsForNurse(@PathVariable Long patientId,
                                                   HttpSession session, Model model) {
        if (!validateStaff(session)) {
            System.out.println("DEBUG: Staff access denied - session: " + session.getAttribute("username") + ", role: " + session.getAttribute("role"));
            return "redirect:/access-denied";
        }

        List<Prescription> prescriptions = prescriptionService.getPrescriptionsByPatient(patientId);
        model.addAttribute("prescriptions", prescriptions);
        model.addAttribute("patient", patientService.getPatientById(patientId));
        model.addAttribute("pageTitle", "Patient Prescriptions - Nurse View");
        return "prescriptions/nurse-patient-prescriptions";
    }

    // Update prescription status
    @PostMapping("/update-status")
    public String updatePrescriptionStatus(@RequestParam Long prescriptionId,
                                           @RequestParam String status,
                                           HttpSession session) {
        if (!validateDoctor(session) && !validateStaff(session)) {
            System.out.println("DEBUG: Update status access denied");
            return "redirect:/access-denied";
        }

        try {
            prescriptionService.updatePrescriptionStatus(prescriptionId, status);
            return "redirect:/prescriptions?success=Prescription+status+updated";
        } catch (Exception e) {
            return "redirect:/prescriptions?error=Failed+to+update+prescription+status";
        }
    }

    // Helper methods - FIXED STAFF VALIDATION
    private boolean validateDoctor(HttpSession session) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        boolean isValid = username != null && "DOCTOR".equals(role);
        System.out.println("DEBUG: Doctor validation - username: " + username + ", role: " + role + ", valid: " + isValid);
        return isValid;
    }

    private boolean validatePatient(HttpSession session) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        boolean isValid = username != null && "PATIENT".equals(role);
        System.out.println("DEBUG: Patient validation - username: " + username + ", role: " + role + ", valid: " + isValid);
        return isValid;
    }

    private boolean validateStaff(HttpSession session) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        // FIXED: Allow both STAFF and LAB_TECH roles
        boolean isValid = username != null && ("STAFF".equals(role) || "LAB_TECH".equals(role));
        System.out.println("DEBUG: Staff validation - username: " + username + ", role: " + role + ", valid: " + isValid);
        return isValid;
    }

    private Long getCurrentDoctorId(HttpSession session) {
        // For demo - using first doctor. In real system, get from session
        String username = (String) session.getAttribute("username");
        System.out.println("DEBUG: Getting doctor ID for username: " + username);

        // Try to find doctor by username
        if ("doctor".equals(username)) {
            return 1L; // Assuming first doctor has ID 1
        }
        // Fallback - get first doctor from database
        var doctors = doctorService.getAllDoctors();
        if (!doctors.isEmpty()) {
            return doctors.get(0).getId();
        }
        return 1L; // Default fallback
    }

    private Long getCurrentPatientId(HttpSession session) {
        // For demo - using first patient. In real system, get from session
        String username = (String) session.getAttribute("username");
        System.out.println("DEBUG: Getting patient ID for username: " + username);

        if ("patient".equals(username)) {
            return 1L; // Assuming first patient has ID 1
        }
        // Fallback - get first patient from database
        var patients = patientService.getAllPatients();
        if (!patients.isEmpty()) {
            return patients.get(0).getId();
        }
        return 1L; // Default fallback
    }
    // Add these methods to PrescriptionController.java

    // Doctor: Delete prescription (only own prescriptions)
    @PostMapping("/delete/{prescriptionId}")
    public String deletePrescription(@PathVariable Long prescriptionId,
                                     HttpSession session,
                                     RedirectAttributes redirectAttributes) {
        if (!validateDoctor(session)) return "redirect:/access-denied";

        try {
            Long doctorId = getCurrentDoctorId(session);
            Prescription prescription = prescriptionService.getPrescriptionById(prescriptionId);

            // Check if prescription exists and belongs to the current doctor
            if (prescription == null) {
                redirectAttributes.addFlashAttribute("error", "Prescription not found");
                return "redirect:/doctor/patients";
            }

            if (!prescription.getDoctor().getId().equals(doctorId)) {
                redirectAttributes.addFlashAttribute("error", "You can only delete prescriptions you created");
                return "redirect:/doctor/patients";
            }

            prescriptionService.deletePrescription(prescriptionId);
            redirectAttributes.addFlashAttribute("success", "Prescription deleted successfully");

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete prescription: " + e.getMessage());
        }

        return "redirect:/doctor/patients";
    }

    // Doctor: Delete prescription from patient details page
    @PostMapping("/delete-from-patient/{prescriptionId}")
    public String deletePrescriptionFromPatient(@PathVariable Long prescriptionId,
                                                HttpSession session,
                                                RedirectAttributes redirectAttributes) {
        if (!validateDoctor(session)) return "redirect:/access-denied";

        try {
            Long doctorId = getCurrentDoctorId(session);
            Prescription prescription = prescriptionService.getPrescriptionById(prescriptionId);

            // Check if prescription exists and belongs to the current doctor
            if (prescription == null) {
                redirectAttributes.addFlashAttribute("error", "Prescription not found");
                return "redirect:/doctor/patient/" + prescription.getPatient().getId();
            }

            if (!prescription.getDoctor().getId().equals(doctorId)) {
                redirectAttributes.addFlashAttribute("error", "You can only delete prescriptions you created");
                return "redirect:/doctor/patient/" + prescription.getPatient().getId();
            }

            Long patientId = prescription.getPatient().getId();
            prescriptionService.deletePrescription(prescriptionId);
            redirectAttributes.addFlashAttribute("success", "Prescription deleted successfully");

            return "redirect:/doctor/patient/" + patientId;

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete prescription: " + e.getMessage());
            return "redirect:/doctor/patients";
        }
    }
}