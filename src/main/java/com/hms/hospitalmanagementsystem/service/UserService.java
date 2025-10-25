package com.hms.hospitalmanagementsystem.service;

import com.hms.hospitalmanagementsystem.entity.*;
import com.hms.hospitalmanagementsystem.repository.*;
import com.hms.hospitalmanagementsystem.service.factory.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
@Transactional
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PatientRepository patientRepository;

    @Autowired
    private DoctorRepository doctorRepository;

    @Autowired
    private StaffRepository staffRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private UserRoleFactory userRoleFactory;

    @Autowired
    private DoctorRoleStrategy doctorRoleStrategy;

    @Autowired
    private PatientRoleStrategy patientRoleStrategy;

    @Autowired
    private StaffRoleStrategy staffRoleStrategy;

    @Autowired
    private AdminRoleStrategy adminRoleStrategy;

    // ==================== EXISTING METHODS (KEEP AS IS) ====================

    /**
     * Original registerUser method - maintains backward compatibility
     */
    public User registerUser(User user) {
        try {
            System.out.println("DEBUG: Registering user: " + user.getUsername());

            // Encode password
            String encodedPassword = passwordEncoder.encode(user.getPassword());
            user.setPassword(encodedPassword);

            // Ensure role is PATIENT for registrations
            if (user.getRole() == null) {
                user.setRole("PATIENT");
            }

            User savedUser = userRepository.save(user);
            System.out.println("DEBUG: User registered successfully: " + savedUser.getUsername());
            return savedUser;

        } catch (Exception e) {
            System.out.println("DEBUG: Registration error: " + e.getMessage());
            throw e;
        }
    }

    public Optional<User> findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    public boolean usernameExists(String username) {
        return userRepository.existsByUsername(username);
    }

    public boolean emailExists(String email) {
        return userRepository.existsByEmail(email);
    }

    // Method for saving users without encoding password (for pre-loaded data)
    public User saveUser(User user) {
        return userRepository.save(user);
    }

    // NEW METHOD: Get all users count
    public long getAllUsersCount() {
        return userRepository.count();
    }

    // NEW METHOD: Get all users (if needed)
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    // NEW METHOD: Get users by role
    public List<User> getUsersByRole(String role) {
        return userRepository.findByRole(role);
    }

    // NEW METHOD: Get user count by role
    public long getUsersCountByRole(String role) {
        return userRepository.countByRole(role);
    }

    public User findByProfileIdAndRole(Long profileId, String role) {
        return userRepository.findByProfileIdAndRole(profileId, role);
    }

    public void deleteUser(Long userId) {
        userRepository.deleteById(userId);
    }

    // ==================== FACTORY PATTERN METHODS ====================

    /**
     * NEW: Create user with role-specific profile using Factory Pattern
     */
    public User createUserWithProfile(String username, String password, String email,
                                      String role, Object profileData) {

        // Check if user already exists
        if (userRepository.existsByUsername(username)) {
            throw new RuntimeException("Username already exists: " + username);
        }
        if (userRepository.existsByEmail(email)) {
            throw new RuntimeException("Email already exists: " + email);
        }

        // Encode password
        String encodedPassword = passwordEncoder.encode(password);

        // Create base user FIRST (without profileId initially)
        User user = new User(username, encodedPassword, email, role, null);
        User savedUser = userRepository.save(user);

        try {
            // Create role-specific profile using factory
            Object profileEntity = userRoleFactory.createProfileEntity(savedUser, profileData);

            // Save profile entity and update user profileId
            if (profileEntity != null) {
                Long profileId = saveProfileEntity(profileEntity, role, savedUser);
                savedUser.setProfileId(profileId);
                savedUser = userRepository.save(savedUser);
            }

            // Initialize role-specific data
            userRoleFactory.initializeProfile(savedUser);

            System.out.println("✅ User created with profile: " + savedUser.getUsername() + " (" + savedUser.getRole() + ")");
            System.out.println("🎯 " + userRoleFactory.getWelcomeMessage(savedUser));

            return savedUser;

        } catch (Exception e) {
            // Rollback user creation if profile creation fails
            userRepository.delete(savedUser);
            throw new RuntimeException("Failed to create user profile: " + e.getMessage(), e);
        }
    }

    /**
     * Save profile entity based on role (UPDATED)
     */
    private Long saveProfileEntity(Object profileEntity, String role, User user) {
        switch (role.toUpperCase()) {
            case "DOCTOR":
                Doctor doctor = (Doctor) profileEntity;
                // ✅ Set email from user if not provided in doctor data
                if (doctor.getEmail() == null) {
                    doctor.setEmail(user.getEmail());
                }
                Doctor savedDoctor = doctorRepository.save(doctor);
                return savedDoctor.getId();

            case "PATIENT":
                Patient patient = (Patient) profileEntity;
                // ✅ Set email from user if not provided in patient data
                if (patient.getEmail() == null) {
                    patient.setEmail(user.getEmail());
                }
                Patient savedPatient = patientRepository.save(patient);
                return savedPatient.getId();

            case "STAFF":
                Staff staff = (Staff) profileEntity;
                // ✅ Set email from user if not provided in staff data
                if (staff.getEmail() == null) {
                    staff.setEmail(user.getEmail());
                }
                Staff savedStaff = staffRepository.save(staff);
                return savedStaff.getId();

            case "ADMIN":
                // Admin doesn't have separate profile entity
                return null;

            default:
                throw new IllegalArgumentException("Unknown role: " + role);
        }
    }

    /**
     * Get user dashboard URL using factory
     */
    public String getUserDashboardUrl(Long userId) {
        User user = getUserById(userId);
        return userRoleFactory.getDashboardUrl(user);
    }

    /**
     * Get welcome message using factory
     */
    public String getWelcomeMessage(Long userId) {
        User user = getUserById(userId);
        return userRoleFactory.getWelcomeMessage(user);
    }

    /**
     * Perform role-specific actions using factory
     */
    public void performRoleSpecificActions(Long userId) {
        User user = getUserById(userId);
        System.out.println("🎯 Performing role-specific actions for: " + user.getUsername());
        userRoleFactory.performRoleActions(user);

        // Execute additional role-specific business logic
        executeAdditionalRoleLogic(user);
    }

    /**
     * Execute additional role-specific business logic (UPDATED)
     */
    private void executeAdditionalRoleLogic(User user) {
        switch (user.getRole().toUpperCase()) {
            case "DOCTOR":
                // ✅ UPDATED: Use profileId to find doctor
                if (user.getProfileId() != null) {
                    Optional<Doctor> doctorOpt = doctorRepository.findByProfileId(user.getProfileId());
                    if (doctorOpt.isPresent()) {
                        doctorRoleStrategy.prescribeMedication(123L, "Amoxicillin 500mg");
                        doctorRoleStrategy.viewPatientRecords(123L);
                    }
                }
                break;

            case "PATIENT":
                // ✅ UPDATED: Use profileId to find patient
                if (user.getProfileId() != null) {
                    Optional<Patient> patientOpt = patientRepository.findByProfileId(user.getProfileId());
                    if (patientOpt.isPresent()) {
                        patientRoleStrategy.bookAppointment(1L, "2024-01-15");
                        patientRoleStrategy.viewMedicalHistory(patientOpt.get().getId());
                    }
                }
                break;

            case "ADMIN":
                adminRoleStrategy.manageSystemUsers();
                adminRoleStrategy.generateSystemReport();
                break;

            case "STAFF":
                // ✅ UPDATED: Use profileId to find staff
                if (user.getProfileId() != null) {
                    Optional<Staff> staffOpt = staffRepository.findByProfileId(user.getProfileId());
                    if (staffOpt.isPresent()) {
                        Staff staff = staffOpt.get();
                        staffRoleStrategy.manageAppointments(staff);
                        if (staff.isReceptionist()) {
                            staffRoleStrategy.processBilling(staff);
                        } else if (staff.isLabTech()) {
                            staffRoleStrategy.handleLabWork(staff);
                        } else if (staff.isWardManager()) {
                            staffRoleStrategy.manageWard(staff);
                        }
                    }
                }
                break;
        }
    }

    /**
     * Get user by ID with proper error handling
     */
    public User getUserById(Long userId) {
        return userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found with ID: " + userId));
    }

    /**
     * Get user profile details using factory
     */
    public String getUserProfileDetails(Long userId) {
        User user = getUserById(userId);
        return userRoleFactory.getProfileDetails(user);
    }

    // ==================== CONVENIENCE METHODS ====================

    /**
     * Create a doctor user with profile
     */
    public User createDoctorUser(String username, String password, String email,
                                 DoctorRoleStrategy.DoctorCreationData doctorData) {
        return createUserWithProfile(username, password, email, "DOCTOR", doctorData);
    }

    /**
     * Create a patient user with profile
     */
    public User createPatientUser(String username, String password, String email,
                                  PatientRoleStrategy.PatientCreationData patientData) {
        return createUserWithProfile(username, password, email, "PATIENT", patientData);
    }

    /**
     * Create a staff user with profile
     */
    public User createStaffUser(String username, String password, String email,
                                StaffRoleStrategy.StaffCreationData staffData) {
        return createUserWithProfile(username, password, email, "STAFF", staffData);
    }

    /**
     * Create an admin user
     */
    public User createAdminUser(String username, String password, String email) {
        // Encode password
        String encodedPassword = passwordEncoder.encode(password);

        User user = new User(username, encodedPassword, email, "ADMIN", null);
        User savedUser = userRepository.save(user);

        // Initialize admin profile
        userRoleFactory.initializeProfile(savedUser);

        return savedUser;
    }

    /**
     * Enhanced user registration with profile creation
     */
    public User registerUserWithProfile(User user, Object profileData) {
        return createUserWithProfile(user.getUsername(), user.getPassword(),
                user.getEmail(), user.getRole(), profileData);
    }

    // ==================== SECURITY HELPER METHODS ====================

    /**
     * Verify user credentials
     */
    public boolean verifyCredentials(String username, String rawPassword) {
        Optional<User> userOpt = userRepository.findByUsername(username);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            return passwordEncoder.matches(rawPassword, user.getPassword());
        }
        return false;
    }

    /**
     * Change user password
     */
    public void changePassword(Long userId, String newPassword) {
        User user = getUserById(userId);
        String encodedPassword = passwordEncoder.encode(newPassword);
        user.setPassword(encodedPassword);
        userRepository.save(user);
    }

    // ==================== PROFILE LINKING METHODS ====================

    /**
     * Link existing profile to user
     */
    public User linkProfileToUser(Long userId, Long profileId, String role) {
        User user = getUserById(userId);
        user.setProfileId(profileId);

        // Update role if different
        if (!user.getRole().equals(role)) {
            user.setRole(role);
        }

        return userRepository.save(user);
    }

    /**
     * Get user by profile ID and role
     */
    public User getUserByProfile(Long profileId, String role) {
        return userRepository.findByProfileIdAndRole(profileId, role);
    }

    /**
     * Get profile entity by user ID
     */
    public Object getProfileEntityByUserId(Long userId) {
        User user = getUserById(userId);
        if (user.getProfileId() == null) {
            return null;
        }

        switch (user.getRole().toUpperCase()) {
            case "DOCTOR":
                return doctorRepository.findByProfileId(user.getProfileId()).orElse(null);
            case "PATIENT":
                return patientRepository.findByProfileId(user.getProfileId()).orElse(null);
            case "STAFF":
                return staffRepository.findByProfileId(user.getProfileId()).orElse(null);
            default:
                return null;
        }
    }

    // ==================== STATUS MANAGEMENT ====================

    /**
     * Update user role
     */
    public User updateUserRole(Long userId, String newRole) {
        User user = getUserById(userId);
        user.setRole(newRole);
        return userRepository.save(user);
    }

    // ==================== UTILITY METHODS ====================

    /**
     * Check if profile ID is available for linking
     */
    public boolean isProfileIdAvailable(Long profileId, String role) {
        return userRepository.findByProfileIdAndRole(profileId, role) == null;
    }

    /**
     * Get user statistics
     */
    public Map<String, Long> getUserStatistics() {
        Map<String, Long> stats = new HashMap<>();
        stats.put("TOTAL_USERS", userRepository.count());
        stats.put("PATIENTS", userRepository.countByRole("PATIENT"));
        stats.put("DOCTORS", userRepository.countByRole("DOCTOR"));
        stats.put("STAFF", userRepository.countByRole("STAFF"));
        stats.put("ADMINS", userRepository.countByRole("ADMIN"));
        return stats;
    }

    /**
     * Find users by multiple criteria
     */
    public List<User> searchUsers(String keyword, String role) {
        if (role != null && !role.isEmpty()) {
            return userRepository.findByRoleAndUsernameOrEmailContaining(role, keyword);
        } else {
            return userRepository.findByUsernameOrEmailContaining(keyword);
        }
    }
}