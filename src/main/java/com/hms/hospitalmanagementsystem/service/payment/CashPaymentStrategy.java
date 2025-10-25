package com.hms.hospitalmanagementsystem.service.payment;

import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

@Component
public class CashPaymentStrategy implements PaymentStrategy {

    @Override
    public Map<String, Object> processPayment(Double amount, Map<String, Object> paymentDetails) {
        Map<String, Object> result = new HashMap<>();

        try {
            System.out.println("💵 Processing cash payment of Rs. " + amount);

            // Validate payment details
            if (!validatePaymentDetails(paymentDetails)) {
                result.put("success", false);
                result.put("message", "Invalid cash payment details");
                return result;
            }

            String receivedBy = (String) paymentDetails.get("receivedBy");
            String receiptNumber = (String) paymentDetails.get("receiptNumber");

            // Generate transaction ID
            String transactionId = "CASH-" + System.currentTimeMillis();

            // Simulate cash payment processing
            System.out.println("✅ Cash payment received by: " + receivedBy);
            System.out.println("💰 Amount: Rs. " + amount);
            if (receiptNumber != null) {
                System.out.println("🧾 Receipt Number: " + receiptNumber);
            }

            result.put("success", true);
            result.put("message", "Cash payment processed successfully");
            result.put("transactionId", transactionId);
            result.put("status", "COMPLETED");
            result.put("processedBy", receivedBy);

        } catch (Exception e) {
            System.out.println("❌ Cash payment failed: " + e.getMessage());
            result.put("success", false);
            result.put("message", "Cash payment failed: " + e.getMessage());
        }

        return result;
    }

    @Override
    public boolean validatePaymentDetails(Map<String, Object> paymentDetails) {
        if (paymentDetails == null) {
            return false;
        }

        String receivedBy = (String) paymentDetails.get("receivedBy");
        return receivedBy != null && !receivedBy.trim().isEmpty();
    }

    @Override
    public String getPaymentMethodType() {
        return "CASH";
    }

    @Override
    public Map<String, Object> refundPayment(String transactionId, Double amount) {
        Map<String, Object> result = new HashMap<>();

        System.out.println("💵 Processing cash refund for transaction: " + transactionId);
        System.out.println("💰 Refund amount: Rs. " + amount);

        // For cash payments, refund would typically be processed manually
        String refundId = transactionId + "-REFUND";

        result.put("success", true);
        result.put("message", "Cash refund initiated - please process manually at counter");
        result.put("refundId", refundId);
        result.put("status", "REFUND_INITIATED");

        return result;
    }
}