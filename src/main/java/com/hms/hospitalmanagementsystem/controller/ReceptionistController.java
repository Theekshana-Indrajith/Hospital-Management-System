package com.hms.hospitalmanagementsystem.controller;

import com.hms.hospitalmanagementsystem.entity.*;
import com.hms.hospitalmanagementsystem.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Controller
@RequestMapping("/receptionist")
public class ReceptionistController {

    @Autowired
    private AppointmentService appointmentService;

    @Autowired
    private PatientService patientService;

    @Autowired
    private ReceptionistService receptionistService;

    @Autowired
    private DoctorService doctorService;

    @Autowired
    private AdmissionService admissionService;

    @Autowired
    private WardService wardService;

    @Autowired
    private UserService userService;





    @GetMapping("/dashboard")
    public String receptionistDashboard(HttpSession session, Model model) {
        if (!validateReceptionist(session)) {
            System.out.println("DEBUG: Receptionist access denied");
            return "redirect:/access-denied";
        }

        try {
            // Get dashboard statistics
            var stats = receptionistService.getDashboardStatistics();

            // Get today's appointments
            List<Appointment> todaysAppointments = receptionistService.getTodaysAppointmentsList();

            // Get recent patients
            List<Patient> recentPatients = receptionistService.getRecentPatientsList(5);

            // Add data to model
            model.addAttribute("username", session.getAttribute("username"));
            model.addAttribute("todayAppointments", stats.get("todayAppointments"));
            model.addAttribute("totalAppointments", stats.get("totalAppointments"));
            model.addAttribute("newPatients", stats.get("newPatients"));
            model.addAttribute("pendingRegistrations", stats.get("pendingRegistrations"));
            model.addAttribute("onlineDoctorsCount", stats.get("onlineDoctorsCount"));
            model.addAttribute("availableRooms", stats.get("availableRooms"));
            model.addAttribute("pendingPayments", stats.get("pendingPayments"));
            model.addAttribute("todaysAppointmentsList", todaysAppointments);
            model.addAttribute("recentPatients", recentPatients);

            System.out.println("DEBUG: Receptionist dashboard loaded successfully");
            return "receptionist/dashboard";

        } catch (Exception e) {
            System.out.println("DEBUG: Error loading receptionist dashboard: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Error loading dashboard data");
            return "receptionist/dashboard";
        }
    }

    @GetMapping("/appointments")
    public String manageAppointments(HttpSession session, Model model) {
        if (!validateReceptionist(session)) return "redirect:/access-denied";

        try {
            List<Appointment> appointments = appointmentService.getAllAppointments();
            List<Patient> patients = patientService.getAllPatients();
            List<Doctor> doctors = doctorService.getAllDoctors(); // Use DoctorService

            model.addAttribute("appointments", appointments);
            model.addAttribute("patients", patients);
            model.addAttribute("doctors", doctors);
            model.addAttribute("pageTitle", "Appointment Management");

            return "receptionist/appointments";
        } catch (Exception e) {
            model.addAttribute("error", "Error loading appointments: " + e.getMessage());
            return "receptionist/appointments";
        }
    }

//    @PostMapping("/appointments/create")
//    public String createAppointment(@RequestParam Long patientId,
//                                    @RequestParam Long doctorId,
//                                    @RequestParam String appointmentDate,
//                                    @RequestParam String appointmentTime,
//                                    @RequestParam String reason,
//                                    HttpSession session) {
//        if (!validateReceptionist(session)) return "redirect:/access-denied";
//
//        try {
//            // Get patient and doctor
//            Patient patient = patientService.getPatientById(patientId);
//            Doctor doctor = doctorService.getDoctorById(doctorId);
//
//            // Combine date and time
//            LocalDateTime dateTime = LocalDateTime.parse(appointmentDate + "T" + appointmentTime);
//
//            // Create and save appointment
//            Appointment appointment = new Appointment(patient, doctor, dateTime, reason, "SCHEDULED");
//            appointmentService.saveAppointment(appointment);
//
//            return "redirect:/receptionist/appointments?success=Appointment created successfully";
//        } catch (Exception e) {
//            return "redirect:/receptionist/appointments?error=Failed to create appointment: " + e.getMessage();
//        }
//    }

    @PostMapping("/appointments/update-status")
    public String updateAppointmentStatus(@RequestParam Long appointmentId,
                                          @RequestParam String status,
                                          HttpSession session) {
        if (!validateReceptionist(session)) return "redirect:/access-denied";

        try {
            Appointment appointment = appointmentService.getAppointmentById(appointmentId);
            if (appointment != null) {
                appointment.setStatus(status);
                appointmentService.saveAppointment(appointment);
                return "redirect:/receptionist/appointments?success=Appointment status updated to " + status;
            } else {
                return "redirect:/receptionist/appointments?error=Appointment not found";
            }
        } catch (Exception e) {
            return "redirect:/receptionist/appointments?error=Failed to update appointment: " + e.getMessage();
        }
    }

    @GetMapping("/patients")
    public String managePatients(HttpSession session, Model model) {
        if (!validateReceptionist(session)) return "redirect:/access-denied";

        try {
            List<Patient> patients = patientService.getAllPatients();
            model.addAttribute("patients", patients);
            model.addAttribute("pageTitle", "Patient Management");
            return "receptionist/patients";
        } catch (Exception e) {
            model.addAttribute("error", "Error loading patients: " + e.getMessage());
            return "receptionist/patients";
        }
    }

    @PostMapping("/patients/create")
    public String createPatient(@RequestParam String firstName,
                                @RequestParam String lastName,
                                @RequestParam(required = false) String dateOfBirth,
                                @RequestParam(required = false) String gender,
                                @RequestParam(required = false) String contactNumber,
                                @RequestParam(required = false) String email,
                                @RequestParam(required = false) String address,
                                @RequestParam String loginUsername,  // New parameter
                                @RequestParam String loginPassword,  // New parameter
                                HttpSession session) {
        if (!validateReceptionist(session)) return "redirect:/access-denied";

        try {
            // Check if username already exists
            if (userService.usernameExists(loginUsername)) {
                return "redirect:/receptionist/patients?error=Username already exists. Please choose a different username.";
            }

            // Create patient entity
            Patient patient = new Patient();
            patient.setFirstName(firstName);
            patient.setLastName(lastName);

            if (dateOfBirth != null && !dateOfBirth.isEmpty()) {
                patient.setDateOfBirth(LocalDate.parse(dateOfBirth));
            }
            if (gender != null && !gender.isEmpty()) {
                patient.setGender(gender);
            }
            if (contactNumber != null) {
                patient.setContactNumber(contactNumber);
            }
            if (email != null) {
                patient.setEmail(email);
            }
            if (address != null) {
                patient.setAddress(address);
            }

            // Save patient first to get the ID
            Patient savedPatient = patientService.savePatient(patient);

            // Create user account for the patient
            User user = new User();
            user.setUsername(loginUsername);
            user.setPassword(loginPassword); // This will be encoded by UserService
            user.setEmail(email != null ? email : loginUsername + "@hospital.com");
            user.setRole("PATIENT");
            user.setProfileId(savedPatient.getId()); // Link to patient ID

            // Save user account
            User savedUser = userService.registerUser(user);

            return "redirect:/receptionist/patients?success=Patient " + firstName + " " + lastName + " registered successfully with username: " + loginUsername;

        } catch (Exception e) {
            return "redirect:/receptionist/patients?error=Failed to create patient: " + e.getMessage();
        }
    }
    // Helper method to generate unique username
    private String generateUsername(String firstName, String lastName, Long patientId) {
        String baseUsername = (firstName.charAt(0) + lastName).toLowerCase().replaceAll("[^a-z0-9]", "");
        String username = baseUsername + patientId; // Append ID to ensure uniqueness

        // Check if username already exists and modify if needed
        int counter = 1;
        String finalUsername = username;
        while (userService.usernameExists(finalUsername)) {
            finalUsername = username + counter;
            counter++;
        }

        return finalUsername;
    }

    // Helper method to generate temporary password
    private String generateTemporaryPassword() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder password = new StringBuilder();
        for (int i = 0; i < 8; i++) {
            password.append(chars.charAt((int) (Math.random() * chars.length())));
        }
        return password.toString();
    }

    @GetMapping("/patients/{patientId}")
    public String viewPatientDetails(@PathVariable Long patientId, HttpSession session, Model model) {
        if (!validateReceptionist(session)) {
            return "redirect:/access-denied";
        }

        try {
            Patient patient = patientService.getPatientById(patientId);
            if (patient == null) {
                return "redirect:/receptionist/patients?error=Patient not found";
            }

            List<Appointment> appointments = appointmentService.getAppointmentsByPatientId(patientId);

            model.addAttribute("patient", patient);
            model.addAttribute("appointments", appointments);
            model.addAttribute("username", session.getAttribute("username"));

            return "receptionist/patient-details";

        } catch (Exception e) {
            return "redirect:/receptionist/patients?error=Error loading patient details: " + e.getMessage();
        }
    }

    @GetMapping("/patients/edit/{patientId}")
    public String editPatientForm(@PathVariable Long patientId, HttpSession session, Model model) {
        if (!validateReceptionist(session)) {
            return "redirect:/access-denied";
        }

        try {
            Patient patient = patientService.getPatientById(patientId);
            if (patient == null) {
                return "redirect:/receptionist/patients?error=Patient not found";
            }

            model.addAttribute("patient", patient);
            model.addAttribute("username", session.getAttribute("username"));
            model.addAttribute("pageTitle", "Edit Patient - " + patient.getFirstName() + " " + patient.getLastName());

            return "receptionist/edit-patient";

        } catch (Exception e) {
            return "redirect:/receptionist/patients?error=Error loading patient form: " + e.getMessage();
        }
    }

    @PostMapping("/patients/update/{patientId}")
    public String updatePatient(@PathVariable Long patientId,
                                @RequestParam String firstName,
                                @RequestParam String lastName,
                                @RequestParam(required = false) String dateOfBirth,
                                @RequestParam(required = false) String gender,
                                @RequestParam(required = false) String contactNumber,
                                @RequestParam(required = false) String email,
                                @RequestParam(required = false) String address,
                                @RequestParam(required = false) String emergencyContactName,
                                @RequestParam(required = false) String emergencyContactRelationship,
                                @RequestParam(required = false) String emergencyContactPhone,
                                @RequestParam(required = false) String bloodType,
                                @RequestParam(required = false) String allergies,
                                HttpSession session) {
        if (!validateReceptionist(session)) {
            return "redirect:/access-denied";
        }

        try {
            Patient patient = patientService.getPatientById(patientId);
            if (patient == null) {
                return "redirect:/receptionist/patients?error=Patient not found";
            }

            patient.setFirstName(firstName);
            patient.setLastName(lastName);

            if (dateOfBirth != null && !dateOfBirth.isEmpty()) {
                patient.setDateOfBirth(java.time.LocalDate.parse(dateOfBirth));
            }
            if (gender != null && !gender.isEmpty()) {
                patient.setGender(gender);
            }
            if (contactNumber != null) {
                patient.setContactNumber(contactNumber);
            }
            if (email != null) {
                patient.setEmail(email);
            }
            if (address != null) {
                patient.setAddress(address);
            }

            // Update the new fields
            if (emergencyContactName != null) {
                patient.setEmergencyContactName(emergencyContactName);
            }
            if (emergencyContactRelationship != null) {
                patient.setEmergencyContactRelationship(emergencyContactRelationship);
            }
            if (emergencyContactPhone != null) {
                patient.setEmergencyContactPhone(emergencyContactPhone);
            }
            if (bloodType != null) {
                patient.setBloodType(bloodType);
            }
            if (allergies != null) {
                patient.setAllergies(allergies);
            }

            patientService.savePatient(patient);

            return "redirect:/receptionist/patients/" + patientId + "?success=Patient updated successfully";

        } catch (Exception e) {
            return "redirect:/receptionist/patients/" + patientId + "?error=Failed to update patient: " + e.getMessage();
        }
    }
    @PostMapping("/patients/delete/{patientId}")
    public String deletePatient(@PathVariable Long patientId, HttpSession session) {
        if (!validateReceptionist(session)) {
            return "redirect:/access-denied";
        }

        try {
            Patient patient = patientService.getPatientById(patientId);
            if (patient == null) {
                return "redirect:/receptionist/patients?error=Patient not found";
            }

            // First, delete all appointments for this patient
            List<Appointment> patientAppointments = appointmentService.getAppointmentsByPatientId(patientId);
            for (Appointment appointment : patientAppointments) {
                appointmentService.deleteAppointment(appointment.getId());
            }

            // Also delete any associated user account
            User patientUser = userService.findByProfileIdAndRole(patientId, "PATIENT");
            if (patientUser != null) {
                userService.deleteUser(patientUser.getId());
            }

            // Now delete the patient
            patientService.deletePatient(patientId);

            return "redirect:/receptionist/patients?success=Patient deleted successfully";

        } catch (Exception e) {
            // Use a simpler error message to avoid URL encoding issues
            String errorMessage = "Failed to delete patient: Patient has associated records";
            try {
                errorMessage = URLEncoder.encode(errorMessage, StandardCharsets.UTF_8.toString());
            } catch (UnsupportedEncodingException ex) {
                // Fallback to simple message
                errorMessage = "Failed to delete patient";
            }
            return "redirect:/receptionist/patients?error=" + errorMessage;
        }
    }

    private boolean validateReceptionist(HttpSession session) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        boolean isValid = username != null && "RECEPTIONIST".equals(role);
        System.out.println("DEBUG: Receptionist validation - username: " + username + ", role: " + role + ", valid: " + isValid);
        return isValid;
    }

    // Add these methods to ReceptionistController.java

    @GetMapping("/admissions")
    public String manageAdmissions(HttpSession session, Model model) {
        if (!validateReceptionist(session)) return "redirect:/access-denied";

        try {
            List<Admission> currentAdmissions = admissionService.getCurrentAdmissions();
            model.addAttribute("currentAdmissions", currentAdmissions);
            model.addAttribute("patients", patientService.getAllPatients());
            model.addAttribute("wards", wardService.getAvailableWards());
            model.addAttribute("pageTitle", "Admissions Management");
            return "receptionist/admissions";
        } catch (Exception e) {
            model.addAttribute("error", "Error loading admissions: " + e.getMessage());
            return "receptionist/admissions";
        }
    }

//    @PostMapping("/admissions/admit")
//    public String admitPatient(@RequestParam Long patientId,
//                               @RequestParam Long wardId,
//                               @RequestParam String reason,
//                               HttpSession session) {
//        if (!validateReceptionist(session)) return "redirect:/access-denied";
//
//        try {
//            // Get available beds for the selected ward
//            var availableBeds = wardService.getAvailableBedsByWardId(wardId);
//            if (availableBeds != null && !availableBeds.isEmpty()) {
//                Long bedId = availableBeds.get(0).getId();
//                admissionService.admitPatient(patientId, wardId, bedId, reason);
//                return "redirect:/receptionist/admissions?success=Patient admitted successfully";
//            } else {
//                return "redirect:/receptionist/admissions?error=No available beds in selected ward";
//            }
//        } catch (Exception e) {
//            return "redirect:/receptionist/admissions?error=Failed to admit patient: " + e.getMessage();
//        }
//    }

    @PostMapping("/admissions/discharge")
    public String dischargePatient(@RequestParam Long admissionId, HttpSession session) {
        if (!validateReceptionist(session)) return "redirect:/access-denied";

        try {
            admissionService.dischargePatient(admissionId);
            return "redirect:/receptionist/admissions?success=Patient discharged successfully";
        } catch (Exception e) {
            return "redirect:/receptionist/admissions?error=Failed to discharge patient: " + e.getMessage();
        }
    }
}