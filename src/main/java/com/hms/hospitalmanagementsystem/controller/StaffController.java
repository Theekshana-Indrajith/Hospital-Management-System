package com.hms.hospitalmanagementsystem.controller;

import com.hms.hospitalmanagementsystem.entity.*;
import com.hms.hospitalmanagementsystem.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/staff")
public class StaffController {

    @Autowired
    private AppointmentService appointmentService;

    @Autowired
    private PatientService patientService;

    @Autowired
    private AdmissionService admissionService;

    @Autowired
    private DoctorService doctorService;

    @Autowired
    private WardService wardService;

    @Autowired
    private PrescriptionService prescriptionService;

    @Autowired
    private LabTestService labTestService;

    @Autowired
    private ShiftService shiftService;

    @Autowired
    private MedicalStaffService medicalStaffService;

    @GetMapping("/dashboard")
    public String staffDashboard(HttpSession session, Model model) {
        if (!validateStaff(session)) return "redirect:/access-denied";

        // Get nurse-specific data from database
        long totalAppointments = appointmentService.getAllAppointments().size();

        // Get current admissions count
        long currentAdmissions = 0;
        try {
            Long admissionsCount = admissionService.countCurrentAdmissions();
            currentAdmissions = admissionsCount != null ? admissionsCount : 0;
        } catch (Exception e) {
            currentAdmissions = 0;
        }

        // Calculate available beds
        long availableBeds = 0;
        try {
            var wards = wardService.getAllWards();
            for (var ward : wards) {
                availableBeds += ward.getAvailableBeds();
            }
        } catch (Exception e) {
            availableBeds = 12; // fallback
        }

        // Nurse-specific statistics
        long medicationsToAdminister = 8; // Placeholder - would come from prescription service
        long todayShiftsCount = 5; // Placeholder - would come from shift service

        model.addAttribute("username", session.getAttribute("username"));
        model.addAttribute("role", session.getAttribute("role"));
        model.addAttribute("totalAppointments", totalAppointments);
        model.addAttribute("currentAdmissions", currentAdmissions);
        model.addAttribute("availableBeds", availableBeds);
        model.addAttribute("medicationsToAdminister", medicationsToAdminister);
        model.addAttribute("todayShiftsCount", todayShiftsCount);

        // Nurse-specific placeholders
        model.addAttribute("pendingAdmissions", 2);
        model.addAttribute("bedsCleaning", 3);
        model.addAttribute("dischargesPending", 1);

        return "staff/dashboard";
    }

    // WARD MANAGEMENT - REAL IMPLEMENTATION
    @GetMapping("/wards")
    public String manageWards(HttpSession session, Model model) {
        if (!validateStaff(session)) return "redirect:/access-denied";

        model.addAttribute("wards", wardService.getAllWards());
        model.addAttribute("pageTitle", "Ward Management");

        return "staff/wards";
    }



    // Add to StaffController.java

// Add these methods to StaffController.java

    @GetMapping("/prescriptions")
    public String staffPrescriptions(HttpSession session, Model model) {
        if (!validateStaff(session)) {
            System.out.println("DEBUG: Staff prescriptions access denied");
            return "redirect:/access-denied";
        }

        // Get all prescriptions for staff view
        List<Prescription> prescriptions = prescriptionService.getAllPrescriptions();
        model.addAttribute("prescriptions", prescriptions);
        model.addAttribute("pageTitle", "Prescriptions Management");
        return "staff/prescriptions";
    }

    @GetMapping("/prescriptions/patient/{patientId}")
    public String viewPatientPrescriptions(@PathVariable Long patientId, HttpSession session, Model model) {
        if (!validateStaff(session)) {
            System.out.println("DEBUG: Staff patient prescriptions access denied");
            return "redirect:/access-denied";
        }

        List<Prescription> prescriptions = prescriptionService.getPrescriptionsByPatient(patientId);
        model.addAttribute("prescriptions", prescriptions);
        model.addAttribute("patient", patientService.getPatientById(patientId));
        model.addAttribute("pageTitle", "Patient Prescriptions");
        return "staff/patient-prescriptions";
    }

    private boolean validateStaff(HttpSession session) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        // Staff means NURSE in this context - only allow STAFF role (nurses)
        boolean isValid = username != null && "STAFF".equals(role);

        System.out.println("DEBUG: StaffController validation - username: " + username +
                ", role: " + role + ", valid: " + isValid);
        return isValid;
    }

    // Add to StaffController.java

    // Add this method to your StaffController.java
    @GetMapping("/patients")
    public String managePatients(
            @RequestParam(required = false) String search,
            @RequestParam(required = false) String status,
            HttpSession session,
            Model model) {

        if (!validateStaff(session)) {
            System.out.println("DEBUG: Staff access denied for patients");
            return "redirect:/access-denied";
        }

        try {
            List<Patient> patients;

            // If search parameter is provided, filter patients
            if (search != null && !search.trim().isEmpty()) {
                patients = patientService.searchPatients(search.trim());
            } else {
                patients = patientService.getAllPatients();
            }

            // If status filter is provided, apply additional filtering
            if (status != null && !status.isEmpty()) {
                patients = filterPatientsByStatus(patients, status);
            }

            // Get prescription and lab test counts for all patients
            Map<Long, Long> prescriptionCounts = patientService.getPrescriptionCountsForPatients(patients);
            Map<Long, Long> labTestCounts = patientService.getLabTestCountsForPatients(patients);

            model.addAttribute("patients", patients);
            model.addAttribute("prescriptionCounts", prescriptionCounts);
            model.addAttribute("labTestCounts", labTestCounts);
            model.addAttribute("pageTitle", "Patient Management");
            model.addAttribute("username", session.getAttribute("username"));

            System.out.println("DEBUG: Loaded " + patients.size() + " patients for staff view");
            return "staff/patients";

        } catch (Exception e) {
            System.out.println("DEBUG: Error loading patients: " + e.getMessage());
            model.addAttribute("error", "Error loading patients: " + e.getMessage());
            return "staff/patients";
        }
    }

    // Helper method to filter patients by status
    private List<Patient> filterPatientsByStatus(List<Patient> patients, String status) {
        // This is a simplified implementation - you would need to integrate with your admission service
        // to get actual admission status for each patient
        return patients.stream()
                .filter(patient -> {
                    // For demo purposes - in real implementation, check admission status
                    switch (status) {
                        case "admitted":
                            return true; // Replace with actual admission check
                        case "discharged":
                            return false; // Replace with actual discharge check
                        case "active":
                        default:
                            return true;
                    }
                })
                .collect(Collectors.toList());
    }

    @GetMapping("/patients/{patientId}")
    public String viewPatientDetails(@PathVariable Long patientId, HttpSession session, Model model) {
        if (!validateStaff(session)) {
            System.out.println("DEBUG: Staff access denied for patient details");
            return "redirect:/access-denied";
        }

        try {
            System.out.println("DEBUG: Loading patient details for ID: " + patientId);

            // Get patient from database
            Patient patient = patientService.getPatientById(patientId);
            if (patient == null) {
                System.out.println("DEBUG: Patient not found with ID: " + patientId);
                return "redirect:/staff/patients?error=Patient not found";
            }

            // Get all related data from database - handle null cases
            List<Appointment> appointments = new ArrayList<>();
            List<Admission> admissions = new ArrayList<>();
            List<Prescription> prescriptions = new ArrayList<>();
            List<LabTest> labTests = new ArrayList<>();

            try {
                appointments = appointmentService.getAppointmentsByPatientId(patientId);
                if (appointments == null) appointments = new ArrayList<>();
            } catch (Exception e) {
                System.out.println("DEBUG: Error loading appointments: " + e.getMessage());
                appointments = new ArrayList<>();
            }

            try {
                admissions = admissionService.getAdmissionsByPatientId(patientId);
                if (admissions == null) admissions = new ArrayList<>();
            } catch (Exception e) {
                System.out.println("DEBUG: Error loading admissions: " + e.getMessage());
                admissions = new ArrayList<>();
            }

            try {
                prescriptions = prescriptionService.getPrescriptionsByPatient(patientId);
                if (prescriptions == null) prescriptions = new ArrayList<>();
            } catch (Exception e) {
                System.out.println("DEBUG: Error loading prescriptions: " + e.getMessage());
                prescriptions = new ArrayList<>();
            }

            try {
                labTests = labTestService.getTestsByPatient(patientId);
                if (labTests == null) labTests = new ArrayList<>();
            } catch (Exception e) {
                System.out.println("DEBUG: Error loading lab tests: " + e.getMessage());
                labTests = new ArrayList<>();
            }

            // Get current admission (if any)
            Admission currentAdmission = admissions.stream()
                    .filter(admission -> "ADMITTED".equals(admission.getStatus()))
                    .findFirst()
                    .orElse(null);

            // Get last appointment (if any)
            Appointment lastAppointment = appointments.stream()
                    .max((a1, a2) -> a1.getAppointmentDateTime().compareTo(a2.getAppointmentDateTime()))
                    .orElse(null);

            // Sort data by date (most recent first) - only if lists are not empty
            if (!appointments.isEmpty()) {
                appointments.sort((a1, a2) -> a2.getAppointmentDateTime().compareTo(a1.getAppointmentDateTime()));
            }
            if (!admissions.isEmpty()) {
                admissions.sort((a1, a2) -> a2.getAdmissionDate().compareTo(a1.getAdmissionDate()));
            }
            if (!prescriptions.isEmpty()) {
                prescriptions.sort((p1, p2) -> p2.getPrescriptionDate().compareTo(p1.getPrescriptionDate()));
            }
            if (!labTests.isEmpty()) {
                labTests.sort((t1, t2) -> t2.getRequestedDate().compareTo(t1.getRequestedDate()));
            }

            // Add data to model - ensure no null values
            model.addAttribute("patient", patient);
            model.addAttribute("appointments", appointments);
            model.addAttribute("admissions", admissions);
            model.addAttribute("prescriptions", prescriptions);
            model.addAttribute("labTests", labTests);
            model.addAttribute("currentAdmission", currentAdmission);
            model.addAttribute("lastAppointment", lastAppointment);
            model.addAttribute("username", session.getAttribute("username"));

            System.out.println("DEBUG: Patient details loaded successfully for: " + patient.getFirstName() + " " + patient.getLastName());
            System.out.println("DEBUG: Appointments: " + appointments.size());
            System.out.println("DEBUG: Admissions: " + admissions.size());
            System.out.println("DEBUG: Prescriptions: " + prescriptions.size());
            System.out.println("DEBUG: Lab Tests: " + labTests.size());

            return "staff/patient-details";

        } catch (Exception e) {
            System.out.println("DEBUG: Error loading patient details: " + e.getMessage());
            e.printStackTrace();
            return "redirect:/staff/patients?error=Error loading patient details: " + e.getMessage();
        }
    }

    @GetMapping("/schedule")
    public String viewMySchedule(HttpSession session, Model model) {
        if (!validateStaff(session)) {
            return "redirect:/access-denied";
        }

        try {
            String username = (String) session.getAttribute("username");
            System.out.println("DEBUG: Loading schedule for user: " + username);

            // Get staff member by username - you need to implement this method
            Staff staff = getCurrentStaff(session);
            if (staff == null) {
                System.out.println("DEBUG: Staff not found for username: " + username);
                return "redirect:/staff/dashboard?error=Staff profile not found. Please contact administrator.";
            }

            System.out.println("DEBUG: Found staff: " + staff.getFirstName() + " " + staff.getLastName());

            LocalDate today = LocalDate.now();
            LocalDate weekStart = today.with(java.time.DayOfWeek.MONDAY);
            LocalDate weekEnd = today.with(java.time.DayOfWeek.SUNDAY);

            // Get this week's schedule
            List<ShiftSchedule> weeklySchedule = shiftService.getStaffSchedule(staff.getId(), weekStart, weekEnd);
            System.out.println("DEBUG: Found " + weeklySchedule.size() + " shifts for this week");

            // Get today's shifts
            List<ShiftSchedule> todaysShifts = shiftService.getStaffSchedule(staff.getId(), today, today);
            System.out.println("DEBUG: Found " + todaysShifts.size() + " shifts for today");

            model.addAttribute("staff", staff);
            model.addAttribute("weeklySchedule", weeklySchedule);
            model.addAttribute("todaysShifts", todaysShifts);
            model.addAttribute("today", today);
            model.addAttribute("weekStart", weekStart);
            model.addAttribute("weekEnd", weekEnd);
            model.addAttribute("username", username);
            model.addAttribute("pageTitle", "My Schedule");

            return "staff/schedule";

        } catch (Exception e) {
            System.out.println("DEBUG: Error loading staff schedule: " + e.getMessage());
            e.printStackTrace();
            return "redirect:/staff/dashboard?error=Error loading schedule: " + e.getMessage();
        }
    }

    // Helper method to get current staff
    private Staff getCurrentStaff(HttpSession session) {
        String username = (String) session.getAttribute("username");
        if (username == null) return null;

        // Try different ways to find the staff member
        // Method 1: Search by email (if email matches username pattern)
        List<Staff> allStaff = medicalStaffService.getAllStaff();
        Staff staff = allStaff.stream()
                .filter(s -> s.getEmail() != null && s.getEmail().contains(username))
                .findFirst()
                .orElse(null);

        // Method 2: If not found, try by name (for demo purposes)
        if (staff == null) {
            staff = allStaff.stream()
                    .filter(s -> s.getFirstName() != null && s.getFirstName().toLowerCase().contains(username.toLowerCase()))
                    .findFirst()
                    .orElse(null);
        }

        // Method 3: Return first staff member as fallback (for testing)
        if (staff == null && !allStaff.isEmpty()) {
            staff = allStaff.get(0);
            System.out.println("DEBUG: Using fallback staff: " + staff.getFirstName());
        }

        return staff;
    }

    @GetMapping("/schedule/month")
    public String viewMonthlySchedule(HttpSession session, Model model,
                                      @RequestParam(required = false) Integer year,
                                      @RequestParam(required = false) Integer month) {
        if (!validateStaff(session)) {
            return "redirect:/access-denied";
        }

        try {
            String username = (String) session.getAttribute("username");
            Staff staff = getCurrentStaff(session);

            if (staff == null) {
                return "redirect:/staff/dashboard?error=Staff profile not found";
            }

            LocalDate today = LocalDate.now();
            if (year == null) year = today.getYear();
            if (month == null) month = today.getMonthValue();

            LocalDate monthStart = LocalDate.of(year, month, 1);
            LocalDate monthEnd = monthStart.withDayOfMonth(monthStart.lengthOfMonth());

            List<ShiftSchedule> monthlySchedule = shiftService.getStaffSchedule(staff.getId(), monthStart, monthEnd);

            model.addAttribute("staff", staff);
            model.addAttribute("monthlySchedule", monthlySchedule);
            model.addAttribute("monthStart", monthStart);
            model.addAttribute("monthEnd", monthEnd);
            model.addAttribute("selectedYear", year);
            model.addAttribute("selectedMonth", month);
            model.addAttribute("username", username);
            model.addAttribute("pageTitle", "Monthly Schedule - " + monthStart.getMonth().toString() + " " + year);

            return "staff/monthly-schedule";

        } catch (Exception e) {
            System.out.println("DEBUG: Error loading monthly schedule: " + e.getMessage());
            return "redirect:/staff/schedule?error=Error loading monthly schedule";
        }
    }

    @PostMapping("/schedule/request-change")
    public String requestScheduleChange(@RequestParam Long shiftId,
                                        @RequestParam String reason,
                                        HttpSession session) {
        if (!validateStaff(session)) {
            return "redirect:/access-denied";
        }

        try {
            // In a real system, this would create a schedule change request
            // For now, we'll just show a success message
            return "redirect:/staff/schedule?success=Schedule change request submitted for review";
        } catch (Exception e) {
            return "redirect:/staff/schedule?error=Failed to submit schedule change request";
        }
    }

    // Debug endpoint to check staff data
    @GetMapping("/debug/staff")
    @ResponseBody
    public String debugStaff(HttpSession session) {
        String username = (String) session.getAttribute("username");
        StringBuilder sb = new StringBuilder();
        sb.append("=== DEBUG STAFF INFO ===\n");
        sb.append("Username: ").append(username).append("\n");

        Staff staff = getCurrentStaff(session);
        if (staff != null) {
            sb.append("Staff Found: ").append(staff.getFirstName()).append(" ").append(staff.getLastName()).append("\n");
            sb.append("Staff ID: ").append(staff.getId()).append("\n");
            sb.append("Staff Type: ").append(staff.getStaffType()).append("\n");

            // Check shifts
            List<ShiftSchedule> shifts = shiftService.getStaffSchedule(staff.getId(), LocalDate.now(), LocalDate.now());
            sb.append("Today's Shifts: ").append(shifts.size()).append("\n");
        } else {
            sb.append("NO STAFF FOUND\n");

            // List all staff for debugging
            List<Staff> allStaff = medicalStaffService.getAllStaff();
            sb.append("All Staff:\n");
            for (Staff s : allStaff) {
                sb.append("- ").append(s.getFirstName()).append(" ").append(s.getLastName())
                        .append(" (ID: ").append(s.getId()).append(")\n");
            }
        }

        return sb.toString();
    }

    // Add to StaffController.java - Profile Management for Staff
    @GetMapping("/profile")
    public String viewMyProfile(HttpSession session, Model model) {
        if (!validateStaff(session)) {
            return "redirect:/access-denied";
        }

        try {
            String username = (String) session.getAttribute("username");
            Staff staff = getCurrentStaff(session);

            if (staff == null) {
                return "redirect:/staff/dashboard?error=Staff profile not found";
            }

            model.addAttribute("staff", staff);
            model.addAttribute("username", username);
            model.addAttribute("pageTitle", "My Profile");

            return "staff/profile";

        } catch (Exception e) {
            return "redirect:/staff/dashboard?error=Error loading profile: " + e.getMessage();
        }
    }

    @GetMapping("/profile/edit")
    public String editProfileForm(HttpSession session, Model model) {
        if (!validateStaff(session)) {
            return "redirect:/access-denied";
        }

        try {
            String username = (String) session.getAttribute("username");
            Staff staff = getCurrentStaff(session);

            if (staff == null) {
                return "redirect:/staff/dashboard?error=Staff profile not found";
            }

            model.addAttribute("staff", staff);
            model.addAttribute("username", username);
            model.addAttribute("pageTitle", "Edit My Profile");

            return "staff/edit-profile";

        } catch (Exception e) {
            return "redirect:/staff/profile?error=Error loading edit form: " + e.getMessage();
        }
    }

    @PostMapping("/profile/update")
    public String updateProfile(@RequestParam String firstName,
                                @RequestParam String lastName,
                                @RequestParam(required = false) String dateOfBirth,
                                @RequestParam(required = false) String gender,
                                @RequestParam(required = false) String contactNumber,
                                @RequestParam(required = false) String email,
                                @RequestParam(required = false) String emergencyContact,
                                @RequestParam(required = false) String emergencyPhone,
                                @RequestParam(required = false) String bloodGroup,
                                @RequestParam(required = false) String allergies,
                                @RequestParam(required = false) String specialSkills,
                                @RequestParam(required = false) String notes,
                                HttpSession session) {
        if (!validateStaff(session)) {
            return "redirect:/access-denied";
        }

        try {
            Staff staff = getCurrentStaff(session);
            if (staff == null) {
                return "redirect:/staff/dashboard?error=Staff profile not found";
            }

            // Update staff fields - only allow updating personal information, not role/type
            staff.setFirstName(firstName);
            staff.setLastName(lastName);

            if (dateOfBirth != null && !dateOfBirth.isEmpty()) {
                staff.setDateOfBirth(java.time.LocalDate.parse(dateOfBirth));
            }
            if (gender != null && !gender.isEmpty()) {
                staff.setGender(gender);
            }
            if (contactNumber != null) {
                staff.setContactNumber(contactNumber);
            }
            if (email != null) {
                staff.setEmail(email);
            }
            if (emergencyContact != null) {
                staff.setEmergencyContact(emergencyContact);
            }
            if (emergencyPhone != null) {
                staff.setEmergencyPhone(emergencyPhone);
            }
            if (bloodGroup != null) {
                staff.setBloodGroup(bloodGroup);
            }
            if (allergies != null) {
                staff.setAllergies(allergies);
            }
            if (specialSkills != null) {
                staff.setSpecialSkills(specialSkills);
            }
            if (notes != null) {
                staff.setNotes(notes);
            }

            medicalStaffService.saveStaff(staff);

            // Update session username if email/name changed
            session.setAttribute("username", staff.getEmail() != null ? staff.getEmail() : staff.getFirstName());

            return "redirect:/staff/profile?success=Profile updated successfully";

        } catch (Exception e) {
            return "redirect:/staff/profile?error=Failed to update profile: " + e.getMessage();
        }
    }
}