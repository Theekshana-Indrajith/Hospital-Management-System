package com.hms.hospitalmanagementsystem.controller;

import com.hms.hospitalmanagementsystem.entity.Appointment;
import com.hms.hospitalmanagementsystem.entity.Doctor;
import com.hms.hospitalmanagementsystem.entity.Patient;
import com.hms.hospitalmanagementsystem.entity.User;
import com.hms.hospitalmanagementsystem.service.AppointmentService;
import com.hms.hospitalmanagementsystem.service.DoctorService;
import com.hms.hospitalmanagementsystem.service.PatientService;
import com.hms.hospitalmanagementsystem.service.PaymentService;
import com.hms.hospitalmanagementsystem.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/patient")
public class AppointmentController {

    @Autowired
    private AppointmentService appointmentService;

    @Autowired
    private PatientService patientService;

    @Autowired
    private DoctorService doctorService;

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private UserService userService;

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

    @GetMapping("/appointments")
    public String patientAppointments(HttpSession session, Model model) {
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
        List<Appointment> appointments = appointmentService.getAppointmentsByPatientId(patientId);

        model.addAttribute("patient", patient);
        model.addAttribute("appointments", appointments);
        model.addAttribute("pageTitle", "My Appointments");

        return "patient/my-appointments";
    }

    @GetMapping("/appointments/book")
    public String showBookAppointmentForm(HttpSession session, Model model) {
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

        // Get all active doctors for selection
        List<Doctor> doctors = doctorService.getAllDoctors();

        model.addAttribute("patient", patient);
        model.addAttribute("doctors", doctors);
        model.addAttribute("pageTitle", "Book Appointment");

        return "patient/book-appointment";
    }

    @PostMapping("/appointments/book")
    public String bookAppointment(@RequestParam Long doctorId,
                                  @RequestParam String appointmentDateTime,
                                  @RequestParam String reason,
                                  @RequestParam String paymentMethod,
                                  HttpSession session,
                                  Model model) {

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

        try {
            // Parse the appointment date and time
            LocalDateTime dateTime = LocalDateTime.parse(appointmentDateTime);

            // Validate appointment time (Mon-Sat, 4 PM to 10 PM)
            if (!appointmentService.isValidAppointmentTime(dateTime)) {
                return "redirect:/patient/appointments/book?error=Appointments are only available Monday to Saturday, between 4 PM and 10 PM";
            }

            // Check if time slot is available for this doctor
            if (!appointmentService.isTimeSlotAvailable(doctorId, dateTime, null)) {
                return "redirect:/patient/appointments/book?error=Selected time slot is not available. Please choose another time";
            }

            // Get patient and doctor objects
            Patient patient = patientService.getPatientById(patientId);
            Doctor doctor = doctorService.getDoctorById(doctorId);

            if (patient == null || doctor == null) {
                return "redirect:/patient/appointments/book?error=Patient or Doctor not found";
            }

            // Validate payment method
            if (!isValidPaymentMethod(paymentMethod)) {
                return "redirect:/patient/appointments/book?error=Invalid payment method selected";
            }

            // Create and save the appointment with PENDING_DOCTOR status
            Appointment appointment = new Appointment();
            appointment.setPatient(patient);
            appointment.setDoctor(doctor);
            appointment.setAppointmentDateTime(dateTime);
            appointment.setReason(reason);
            appointment.setStatus("PENDING_DOCTOR"); // Changed from SCHEDULED to PENDING_DOCTOR
            appointment.setPaymentMethod(paymentMethod);
            appointment.setPaymentStatus("PENDING");
            appointment.setRescheduleCount(0); // Initialize reschedule count

            // Set consultation fee based on doctor's specialization
            Double consultationFee = paymentService.calculateConsultationFee(doctor.getSpecialization());
            appointment.setConsultationFee(consultationFee);

            Appointment savedAppointment = appointmentService.saveAppointment(appointment);

            System.out.println("DEBUG: Appointment created - ID: " + savedAppointment.getId() +
                    ", Status: PENDING_DOCTOR, Payment Method: " + paymentMethod);

            // For ONLINE payment, redirect to payment gateway immediately
            if ("ONLINE".equals(paymentMethod)) {
                return "redirect:/payments/online/" + savedAppointment.getId();
            }

            // For MANUAL payment, redirect to pending confirmation
            return "redirect:/patient/appointments/pending-confirmation/" + savedAppointment.getId();

        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/patient/appointments/book?error=Failed to book appointment: " + e.getMessage();
        }
    }

    // Helper method to validate payment method
    private boolean isValidPaymentMethod(String paymentMethod) {
        return "MANUAL".equals(paymentMethod) || "ONLINE".equals(paymentMethod);
    }

    @PostMapping("/appointments/cancel")
    public String cancelAppointment(@RequestParam Long appointmentId,
                                    HttpSession session) {

        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"PATIENT".equals(role)) {
            return "redirect:/access-denied";
        }

        try {
            // Get the appointment
            Appointment appointment = appointmentService.getAppointmentById(appointmentId);

            // Verify that the appointment belongs to the logged-in patient
            Long patientId = getCurrentPatientId(session);
            if (appointment == null || !appointment.getPatient().getId().equals(patientId)) {
                return "redirect:/patient/appointments?error=Appointment not found or access denied";
            }

            // Allow cancellation for PENDING_DOCTOR appointments
            if (!"PENDING_DOCTOR".equals(appointment.getStatus()) && !"SCHEDULED".equals(appointment.getStatus())) {
                return "redirect:/patient/appointments?error=Only pending or scheduled appointments can be cancelled";
            }

            // Cancel the appointment
            appointment.setStatus("CANCELLED");

            // Handle refund logic for paid online appointments
            if ("ONLINE".equals(appointment.getPaymentMethod()) && "PAID".equals(appointment.getPaymentStatus())) {
                System.out.println("DEBUG: Online paid appointment cancelled - consider refund process for ID: " + appointment.getId());
                // You can integrate with your payment service for refunds here
            }

            appointmentService.saveAppointment(appointment);

            return "redirect:/patient/appointments?success=Appointment cancelled successfully!";

        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/patient/appointments?error=Failed to cancel appointment: " + e.getMessage();
        }
    }

    @GetMapping("/appointments/manual-confirmation/{appointmentId}")
    public String manualConfirmation(@PathVariable Long appointmentId, HttpSession session, Model model) {
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

        try {
            Appointment appointment = appointmentService.getAppointmentById(appointmentId);

            // Verify appointment belongs to patient
            if (appointment == null || !appointment.getPatient().getId().equals(patientId)) {
                return "redirect:/patient/appointments?error=Appointment not found or access denied";
            }

            // Format appointment date for display
            String formattedDateTime = appointment.getAppointmentDateTime().format(java.time.format.DateTimeFormatter.ofPattern("MMMM dd, yyyy 'at' hh:mm a"));

            model.addAttribute("appointment", appointment);
            model.addAttribute("formattedDateTime", formattedDateTime);
            model.addAttribute("patient", getCurrentPatient(session));
            model.addAttribute("pageTitle", "Appointment Confirmation");

            return "patient/manual-confirmation";

        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/patient/appointments?error=Error loading confirmation";
        }
    }

    @GetMapping("/appointments/reschedule/{appointmentId}")
    public String showRescheduleForm(@PathVariable Long appointmentId, HttpSession session, Model model) {
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

        try {
            Appointment appointment = appointmentService.getAppointmentById(appointmentId);

            // Verify appointment belongs to patient
            if (appointment == null || !appointment.getPatient().getId().equals(patientId)) {
                return "redirect:/patient/appointments?error=Appointment not found or access denied";
            }

            // ALLOW rescheduling for BOTH PENDING_DOCTOR and SCHEDULED appointments
            if (!"PENDING_DOCTOR".equals(appointment.getStatus()) && !"SCHEDULED".equals(appointment.getStatus())) {
                return "redirect:/patient/appointments?error=Only pending or scheduled appointments can be rescheduled";
            }

            // Check reschedule limit - allow both manual and online payment patients
            if (appointment.getRescheduleCount() >= appointmentService.getMaxRescheduleCount()) {
                return "redirect:/patient/appointments?error=Maximum reschedule limit reached";
            }

            List<Doctor> doctors = doctorService.getAllDoctors();
            Patient patient = getCurrentPatient(session);

            model.addAttribute("patient", patient);
            model.addAttribute("doctors", doctors);
            model.addAttribute("appointment", appointment);
            model.addAttribute("pageTitle", "Reschedule Appointment");

            return "patient/reschedule-appointment";

        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/patient/appointments?error=Error loading reschedule form";
        }
    }

    @PostMapping("/appointments/reschedule")
    public String rescheduleAppointment(@RequestParam Long appointmentId,
                                        @RequestParam String appointmentDateTime,
                                        @RequestParam String rescheduleReason,
                                        HttpSession session) {
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

        try {
            Appointment appointment = appointmentService.getAppointmentById(appointmentId);

            // Verify appointment belongs to patient
            if (appointment == null || !appointment.getPatient().getId().equals(patientId)) {
                return "redirect:/patient/appointments?error=Appointment not found or access denied";
            }

            // Allow rescheduling for both PENDING_DOCTOR and SCHEDULED appointments
            if (!"PENDING_DOCTOR".equals(appointment.getStatus()) && !"SCHEDULED".equals(appointment.getStatus())) {
                return "redirect:/patient/appointments?error=Only pending or scheduled appointments can be rescheduled";
            }

            // Parse the new appointment date and time
            LocalDateTime newDateTime = LocalDateTime.parse(appointmentDateTime);

            // Validate appointment time (Mon-Sat, 4 PM to 10 PM)
            if (!appointmentService.isValidAppointmentTime(newDateTime)) {
                return "redirect:/patient/appointments/reschedule/" + appointmentId +
                        "?error=Appointments are only available Monday to Saturday, between 4 PM and 10 PM";
            }

            // Check if time slot is available
            if (!appointmentService.isTimeSlotAvailable(appointment.getDoctor().getId(), newDateTime, appointmentId)) {
                return "redirect:/patient/appointments/reschedule/" + appointmentId +
                        "?error=Selected time slot is not available. Please choose another time";
            }

            // Store original appointment date if this is the first reschedule
            if (appointment.getOriginalAppointmentDateTime() == null) {
                appointment.setOriginalAppointmentDateTime(appointment.getAppointmentDateTime());
            }

            // Update appointment - CHANGE STATUS TO PENDING_DOCTOR so doctor can review the new time
            appointment.setAppointmentDateTime(newDateTime);
            appointment.setRescheduleReason(rescheduleReason);
            appointment.setRescheduleCount(appointment.getRescheduleCount() + 1);
            appointment.setStatus("PENDING_DOCTOR"); // Reset status to pending doctor approval

            appointmentService.saveAppointment(appointment);

            return "redirect:/patient/appointments?success=Appointment rescheduled successfully! It is now pending doctor confirmation.";

        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/patient/appointments/reschedule/" + appointmentId +
                    "?error=Failed to reschedule appointment: " + e.getMessage();
        }
    }
    // AJAX endpoint for manual payment booking
    @PostMapping("/appointments/book-manual-ajax")
    @ResponseBody
    public Map<String, Object> bookAppointmentManualAjax(@RequestParam Long doctorId,
                                                         @RequestParam String appointmentDateTime,
                                                         @RequestParam String reason,
                                                         @RequestParam(required = false) String paymentMethod,
                                                         HttpSession session) {

        Map<String, Object> response = new HashMap<>();

        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"PATIENT".equals(role)) {
            response.put("success", false);
            response.put("message", "Access denied");
            return response;
        }

        // Get the actual patient for logged-in user
        Long patientId = getCurrentPatientId(session);
        if (patientId == null) {
            response.put("success", false);
            response.put("message", "Patient not found");
            return response;
        }

        try {
            // Parse the appointment date and time
            LocalDateTime dateTime = LocalDateTime.parse(appointmentDateTime);

            // Validate appointment time
            if (!appointmentService.isValidAppointmentTime(dateTime)) {
                response.put("success", false);
                response.put("message", "Appointments are only available Monday to Saturday, between 4 PM and 10 PM");
                return response;
            }

            // Check if time slot is available
            if (!appointmentService.isTimeSlotAvailable(doctorId, dateTime, null)) {
                response.put("success", false);
                response.put("message", "Selected time slot is not available. Please choose another time");
                return response;
            }

            // Create and save the appointment with PENDING_DOCTOR status
            Appointment appointment = new Appointment();
            appointment.setPatient(patientService.getPatientById(patientId));
            appointment.setDoctor(doctorService.getDoctorById(doctorId));
            appointment.setAppointmentDateTime(dateTime);
            appointment.setReason(reason);
            appointment.setStatus("PENDING_DOCTOR"); // CHANGED FROM "SCHEDULED" to "PENDING_DOCTOR"
            appointment.setPaymentMethod("MANUAL");
            appointment.setPaymentStatus("PENDING");
            appointment.setRescheduleCount(0);

            // Set consultation fee based on doctor's specialization
            Double consultationFee = paymentService.calculateConsultationFee(doctorService.getDoctorById(doctorId).getSpecialization());
            appointment.setConsultationFee(consultationFee);

            Appointment savedAppointment = appointmentService.saveAppointment(appointment);

            System.out.println("DEBUG: Manual payment appointment created - ID: " + savedAppointment.getId() +
                    ", Status: PENDING_DOCTOR, Payment Method: MANUAL");

            // Return redirect URL instead of appointment data
            response.put("success", true);
            response.put("redirectUrl", "/patient/appointments/manual-confirmation/" + savedAppointment.getId());
            return response;

        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "Failed to book appointment: " + e.getMessage());
            return response;
        }
    }

    // Existing methods for other appointment functionalities
    @GetMapping
    public String listAppointments(Model model) {
        List<Appointment> appointments = appointmentService.getAllAppointments();
        List<Patient> patients = patientService.getAllPatients();
        List<Doctor> doctors = doctorService.getAllDoctors();

        model.addAttribute("appointments", appointments);
        model.addAttribute("patients", patients);
        model.addAttribute("doctors", doctors);
        model.addAttribute("appointment", new Appointment());
        return "appointments";
    }

    @GetMapping("/check-availability")
    @ResponseBody
    public Map<String, Object> checkTimeSlotAvailability(@RequestParam Long doctorId,
                                                         @RequestParam String dateTime) {
        Map<String, Object> response = new HashMap<>();

        try {
            LocalDateTime appointmentDateTime = LocalDateTime.parse(dateTime);
            boolean isAvailable = appointmentService.isTimeSlotAvailable(doctorId, appointmentDateTime, null);

            response.put("available", isAvailable);
            response.put("doctorId", doctorId);
            response.put("dateTime", dateTime);

        } catch (Exception e) {
            response.put("available", false);
            response.put("error", e.getMessage());
        }

        return response;
    }
    // In AppointmentController.java - add this method
    @GetMapping("/appointments/pending-confirmation/{appointmentId}")
    public String pendingConfirmation(@PathVariable Long appointmentId, HttpSession session, Model model) {
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

        try {
            Appointment appointment = appointmentService.getAppointmentById(appointmentId);

            // Verify appointment belongs to patient
            if (appointment == null || !appointment.getPatient().getId().equals(patientId)) {
                return "redirect:/patient/appointments?error=Appointment not found or access denied";
            }

            // Format appointment date for display
            String formattedDateTime = appointment.getAppointmentDateTime().format(java.time.format.DateTimeFormatter.ofPattern("MMMM dd, yyyy 'at' hh:mm a"));

            model.addAttribute("appointment", appointment);
            model.addAttribute("formattedDateTime", formattedDateTime);
            model.addAttribute("patient", getCurrentPatient(session));
            model.addAttribute("pageTitle", "Appointment Pending Confirmation");

            return "patient/pending-confirmation";

        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/patient/appointments?error=Error loading confirmation";
        }
    }
}