package com.hms.hospitalmanagementsystem.entity;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "lab_departments")
public class LabDepartment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String name;

    private String description;
    private String location;
    private String contactNumber;
    private String email;

    @Column(name = "operating_hours")
    private String operatingHours;

//    @OneToMany(mappedBy = "department", fetch = FetchType.LAZY)
//    private List<Staff> labTechnicians = new ArrayList<>();

    // Constructors
    public LabDepartment() {}

    public LabDepartment(String name, String description, String location, String contactNumber) {
        this.name = name;
        this.description = description;
        this.location = location;
        this.contactNumber = contactNumber;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getOperatingHours() { return operatingHours; }
    public void setOperatingHours(String operatingHours) { this.operatingHours = operatingHours; }
//    public List<Staff> getLabTechnicians() { return labTechnicians; }
//    public void setLabTechnicians(List<Staff> labTechnicians) { this.labTechnicians = labTechnicians; }
}