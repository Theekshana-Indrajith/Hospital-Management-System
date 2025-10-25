// Ward.java - Add department relationship
package com.hms.hospitalmanagementsystem.entity;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "wards")
public class Ward {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "ward_number", unique = true, nullable = false)
    private String wardNumber;

    @Column(name = "ward_type", nullable = false)
    private String wardType; // ICU, GENERAL, PEDIATRIC, SURGICAL, etc.

    private String description;

    @Column(name = "total_beds")
    private int totalBeds;

    @Column(name = "available_beds")
    private int availableBeds;

    @Column(name = "charge_per_day")
    private double chargePerDay;

    // NEW: Department relationship
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "department_id")
    private Department department;

    @OneToMany(mappedBy = "ward", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Bed> beds = new ArrayList<>();

    // Constructors
    public Ward() {}

    public Ward(String wardNumber, String wardType, String description, int totalBeds, double chargePerDay, Department department) {
        this.wardNumber = wardNumber;
        this.wardType = wardType;
        this.description = description;
        this.totalBeds = totalBeds;
        this.availableBeds = totalBeds;
        this.chargePerDay = chargePerDay;
        this.department = department;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getWardNumber() { return wardNumber; }
    public void setWardNumber(String wardNumber) { this.wardNumber = wardNumber; }
    public String getWardType() { return wardType; }
    public void setWardType(String wardType) { this.wardType = wardType; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public int getTotalBeds() { return totalBeds; }
    public void setTotalBeds(int totalBeds) { this.totalBeds = totalBeds; }
    public int getAvailableBeds() { return availableBeds; }
    public void setAvailableBeds(int availableBeds) { this.availableBeds = availableBeds; }
    public double getChargePerDay() { return chargePerDay; }
    public void setChargePerDay(double chargePerDay) { this.chargePerDay = chargePerDay; }
    public Department getDepartment() { return department; }
    public void setDepartment(Department department) { this.department = department; }
    public List<Bed> getBeds() { return beds; }
    public void setBeds(List<Bed> beds) { this.beds = beds; }
}