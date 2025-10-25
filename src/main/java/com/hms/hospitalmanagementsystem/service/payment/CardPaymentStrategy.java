package com.hms.hospitalmanagementsystem.service.payment;

import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@Component
public class CardPaymentStrategy implements PaymentStrategy {

    @Override
    public Map<String, Object> processPayment(Double amount, Map<String, Object> paymentDetails) {
        Map<String, Object> result = new HashMap<>();

        try {
            System.out.println("💳 Processing card payment of Rs. " + amount);

            // Validate payment details
            if (!validatePaymentDetails(paymentDetails)) {
                result.put("success", false);
                result.put("message", "Invalid card payment details");
                return result;
            }

            String cardNumber = (String) paymentDetails.get("cardNumber");
            String expiryDate = (String) paymentDetails.get("expiryDate");
            String cvv = (String) paymentDetails.get("cvv");
            String cardHolderName = (String) paymentDetails.get("cardHolderName");

            // Simulate card payment gateway integration
            System.out.println("🔗 Connecting to payment gateway...");
            System.out.println("💳 Card: **** **** **** " + getLastFourDigits(cardNumber));
            System.out.println("👤 Card Holder: " + cardHolderName);

            // Simple 16-digit card number validation
            if (cardNumber.length() != 16 || !cardNumber.matches("\\d+")) {
                result.put("success", false);
                result.put("message", "Card number must be exactly 16 digits");
                return result;
            }

            // Check if card is expired
            if (isCardExpired(expiryDate)) {
                result.put("success", false);
                result.put("message", "Card is expired");
                return result;
            }

            // CVV validation
            if (cvv == null || cvv.length() != 3 || !cvv.matches("\\d+")) {
                result.put("success", false);
                result.put("message", "Invalid CVV");
                return result;
            }

            // Simulate payment processing with 95% success rate
            Random random = new Random();
            boolean paymentSuccess = random.nextDouble() > 0.05; // 95% success rate

            if (paymentSuccess) {
                String transactionId = "CARD-" + System.currentTimeMillis();

                System.out.println("✅ Card payment processed successfully");
                System.out.println("📦 Transaction ID: " + transactionId);

                result.put("success", true);
                result.put("message", "Card payment processed successfully");
                result.put("transactionId", transactionId);
                result.put("status", "COMPLETED");
                result.put("lastFourDigits", getLastFourDigits(cardNumber));
            } else {
                System.out.println("❌ Card payment declined by bank");
                result.put("success", false);
                result.put("message", "Payment declined by bank. Please try another card.");
            }

        } catch (Exception e) {
            System.out.println("❌ Card payment failed: " + e.getMessage());
            result.put("success", false);
            result.put("message", "Card payment failed: " + e.getMessage());
        }

        return result;
    }

    @Override
    public boolean validatePaymentDetails(Map<String, Object> paymentDetails) {
        if (paymentDetails == null) {
            return false;
        }

        String cardNumber = (String) paymentDetails.get("cardNumber");
        String expiryDate = (String) paymentDetails.get("expiryDate");
        String cvv = (String) paymentDetails.get("cvv");
        String cardHolderName = (String) paymentDetails.get("cardHolderName");

        return cardNumber != null && cardNumber.length() == 16 && cardNumber.matches("\\d+") &&
                expiryDate != null && expiryDate.matches("\\d{2}/\\d{2}") &&
                cvv != null && cvv.length() == 3 && cvv.matches("\\d+") &&
                cardHolderName != null && !cardHolderName.trim().isEmpty();
    }

    @Override
    public String getPaymentMethodType() {
        return "CARD";
    }

    @Override
    public Map<String, Object> refundPayment(String transactionId, Double amount) {
        Map<String, Object> result = new HashMap<>();

        System.out.println("💳 Processing card refund for transaction: " + transactionId);
        System.out.println("💰 Refund amount: Rs. " + amount);
        System.out.println("🔗 Connecting to payment gateway for refund...");

        String refundTransactionId = transactionId + "-REFUND";

        // Simulate refund processing
        System.out.println("✅ Card refund processed successfully");
        System.out.println("📦 Refund Transaction ID: " + refundTransactionId);

        result.put("success", true);
        result.put("message", "Card refund processed successfully");
        result.put("refundId", refundTransactionId);
        result.put("status", "REFUNDED");

        return result;
    }

    // Helper methods
    private String getLastFourDigits(String cardNumber) {
        if (cardNumber != null && cardNumber.length() >= 4) {
            return cardNumber.substring(cardNumber.length() - 4);
        }
        return null;
    }

    private boolean isCardExpired(String expiryDate) {
        try {
            String[] parts = expiryDate.split("/");
            int month = Integer.parseInt(parts[0]);
            int year = Integer.parseInt(parts[1]) + 2000; // Assuming XX format for year

            LocalDate expiry = LocalDate.of(year, month, 1).plusMonths(1).minusDays(1);
            return expiry.isBefore(LocalDate.now());
        } catch (Exception e) {
            return true; // If we can't parse, consider expired
        }
    }
}