package com.hms.hospitalmanagementsystem.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "lab_tests")
public class LabTest {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "patient_id", nullable = false)
    private Patient patient;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "doctor_id")
    private Doctor doctor;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "lab_technician_id")
    private Staff labTechnician;

//    @ManyToOne(fetch = FetchType.LAZY)
//    @JoinColumn(name = "requesting_doctor_id")
//    private Doctor requestingDoctor;

    @Column(nullable = false)
    private String testName;

   // private String testCode;
    private String testType; // BLOOD, URINE, XRAY, MRI, etc.
    private String description;
    private String instructions;

    @Column(nullable = false)
    private String status; // REQUESTED, IN_PROGRESS, COMPLETED, CANCELLED

    private String priority; // NORMAL, URGENT, STAT

    @Column(name = "requested_date")
    private LocalDateTime requestedDate;

    @Column(name = "collection_date")
    private LocalDateTime collectionDate;

    @Column(name = "completed_date")
    private LocalDateTime completedDate;

//    @Column(name = "result_status")
//    private String resultStatus;

    private String results;
    private String normalRange;
    private String units;
    private String findings;
    private String notes;

    @Column(name = "is_abnormal")
    private Boolean isAbnormal = false;

    // Constructors
    public LabTest() {}

    public LabTest(Patient patient, Doctor doctor, String testName, String testType, String priority) {
        this.patient = patient;
        this.doctor = doctor;
        this.testName = testName;
        this.testType = testType;
        this.priority = priority;
        this.status = "REQUESTED";
        this.requestedDate = LocalDateTime.now();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Patient getPatient() { return patient; }
    public void setPatient(Patient patient) { this.patient = patient; }
    public Doctor getDoctor() { return doctor; }
    public void setDoctor(Doctor doctor) { this.doctor = doctor; }
    public Staff getLabTechnician() { return labTechnician; }
    public void setLabTechnician(Staff labTechnician) { this.labTechnician = labTechnician; }
    public String getTestName() { return testName; }
    public void setTestName(String testName) { this.testName = testName; }
    //public String getTestCode() { return testCode; }
   // public void setTestCode(String testCode) { this.testCode = testCode; }
    public String getTestType() { return testType; }
    public void setTestType(String testType) { this.testType = testType; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getInstructions() { return instructions; }
    public void setInstructions(String instructions) { this.instructions = instructions; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getPriority() { return priority; }
    public void setPriority(String priority) { this.priority = priority; }
    public LocalDateTime getRequestedDate() { return requestedDate; }
    public void setRequestedDate(LocalDateTime requestedDate) { this.requestedDate = requestedDate; }
    public LocalDateTime getCollectionDate() { return collectionDate; }
    public void setCollectionDate(LocalDateTime collectionDate) { this.collectionDate = collectionDate; }
    public LocalDateTime getCompletedDate() { return completedDate; }
    public void setCompletedDate(LocalDateTime completedDate) { this.completedDate = completedDate; }
    public String getResults() { return results; }
    public void setResults(String results) { this.results = results; }
    public String getNormalRange() { return normalRange; }
    public void setNormalRange(String normalRange) { this.normalRange = normalRange; }
    public String getUnits() { return units; }
    public void setUnits(String units) { this.units = units; }
    public String getFindings() { return findings; }
    public void setFindings(String findings) { this.findings = findings; }
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
    public Boolean getIsAbnormal() { return isAbnormal; }
    public void setIsAbnormal(Boolean isAbnormal) { this.isAbnormal = isAbnormal; }

//    public String getResultStatus() { return resultStatus; }
//    public void setResultStatus(String resultStatus) { this.resultStatus = resultStatus; }
//
//    public Doctor getRequestingDoctor() { return requestingDoctor; }
//    public void setRequestingDoctor(Doctor requestingDoctor) { this.requestingDoctor = requestingDoctor; }
}