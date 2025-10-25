// Department.java
package com.hms.hospitalmanagementsystem.entity;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "departments")
public class Department {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String name;

    private String description;

    @Column(name = "head_of_department")
    private String headOfDepartment;

    @Column(name = "contact_number")
    private String contactNumber;

    private String email;

    @Column(name = "room_number")
    private String roomNumber;

    @Column(name = "morning_shift_start")
    private String morningShiftStart = "08:00";

    @Column(name = "morning_shift_end")
    private String morningShiftEnd = "16:00";

    @Column(name = "evening_shift_start")
    private String eveningShiftStart = "16:00";

    @Column(name = "evening_shift_end")
    private String eveningShiftEnd = "00:00";

    @Column(name = "night_shift_start")
    private String nightShiftStart = "00:00";

    @Column(name = "night_shift_end")
    private String nightShiftEnd = "08:00";

    @OneToMany(mappedBy = "department", fetch = FetchType.LAZY)
    private List<Doctor> doctors = new ArrayList<>();

    // Constructors
    public Department() {}

    public Department(String name, String description, String headOfDepartment,
                      String contactNumber, String email, String roomNumber) {
        this.name = name;
        this.description = description;
        this.headOfDepartment = headOfDepartment;
        this.contactNumber = contactNumber;
        this.email = email;
        this.roomNumber = roomNumber;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getHeadOfDepartment() { return headOfDepartment; }
    public void setHeadOfDepartment(String headOfDepartment) { this.headOfDepartment = headOfDepartment; }
    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getRoomNumber() { return roomNumber; }
    public void setRoomNumber(String roomNumber) { this.roomNumber = roomNumber; }
    public List<Doctor> getDoctors() { return doctors; }
    public void setDoctors(List<Doctor> doctors) { this.doctors = doctors; }

    // Add getters and setters
    public String getMorningShiftStart() { return morningShiftStart; }
    public void setMorningShiftStart(String morningShiftStart) { this.morningShiftStart = morningShiftStart; }

    public String getMorningShiftEnd() { return morningShiftEnd; }
    public void setMorningShiftEnd(String morningShiftEnd) { this.morningShiftEnd = morningShiftEnd; }

    public String getEveningShiftStart() { return eveningShiftStart; }
    public void setEveningShiftStart(String eveningShiftStart) { this.eveningShiftStart = eveningShiftStart; }

    public String getEveningShiftEnd() { return eveningShiftEnd; }
    public void setEveningShiftEnd(String eveningShiftEnd) { this.eveningShiftEnd = eveningShiftEnd; }

    public String getNightShiftStart() { return nightShiftStart; }
    public void setNightShiftStart(String nightShiftStart) { this.nightShiftStart = nightShiftStart; }

    public String getNightShiftEnd() { return nightShiftEnd; }
    public void setNightShiftEnd(String nightShiftEnd) { this.nightShiftEnd = nightShiftEnd; }
}