package com.hms.hospitalmanagementsystem.service.payment;

import java.util.Map;

public interface PaymentStrategy {

    /**
     * Process payment with the specific strategy
     * @param amount Payment amount
     * @param paymentDetails Additional details required for payment processing
     * @return Payment result with status and transaction details
     */
    Map<String, Object> processPayment(Double amount, Map<String, Object> paymentDetails);

    /**
     * Validate payment details before processing
     * @param paymentDetails Payment-specific details
     * @return Validation result
     */
    boolean validatePaymentDetails(Map<String, Object> paymentDetails);

    /**
     * Get the payment method type this strategy handles
     * @return Payment method type
     */
    String getPaymentMethodType();

    /**
     * Refund a payment
     * @param transactionId Original transaction ID
     * @param amount Amount to refund
     * @return Refund result
     */
    Map<String, Object> refundPayment(String transactionId, Double amount);
}