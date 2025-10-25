package com.hms.hospitalmanagementsystem.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/contact")
public class ContactController {

    @GetMapping
    public String contactPage() {
        return "contact"; // This will resolve to contact.jsp
    }

    @PostMapping("/submit")
    public String handleContactForm(
            @RequestParam String firstName,
            @RequestParam String lastName,
            @RequestParam String email,
            @RequestParam String phone,
            @RequestParam String subject,
            @RequestParam String message) {

        // Process the contact form submission
        // You can save to database, send email, etc.
        System.out.println("Contact form submitted:");
        System.out.println("Name: " + firstName + " " + lastName);
        System.out.println("Email: " + email);
        System.out.println("Phone: " + phone);
        System.out.println("Subject: " + subject);
        System.out.println("Message: " + message);

        // Redirect to a thank you page or back to contact with success message
        return "redirect:/contact?success=true";
    }
}