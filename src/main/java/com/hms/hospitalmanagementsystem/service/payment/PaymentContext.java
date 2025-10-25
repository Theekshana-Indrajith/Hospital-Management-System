package com.hms.hospitalmanagementsystem.service.payment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

@Component
public class PaymentContext {

    private final Map<String, PaymentStrategy> strategies = new HashMap<>();

    @Autowired
    public PaymentContext(CashPaymentStrategy cashStrategy,
                          CardPaymentStrategy cardStrategy) {
        strategies.put("CASH", cashStrategy);
        strategies.put("CARD", cardStrategy);
    }

    /**
     * Get the payment strategy based on payment method
     * @param paymentMethod The payment method (CASH, CARD)
     * @return The appropriate payment strategy
     */
    public PaymentStrategy getStrategy(String paymentMethod) {
        PaymentStrategy strategy = strategies.get(paymentMethod.toUpperCase());
        if (strategy == null) {
            throw new IllegalArgumentException("No payment strategy found for: " + paymentMethod);
        }
        return strategy;
    }

    /**
     * Process payment using the appropriate strategy
     * @param paymentMethod The payment method
     * @param amount Payment amount
     * @param paymentDetails Payment-specific details
     * @return Payment result
     */
    public Map<String, Object> processPayment(String paymentMethod,
                                              Double amount,
                                              Map<String, Object> paymentDetails) {
        PaymentStrategy strategy = getStrategy(paymentMethod);
        return strategy.processPayment(amount, paymentDetails);
    }

    /**
     * Validate payment details for the given payment method
     * @param paymentMethod The payment method
     * @param paymentDetails Payment-specific details
     * @return Validation result
     */
    public boolean validatePaymentDetails(String paymentMethod, Map<String, Object> paymentDetails) {
        PaymentStrategy strategy = getStrategy(paymentMethod);
        return strategy.validatePaymentDetails(paymentDetails);
    }

    /**
     * Refund a payment using the appropriate strategy
     * @param paymentMethod Original payment method
     * @param transactionId Original transaction ID
     * @param amount Amount to refund
     * @return Refund result
     */
    public Map<String, Object> refundPayment(String paymentMethod, String transactionId, Double amount) {
        PaymentStrategy strategy = getStrategy(paymentMethod);
        return strategy.refundPayment(transactionId, amount);
    }

    /**
     * Get all available payment methods
     * @return Array of available payment methods
     */
    public String[] getAvailablePaymentMethods() {
        return strategies.keySet().toArray(new String[0]);
    }
}