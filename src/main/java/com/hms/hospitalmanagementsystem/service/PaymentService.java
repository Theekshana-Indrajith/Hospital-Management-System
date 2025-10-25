package com.hms.hospitalmanagementsystem.service;

import com.hms.hospitalmanagementsystem.entity.Appointment;
import com.hms.hospitalmanagementsystem.repository.AppointmentRepository;
import com.hms.hospitalmanagementsystem.service.payment.PaymentContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.*;

@Service
public class PaymentService {

    @Autowired
    private AppointmentRepository appointmentRepository;

    @Autowired
    private PaymentContext paymentContext;

    // Service fee calculation
    private Double getServiceFee() {
        return 200.00; // fixed service fee
    }

    /**
     * Process payment using Strategy Pattern
     */
    public Map<String, Object> processPayment(Long appointmentId, String paymentMethod,
                                              Double amount, Map<String, Object> paymentDetails) {
        Map<String, Object> result = new HashMap<>();

        try {
            Appointment appointment = appointmentRepository.findById(appointmentId).orElse(null);
            if (appointment == null) {
                result.put("success", false);
                result.put("message", "Appointment not found");
                return result;
            }

            // Calculate total fee = consultation fee + service fee
            Double serviceFee = getServiceFee();
            Double totalFee = appointment.getConsultationFee() + serviceFee;

            // Validate payment amount
            if (!amount.equals(totalFee)) {
                result.put("success", false);
                result.put("message", String.format("Payment amount (Rs. %.2f) does not match total fee (Rs. %.2f)",
                        amount, totalFee));
                return result;
            }

            // Validate payment method
            if (!isValidPaymentMethod(paymentMethod)) {
                result.put("success", false);
                result.put("message", "Invalid payment method: " + paymentMethod);
                return result;
            }

            // Validate payment details
            if (!paymentContext.validatePaymentDetails(paymentMethod, paymentDetails)) {
                result.put("success", false);
                result.put("message", "Invalid payment details for " + paymentMethod + " payment");
                return result;
            }

            // Process payment using Strategy Pattern
            System.out.println("🎯 Processing " + paymentMethod + " payment for appointment: " + appointmentId);
            Map<String, Object> paymentResult = paymentContext.processPayment(
                    paymentMethod, amount, paymentDetails);

            if ((Boolean) paymentResult.get("success")) {
                // Update appointment with payment details
                appointment.setPaymentStatus("PAID");
                appointment.setPaymentMethod(paymentMethod);
                appointment.setPaymentDate(LocalDateTime.now());
                appointment.setTransactionId((String) paymentResult.get("transactionId"));
                appointment.setStatus("CONFIRMED");

                // Set all fees
                appointment.setServiceFee(serviceFee);
                appointment.setTotalFee(totalFee);

                appointmentRepository.save(appointment);

                result.put("success", true);
                result.put("message", paymentResult.get("message"));
                result.put("appointment", appointment);
                result.put("transactionId", paymentResult.get("transactionId"));
                result.put("paymentMethod", paymentMethod);

                System.out.println("✅ Payment successful - Transaction ID: " + paymentResult.get("transactionId"));
                System.out.println("💰 Fees - Consultation: Rs. " + appointment.getConsultationFee() +
                        ", Service: Rs. " + serviceFee + ", Total: Rs. " + totalFee);
            } else {
                result.put("success", false);
                result.put("message", paymentResult.get("message"));
                System.out.println("❌ Payment failed: " + paymentResult.get("message"));
            }

        } catch (Exception e) {
            System.out.println("❌ Payment processing error: " + e.getMessage());
            result.put("success", false);
            result.put("message", "Error processing payment: " + e.getMessage());
        }

        return result;
    }

    /**
     * Process refund using Strategy Pattern
     */
    public Map<String, Object> processRefund(Long appointmentId) {
        Map<String, Object> result = new HashMap<>();

        try {
            Appointment appointment = appointmentRepository.findById(appointmentId).orElse(null);
            if (appointment == null) {
                result.put("success", false);
                result.put("message", "Appointment not found");
                return result;
            }

            if (!"PAID".equals(appointment.getPaymentStatus())) {
                result.put("success", false);
                result.put("message", "Appointment is not paid, cannot refund");
                return result;
            }

            if (appointment.getTransactionId() == null) {
                result.put("success", false);
                result.put("message", "No transaction ID found for refund");
                return result;
            }

            // Process refund using Strategy Pattern
            System.out.println("🔄 Processing refund for appointment: " + appointmentId);
            Map<String, Object> refundResult = paymentContext.refundPayment(
                    appointment.getPaymentMethod(),
                    appointment.getTransactionId(),
                    appointment.getTotalFee());

            if ((Boolean) refundResult.get("success")) {
                // Update appointment status
                appointment.setPaymentStatus("REFUNDED");
                appointment.setStatus("CANCELLED");
                appointmentRepository.save(appointment);

                result.put("success", true);
                result.put("message", refundResult.get("message"));
                result.put("refundId", refundResult.get("refundId"));

                System.out.println("✅ Refund successful - Refund ID: " + refundResult.get("refundId"));
            } else {
                result.put("success", false);
                result.put("message", refundResult.get("message"));
                System.out.println("❌ Refund failed: " + refundResult.get("message"));
            }

        } catch (Exception e) {
            System.out.println("❌ Refund processing error: " + e.getMessage());
            result.put("success", false);
            result.put("message", "Error processing refund: " + e.getMessage());
        }

        return result;
    }

    /**
     * Get available payment methods from Strategy Pattern
     */
    public Map<String, String> getPaymentMethods() {
        Map<String, String> paymentMethods = new LinkedHashMap<>(); // Maintain order
        String[] availableMethods = paymentContext.getAvailablePaymentMethods();

        for (String method : availableMethods) {
            switch (method) {
                case "CASH":
                    paymentMethods.put("CASH", "💵 Cash Payment");
                    break;
                case "CARD":
                    paymentMethods.put("CARD", "💳 Credit/Debit Card");
                    break;
            }
        }
        return paymentMethods;
    }

    /**
     * Calculate consultation fee based on doctor specialization
     */
    public Double calculateConsultationFee(String specialization) {
        Map<String, Double> feeStructure = new HashMap<>();
        feeStructure.put("CARDIOLOGY", 2500.00);
        feeStructure.put("NEUROLOGY", 2200.00);
        feeStructure.put("ORTHOPEDICS", 1800.00);
        feeStructure.put("PEDIATRICS", 1200.00);
        feeStructure.put("DERMATOLOGY", 1500.00);
        feeStructure.put("GENERAL", 1000.00);
        feeStructure.put("DENTAL", 1300.00);
        feeStructure.put("EYE", 1600.00);
        feeStructure.put("SURGERY", 3000.00);

        return feeStructure.getOrDefault(specialization.toUpperCase(), 1500.00);
    }

    /**
     * Online payment method (for backward compatibility with existing online payment flow)
     */
    public boolean processOnlinePayment(Long appointmentId, String cardNumber, String expiryDate, String cvv) {
        try {
            // Prepare payment details for card strategy
            Map<String, Object> paymentDetails = new HashMap<>();
            paymentDetails.put("cardNumber", cardNumber);
            paymentDetails.put("expiryDate", expiryDate);
            paymentDetails.put("cvv", cvv);
            paymentDetails.put("cardHolderName", "Patient"); // Default value

            // Validate card details
            if (!paymentContext.validatePaymentDetails("CARD", paymentDetails)) {
                System.out.println("❌ Online payment validation failed");
                return false;
            }

            // Get appointment to calculate amount
            Appointment appointment = appointmentRepository.findById(appointmentId).orElse(null);
            if (appointment == null) {
                System.out.println("❌ Appointment not found for online payment");
                return false;
            }

            Double totalAmount = appointment.getConsultationFee() + getServiceFee();

            // Process payment using card strategy
            System.out.println("💳 Processing online payment for appointment: " + appointmentId);
            Map<String, Object> paymentResult = paymentContext.processPayment(
                    "CARD", totalAmount, paymentDetails);

            boolean success = (Boolean) paymentResult.get("success");

            if (success) {
                // Update appointment
                appointment.setPaymentStatus("PAID");
                appointment.setPaymentMethod("CARD");
                appointment.setPaymentDate(LocalDateTime.now());
                appointment.setTransactionId((String) paymentResult.get("transactionId"));
                appointment.setStatus("PENDING_DOCTOR"); // Online payments need doctor confirmation
                appointment.setServiceFee(getServiceFee());
                appointment.setTotalFee(totalAmount);

                appointmentRepository.save(appointment);
                System.out.println("✅ Online payment successful");
            } else {
                System.out.println("❌ Online payment failed: " + paymentResult.get("message"));
            }

            return success;

        } catch (Exception e) {
            System.out.println("❌ Online payment processing error: " + e.getMessage());
            return false;
        }
    }

    /**
     * Validate payment method
     */
    private boolean isValidPaymentMethod(String paymentMethod) {
        try {
            paymentContext.getStrategy(paymentMethod);
            return true;
        } catch (IllegalArgumentException e) {
            return false;
        }
    }

    /**
     * Get payment statistics
     */
    public Map<String, Object> getPaymentStatistics() {
        Map<String, Object> stats = new HashMap<>();

        try {
            List<Appointment> allAppointments = appointmentRepository.findAll();

            double totalRevenue = allAppointments.stream()
                    .filter(app -> "PAID".equals(app.getPaymentStatus()) && app.getTotalFee() != null)
                    .mapToDouble(Appointment::getTotalFee)
                    .sum();

            long totalAppointments = allAppointments.size();
            long paidAppointments = allAppointments.stream()
                    .filter(app -> "PAID".equals(app.getPaymentStatus()))
                    .count();

            long cashPayments = allAppointments.stream()
                    .filter(app -> "PAID".equals(app.getPaymentStatus()) && "CASH".equals(app.getPaymentMethod()))
                    .count();

            long cardPayments = allAppointments.stream()
                    .filter(app -> "PAID".equals(app.getPaymentStatus()) && "CARD".equals(app.getPaymentMethod()))
                    .count();

            stats.put("totalRevenue", totalRevenue);
            stats.put("totalAppointments", totalAppointments);
            stats.put("paidAppointments", paidAppointments);
            stats.put("cashPayments", cashPayments);
            stats.put("cardPayments", cardPayments);
            stats.put("pendingPayments", totalAppointments - paidAppointments);

        } catch (Exception e) {
            System.out.println("❌ Error calculating payment statistics: " + e.getMessage());
        }

        return stats;
    }

    /**
     * Get payments by patient ID
     */
    public List<Appointment> getPaymentsByPatientId(Long patientId) {
        return appointmentRepository.findByPatientIdAndPaymentStatus(patientId, "PAID");
    }

    /**
     * Get all paid appointments
     */
    public List<Appointment> getAllPaidAppointments() {
        return appointmentRepository.findByPaymentStatus("PAID");
    }
}