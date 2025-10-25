package com.hms.hospitalmanagementsystem.controller;

import com.hms.hospitalmanagementsystem.entity.Patient;
import com.hms.hospitalmanagementsystem.entity.User;
import com.hms.hospitalmanagementsystem.service.PatientService;
import com.hms.hospitalmanagementsystem.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class RegistrationController {

    @Autowired
    private UserService userService;

    @Autowired
    private PatientService patientService;

    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(@RequestParam String firstName,
                               @RequestParam String lastName,
                               @RequestParam String username,
                               @RequestParam String email,
                               @RequestParam String password,
                               @RequestParam String confirmPassword,
                               Model model) {

        System.out.println("DEBUG: Registration attempt for: " + username);

        // Validation
        if (firstName == null || firstName.trim().isEmpty()) {
            model.addAttribute("error", "First name is required!");
            model.addAttribute("firstName", firstName);
            model.addAttribute("lastName", lastName);
            model.addAttribute("username", username);
            model.addAttribute("email", email);
            return "register";
        }

        if (lastName == null || lastName.trim().isEmpty()) {
            model.addAttribute("error", "Last name is required!");
            model.addAttribute("firstName", firstName);
            model.addAttribute("lastName", lastName);
            model.addAttribute("username", username);
            model.addAttribute("email", email);
            return "register";
        }

        // Validate first name and last name (no digits allowed)
        if (!firstName.matches("^[a-zA-Z\\s]+$")) {
            model.addAttribute("error", "First name can only contain letters and spaces!");
            model.addAttribute("firstName", firstName);
            model.addAttribute("lastName", lastName);
            model.addAttribute("username", username);
            model.addAttribute("email", email);
            return "register";
        }

        if (!lastName.matches("^[a-zA-Z\\s]+$")) {
            model.addAttribute("error", "Last name can only contain letters and spaces!");
            model.addAttribute("firstName", firstName);
            model.addAttribute("lastName", lastName);
            model.addAttribute("username", username);
            model.addAttribute("email", email);
            return "register";
        }

        // Validate username (no digits and no spaces)
        if (!username.matches("^[a-zA-Z]+$")) {
            model.addAttribute("error", "Username can only contain letters (no digits or spaces)!");
            model.addAttribute("firstName", firstName);
            model.addAttribute("lastName", lastName);
            model.addAttribute("username", username);
            model.addAttribute("email", email);
            return "register";
        }

        if (userService.usernameExists(username)) {
            model.addAttribute("error", "Username already exists!");
            model.addAttribute("firstName", firstName);
            model.addAttribute("lastName", lastName);
            model.addAttribute("username", username);
            model.addAttribute("email", email);
            return "register";
        }

        if (userService.emailExists(email)) {
            model.addAttribute("error", "Email already registered!");
            model.addAttribute("firstName", firstName);
            model.addAttribute("lastName", lastName);
            model.addAttribute("username", username);
            model.addAttribute("email", email);
            return "register";
        }

        if (!password.equals(confirmPassword)) {
            model.addAttribute("error", "Passwords do not match!");
            model.addAttribute("firstName", firstName);
            model.addAttribute("lastName", lastName);
            model.addAttribute("username", username);
            model.addAttribute("email", email);
            return "register";
        }

        if (password.length() < 6) {
            model.addAttribute("error", "Password must be at least 6 characters long!");
            model.addAttribute("firstName", firstName);
            model.addAttribute("lastName", lastName);
            model.addAttribute("username", username);
            model.addAttribute("email", email);
            return "register";
        }

        try {
            // Create patient profile with proper details
            Patient patient = new Patient();
            patient.setFirstName(firstName.trim());
            patient.setLastName(lastName.trim());
            patient.setEmail(email);
            Patient savedPatient = patientService.savePatient(patient);

            // Create user account - Force PATIENT role for registrations
            User user = new User();
            user.setUsername(username.trim());
            user.setPassword(password); // Will be encoded in service
            user.setEmail(email.trim());
            user.setRole("PATIENT"); // Always PATIENT for registrations
            user.setProfileId(savedPatient.getId()); // Link to patient ID

            userService.registerUser(user);

            System.out.println("DEBUG: Registration successful for: " + username);
            System.out.println("DEBUG: Patient created - Name: " + firstName + " " + lastName);
            System.out.println("DEBUG: Patient ID created: " + savedPatient.getId());
            System.out.println("DEBUG: User profile ID set to: " + user.getProfileId());

            return "redirect:/login?success=true";

        } catch (Exception e) {
            System.out.println("DEBUG: Registration failed: " + e.getMessage());
            model.addAttribute("error", "Registration failed: " + e.getMessage());
            model.addAttribute("firstName", firstName);
            model.addAttribute("lastName", lastName);
            model.addAttribute("username", username);
            model.addAttribute("email", email);
            return "register";
        }
    }
}