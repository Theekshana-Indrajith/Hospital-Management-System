// MedicalStaffService.java - Add ward-based shift methods
package com.hms.hospitalmanagementsystem.service;

import com.hms.hospitalmanagementsystem.entity.Department;
import com.hms.hospitalmanagementsystem.entity.Doctor;
import com.hms.hospitalmanagementsystem.entity.ShiftSchedule;
import com.hms.hospitalmanagementsystem.entity.Staff;
import com.hms.hospitalmanagementsystem.repository.DepartmentRepository;
import com.hms.hospitalmanagementsystem.repository.DoctorRepository;
import com.hms.hospitalmanagementsystem.repository.ShiftScheduleRepository;
import com.hms.hospitalmanagementsystem.repository.StaffRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class MedicalStaffService {

    @Autowired
    private DepartmentRepository departmentRepository;

    @Autowired
    private DoctorRepository doctorRepository;

    @Autowired
    private StaffRepository staffRepository;

    @Autowired
    private ShiftService shiftService;

    @Autowired
    private WardService wardService;

    @Autowired
    private ShiftScheduleRepository shiftScheduleRepository;

    // Department Management (unchanged)
    public List<Department> getAllDepartments() {
        return departmentRepository.findAll();
    }

    public Department getDepartmentById(Long id) {
        return departmentRepository.findById(id).orElse(null);
    }

    public Department saveDepartment(Department department) {
        return departmentRepository.save(department);
    }

    public void deleteDepartment(Long id) {
        departmentRepository.deleteById(id);
    }

    public List<Department> getDepartmentsWithDoctors() {
        return departmentRepository.findDepartmentsWithDoctors();
    }

    // Doctor Management (unchanged)
    public List<Doctor> getAllDoctors() {
        return doctorRepository.findAll();
    }

    public List<Doctor> getDoctorsByDepartment(Long departmentId) {
        return doctorRepository.findByDepartmentId(departmentId);
    }

    public Doctor assignDoctorToDepartment(Long doctorId, Long departmentId) {
        Optional<Doctor> doctorOpt = doctorRepository.findById(doctorId);
        Optional<Department> deptOpt = departmentRepository.findById(departmentId);

        if (doctorOpt.isPresent() && deptOpt.isPresent()) {
            Doctor doctor = doctorOpt.get();
            doctor.setDepartment(deptOpt.get());
            return doctorRepository.save(doctor);
        }
        return null;
    }

    // Staff Management (unchanged)
    public List<Staff> getAllStaff() {
        return staffRepository.findAll();
    }

    public List<Staff> getStaffByType(String staffType) {
        return staffRepository.findByStaffType(staffType);
    }

    public List<Staff> getActiveStaff() {
        return staffRepository.findByIsActiveTrue();
    }

    public Staff saveStaff(Staff staff) {
        return staffRepository.save(staff);
    }

    public void deactivateStaff(Long staffId) {
        Optional<Staff> staffOpt = staffRepository.findById(staffId);
        if (staffOpt.isPresent()) {
            Staff staff = staffOpt.get();
            staff.setIsActive(false);
            staffRepository.save(staff);
        }
    }

    // UPDATED: Shift Management Methods - Now ward-based
    public List<ShiftSchedule> getWardShifts(Long wardId, LocalDate date) {
        return shiftService.getWardSchedules(wardId, date);
    }

    // For backward compatibility
    public List<ShiftSchedule> getDepartmentShifts(Long departmentId, LocalDate date) {
        return shiftService.getDepartmentSchedules(departmentId, date);
    }

    public List<ShiftSchedule> getStaffShifts(Long staffId, LocalDate startDate, LocalDate endDate) {
        return shiftService.getStaffSchedule(staffId, startDate, endDate);
    }

    // UPDATED: Assign shift to staff for a specific ward
    public ShiftSchedule assignShiftToStaff(Long staffId, Long wardId, LocalDate date,
                                            String shiftType, String notes) {
        return shiftService.scheduleShift(staffId, wardId, date, shiftType, notes);
    }

    // UPDATED: Generate weekly schedule for a ward
    public void generateWeeklyScheduleForWard(Long wardId) {
        shiftService.generateWeeklySchedule(wardId, LocalDate.now());
    }

    // NEW: Get available staff for a specific ward
    public List<Staff> getAvailableStaffForWard(Long wardId, LocalDate date, String shiftType) {
        return shiftService.getAvailableStaffForWard(wardId, date, shiftType);
    }

    // Update staff shift preferences
    public Staff updateStaffShift(Long staffId, String assignedShift, String workingDays) {
        Optional<Staff> staffOpt = staffRepository.findById(staffId);
        if (staffOpt.isPresent()) {
            Staff staff = staffOpt.get();
            staff.setAssignedShift(assignedShift);
            staff.setWorkingDays(workingDays);
            return staffRepository.save(staff);
        }
        return null;
    }

    public List<Staff> getStaffByDepartment(Long departmentId) {
        return staffRepository.findByDepartmentId(departmentId);
    }

    public Staff getStaffById(Long staffId) {
        return staffRepository.findById(staffId).orElse(null);
    }

    // Statistics (unchanged)
    public long getTotalDoctors() {
        return doctorRepository.count();
    }

    public long getTotalActiveStaff() {
        return staffRepository.count();
    }

    public long getStaffCountByType(String staffType) {
        Long count = staffRepository.countActiveStaffByType(staffType);
        return count != null ? count : 0L;
    }

    public long getDoctorsCountByDepartment(Long departmentId) {
        Long count = doctorRepository.countByDepartmentId(departmentId);
        return count != null ? count : 0L;
    }

    public List<Doctor> getDoctorsByShift(String shiftSchedule) {
        return doctorRepository.findByShiftSchedule(shiftSchedule);
    }

    public List<Doctor> getActiveDoctors() {
        return doctorRepository.findByIsActiveTrue();
    }

    public Staff getStaffByUsername(String username) {
        // This method should find staff by their user username
        // You might need to create a relationship between User and Staff entities
        // For now, let's implement a basic version

        List<Staff> allStaff = staffRepository.findAll();
        return allStaff.stream()
                .filter(staff -> staff.getEmail() != null && staff.getEmail().contains(username))
                .findFirst()
                .orElse(null);
    }
}