package com.hms.hospitalmanagementsystem.controller;

import com.hms.hospitalmanagementsystem.entity.Appointment;
import com.hms.hospitalmanagementsystem.entity.User;
import com.hms.hospitalmanagementsystem.service.PDFService;
import com.hms.hospitalmanagementsystem.service.PaymentService;
import com.hms.hospitalmanagementsystem.service.AppointmentService;
import com.hms.hospitalmanagementsystem.service.UserService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.OutputStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/payments")
public class PaymentController {

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private AppointmentService appointmentService;

    @Autowired
    private PDFService pdfService;

    @Autowired
    private UserService userService;

    // Helper method to get current patient ID from logged-in user
    private Long getCurrentPatientId(HttpSession session) {
        String username = (String) session.getAttribute("username");
        if (username == null) return null;

        try {
            User user = userService.findByUsername(username).orElse(null);
            if (user != null && "PATIENT".equals(user.getRole())) {
                return user.getProfileId();
            }
        } catch (Exception e) {
            System.out.println("❌ Error getting patient ID: " + e.getMessage());
        }
        return null;
    }

    /**
     * Show payment form for appointment
     */
    @GetMapping("/appointment/{appointmentId}")
    public String showPaymentForm(@PathVariable Long appointmentId, HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        if (username == null) {
            return "redirect:/login";
        }

        System.out.println("DEBUG: Loading payment form for appointment: " + appointmentId);

        try {
            Appointment appointment = appointmentService.getAppointmentById(appointmentId);
            if (appointment == null) {
                System.out.println("DEBUG: Appointment not found: " + appointmentId);
                return "redirect:/appointments/my-appointments?error=Appointment not found";
            }

            // Verify appointment belongs to logged-in patient
            Long patientId = getCurrentPatientId(session);
            if (patientId == null || !appointment.getPatient().getId().equals(patientId)) {
                return "redirect:/access-denied";
            }

            // Check if already paid
            if ("PAID".equals(appointment.getPaymentStatus())) {
                return "redirect:/payments/success?appointmentId=" + appointmentId;
            }

            System.out.println("DEBUG: Appointment found - Patient: " + appointment.getPatient().getFirstName() +
                    ", Doctor: " + appointment.getDoctor().getName() +
                    ", Fee: Rs. " + appointment.getConsultationFee());

            model.addAttribute("appointment", appointment);
            model.addAttribute("paymentMethods", paymentService.getPaymentMethods());
            model.addAttribute("username", username);
            model.addAttribute("role", session.getAttribute("role"));
            model.addAttribute("serviceFee", 200.00); // Show service fee
            model.addAttribute("totalFee", appointment.getConsultationFee() + 200.00);

            return "payments/payment-form";

        } catch (Exception e) {
            System.out.println("DEBUG: Error loading payment form: " + e.getMessage());
            e.printStackTrace();
            return "redirect:/appointments/my-appointments?error=Error loading payment form";
        }
    }

    /**
     * Process payment using Strategy Pattern
     */
    @PostMapping("/process")
    public String processPayment(@RequestParam Long appointmentId,
                                 @RequestParam String paymentMethod,
                                 @RequestParam Double amount,
                                 @RequestParam(required = false) String receivedBy,
                                 @RequestParam(required = false) String cardNumber,
                                 @RequestParam(required = false) String cardHolder,
                                 @RequestParam(required = false) String expiryDate,
                                 @RequestParam(required = false) String cvv,
                                 HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        if (username == null) {
            return "redirect:/login";
        }

        System.out.println("DEBUG: Processing " + paymentMethod + " payment for appointment: " + appointmentId);
        System.out.println("DEBUG: Amount: Rs. " + amount);

        try {
            // Prepare payment details based on payment method
            Map<String, Object> paymentDetails = new HashMap<>();

            if ("CASH".equals(paymentMethod)) {
                paymentDetails.put("receivedBy", receivedBy != null ? receivedBy : username);
                System.out.println("DEBUG: Cash payment - Received by: " + paymentDetails.get("receivedBy"));
            } else if ("CARD".equals(paymentMethod)) {
                paymentDetails.put("cardNumber", cardNumber);
                paymentDetails.put("cardHolderName", cardHolder);
                paymentDetails.put("expiryDate", expiryDate);
                paymentDetails.put("cvv", cvv);
                System.out.println("DEBUG: Card payment - Card: **** **** **** " +
                        (cardNumber != null && cardNumber.length() >= 4 ? cardNumber.substring(cardNumber.length() - 4) : ""));
            }

            Map<String, Object> paymentResult = paymentService.processPayment(
                    appointmentId, paymentMethod, amount, paymentDetails);

            if ((Boolean) paymentResult.get("success")) {
                System.out.println("DEBUG: Payment successful for appointment: " + appointmentId);
                return "redirect:/payments/success?appointmentId=" + appointmentId;
            } else {
                System.out.println("DEBUG: Payment failed: " + paymentResult.get("message"));
                model.addAttribute("error", paymentResult.get("message"));

                // Reload appointment and form data
                Appointment appointment = appointmentService.getAppointmentById(appointmentId);
                model.addAttribute("appointment", appointment);
                model.addAttribute("paymentMethods", paymentService.getPaymentMethods());
                model.addAttribute("username", username);
                model.addAttribute("role", session.getAttribute("role"));
                model.addAttribute("serviceFee", 200.00);
                model.addAttribute("totalFee", appointment.getConsultationFee() + 200.00);

                // Preserve form data
                model.addAttribute("paymentMethod", paymentMethod);
                model.addAttribute("receivedBy", receivedBy);
                model.addAttribute("cardNumber", cardNumber);
                model.addAttribute("cardHolder", cardHolder);
                model.addAttribute("expiryDate", expiryDate);

                return "payments/payment-form";
            }
        } catch (Exception e) {
            System.out.println("DEBUG: Payment processing error: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Payment processing failed: " + e.getMessage());

            // Reload form on error
            Appointment appointment = appointmentService.getAppointmentById(appointmentId);
            model.addAttribute("appointment", appointment);
            model.addAttribute("paymentMethods", paymentService.getPaymentMethods());
            return "payments/payment-form";
        }
    }

    /**
     * Payment success page
     */
    @GetMapping("/success")
    public String paymentSuccess(@RequestParam Long appointmentId, HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        if (username == null) {
            return "redirect:/login";
        }

        System.out.println("DEBUG: Loading success page for appointment: " + appointmentId);

        try {
            Appointment appointment = appointmentService.getAppointmentById(appointmentId);
            if (appointment == null) {
                System.out.println("DEBUG: Appointment not found for success: " + appointmentId);
                return "redirect:/appointments/my-appointments?error=Appointment not found";
            }

            System.out.println("DEBUG: Success page - Appointment status: " + appointment.getStatus() +
                    ", Payment status: " + appointment.getPaymentStatus());

            // Format dates
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd, yyyy 'at' hh:mm a");
            String paymentDate = appointment.getPaymentDate() != null ?
                    appointment.getPaymentDate().format(formatter) : "N/A";

            model.addAttribute("appointment", appointment);
            model.addAttribute("username", username);
            model.addAttribute("role", session.getAttribute("role"));
            model.addAttribute("paymentDate", paymentDate);
            model.addAttribute("transactionId", appointment.getTransactionId());

            return "payments/payment-success";

        } catch (Exception e) {
            System.out.println("DEBUG: Error loading success page: " + e.getMessage());
            e.printStackTrace();
            return "redirect:/appointments/my-appointments?error=Error loading confirmation";
        }
    }

    /**
     * Process refund
     */
    @PostMapping("/{appointmentId}/refund")
    public String refundPayment(@PathVariable Long appointmentId, HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"ADMIN".equals(role)) {
            return "redirect:/access-denied";
        }

        try {
            Map<String, Object> refundResult = paymentService.processRefund(appointmentId);

            if ((Boolean) refundResult.get("success")) {
                model.addAttribute("success", refundResult.get("message"));
            } else {
                model.addAttribute("error", refundResult.get("message"));
            }

            return "redirect:/admin/appointments?refunded=true";

        } catch (Exception e) {
            model.addAttribute("error", "Refund processing failed: " + e.getMessage());
            return "redirect:/admin/appointments?error=Refund failed";
        }
    }

    /**
     * Payment statistics (for admin)
     */
    @GetMapping("/statistics")
    public String paymentStatistics(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"ADMIN".equals(role)) {
            return "redirect:/access-denied";
        }

        try {
            Map<String, Object> stats = paymentService.getPaymentStatistics();

            model.addAttribute("totalRevenue", stats.get("totalRevenue"));
            model.addAttribute("totalAppointments", stats.get("totalAppointments"));
            model.addAttribute("paidAppointments", stats.get("paidAppointments"));
            model.addAttribute("cashPayments", stats.get("cashPayments"));
            model.addAttribute("cardPayments", stats.get("cardPayments"));
            model.addAttribute("pendingPayments", stats.get("pendingPayments"));
            model.addAttribute("username", username);
            model.addAttribute("role", role);

        } catch (Exception e) {
            System.out.println("DEBUG: Error loading statistics: " + e.getMessage());
            model.addAttribute("error", "Error loading payment statistics");
        }

        return "payments/statistics";
    }

    /**
     * Online payment gateway (for backward compatibility)
     */
    @GetMapping("/online/{appointmentId}")
    public String onlinePayment(@PathVariable Long appointmentId, HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        if (username == null) {
            return "redirect:/login";
        }

        try {
            Appointment appointment = appointmentService.getAppointmentById(appointmentId);
            if (appointment == null) {
                return "redirect:/patient/appointments?error=Appointment not found";
            }

            // Verify that the appointment belongs to the logged-in patient
            Long patientId = getCurrentPatientId(session);
            if (patientId == null || !appointment.getPatient().getId().equals(patientId)) {
                return "redirect:/access-denied";
            }

            // Format dates as strings
            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("MMM dd, yyyy HH:mm");
            DateTimeFormatter dateOnlyFormatter = DateTimeFormatter.ofPattern("EEEE, MMMM dd, yyyy");
            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("hh:mm a");

            String formattedAppointmentDateTime = "Not set";
            String formattedAppointmentDate = "Not set";
            String formattedAppointmentTime = "Not set";

            if (appointment.getAppointmentDateTime() != null) {
                formattedAppointmentDateTime = appointment.getAppointmentDateTime().format(dateFormatter);
                formattedAppointmentDate = appointment.getAppointmentDateTime().format(dateOnlyFormatter);
                formattedAppointmentTime = appointment.getAppointmentDateTime().format(timeFormatter);
            }

            Double totalFee = appointment.getConsultationFee() + 200.00; // consultation + service fee

            model.addAttribute("appointment", appointment);
            model.addAttribute("formattedAppointmentDateTime", formattedAppointmentDateTime);
            model.addAttribute("formattedAppointmentDate", formattedAppointmentDate);
            model.addAttribute("formattedAppointmentTime", formattedAppointmentTime);
            model.addAttribute("username", username);
            model.addAttribute("serviceFee", 200.00);
            model.addAttribute("totalFee", totalFee);

            return "payments/online-payment-gateway";

        } catch (Exception e) {
            System.out.println("DEBUG: Error loading payment gateway: " + e.getMessage());
            e.printStackTrace();
            return "redirect:/patient/appointments?error=Error loading payment gateway";
        }
    }

    /**
     * Process online payment (for backward compatibility)
     */
    @PostMapping("/process-online")
    public String processOnlinePayment(@RequestParam Long appointmentId,
                                       @RequestParam String cardNumber,
                                       @RequestParam String cardHolder,
                                       @RequestParam String expiryDate,
                                       @RequestParam String cvv,
                                       HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        if (username == null) {
            return "redirect:/login";
        }

        try {
            boolean paymentSuccess = paymentService.processOnlinePayment(appointmentId, cardNumber, expiryDate, cvv);

            if (paymentSuccess) {
                System.out.println("DEBUG: Online payment successful for appointment: " + appointmentId);
                return "redirect:/payments/online-success?appointmentId=" + appointmentId;
            } else {
                model.addAttribute("error", "Payment failed. Please try again or use a different card.");

                // Reload appointment data
                Appointment appointment = appointmentService.getAppointmentById(appointmentId);
                Double totalFee = appointment.getConsultationFee() + 200.00;

                model.addAttribute("appointment", appointment);
                model.addAttribute("serviceFee", 200.00);
                model.addAttribute("totalFee", totalFee);
                model.addAttribute("username", username);

                return "payments/online-payment-gateway";
            }

        } catch (Exception e) {
            model.addAttribute("error", "Payment processing error: " + e.getMessage());

            // Reload appointment data on error
            Appointment appointment = appointmentService.getAppointmentById(appointmentId);
            Double totalFee = appointment.getConsultationFee() + 200.00;

            model.addAttribute("appointment", appointment);
            model.addAttribute("serviceFee", 200.00);
            model.addAttribute("totalFee", totalFee);
            model.addAttribute("username", username);

            return "payments/online-payment-gateway";
        }
    }

    /**
     * Online payment success page
     */
    @GetMapping("/online-success")
    public String onlinePaymentSuccess(@RequestParam Long appointmentId, HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        if (username == null) {
            return "redirect:/login";
        }

        try {
            Appointment appointment = appointmentService.getAppointmentById(appointmentId);
            if (appointment == null) {
                return "redirect:/appointments/my-appointments?error=Appointment not found";
            }

            // Format dates as strings for success page
            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("MMM dd, yyyy HH:mm");
            DateTimeFormatter dateOnlyFormatter = DateTimeFormatter.ofPattern("EEEE, MMMM dd, yyyy");
            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("hh:mm a");

            String formattedAppointmentDateTime = appointment.getAppointmentDateTime().format(dateFormatter);
            String formattedAppointmentDate = appointment.getAppointmentDateTime().format(dateOnlyFormatter);
            String formattedAppointmentTime = appointment.getAppointmentDateTime().format(timeFormatter);

            String formattedPaymentDate = appointment.getPaymentDate() != null ?
                    appointment.getPaymentDate().format(dateFormatter) : "N/A";

            model.addAttribute("appointment", appointment);
            model.addAttribute("formattedAppointmentDateTime", formattedAppointmentDateTime);
            model.addAttribute("formattedAppointmentDate", formattedAppointmentDate);
            model.addAttribute("formattedAppointmentTime", formattedAppointmentTime);
            model.addAttribute("formattedPaymentDate", formattedPaymentDate);
            model.addAttribute("username", username);
            model.addAttribute("transactionId", appointment.getTransactionId());

            return "payments/online-payment-success";

        } catch (Exception e) {
            return "redirect:/appointments/my-appointments?error=Error loading confirmation";
        }
    }

    /**
     * Download receipt as PDF
     */
    @GetMapping("/download-receipt/{appointmentId}")
    public void downloadReceipt(@PathVariable Long appointmentId, HttpServletResponse response) {
        try {
            Appointment appointment = appointmentService.getAppointmentById(appointmentId);
            if (appointment == null) {
                response.sendRedirect("/appointments/my-appointments?error=Appointment not found");
                return;
            }

            // Generate PDF bytes
            byte[] pdfBytes = pdfService.generateReceiptPDF(appointment);

            // Set response headers for PDF download
            response.setContentType("application/pdf");
            response.setHeader(HttpHeaders.CONTENT_DISPOSITION,
                    "attachment; filename=\"payment-receipt-" + appointmentId + ".pdf\"");
            response.setContentLength(pdfBytes.length);

            // Write PDF to response
            try (OutputStream os = response.getOutputStream()) {
                os.write(pdfBytes);
                os.flush();
            }

            System.out.println("DEBUG: PDF receipt generated successfully for appointment: " + appointmentId);

        } catch (Exception e) {
            System.out.println("DEBUG: Error generating PDF receipt: " + e.getMessage());
            try {
                response.sendRedirect("/payments/online-success?appointmentId=" + appointmentId + "&error=Error generating receipt");
            } catch (Exception ex) {
                System.out.println("DEBUG: Redirect failed: " + ex.getMessage());
            }
        }
    }

    /**
     * Debug endpoint for appointment details
     */
    @GetMapping("/debug/appointment/{appointmentId}")
    @ResponseBody
    public String debugAppointment(@PathVariable Long appointmentId) {
        StringBuilder sb = new StringBuilder();
        sb.append("=== DEBUG APPOINTMENT ===\n");

        Appointment appointment = appointmentService.getAppointmentById(appointmentId);
        if (appointment != null) {
            sb.append("ID: ").append(appointment.getId()).append("\n");
            sb.append("Patient: ").append(appointment.getPatient().getFirstName()).append(" ").append(appointment.getPatient().getLastName()).append("\n");
            sb.append("Doctor: ").append(appointment.getDoctor().getName()).append("\n");
            sb.append("Consultation Fee: Rs. ").append(appointment.getConsultationFee()).append("\n");
            sb.append("Service Fee: Rs. ").append(appointment.getServiceFee()).append("\n");
            sb.append("Total Fee: Rs. ").append(appointment.getTotalFee()).append("\n");
            sb.append("Status: ").append(appointment.getStatus()).append("\n");
            sb.append("Payment Status: ").append(appointment.getPaymentStatus()).append("\n");
            sb.append("Payment Method: ").append(appointment.getPaymentMethod()).append("\n");
            sb.append("Transaction ID: ").append(appointment.getTransactionId()).append("\n");
        } else {
            sb.append("Appointment not found: ").append(appointmentId);
        }

        return sb.toString();
    }
}