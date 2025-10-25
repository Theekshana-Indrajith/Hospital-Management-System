package com.hms.hospitalmanagementsystem.controller;

import com.hms.hospitalmanagementsystem.entity.*;
import com.hms.hospitalmanagementsystem.repository.BedRepository;
import com.hms.hospitalmanagementsystem.repository.DoctorRepository;
import com.hms.hospitalmanagementsystem.repository.UserRepository;
import com.hms.hospitalmanagementsystem.repository.WardRepository;
import com.hms.hospitalmanagementsystem.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/doctor")
public class DoctorController {

    @Autowired
    private AppointmentService appointmentService;

    @Autowired
    private PatientService patientService;

    @Autowired
    private AdmissionService admissionService;

    @Autowired
    private PrescriptionService prescriptionService;

    @Autowired
    private LabTestService labTestService;

    @Autowired
    private WardService wardService;

    @Autowired
    private BedService bedService;

    @Autowired
    private DoctorRepository doctorRepository;

    @Autowired
    private BedRepository bedRepository;

    @Autowired
    private WardRepository wardRepository;

    @Autowired
    private DoctorService doctorService;

    @Autowired
    private UserRepository userRepository;

// In DoctorController.java - REPLACE these methods:

    private Long getCurrentDoctorId(HttpSession session) {
        String username = (String) session.getAttribute("username");
        if (username == null) return null;

        // Clear any cached ID first to force fresh lookup
        session.removeAttribute("doctorId");

        System.out.println("=== FINDING DOCTOR ID FOR: " + username + " ===");

        // METHOD 1: Direct database link via User table
        try {
            Optional<Doctor> doctorOpt = doctorRepository.findByUsername(username);
            if (doctorOpt.isPresent()) {
                Long doctorId = doctorOpt.get().getId();
                session.setAttribute("doctorId", doctorId);
                System.out.println("SUCCESS: Found via direct link - Doctor ID: " + doctorId + ", Name: " + doctorOpt.get().getName());
                return doctorId;
            }
        } catch (Exception e) {
            System.out.println("Direct link query failed: " + e.getMessage());
        }

        // METHOD 2: Find user and get profileId
        try {
            Optional<User> userOpt = userRepository.findByUsername(username);
            if (userOpt.isPresent()) {
                User user = userOpt.get();
                System.out.println("Found user - Role: " + user.getRole() + ", ProfileID: " + user.getProfileId());

                if ("DOCTOR".equals(user.getRole()) && user.getProfileId() != null && user.getProfileId() > 0) {
                    // Verify the doctor exists
                    Optional<Doctor> doctorOpt = doctorRepository.findById(user.getProfileId());
                    if (doctorOpt.isPresent()) {
                        Long doctorId = doctorOpt.get().getId();
                        session.setAttribute("doctorId", doctorId);
                        System.out.println("SUCCESS: Found via user profileId - Doctor ID: " + doctorId + ", Name: " + doctorOpt.get().getName());
                        return doctorId;
                    } else {
                        System.out.println("ERROR: User profileId " + user.getProfileId() + " but no doctor found with that ID");
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("User lookup failed: " + e.getMessage());
        }

        System.out.println("ERROR: Could not find doctor ID for username: " + username);
        return null;
    }

    private Long getDoctorIdFromUsername(String username) {
        try {
            System.out.println("DEBUG: Looking up doctor ID for username: " + username);

            // Method 1: Direct username link via User table
            Optional<Doctor> doctorOpt = doctorRepository.findByUsername(username);
            if (doctorOpt.isPresent()) {
                Doctor doctor = doctorOpt.get();
                System.out.println("DEBUG: Found doctor via username link: " + doctor.getName() + " (ID: " + doctor.getId() + ")");
                return doctor.getId();
            }

            System.out.println("DEBUG: No direct username link found, trying alternative methods...");

            // Method 2: Try to find by email match
            List<Doctor> allDoctors = doctorRepository.findAll();
            for (Doctor doctor : allDoctors) {
                if (doctor.getEmail() != null && doctor.getEmail().equalsIgnoreCase(username)) {
                    System.out.println("DEBUG: Found doctor via email match: " + doctor.getName() + " (ID: " + doctor.getId() + ")");
                    return doctor.getId();
                }
            }

            // Method 3: Try name contains (for testing)
            for (Doctor doctor : allDoctors) {
                if (doctor.getName() != null && doctor.getName().toLowerCase().contains(username.toLowerCase())) {
                    System.out.println("DEBUG: Found doctor via name match: " + doctor.getName() + " (ID: " + doctor.getId() + ")");
                    return doctor.getId();
                }
            }

            // Method 4: Fallback to first doctor (remove this in production)
            if (!allDoctors.isEmpty()) {
                Doctor fallbackDoctor = allDoctors.get(0);
                System.out.println("WARNING: Using fallback doctor: " + fallbackDoctor.getName() + " (ID: " + fallbackDoctor.getId() + ")");
                return fallbackDoctor.getId();
            }

            return null;

        } catch (Exception e) {
            System.err.println("ERROR in getDoctorIdFromUsername: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    private String getDoctorName(Long doctorId) {
        try {
            Doctor doctor = doctorRepository.findById(doctorId).orElse(null);
            return doctor != null ? doctor.getName() : "Doctor";
        } catch (Exception e) {
            return "Doctor";
        }
    }
    @GetMapping("/lab-tests/{testId}")
    public String viewLabTestDetails(@PathVariable Long testId, HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"DOCTOR".equals(role)) {
            return "redirect:/access-denied";
        }

        try {
            LabTest labTest = labTestService.getLabTestById(testId);
            if (labTest == null) {
                model.addAttribute("error", "Lab test not found");
                return "redirect:/doctor/patients";
            }

            // Verify the test belongs to a patient that this doctor can access
            // You might want to add additional security checks here

            model.addAttribute("labTest", labTest);
            model.addAttribute("username", username);
            model.addAttribute("role", role);
            model.addAttribute("pageTitle", "Lab Test Details - " + labTest.getTestName());

            return "lab-tests/test-details";

        } catch (Exception e) {
            model.addAttribute("error", "Error loading lab test details: " + e.getMessage());
            return "redirect:/doctor/patients";
        }
    }

    @GetMapping("/profile")
    public String viewMyProfile(HttpSession session, Model model) {
        System.out.println("=== ACCESSING DOCTOR PROFILE ===");

        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        System.out.println("Username: " + username);
        System.out.println("Role: " + role);

        if (username == null || !"DOCTOR".equals(role)) {
            System.out.println("Access denied - redirecting to login");
            return "redirect:/access-denied";
        }

        try {
            Long doctorId = getCurrentDoctorId(session);
            System.out.println("Doctor ID: " + doctorId);

            if (doctorId == null) {
                return "redirect:/login?error=Doctor profile not found";
            }

            Doctor doctor = doctorRepository.findById(doctorId).orElse(null);
            if (doctor == null) {
                return "redirect:/login?error=Doctor profile not found";
            }

            model.addAttribute("doctor", doctor);
            model.addAttribute("username", username);
            model.addAttribute("pageTitle", "My Profile");

            System.out.println("Returning doctor/profile view");
            return "doctor/profile";

        } catch (Exception e) {
            System.out.println("Error in profile: " + e.getMessage());
            e.printStackTrace();
            return "redirect:/doctor/dashboard?error=Error loading profile: " + e.getMessage();
        }
    }

    @GetMapping("/profile/edit")
    public String editProfileForm(HttpSession session, Model model) {
        System.out.println("=== ACCESSING DOCTOR EDIT PROFILE ===");

        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"DOCTOR".equals(role)) {
            return "redirect:/access-denied";
        }

        try {
            Long doctorId = getCurrentDoctorId(session);
            if (doctorId == null) {
                return "redirect:/login?error=Doctor profile not found";
            }

            Doctor doctor = doctorRepository.findById(doctorId).orElse(null);
            if (doctor == null) {
                return "redirect:/login?error=Doctor profile not found";
            }

            model.addAttribute("doctor", doctor);
            model.addAttribute("username", username);
            model.addAttribute("pageTitle", "Edit My Profile");

            return "doctor/edit-profile";

        } catch (Exception e) {
            return "redirect:/doctor/profile?error=Error loading edit form: " + e.getMessage();
        }
    }

    @PostMapping("/profile/update")
    public String updateProfile(@RequestParam String name,
                                @RequestParam String specialization,
                                @RequestParam(required = false) String contactNumber,
                                @RequestParam String email,
                                @RequestParam(required = false) String roomNumber,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        System.out.println("=== UPDATING DOCTOR PROFILE ===");

        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"DOCTOR".equals(role)) {
            return "redirect:/access-denied";
        }

        try {
            Long doctorId = getCurrentDoctorId(session);
            if (doctorId == null) {
                redirectAttributes.addFlashAttribute("error", "Doctor profile not found");
                return "redirect:/login";
            }

            Doctor doctor = doctorRepository.findById(doctorId).orElse(null);
            if (doctor == null) {
                redirectAttributes.addFlashAttribute("error", "Doctor profile not found");
                return "redirect:/login";
            }

            // Validate required fields
            if (name == null || name.trim().isEmpty() ||
                    specialization == null || specialization.trim().isEmpty() ||
                    email == null || email.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Name, Specialization, and Email are required fields");
                return "redirect:/doctor/profile/edit";
            }

            // Basic email validation
            if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
                redirectAttributes.addFlashAttribute("error", "Please enter a valid email address");
                return "redirect:/doctor/profile/edit";
            }

            // Update doctor fields
            doctor.setName(name.trim());
            doctor.setSpecialization(specialization.trim());
            doctor.setEmail(email.trim());

            // Handle optional fields
            if (contactNumber != null && !contactNumber.trim().isEmpty()) {
                doctor.setContactNumber(contactNumber.trim());
            } else {
                doctor.setContactNumber(null);
            }

            if (roomNumber != null && !roomNumber.trim().isEmpty()) {
                doctor.setRoomNumber(roomNumber.trim());
            } else {
                doctor.setRoomNumber(null);
            }

            // Save the updated doctor
            doctorRepository.save(doctor);

            System.out.println("Profile updated successfully for doctor ID: " + doctorId);
            System.out.println("Updated details - Name: " + name + ", Email: " + email + ", Specialization: " + specialization);

            redirectAttributes.addFlashAttribute("success", "Profile updated successfully");
            return "redirect:/doctor/profile";

        } catch (Exception e) {
            System.out.println("Error updating profile: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Failed to update profile: " + e.getMessage());
            return "redirect:/doctor/profile/edit";
        }
    }

    // Test endpoint
    @GetMapping("/test")
    public String testJsp() {
        System.out.println("=== TEST JSP ENDPOINT ===");
        return "doctor/test";
    }

    @GetMapping("/profile/debug")
    @ResponseBody
    public String debugProfile(HttpSession session) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        return "Debug Profile Endpoint - Username: " + username + ", Role: " + role +
                ", Profile mapping is working! Controller is responding.";
    }



    @GetMapping("/admissions/discharge/{admissionId}")
    public String dischargePatient(@PathVariable Long admissionId, HttpSession session) {
        try {
            String username = (String) session.getAttribute("username");
            if (username == null) {
                return "redirect:/login";
            }

            admissionService.dischargePatient(admissionId);
            return "redirect:/doctor/admissions/manage?success=Patient discharged successfully";
        } catch (Exception e) {
            return "redirect:/doctor/admissions/manage?error=" + e.getMessage();
        }
    }


    @GetMapping("/dashboard")
    public String doctorDashboard(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"DOCTOR".equals(role)) {
            return "redirect:/login";
        }

        Long doctorId = getCurrentDoctorId(session);
        if (doctorId == null) {
            model.addAttribute("error", "Doctor profile not found for user: " + username);
            return "redirect:/login?error=Doctor profile not found";
        }

        // Get admission statistics for this specific doctor
        Map<String, Long> admissionStats = admissionService.getAdmissionStatisticsByDoctor(doctorId);
        List<Admission> currentAdmissions = admissionService.getCurrentAdmissionsByDoctor(doctorId);

        // Get other data specific to this doctor
        List<Prescription> recentPrescriptions = prescriptionService.getActivePrescriptionsByDoctor(doctorId);
        int todayAppointments = appointmentService.getAppointmentsByDoctorId(doctorId).size();

        // TEMPORARY FIX: Use existing methods without doctor filtering
        int pendingTests = labTestService.getPendingTests().size();
        int urgentCases = labTestService.getAbnormalResults().size();

        // Get current doctor details for display
        Doctor currentDoctor = doctorRepository.findById(doctorId).orElse(null);

        // ADD THIS LINE - Get today's appointments list
        List<Appointment> todaysAppointments = appointmentService.getTodaysAppointmentsByDoctor(doctorId);

        model.addAttribute("username", username);
        model.addAttribute("role", role);
        model.addAttribute("doctor", currentDoctor);
        model.addAttribute("todayAppointments", todayAppointments);
        model.addAttribute("currentPatients", admissionStats.get("currentAdmissions"));
        model.addAttribute("pendingTests", pendingTests);
        model.addAttribute("urgentCases", urgentCases);
        model.addAttribute("activePrescriptionsCount", recentPrescriptions.size());
        model.addAttribute("recentPrescriptions", recentPrescriptions);
        model.addAttribute("admissionStats", admissionStats);
        model.addAttribute("currentAdmissions", currentAdmissions);
        model.addAttribute("timeOfDay", getTimeOfDayGreeting());
        model.addAttribute("dashboardType", "Doctor");

        // ADD THIS LINE - Pass today's appointments to JSP
        model.addAttribute("todaysAppointments", todaysAppointments);

        return "doctor/dashboard";
    }

    // New admission management endpoints
    @GetMapping("/admissions/manage")
    public String manageAdmissions(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"DOCTOR".equals(role)) {
            return "redirect:/access-denied";
        }

        Long doctorId = getCurrentDoctorId(session);
        if (doctorId == null) {
            return "redirect:/login?error=Doctor profile not found";
        }

        List<Admission> admissions = admissionService.getCurrentAdmissionsByDoctor(doctorId);
        Map<String, Long> stats = admissionService.getAdmissionStatisticsByDoctor(doctorId);

        model.addAttribute("admissions", admissions);
        model.addAttribute("admissionStats", stats);
        model.addAttribute("pageTitle", "Manage Admissions");
        model.addAttribute("doctorId", doctorId); // Add this for templates

        return "doctor/manage-admissions";
    }

    // Update the showAdmitForm method in DoctorController.java
    @GetMapping("/admissions/admit")
    public String showAdmitForm(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"DOCTOR".equals(role)) {
            return "redirect:/access-denied";
        }

        try {
            // Get all patients (simplified approach)
            List<Patient> patients = patientService.getAllPatients();
            List<Ward> availableWards = wardService.getAvailableWards();

            model.addAttribute("patients", patients != null ? patients : new ArrayList<>());
            model.addAttribute("wards", availableWards != null ? availableWards : new ArrayList<>());
            model.addAttribute("pageTitle", "Admit Patient");
            model.addAttribute("username", username);

            return "doctor/admit-patient";

        } catch (Exception e) {
            model.addAttribute("error", "Error loading admission form: " + e.getMessage());
            return "redirect:/doctor/admissions/manage";
        }
    }

    @PostMapping("/admissions/admit")
    public String admitPatient(@RequestParam Long patientId,
                               @RequestParam Long wardId,
                               @RequestParam String reason,
                               @RequestParam String diagnosis,
                               @RequestParam String severityLevel,
                               HttpSession session) {
        try {
            String username = (String) session.getAttribute("username");
            if (username == null) {
                return "redirect:/login";
            }

            // Use the current logged-in doctor's ID
            Long doctorId = getCurrentDoctorId(session);
            if (doctorId == null) {
                return "redirect:/doctor/admissions/admit?error=Doctor profile not found";
            }

            // Rest of the method remains the same...
            Optional<Ward> wardOpt = wardRepository.findById(wardId);
            if (!wardOpt.isPresent()) {
                return "redirect:/doctor/admissions/admit?error=Ward not found";
            }
            Ward ward = wardOpt.get();

            if (ward.getAvailableBeds() <= 0) {
                return "redirect:/doctor/admissions/admit?error=No available beds in selected ward";
            }

            Bed bed = findOrCreateAvailableBed(ward);
            if (bed == null) {
                return "redirect:/doctor/admissions/admit?error=Could not assign a bed. Please try again.";
            }

            Admission admission = admissionService.admitPatientByDoctor(
                    patientId, wardId, bed.getId(), reason, doctorId, diagnosis, severityLevel);

            if (admission != null) {
                return "redirect:/doctor/admissions/manage?success=Patient admitted successfully to " + ward.getWardNumber();
            } else {
                return "redirect:/doctor/admissions/admit?error=Failed to admit patient";
            }

        } catch (Exception e) {
            e.printStackTrace();
            // FIX: Use a generic error message instead of the full exception message
            String errorMessage = "Admission failed due to system error";
            if (e.getMessage().contains("Duplicate entry")) {
                errorMessage = "Bed is already occupied. Please select another bed.";
            } else if (e.getMessage().contains("constraint")) {
                errorMessage = "Database constraint violation. Please try again.";
            }
            return "redirect:/doctor/admissions/admit?error=" + encodeURL(errorMessage);
        }
    }

    // Helper method to URL encode the error message
    private String encodeURL(String message) {
        try {
            return java.net.URLEncoder.encode(message, "UTF-8");
        } catch (Exception e) {
            return "System error occurred";
        }
    }

    // Helper method to find or create a bed
    private Bed findOrCreateAvailableBed(Ward ward) {
        try {
            // First, try to find an available bed in this ward
            List<Bed> availableBeds = bedRepository.findByWardIdAndStatus(ward.getId(), "AVAILABLE");
            if (!availableBeds.isEmpty()) {
                return availableBeds.get(0); // Return first available bed
            }

            // If no available beds, create a new one
            Bed newBed = new Bed();
            newBed.setBedNumber("BED-" + ward.getWardNumber() + "-" + (System.currentTimeMillis() % 1000));
            newBed.setStatus("AVAILABLE");
            newBed.setWard(ward);
            return bedRepository.save(newBed);

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }


    @GetMapping("/admissions/transfer/{admissionId}")
    public String showTransferForm(@PathVariable Long admissionId, HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"DOCTOR".equals(role)) {
            return "redirect:/access-denied";
        }

        Admission admission = admissionService.getAdmissionById(admissionId);
        List<Ward> availableWards = wardService.getAvailableWards();

        model.addAttribute("admission", admission);
        model.addAttribute("wards", availableWards);
        model.addAttribute("pageTitle", "Transfer Patient");

        return "doctor/transfer-patient";
    }

    @PostMapping("/admissions/transfer/{admissionId}")
    public String transferPatient(@PathVariable Long admissionId,
                                  @RequestParam Long newWardId,
                                  @RequestParam Long newBedId,
                                  HttpSession session) {
        try {
            String username = (String) session.getAttribute("username");
            if (username == null) {
                return "redirect:/login";
            }

            admissionService.transferPatient(admissionId, newWardId, newBedId);
            return "redirect:/doctor/admissions/manage?success=Patient transferred successfully";
        } catch (Exception e) {
            return "redirect:/doctor/admissions/transfer/" + admissionId + "?error=" + e.getMessage();
        }
    }


    private String getTimeOfDayGreeting() {
        int hour = java.time.LocalTime.now().getHour();
        if (hour < 12) return "Morning";
        else if (hour < 17) return "Afternoon";
        else return "Evening";
    }

    @GetMapping("/schedule")
    public String doctorSchedule(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        System.out.println("=== SCHEDULE ACCESS ===");
        System.out.println("Username: " + username);
        System.out.println("Role: " + role);

        if (username == null || !"DOCTOR".equals(role)) {
            return "redirect:/access-denied";
        }

        // Get the current doctor's ID
        Long doctorId = getCurrentDoctorId(session);
        if (doctorId == null) {
            System.out.println("ERROR: Could not find doctor ID for: " + username);
            return "redirect:/login?error=Doctor profile not found";
        }

        System.out.println("Current Doctor ID: " + doctorId);

        // Get appointments ONLY for this specific doctor
        List<Appointment> allAppointments = appointmentService.getAllAppointments();
        List<Appointment> myAppointments = new ArrayList<>();

        List<Appointment> pendingAppointments = appointmentService.getPendingDoctorAppointments(doctorId);
        model.addAttribute("pendingCount", pendingAppointments.size());

        // Manual filtering to ensure only this doctor's appointments
        for (Appointment appointment : allAppointments) {
            if (appointment.getDoctor() != null && appointment.getDoctor().getId().equals(doctorId)) {
                myAppointments.add(appointment);
            }
        }

        System.out.println("Total appointments in system: " + allAppointments.size());
        System.out.println("My appointments: " + myAppointments.size());

        // Debug: Print each appointment to verify
        for (Appointment app : myAppointments) {
            System.out.println("My Appointment: " + app.getId() +
                    " - Patient: " + app.getPatient().getFirstName() +
                    " - Doctor: " + app.getDoctor().getName() +
                    " (ID: " + app.getDoctor().getId() + ")");
        }

        // Get current doctor details
        Doctor currentDoctor = doctorRepository.findById(doctorId).orElse(null);
        if (currentDoctor == null) {
            System.out.println("ERROR: Current doctor not found with ID: " + doctorId);
            return "redirect:/login?error=Doctor not found";
        }

        System.out.println("Displaying schedule for: Dr. " + currentDoctor.getName());

        model.addAttribute("appointments", myAppointments);
        model.addAttribute("doctorName", currentDoctor.getName());
        model.addAttribute("doctorSpecialization", currentDoctor.getSpecialization());
        model.addAttribute("pageTitle", "My Schedule");

        return "doctor/schedule";
    }

    @GetMapping("/patients")
    public String doctorPatients(HttpSession session, Model model,
                                 @RequestParam(required = false) String search) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"DOCTOR".equals(role)) {
            return "redirect:/access-denied";
        }

        // Get all patients from database
        List<Patient> patients = patientService.getAllPatients();

        // Apply search filter if search parameter is provided
        if (search != null && !search.trim().isEmpty()) {
            String searchTerm = search.toLowerCase().trim();
            patients = patients.stream()
                    .filter(patient ->
                            (patient.getFirstName() != null && patient.getFirstName().toLowerCase().contains(searchTerm)) ||
                                    (patient.getLastName() != null && patient.getLastName().toLowerCase().contains(searchTerm)) ||
                                    (patient.getFirstName() + " " + patient.getLastName()).toLowerCase().contains(searchTerm))
                    .collect(Collectors.toList());
        }

        // Create maps for patient data
        Map<Long, Appointment> patientAppointmentMap = new HashMap<>();
        Map<Long, Admission> patientAdmissionMap = new HashMap<>();

        // Populate maps with latest data for each patient
        for (Patient patient : patients) {
            List<Appointment> patientAppointments = appointmentService.getAppointmentsByPatientId(patient.getId());
            if (!patientAppointments.isEmpty()) {
                // Get the most recent appointment
                patientAppointments.sort((a1, a2) -> a2.getAppointmentDateTime().compareTo(a1.getAppointmentDateTime()));
                patientAppointmentMap.put(patient.getId(), patientAppointments.get(0));
            }

            List<Admission> patientAdmissions = admissionService.getAdmissionsByPatientId(patient.getId());
            // Check for active admissions
            Admission activeAdmission = patientAdmissions.stream()
                    .filter(admission -> "ADMITTED".equals(admission.getStatus()))
                    .findFirst()
                    .orElse(null);
            if (activeAdmission != null) {
                patientAdmissionMap.put(patient.getId(), activeAdmission);
            }
        }

        // Add current month for statistics
        int currentMonth = java.time.LocalDate.now().getMonthValue();

        model.addAttribute("patients", patients);
        model.addAttribute("patientAppointmentMap", patientAppointmentMap);
        model.addAttribute("patientAdmissionMap", patientAdmissionMap);
        model.addAttribute("currentMonth", currentMonth);
        model.addAttribute("pageTitle", "My Patients");

        return "doctor/patients";
    }
    @GetMapping("/appointments")
    public String doctorAppointments(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"DOCTOR".equals(role)) {
            return "redirect:/access-denied";
        }

        Long doctorId = getCurrentDoctorId(session);
        if (doctorId == null) {
            return "redirect:/login?error=Doctor profile not found";
        }

        model.addAttribute("appointments", appointmentService.getAppointmentsByDoctorId(doctorId));
        model.addAttribute("pageTitle", "My Appointments");
        model.addAttribute("doctorId", doctorId);
        return "doctor/appointments";
    }

    @GetMapping("/records")
    public String medicalRecords(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"DOCTOR".equals(role)) {
            return "redirect:/access-denied";
        }

        model.addAttribute("pageTitle", "Medical Records");
        return "doctor/records";
    }

    @GetMapping("/patient/{patientId}")
    public String viewPatientDetails(@PathVariable Long patientId, HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"DOCTOR".equals(role)) {
            return "redirect:/access-denied";
        }

        try {
            // Get patient and all related data from database
            Patient patient = patientService.getPatientById(patientId);
            if (patient == null) {
                model.addAttribute("error", "Patient not found");
                return "redirect:/doctor/patients";
            }

            List<Appointment> appointments = appointmentService.getAppointmentsByPatientId(patientId);
            List<Admission> admissions = admissionService.getAdmissionsByPatientId(patientId);
            List<Prescription> prescriptions = prescriptionService.getPrescriptionsByPatient(patientId);
            List<LabTest> labTests = labTestService.getTestsByPatient(patientId);

            // Sort appointments by date (most recent first)
            if (appointments != null) {
                appointments.sort((a1, a2) -> a2.getAppointmentDateTime().compareTo(a1.getAppointmentDateTime()));
            }

            // Sort admissions by date (most recent first)
            if (admissions != null) {
                admissions.sort((a1, a2) -> a2.getAdmissionDate().compareTo(a1.getAdmissionDate()));
            }

            // Sort prescriptions by date (most recent first)
            if (prescriptions != null) {
                prescriptions.sort((p1, p2) -> p2.getPrescriptionDate().compareTo(p1.getPrescriptionDate()));
            }

            // Sort lab tests by date (most recent first)
            if (labTests != null) {
                labTests.sort((t1, t2) -> t2.getRequestedDate().compareTo(t1.getRequestedDate()));
            }

            // Create medical info object
            Map<String, String> patientMedicalInfo = new HashMap<>();
            patientMedicalInfo.put("bloodType", "O+"); // This should come from database
            patientMedicalInfo.put("allergies", "Penicillin, Pollen");
            patientMedicalInfo.put("chronicConditions", "Hypertension");
            patientMedicalInfo.put("emergencyContact", "John Smith (077-1234567)");

            model.addAttribute("patient", patient);
            model.addAttribute("appointments", appointments != null ? appointments : new ArrayList<>());
            model.addAttribute("admissions", admissions != null ? admissions : new ArrayList<>());
            model.addAttribute("prescriptions", prescriptions != null ? prescriptions : new ArrayList<>());
            model.addAttribute("labTests", labTests != null ? labTests : new ArrayList<>());
            model.addAttribute("patientMedicalInfo", patientMedicalInfo);
            model.addAttribute("username", username);

            return "doctor/patient-details";

        } catch (Exception e) {
            model.addAttribute("error", "Error loading patient details: " + e.getMessage());
            return "redirect:/doctor/patients";
        }
    }

    @GetMapping("/admissions/available-beds/{wardId}")
    @ResponseBody
    public Map<String, Object> getAvailableBeds(@PathVariable Long wardId) {
        Map<String, Object> response = new HashMap<>();
        try {
            List<Bed> availableBeds = bedService.getAvailableBedsByWard(wardId);
            response.put("success", true);
            response.put("beds", availableBeds);
            response.put("count", availableBeds.size());
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", "Failed to load available beds");
            response.put("beds", new ArrayList<>());
            response.put("count", 0);
        }
        return response;
    }

    @GetMapping("/admissions")
    public String doctorAdmissions(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"DOCTOR".equals(role)) {
            return "redirect:/access-denied";
        }

        // Get current admissions data
        List<Admission> admissions = admissionService.getCurrentAdmissions();
        model.addAttribute("admissions", admissions);
        model.addAttribute("pageTitle", "Current Admissions");

        return "doctor/admissions";
    }
    // Add this method for debugging
    @GetMapping("/debug/patients")
    @ResponseBody
    public String debugPatients() {
        List<Patient> patients = patientService.getAllPatients();
        StringBuilder result = new StringBuilder();
        result.append("Total patients: ").append(patients.size()).append("\n");
        for (Patient patient : patients) {
            result.append("Patient ID: ").append(patient.getId())
                    .append(", Name: ").append(patient.getFirstName()).append(" ").append(patient.getLastName())
                    .append("\n");
        }
        return result.toString();
    }

    // Add to DoctorController - temporary debug endpoint
    @GetMapping("/admissions/debug-beds")
    @ResponseBody
    public String debugBeds() {
        StringBuilder result = new StringBuilder();
        result.append("=== ALL BEDS IN DATABASE ===\n");

        try {
            List<Bed> allBeds = bedRepository.findAll();
            if (allBeds.isEmpty()) {
                result.append("No beds found in database!\n");
            } else {
                for (Bed bed : allBeds) {
                    result.append(String.format("Bed ID: %d, Number: %s, Status: %s, Ward ID: %d\n",
                            bed.getId(), bed.getBedNumber(), bed.getStatus(),
                            bed.getWard() != null ? bed.getWard().getId() : -1));
                }
            }

            result.append("\n=== AVAILABLE BEDS ===\n");
            List<Bed> availableBeds = bedRepository.findByStatus("AVAILABLE");
            if (availableBeds.isEmpty()) {
                result.append("No available beds found!\n");
            } else {
                for (Bed bed : availableBeds) {
                    result.append(String.format("Bed ID: %d, Number: %s, Ward ID: %d\n",
                            bed.getId(), bed.getBedNumber(),
                            bed.getWard() != null ? bed.getWard().getId() : -1));
                }
            }

            return result.toString();
        } catch (Exception e) {
            return "Error: " + e.getMessage();
        }
    }

    @GetMapping("/admissions/all-available-beds")
    @ResponseBody
    public Map<String, Object> getAllAvailableBeds() {
        Map<String, Object> response = new HashMap<>();
        try {
            List<Bed> availableBeds = bedRepository.findByStatus("AVAILABLE");
            response.put("success", true);
            response.put("beds", availableBeds);
            response.put("count", availableBeds.size());
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", "Failed to load available beds");
            response.put("beds", new ArrayList<>());
            response.put("count", 0);
        }
        return response;
    }

//    @GetMapping("/debug/my-info")
//    @ResponseBody
//    public String debugDoctorInfo(HttpSession session) {
//        String username = (String) session.getAttribute("username");
//        String role = (String) session.getAttribute("role");
//
//        StringBuilder sb = new StringBuilder();
//        sb.append("=== DEBUG DOCTOR INFO ===\n");
//        sb.append("Username: ").append(username).append("\n");
//        sb.append("Role: ").append(role).append("\n");
//
//        if ("DOCTOR".equals(role)) {
//            Long doctorId = getCurrentDoctorId(session);
//            sb.append("Doctor ID: ").append(doctorId).append("\n");
//
//            if (doctorId != null) {
//                Doctor doctor = doctorRepository.findById(doctorId).orElse(null);
//                if (doctor != null) {
//                    sb.append("Doctor Name: ").append(doctor.getName()).append("\n");
//                    sb.append("Specialization: ").append(doctor.getSpecialization()).append("\n");
//                    sb.append("Email: ").append(doctor.getEmail()).append("\n");
//                } else {
//                    sb.append("Doctor details not found!\n");
//                }
//            } else {
//                sb.append("Doctor ID not found!\n");
//            }
//
//            // Check user-doctor linking
//            Doctor linkedDoctor = doctorService.getDoctorByUsername(username);
//            sb.append("Direct username link: ").append(linkedDoctor != null ? "FOUND" : "NOT FOUND").append("\n");
//        }
//
//        return sb.toString();
//    }

    @GetMapping("/debug/my-appointments")
    @ResponseBody
    public String debugMyAppointments(HttpSession session) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        StringBuilder sb = new StringBuilder();
        sb.append("=== DEBUG MY APPOINTMENTS ===\n");
        sb.append("Username: ").append(username).append("\n");
        sb.append("Role: ").append(role).append("\n");

        if ("DOCTOR".equals(role)) {
            Long doctorId = getCurrentDoctorId(session);
            sb.append("Doctor ID: ").append(doctorId).append("\n");

            if (doctorId != null) {
                Doctor doctor = doctorRepository.findById(doctorId).orElse(null);
                if (doctor != null) {
                    sb.append("Doctor Name: ").append(doctor.getName()).append("\n");
                }

                // Get appointments for this doctor
                List<Appointment> appointments = appointmentService.getAppointmentsByDoctorId(doctorId);
                sb.append("Total Appointments: ").append(appointments.size()).append("\n\n");

                for (Appointment appointment : appointments) {
                    sb.append(String.format("Appointment ID: %d\n", appointment.getId()));
                    sb.append(String.format("  Patient: %s %s\n",
                            appointment.getPatient().getFirstName(),
                            appointment.getPatient().getLastName()));
                    sb.append(String.format("  Date: %s\n", appointment.getAppointmentDateTime()));
                    sb.append(String.format("  Reason: %s\n", appointment.getReason()));
                    sb.append(String.format("  Status: %s\n", appointment.getStatus()));
                    sb.append(String.format("  Assigned Doctor: %s (ID: %d)\n",
                            appointment.getDoctor().getName(), appointment.getDoctor().getId()));
                    sb.append("  ---\n");
                }
            } else {
                sb.append("ERROR: Doctor ID is null!\n");
            }
        }

        return sb.toString();
    }

    @GetMapping("/debug/doctor-info")
    @ResponseBody
    public String debugDoctorInfo(HttpSession session) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        StringBuilder sb = new StringBuilder();
        sb.append("=== COMPREHENSIVE DOCTOR DEBUG ===\n\n");

        sb.append("SESSION INFO:\n");
        sb.append("Username: ").append(username).append("\n");
        sb.append("Role: ").append(role).append("\n");

        if ("DOCTOR".equals(role)) {
            // Test doctor ID resolution
            Long doctorId = getCurrentDoctorId(session);
            sb.append("Resolved Doctor ID: ").append(doctorId).append("\n\n");

            // Check all doctors in system
            sb.append("ALL DOCTORS IN SYSTEM:\n");
            List<Doctor> allDoctors = doctorRepository.findAll();
            for (Doctor doc : allDoctors) {
                sb.append(String.format("ID: %d, Name: %s, Email: %s, Specialization: %s\n",
                        doc.getId(), doc.getName(), doc.getEmail(), doc.getSpecialization()));
            }
            sb.append("\n");

            // Check user-doctor linking
            sb.append("USER-DOCTOR LINKING:\n");
            if (username != null) {
                Optional<Doctor> linkedDoctor = doctorRepository.findByUsername(username);
                if (linkedDoctor.isPresent()) {
                    sb.append("✓ Direct username link FOUND: ").append(linkedDoctor.get().getName()).append("\n");
                } else {
                    sb.append("✗ Direct username link NOT FOUND\n");
                }

                // Check if any doctor has matching email
                boolean emailMatch = allDoctors.stream()
                        .anyMatch(doc -> doc.getEmail() != null && doc.getEmail().equalsIgnoreCase(username));
                sb.append("Email match: ").append(emailMatch ? "FOUND" : "NOT FOUND").append("\n");
            }
            sb.append("\n");

            // Show appointments for this doctor
            if (doctorId != null) {
                List<Appointment> appointments = appointmentService.getAppointmentsByDoctorId(doctorId);
                sb.append("MY APPOINTMENTS (Doctor ID: ").append(doctorId).append("):\n");
                sb.append("Count: ").append(appointments.size()).append("\n");
                for (Appointment app : appointments) {
                    sb.append(String.format("  Appointment %d: %s %s with Dr. %s\n",
                            app.getId(), app.getPatient().getFirstName(), app.getPatient().getLastName(),
                            app.getDoctor().getName()));
                }
            }
        }

        return sb.toString();
    }

    @GetMapping("/debug/check-doctor")
    @ResponseBody
    public String checkDoctorLink(HttpSession session) {
        String username = (String) session.getAttribute("username");
        StringBuilder result = new StringBuilder();

        result.append("Username: ").append(username).append("\n");

        Long doctorId = getCurrentDoctorId(session);
        result.append("Current Doctor ID: ").append(doctorId).append("\n");

        if (doctorId != null) {
            Doctor doctor = doctorRepository.findById(doctorId).orElse(null);
            if (doctor != null) {
                result.append("Doctor Name: ").append(doctor.getName()).append("\n");
                result.append("Doctor Email: ").append(doctor.getEmail()).append("\n");
            }

            // Check appointments
            List<Appointment> allAppointments = appointmentService.getAllAppointments();
            List<Appointment> myAppointments = new ArrayList<>();

            for (Appointment app : allAppointments) {
                if (app.getDoctor() != null && app.getDoctor().getId().equals(doctorId)) {
                    myAppointments.add(app);
                }
            }

            result.append("Total appointments in system: ").append(allAppointments.size()).append("\n");
            result.append("My appointments: ").append(myAppointments.size()).append("\n");

            for (Appointment app : myAppointments) {
                result.append(" - Appointment ").append(app.getId())
                        .append(": ").append(app.getPatient().getFirstName())
                        .append(" ").append(app.getPatient().getLastName())
                        .append(" with Dr. ").append(app.getDoctor().getName())
                        .append("\n");
            }
        }

        return result.toString();
    }

    @GetMapping("/debug/user-linking")
    @ResponseBody
    public String debugUserLinking(HttpSession session) {
        String username = (String) session.getAttribute("username");
        StringBuilder result = new StringBuilder();

        result.append("=== USER-DOCTOR LINKING DEBUG ===\n\n");
        result.append("Logged in as: ").append(username).append("\n\n");

        // Check all users in system
        result.append("ALL USERS IN SYSTEM:\n");
        List<User> allUsers = userRepository.findAll();
        for (User user : allUsers) {
            result.append(String.format("Username: %s, Role: %s, ProfileID: %s, Email: %s\n",
                    user.getUsername(), user.getRole(), user.getProfileId(), user.getEmail()));
        }
        result.append("\n");

        // Check all doctors in system
        result.append("ALL DOCTORS IN SYSTEM:\n");
        List<Doctor> allDoctors = doctorRepository.findAll();
        for (Doctor doctor : allDoctors) {
            result.append(String.format("ID: %d, Name: %s, Email: %s\n",
                    doctor.getId(), doctor.getName(), doctor.getEmail()));
        }
        result.append("\n");

        // Check direct linking
        result.append("DIRECT USER-DOCTOR LINKING:\n");
        Optional<Doctor> linkedDoctor = doctorRepository.findByUsername(username);
        if (linkedDoctor.isPresent()) {
            result.append("✓ Direct link FOUND: ").append(linkedDoctor.get().getName()).append("\n");
        } else {
            result.append("✗ Direct link NOT FOUND\n");

            // Show why it might be linking to Dr. Priya Silva
            result.append("\nPOSSIBLE LINKING REASONS:\n");
            for (Doctor doctor : allDoctors) {
                if (doctor.getEmail() != null && doctor.getEmail().equalsIgnoreCase(username)) {
                    result.append("✓ Email match: ").append(doctor.getName()).append("\n");
                }
                if (doctor.getName() != null && doctor.getName().toLowerCase().contains(username.toLowerCase())) {
                    result.append("✓ Name contains: ").append(doctor.getName()).append("\n");
                }
            }
        }

        return result.toString();
    }

    @GetMapping("/fix-linking/{doctorId}")
    @ResponseBody
    public String manuallyFixLinking(@PathVariable Long doctorId, HttpSession session) {
        String username = (String) session.getAttribute("username");
        if (username == null) return "Not logged in";

        try {
            // Find the user
            Optional<User> userOpt = userRepository.findByUsername(username);
            if (!userOpt.isPresent()) {
                return "User not found: " + username;
            }

            User user = userOpt.get();

            // Find the doctor
            Optional<Doctor> doctorOpt = doctorRepository.findById(doctorId);
            if (!doctorOpt.isPresent()) {
                return "Doctor not found with ID: " + doctorId;
            }

            Doctor doctor = doctorOpt.get();

            // Update the user's profileId
            user.setProfileId(doctorId);
            userRepository.save(user);

            // Update session
            session.setAttribute("doctorId", doctorId);

            return String.format("SUCCESS: Linked user '%s' to Dr. %s (ID: %d)",
                    username, doctor.getName(), doctorId);

        } catch (Exception e) {
            return "Error: " + e.getMessage();
        }
    }
    // In DoctorController.java - add these methods

    @GetMapping("/appointments/pending")
    public String pendingAppointments(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"DOCTOR".equals(role)) {
            return "redirect:/access-denied";
        }

        Long doctorId = getCurrentDoctorId(session);
        if (doctorId == null) {
            return "redirect:/login?error=Doctor profile not found";
        }

        List<Appointment> pendingAppointments = appointmentService.getPendingDoctorAppointments(doctorId);

        model.addAttribute("pendingAppointments", pendingAppointments);
        model.addAttribute("pageTitle", "Pending Appointment Requests");
        model.addAttribute("doctorId", doctorId);

        return "doctor/pending-appointments";
    }

    // In DoctorController.java - enhance the approveAppointment method
    @PostMapping("/appointments/approve")
    public String approveAppointment(@RequestParam Long appointmentId, HttpSession session) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"DOCTOR".equals(role)) {
            return "redirect:/access-denied";
        }

        try {
            Appointment appointment = appointmentService.getAppointmentById(appointmentId);
            if (appointment == null) {
                return "redirect:/doctor/appointments/pending?error=Appointment not found";
            }

            // Verify the appointment belongs to this doctor
            Long doctorId = getCurrentDoctorId(session);
            if (!appointment.getDoctor().getId().equals(doctorId)) {
                return "redirect:/doctor/appointments/pending?error=Access denied";
            }

            // Update status to SCHEDULED (confirmed by doctor)
            appointment.setStatus("SCHEDULED");
            appointmentService.saveAppointment(appointment);

            System.out.println("DEBUG: Doctor approved appointment: " + appointmentId +
                    ", Payment Status: " + appointment.getPaymentStatus() +
                    ", New Status: SCHEDULED");

            return "redirect:/doctor/appointments/pending?success=Appointment approved successfully";

        } catch (Exception e) {
            return "redirect:/doctor/appointments/pending?error=Failed to approve appointment: " + e.getMessage();
        }
    }

    @PostMapping("/appointments/reject")
    public String rejectAppointment(@RequestParam Long appointmentId,
                                    @RequestParam(required = false) String rejectionReason,
                                    HttpSession session) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"DOCTOR".equals(role)) {
            return "redirect:/access-denied";
        }

        try {
            Appointment appointment = appointmentService.getAppointmentById(appointmentId);
            if (appointment == null) {
                return "redirect:/doctor/appointments/pending?error=Appointment not found";
            }

            // Verify the appointment belongs to this doctor
            Long doctorId = getCurrentDoctorId(session);
            if (!appointment.getDoctor().getId().equals(doctorId)) {
                return "redirect:/doctor/appointments/pending?error=Access denied";
            }

            // Update status to CANCELLED and set rejection reason
            appointment.setStatus("CANCELLED");
            appointment.setRescheduleReason(rejectionReason != null ? rejectionReason : "Rejected by doctor");
            appointmentService.saveAppointment(appointment);

            return "redirect:/doctor/appointments/pending?success=Appointment rejected successfully";

        } catch (Exception e) {
            return "redirect:/doctor/appointments/pending?error=Failed to reject appointment: " + e.getMessage();
        }
    }



}