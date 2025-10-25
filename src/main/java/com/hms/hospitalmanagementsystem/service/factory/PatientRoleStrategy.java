package com.hms.hospitalmanagementsystem.service.factory;

import com.hms.hospitalmanagementsystem.entity.User;
import com.hms.hospitalmanagementsystem.entity.Patient;
import com.hms.hospitalmanagementsystem.repository.PatientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.util.Optional;

@Component
public class PatientRoleStrategy implements UserRoleStrategy {

    @Autowired
    private PatientRepository patientRepository;

    @Override
    public String getDashboardUrl(User user) {
        return "/patient/dashboard";
    }

    @Override
    public String getWelcomeMessage(User user) {
        // ✅ UPDATED: Use profileId to find patient
        if (user.getProfileId() != null) {
            Optional<Patient> patientOpt = patientRepository.findByProfileId(user.getProfileId());
            if (patientOpt.isPresent()) {
                Patient patient = patientOpt.get();
                return "Welcome " + patient.getFirstName() + " " + patient.getLastName() + " to Patient Portal";
            }
        }
        return "Welcome Patient " + user.getUsername() + " to Patient Portal";
    }

    @Override
    public void performRoleSpecificActions(User user) {
        // ✅ UPDATED: Use profileId to find patient
        Optional<Patient> patientOpt = Optional.empty();
        if (user.getProfileId() != null) {
            patientOpt = patientRepository.findByProfileId(user.getProfileId());
        }

        System.out.println("👤 Patient Actions for: " + user.getUsername());
        System.out.println("   - Booking appointments");
        System.out.println("   - Viewing medical history");
        System.out.println("   - Making payments");

        if (patientOpt.isPresent()) {
            Patient patient = patientOpt.get();
            System.out.println("   - Name: " + patient.getFirstName() + " " + patient.getLastName());
            System.out.println("   - Contact: " + patient.getContactNumber());
        }
    }

    @Override
    public Object createProfileEntity(User user, Object profileData) {
        if (!(profileData instanceof PatientCreationData)) {
            throw new IllegalArgumentException("Patient profile data required");
        }

        PatientCreationData data = (PatientCreationData) profileData;
        Patient patient = new Patient();
        patient.setFirstName(data.getFirstName());
        patient.setLastName(data.getLastName());
        patient.setDateOfBirth(data.getDateOfBirth());
        patient.setGender(data.getGender());
        patient.setContactNumber(data.getContactNumber());
        patient.setAddress(data.getAddress());
        patient.setEmail(data.getEmail());
        patient.setEmergencyContactName(data.getEmergencyContactName());
        patient.setEmergencyContactRelationship(data.getEmergencyContactRelationship());
        patient.setEmergencyContactPhone(data.getEmergencyContactPhone());
        patient.setBloodType(data.getBloodType());
        patient.setAllergies(data.getAllergies());

        // ✅ UPDATED: The profileId will be set after saving the patient entity
        // user.setProfileId(patient.getId()); // This will be handled in UserService

        return patient;
    }

    @Override
    public void initializeProfile(User user) {
        System.out.println("👤 Initializing patient profile for user: " + user.getUsername());
        // Additional patient-specific initialization
    }

    @Override
    public String getProfileDetails(User user) {
        // ✅ UPDATED: Use profileId to find patient
        if (user.getProfileId() != null) {
            Optional<Patient> patientOpt = patientRepository.findByProfileId(user.getProfileId());
            if (patientOpt.isPresent()) {
                Patient patient = patientOpt.get();
                return String.format("Patient: %s %s | %s | %s",
                        patient.getFirstName(),
                        patient.getLastName(),
                        patient.getContactNumber(),
                        patient.getEmail());
            }
        }
        return "Patient profile not found";
    }

    // Patient-specific business methods
    public void bookAppointment(Long doctorId, String date) {
        System.out.println("📅 Patient booking appointment with doctor ID: " + doctorId + " on " + date);
    }

    public void viewMedicalHistory(Long patientId) {
        System.out.println("📊 Patient viewing medical history for ID: " + patientId);
    }

    public void makePayment(double amount) {
        System.out.println("💳 Patient making payment of $" + amount);
    }

    // Data transfer object for patient creation
    public static class PatientCreationData {
        private String firstName;
        private String lastName;
        private LocalDate dateOfBirth;
        private String gender;
        private String contactNumber;
        private String address;
        private String email;
        private String emergencyContactName;
        private String emergencyContactRelationship;
        private String emergencyContactPhone;
        private String bloodType;
        private String allergies;

        // Constructors
        public PatientCreationData() {}

        public PatientCreationData(String firstName, String lastName, LocalDate dateOfBirth,
                                   String gender, String contactNumber, String address, String email) {
            this.firstName = firstName;
            this.lastName = lastName;
            this.dateOfBirth = dateOfBirth;
            this.gender = gender;
            this.contactNumber = contactNumber;
            this.address = address;
            this.email = email;
        }

        // Getters and setters
        public String getFirstName() { return firstName; }
        public void setFirstName(String firstName) { this.firstName = firstName; }
        public String getLastName() { return lastName; }
        public void setLastName(String lastName) { this.lastName = lastName; }
        public LocalDate getDateOfBirth() { return dateOfBirth; }
        public void setDateOfBirth(LocalDate dateOfBirth) { this.dateOfBirth = dateOfBirth; }
        public String getGender() { return gender; }
        public void setGender(String gender) { this.gender = gender; }
        public String getContactNumber() { return contactNumber; }
        public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }
        public String getAddress() { return address; }
        public void setAddress(String address) { this.address = address; }
        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }
        public String getEmergencyContactName() { return emergencyContactName; }
        public void setEmergencyContactName(String emergencyContactName) { this.emergencyContactName = emergencyContactName; }
        public String getEmergencyContactRelationship() { return emergencyContactRelationship; }
        public void setEmergencyContactRelationship(String emergencyContactRelationship) { this.emergencyContactRelationship = emergencyContactRelationship; }
        public String getEmergencyContactPhone() { return emergencyContactPhone; }
        public void setEmergencyContactPhone(String emergencyContactPhone) { this.emergencyContactPhone = emergencyContactPhone; }
        public String getBloodType() { return bloodType; }
        public void setBloodType(String bloodType) { this.bloodType = bloodType; }
        public String getAllergies() { return allergies; }
        public void setAllergies(String allergies) { this.allergies = allergies; }
    }
}