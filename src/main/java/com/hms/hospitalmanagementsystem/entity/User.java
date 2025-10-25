package com.hms.hospitalmanagementsystem.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String username;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(nullable = false)
    private String role; // PATIENT, DOCTOR, ADMIN, STAFF

    @Column(name = "profile_id")
    private Long profileId; // Links to patient/doctor ID

    // In User.java - Add this method
    public boolean isDoctor() {
        return "DOCTOR".equals(this.role);
    }

    // Constructors
    public User() {}

    public User(String username, String password, String email, String role, Long profileId) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.role = role;
        this.profileId = profileId;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public Long getProfileId() { return profileId; }
    public void setProfileId(Long profileId) { this.profileId = profileId; }
}