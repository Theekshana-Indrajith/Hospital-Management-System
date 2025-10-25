package com.hms.hospitalmanagementsystem.service.factory;

import com.hms.hospitalmanagementsystem.entity.User;
import com.hms.hospitalmanagementsystem.entity.Doctor;
import com.hms.hospitalmanagementsystem.entity.Department;
import com.hms.hospitalmanagementsystem.repository.DoctorRepository;
import com.hms.hospitalmanagementsystem.repository.DepartmentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Optional;

@Component
public class DoctorRoleStrategy implements UserRoleStrategy {

    @Autowired
    private DoctorRepository doctorRepository;

    @Autowired
    private DepartmentRepository departmentRepository;

    @Override
    public String getDashboardUrl(User user) {
        return "/doctor/dashboard";
    }

    @Override
    public String getWelcomeMessage(User user) {
        // ✅ UPDATED: Use profileId to find doctor
        if (user.getProfileId() != null) {
            Optional<Doctor> doctorOpt = doctorRepository.findByProfileId(user.getProfileId());
            if (doctorOpt.isPresent()) {
                Doctor doctor = doctorOpt.get();
                return "Welcome Dr. " + doctor.getName() + " (" + doctor.getSpecialization() + ") to Medical Dashboard";
            }
        }
        return "Welcome Doctor " + user.getUsername() + " to Medical Dashboard";
    }

    @Override
    public void performRoleSpecificActions(User user) {
        // ✅ UPDATED: Use profileId to find doctor
        Optional<Doctor> doctorOpt = Optional.empty();
        if (user.getProfileId() != null) {
            doctorOpt = doctorRepository.findByProfileId(user.getProfileId());
        }

        System.out.println("🔬 Doctor Actions for: " + user.getUsername());
        System.out.println("   - Viewing patient records");
        System.out.println("   - Prescribing medication");
        System.out.println("   - Managing appointments");

        if (doctorOpt.isPresent()) {
            Doctor doctor = doctorOpt.get();
            System.out.println("   - Specialization: " + doctor.getSpecialization());
            System.out.println("   - Room: " + doctor.getRoomNumber());
        }
    }

    @Override
    public Object createProfileEntity(User user, Object profileData) {
        if (!(profileData instanceof DoctorCreationData)) {
            throw new IllegalArgumentException("Doctor profile data required");
        }

        DoctorCreationData data = (DoctorCreationData) profileData;
        Doctor doctor = new Doctor();
        doctor.setName(data.getName());
        doctor.setSpecialization(data.getSpecialization());
        doctor.setContactNumber(data.getContactNumber());
        doctor.setEmail(data.getEmail());
        doctor.setRoomNumber(data.getRoomNumber());
        doctor.setDepartment(data.getDepartment());
        doctor.setShiftSchedule(data.getShiftSchedule());

        // ✅ UPDATED: The profileId will be set after saving the doctor entity
        // user.setProfileId(doctor.getId()); // This will be handled in UserService

        return doctor;
    }

    @Override
    public void initializeProfile(User user) {
        System.out.println("🩺 Initializing doctor profile for user: " + user.getUsername());
        // Additional doctor-specific initialization logic
    }

    @Override
    public String getProfileDetails(User user) {
        // ✅ UPDATED: Use profileId to find doctor
        if (user.getProfileId() != null) {
            Optional<Doctor> doctorOpt = doctorRepository.findByProfileId(user.getProfileId());
            if (doctorOpt.isPresent()) {
                Doctor doctor = doctorOpt.get();
                return String.format("Dr. %s | %s | Room: %s | Dept: %s",
                        doctor.getName(),
                        doctor.getSpecialization(),
                        doctor.getRoomNumber(),
                        doctor.getDepartment() != null ? doctor.getDepartment().getName() : "N/A");
            }
        }
        return "Doctor profile not found";
    }

    // Doctor-specific business methods
    public void prescribeMedication(Long patientId, String medication) {
        System.out.println("💊 Doctor prescribing " + medication + " to patient ID: " + patientId);
    }

    public void viewPatientRecords(Long patientId) {
        System.out.println("📋 Doctor viewing medical records for patient ID: " + patientId);
    }

    public void manageAppointments() {
        System.out.println("📅 Doctor managing appointments and schedule");
    }

    // Data transfer object for doctor creation
    public static class DoctorCreationData {
        private String name;
        private String specialization;
        private String contactNumber;
        private String email;
        private String roomNumber;
        private Department department;
        private String shiftSchedule;

        // Constructors
        public DoctorCreationData() {}

        public DoctorCreationData(String name, String specialization, String contactNumber,
                                  String email, String roomNumber, Department department) {
            this.name = name;
            this.specialization = specialization;
            this.contactNumber = contactNumber;
            this.email = email;
            this.roomNumber = roomNumber;
            this.department = department;
        }

        // Getters and setters
        public String getName() { return name; }
        public void setName(String name) { this.name = name; }
        public String getSpecialization() { return specialization; }
        public void setSpecialization(String specialization) { this.specialization = specialization; }
        public String getContactNumber() { return contactNumber; }
        public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }
        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }
        public String getRoomNumber() { return roomNumber; }
        public void setRoomNumber(String roomNumber) { this.roomNumber = roomNumber; }
        public Department getDepartment() { return department; }
        public void setDepartment(Department department) { this.department = department; }
        public String getShiftSchedule() { return shiftSchedule; }
        public void setShiftSchedule(String shiftSchedule) { this.shiftSchedule = shiftSchedule; }
    }
}