package com.hms.hospitalmanagementsystem.controller;

import com.hms.hospitalmanagementsystem.entity.*;
import com.hms.hospitalmanagementsystem.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/patient")
public class PatientController {

    @Autowired
    private PatientService patientService;

    @Autowired
    private AppointmentService appointmentService;

    @Autowired
    private AdmissionService admissionService;

    @Autowired
    private PrescriptionService prescriptionService;

    @Autowired
    private LabTestService labTestService;

    @Autowired
    private UserService userService;

    @Autowired
    private DoctorService doctorService;

    @Autowired
    private PaymentService paymentService;

    // Helper method to get current patient ID from logged-in user
    private Long getCurrentPatientId(HttpSession session) {
        String username = (String) session.getAttribute("username");
        if (username == null) {
            System.out.println("DEBUG: No username in session");
            return null;
        }

        System.out.println("DEBUG: Username from session: " + username);

        // Find user by username
        User user = userService.findByUsername(username).orElse(null);
        if (user != null) {
            System.out.println("DEBUG: User found - Role: " + user.getRole() + ", ProfileId: " + user.getProfileId());
            if ("PATIENT".equals(user.getRole())) {
                return user.getProfileId(); // This links to patient ID
            }
        } else {
            System.out.println("DEBUG: User not found in database");
        }
        return null;
    }

    // Helper method to get current patient object
    private Patient getCurrentPatient(HttpSession session) {
        Long patientId = getCurrentPatientId(session);
        if (patientId != null) {
            return patientService.getPatientById(patientId);
        }
        return null;
    }

    @GetMapping("/dashboard")
    public String patientDashboard(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null) {
            return "redirect:/login";
        }

        if (!"PATIENT".equals(role)) {
            model.addAttribute("error", "Access denied. Patient privileges required.");
            return "redirect:/dashboard";
        }

        // Get the actual patient for logged-in user
        Patient patient = getCurrentPatient(session);
        if (patient == null) {
            model.addAttribute("error", "Patient profile not found.");
            return "redirect:/login";
        }

        Long patientId = patient.getId();

        // Get prescription data for this specific patient
        Long activePrescriptions = prescriptionService.getActivePrescriptionCountByPatient(patientId);
        List<Prescription> recentPrescriptions = prescriptionService.getActivePrescriptionsByPatient(patientId);

        // Get other data for this specific patient
        int upcomingAppointments = appointmentService.getAppointmentsByPatientId(patientId).size();
        int labTestsCount = labTestService.getTestsByPatient(patientId).size();
        int pendingLabResults = labTestService.getPendingTestsByPatient(patientId).size();
        int admissionsCount = admissionService.getAdmissionsByPatientId(patientId).size();

        model.addAttribute("username", username);
        model.addAttribute("role", role);
        model.addAttribute("patient", patient);
        model.addAttribute("upcomingAppointments", upcomingAppointments);
        model.addAttribute("labTestsCount", labTestsCount);
        model.addAttribute("pendingLabResults", pendingLabResults);
        model.addAttribute("activePrescriptions", activePrescriptions);
        model.addAttribute("recentPrescriptions", recentPrescriptions);
        model.addAttribute("admissionsCount", admissionsCount);
        model.addAttribute("currentAdmissionStatus", "No current admission");

        return "patient/dashboard";
    }

    @GetMapping("/profile")
    public String patientProfile(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"PATIENT".equals(role)) {
            return "redirect:/access-denied";
        }

        // Get the actual patient for logged-in user
        Patient patient = getCurrentPatient(session);
        if (patient == null) {
            return "redirect:/login";
        }

        model.addAttribute("patient", patient);
        model.addAttribute("pageTitle", "My Profile");

        return "patient/profile";
    }

    @PostMapping("/profile/update")
    public String updateProfile(@ModelAttribute Patient patient, HttpSession session) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"PATIENT".equals(role)) {
            return "redirect:/access-denied";
        }

        // Get current patient to preserve the ID and merge with existing data
        Patient currentPatient = getCurrentPatient(session);
        if (currentPatient != null) {
            // Update the current patient with new data
            currentPatient.setFirstName(patient.getFirstName());
            currentPatient.setLastName(patient.getLastName());
            currentPatient.setDateOfBirth(patient.getDateOfBirth());
            currentPatient.setGender(patient.getGender());
            currentPatient.setContactNumber(patient.getContactNumber());
            currentPatient.setAddress(patient.getAddress());
            currentPatient.setEmail(patient.getEmail());

            // Update new fields
            currentPatient.setEmergencyContactName(patient.getEmergencyContactName());
            currentPatient.setEmergencyContactRelationship(patient.getEmergencyContactRelationship());
            currentPatient.setEmergencyContactPhone(patient.getEmergencyContactPhone());
            currentPatient.setBloodType(patient.getBloodType());
            currentPatient.setAllergies(patient.getAllergies());

            patientService.savePatient(currentPatient);
            return "redirect:/patient/profile?success=true";
        }

        return "redirect:/patient/profile?error=Patient not found";
    }

    @GetMapping("/medical-records")
    public String medicalRecords(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"PATIENT".equals(role)) {
            return "redirect:/access-denied";
        }

        // Get the actual patient for logged-in user
        Long patientId = getCurrentPatientId(session);
        if (patientId == null) {
            return "redirect:/login";
        }

        Patient patient = getCurrentPatient(session);

        // Debug logging
        System.out.println("DEBUG: Loading medical records for patient ID: " + patientId);

        // Get all medical data for this patient from database
        List<Appointment> appointments = appointmentService.getAppointmentsByPatientId(patientId);
        List<Prescription> prescriptions = prescriptionService.getPrescriptionsByPatient(patientId);
        List<LabTest> labTests = labTestService.getTestsByPatient(patientId);
        List<Admission> admissions = admissionService.getAdmissionsByPatientId(patientId);

        // Debug logging to check data
        System.out.println("DEBUG: Appointments found: " + appointments.size());
        System.out.println("DEBUG: Prescriptions found: " + prescriptions.size());
        System.out.println("DEBUG: Lab tests found: " + labTests.size());
        System.out.println("DEBUG: Admissions found: " + admissions.size());

        // Calculate statistics
        long totalVisits = appointments.size();
        long activeMedications = prescriptions.stream()
                .filter(p -> "ACTIVE".equals(p.getStatus()))
                .count();
        long completedLabTests = labTests.stream()
                .filter(test -> "COMPLETED".equals(test.getStatus()))
                .count();

        // Get last appointment
        Appointment lastAppointment = appointments.stream()
                .max((a1, a2) -> a1.getAppointmentDateTime().compareTo(a2.getAppointmentDateTime()))
                .orElse(null);

        String lastCheckup = "Never";
        if (lastAppointment != null) {
            java.time.LocalDate lastDate = lastAppointment.getAppointmentDateTime().toLocalDate();
            java.time.Period period = java.time.Period.between(lastDate, java.time.LocalDate.now());
            if (period.getDays() == 0) {
                lastCheckup = "Today";
            } else if (period.getDays() == 1) {
                lastCheckup = "Yesterday";
            } else {
                lastCheckup = period.getDays() + " days ago";
            }
        }

        // Add all attributes to model
        model.addAttribute("patient", patient);
        model.addAttribute("appointments", appointments != null ? appointments : new ArrayList<>());
        model.addAttribute("prescriptions", prescriptions != null ? prescriptions : new ArrayList<>());
        model.addAttribute("labTests", labTests != null ? labTests : new ArrayList<>());
        model.addAttribute("admissions", admissions != null ? admissions : new ArrayList<>());
        model.addAttribute("totalVisits", totalVisits);
        model.addAttribute("activeMedications", activeMedications);
        model.addAttribute("completedLabTests", completedLabTests);
        model.addAttribute("lastCheckup", lastCheckup);
        model.addAttribute("pageTitle", "Medical Records");

        return "patient/medical-records";
    }

    @GetMapping("/admissions")
    public String patientAdmissions(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"PATIENT".equals(role)) {
            return "redirect:/access-denied";
        }

        // Get the actual patient for logged-in user
        Long patientId = getCurrentPatientId(session);
        if (patientId == null) {
            return "redirect:/login";
        }

        // Get patient object and add to model
        Patient patient = getCurrentPatient(session);
        if (patient == null) {
            return "redirect:/login";
        }

        System.out.println("DEBUG: Patient found - ID: " + patient.getId() + ", Name: " + patient.getFirstName() + " " + patient.getLastName());

        model.addAttribute("patient", patient);
        model.addAttribute("admissions", admissionService.getAdmissionsByPatientId(patientId));
        model.addAttribute("pageTitle", "My Admissions");
        return "patient/admissions";
    }

    @GetMapping("/prescriptions")
    public String patientPrescriptions(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"PATIENT".equals(role)) {
            return "redirect:/access-denied";
        }

        // Get prescriptions for the actual logged-in patient
        Long patientId = getCurrentPatientId(session);
        if (patientId == null) {
            return "redirect:/login";
        }

        model.addAttribute("prescriptions", prescriptionService.getPrescriptionsByPatient(patientId));
        model.addAttribute("pageTitle", "My Prescriptions");
        return "patient/prescriptions";
    }

    @GetMapping("/lab-tests")
    public String patientLabTests(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"PATIENT".equals(role)) {
            return "redirect:/access-denied";
        }

        // Get the actual patient for logged-in user
        Long patientId = getCurrentPatientId(session);
        if (patientId == null) {
            return "redirect:/login";
        }

        Patient patient = getCurrentPatient(session);
        List<LabTest> labTests = labTestService.getTestsByPatient(patientId);

        // Calculate statistics
        long totalTests = labTests.size();
        long completedTests = labTests.stream().filter(test -> "COMPLETED".equals(test.getStatus())).count();
        long pendingTests = labTests.stream().filter(test -> "PENDING".equals(test.getStatus()) || "REQUESTED".equals(test.getStatus())).count();
        long recentTests = labTests.stream()
                .filter(test -> test.getRequestedDate().isAfter(java.time.LocalDateTime.now().minusMonths(1)))
                .count();

        model.addAttribute("patient", patient);
        model.addAttribute("labTests", labTests);
        model.addAttribute("totalTests", totalTests);
        model.addAttribute("completedTests", completedTests);
        model.addAttribute("pendingTests", pendingTests);
        model.addAttribute("recentTests", recentTests);
        model.addAttribute("pageTitle", "My Lab Results");

        return "patient/lab-tests";
    }
    @GetMapping("/admissions/details/{admissionId}")
    public String viewAdmissionDetails(@PathVariable Long admissionId, HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"PATIENT".equals(role)) {
            return "redirect:/access-denied";
        }

        // Get the current patient
        Patient patient = getCurrentPatient(session);
        if (patient == null) {
            return "redirect:/login";
        }

        try {
            System.out.println("=== DEBUG: Loading admission details for ID: " + admissionId + " ===");

            // Get admission details
            Admission admission = admissionService.getAdmissionById(admissionId);
            System.out.println("Admission object: " + admission);

            if (admission != null) {
                System.out.println("Admission patient ID: " + admission.getPatient().getId());
                System.out.println("Current patient ID: " + patient.getId());
                System.out.println("Admission ward: " + admission.getWard());
                System.out.println("Admission bed: " + admission.getBed());
                System.out.println("Admission doctor: " + admission.getAdmittingDoctor());
            }

            // Verify the admission belongs to the current patient
            if (admission == null || !admission.getPatient().getId().equals(patient.getId())) {
                System.out.println("ERROR: Admission not found or access denied");
                model.addAttribute("error", "Admission not found or access denied");
                return "redirect:/patient/admissions";
            }

            model.addAttribute("patient", patient);
            model.addAttribute("admission", admission);
            model.addAttribute("pageTitle", "Admission Details");

            return "patient/admission-details";

        } catch (Exception e) {
            System.out.println("ERROR in admission details: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Error loading admission details: " + e.getMessage());
            return "redirect:/patient/admissions";
        }
    }
    @GetMapping("/lab-tests/{testId}")
    public String viewTestDetails(@PathVariable Long testId, HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"PATIENT".equals(role)) {
            return "redirect:/access-denied";
        }

        // Get the current patient
        Patient patient = getCurrentPatient(session);
        if (patient == null) {
            return "redirect:/login";
        }

        try {
            System.out.println("=== DEBUG: Loading test details for ID: " + testId + " ===");

            // Get test details
            LabTest labTest = labTestService.getTestById(testId);
            System.out.println("LabTest object: " + labTest);

            if (labTest != null) {
                System.out.println("LabTest patient ID: " + labTest.getPatient().getId());
                System.out.println("Current patient ID: " + patient.getId());
            }

            // Verify the test belongs to the current patient
            if (labTest == null || !labTest.getPatient().getId().equals(patient.getId())) {
                System.out.println("ERROR: Test not found or access denied");
                model.addAttribute("error", "Test not found or access denied");
                return "redirect:/patient/lab-tests";
            }

            model.addAttribute("patient", patient);
            model.addAttribute("labTest", labTest);
            model.addAttribute("username", username);
            model.addAttribute("role", role);
            model.addAttribute("pageTitle", "Test Details");

            // Return the correct view name - adjust this based on where your test-details.jsp is located
            return "lab-tests/test-details"; // If it's in the root of templates folder
            // OR return "patient/test-details"; // If it's in patient subfolder

        } catch (Exception e) {
            System.out.println("ERROR in test details: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Error loading test details: " + e.getMessage());
            return "redirect:/patient/lab-tests";
        }
    }
}