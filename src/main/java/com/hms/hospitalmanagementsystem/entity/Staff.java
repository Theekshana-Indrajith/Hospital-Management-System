package com.hms.hospitalmanagementsystem.entity;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "staff")
public class Staff {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "first_name", nullable = false)
    private String firstName;

    @Column(name = "last_name", nullable = false)
    private String lastName;

    @Column(name = "staff_type", nullable = false)
    private String staffType; // NURSE, RECEPTIONIST, LAB_TECH, WARD_MANAGER, ADMIN_ASSISTANT

    @Column(name = "date_of_birth")
    private LocalDate dateOfBirth;

    private String gender;

    @Column(name = "contact_number")
    private String contactNumber;

    private String email;

    private String qualification;

    @Column(name = "shift_schedule")
    private String shiftSchedule;

    @Column(name = "is_active")
    private Boolean isActive = true;

    // Shift management fields
    @Column(name = "assigned_shift")
    private String assignedShift; // MORNING, EVENING, NIGHT, ROTATING

    @Column(name = "shift_start_time")
    private String shiftStartTime;

    @Column(name = "shift_end_time")
    private String shiftEndTime;

    @Column(name = "working_days")
    private String workingDays = "MON-FRI";

    @Column(name = "employee_id", unique = true)
    private String employeeId;

    @Column(name = "date_joined")
    private LocalDate dateJoined;

    @Column(name = "emergency_contact")
    private String emergencyContact;

    @Column(name = "emergency_phone")
    private String emergencyPhone;

    @Column(name = "blood_group")
    private String bloodGroup;

    @Column(name = "allergies")
    private String allergies;

    @Column(name = "special_skills")
    private String specialSkills;

    @Column(name = "notes")
    private String notes;

    // Relationships
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "department_id")
    private Department department;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "lab_department_id")
    private LabDepartment labDepartment;

    @OneToMany(mappedBy = "staff", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<ShiftSchedule> shiftSchedules;



    // Constructors
    public Staff() {}

    public Staff(String firstName, String lastName, String staffType,
                 LocalDate dateOfBirth, String gender, String contactNumber,
                 String email, String qualification, Department department) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.staffType = staffType;
        this.dateOfBirth = dateOfBirth;
        this.gender = gender;
        this.contactNumber = contactNumber;
        this.email = email;
        this.qualification = qualification;
        this.department = department;
        this.isActive = true;
        this.dateJoined = LocalDate.now();
    }

    // Receptionist-specific constructor
    public Staff(String firstName, String lastName, String staffType,
                 LocalDate dateOfBirth, String gender, String contactNumber,
                 String email, String qualification) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.staffType = staffType;
        this.dateOfBirth = dateOfBirth;
        this.gender = gender;
        this.contactNumber = contactNumber;
        this.email = email;
        this.qualification = qualification;
        this.isActive = true;
        this.dateJoined = LocalDate.now();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getStaffType() { return staffType; }
    public void setStaffType(String staffType) { this.staffType = staffType; }

    public LocalDate getDateOfBirth() { return dateOfBirth; }
    public void setDateOfBirth(LocalDate dateOfBirth) { this.dateOfBirth = dateOfBirth; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getQualification() { return qualification; }
    public void setQualification(String qualification) { this.qualification = qualification; }

    public String getShiftSchedule() { return shiftSchedule; }
    public void setShiftSchedule(String shiftSchedule) { this.shiftSchedule = shiftSchedule; }

    public Boolean getIsActive() { return isActive; }
    public void setIsActive(Boolean isActive) { this.isActive = isActive; }

    public String getAssignedShift() { return assignedShift; }
    public void setAssignedShift(String assignedShift) { this.assignedShift = assignedShift; }

    public String getShiftStartTime() { return shiftStartTime; }
    public void setShiftStartTime(String shiftStartTime) { this.shiftStartTime = shiftStartTime; }

    public String getShiftEndTime() { return shiftEndTime; }
    public void setShiftEndTime(String shiftEndTime) { this.shiftEndTime = shiftEndTime; }

    public String getWorkingDays() { return workingDays; }
    public void setWorkingDays(String workingDays) { this.workingDays = workingDays; }

    public String getEmployeeId() { return employeeId; }
    public void setEmployeeId(String employeeId) { this.employeeId = employeeId; }

    public LocalDate getDateJoined() { return dateJoined; }
    public void setDateJoined(LocalDate dateJoined) { this.dateJoined = dateJoined; }

    public String getEmergencyContact() { return emergencyContact; }
    public void setEmergencyContact(String emergencyContact) { this.emergencyContact = emergencyContact; }

    public String getEmergencyPhone() { return emergencyPhone; }
    public void setEmergencyPhone(String emergencyPhone) { this.emergencyPhone = emergencyPhone; }

    public String getBloodGroup() { return bloodGroup; }
    public void setBloodGroup(String bloodGroup) { this.bloodGroup = bloodGroup; }

    public String getAllergies() { return allergies; }
    public void setAllergies(String allergies) { this.allergies = allergies; }

    public String getSpecialSkills() { return specialSkills; }
    public void setSpecialSkills(String specialSkills) { this.specialSkills = specialSkills; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    public Department getDepartment() { return department; }
    public void setDepartment(Department department) { this.department = department; }

    public LabDepartment getLabDepartment() { return labDepartment; }
    public void setLabDepartment(LabDepartment labDepartment) { this.labDepartment = labDepartment; }

    public List<ShiftSchedule> getShiftSchedules() { return shiftSchedules; }
    public void setShiftSchedules(List<ShiftSchedule> shiftSchedules) { this.shiftSchedules = shiftSchedules; }

    // Helper methods
    public String getFullName() {
        return firstName + " " + lastName;
    }

    public boolean isReceptionist() {
        return "RECEPTIONIST".equals(staffType);
    }

    public boolean isNurse() {
        return "NURSE".equals(staffType);
    }

    public boolean isLabTech() {
        return "LAB_TECH".equals(staffType);
    }

    public boolean isWardManager() {
        return "WARD_MANAGER".equals(staffType);
    }

    public int getAge() {
        if (dateOfBirth == null) return 0;
        return LocalDate.now().getYear() - dateOfBirth.getYear();
    }

    public String getFormattedContactInfo() {
        return String.format("%s | %s", contactNumber, email);
    }

    // Business logic methods
    public boolean isCurrentlyWorking() {
        // Logic to check if staff is currently on shift
        // This would check current time against shift schedule
        return true; // Simplified for demo
    }

    public boolean canHandleAppointments() {
        return isReceptionist() || isWardManager();
    }

    public boolean canManagePatients() {
        return isReceptionist() || isNurse();
    }




}