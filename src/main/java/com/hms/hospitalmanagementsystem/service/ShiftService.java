// ShiftService.java - Complete ward-based implementation
package com.hms.hospitalmanagementsystem.service;

import com.hms.hospitalmanagementsystem.entity.ShiftSchedule;
import com.hms.hospitalmanagementsystem.entity.Staff;
import com.hms.hospitalmanagementsystem.entity.Ward;
import com.hms.hospitalmanagementsystem.entity.Department;
import com.hms.hospitalmanagementsystem.repository.ShiftScheduleRepository;
import com.hms.hospitalmanagementsystem.repository.StaffRepository;
import com.hms.hospitalmanagementsystem.repository.WardRepository;
import com.hms.hospitalmanagementsystem.repository.DepartmentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ShiftService {

    @Autowired
    private ShiftScheduleRepository shiftScheduleRepository;

    @Autowired
    private StaffRepository staffRepository;

    @Autowired
    private WardRepository wardRepository;

    @Autowired
    private DepartmentRepository departmentRepository;

    // UPDATED: Schedule shift for a specific ward
    public ShiftSchedule scheduleShift(Long staffId, Long wardId, LocalDate date,
                                       String shiftType, String notes) {
        Optional<Staff> staffOpt = staffRepository.findById(staffId);
        Optional<Ward> wardOpt = wardRepository.findById(wardId);

        if (staffOpt.isPresent() && wardOpt.isPresent()) {
            Ward ward = wardOpt.get();
            Department department = ward.getDepartment(); // Get department from ward

            LocalTime startTime = getShiftStartTime(shiftType, department);
            LocalTime endTime = getShiftEndTime(shiftType, department);

            ShiftSchedule schedule = new ShiftSchedule(staffOpt.get(), ward, date,
                    shiftType, startTime, endTime);
            schedule.setNotes(notes);

            return shiftScheduleRepository.save(schedule);
        }
        throw new RuntimeException("Staff or Ward not found");
    }

    // UPDATED: Get schedules for a specific ward
    public List<ShiftSchedule> getWardSchedules(Long wardId, LocalDate date) {
        return shiftScheduleRepository.findTodaySchedulesByWard(wardId, date);
    }

    // NEW: Get schedules for a department (for backward compatibility)
    public List<ShiftSchedule> getDepartmentSchedules(Long departmentId, LocalDate date) {
        return shiftScheduleRepository.findTodaySchedulesByDepartment(departmentId, date);
    }

    // Get staff member's schedule for a date range
    public List<ShiftSchedule> getStaffSchedule(Long staffId, LocalDate startDate, LocalDate endDate) {
        return shiftScheduleRepository.findByStaffIdAndScheduleDateBetween(staffId, startDate, endDate);
    }

    // Update shift status
    public ShiftSchedule updateShiftStatus(Long scheduleId, String status) {
        Optional<ShiftSchedule> scheduleOpt = shiftScheduleRepository.findById(scheduleId);
        if (scheduleOpt.isPresent()) {
            ShiftSchedule schedule = scheduleOpt.get();
            schedule.setStatus(status);
            return shiftScheduleRepository.save(schedule);
        }
        throw new RuntimeException("Shift schedule not found");
    }

    // UPDATED: Generate weekly schedule for a ward
    public void generateWeeklySchedule(Long wardId, LocalDate startDate) {
        List<Staff> wardStaff = getStaffAssignedToWard(wardId);
        Ward ward = wardRepository.findById(wardId)
                .orElseThrow(() -> new RuntimeException("Ward not found"));

        // Simple rotation: MORNING, EVENING, NIGHT
        String[] shifts = {"MORNING", "EVENING", "NIGHT"};
        int shiftIndex = 0;

        for (int day = 0; day < 7; day++) {
            LocalDate currentDate = startDate.plusDays(day);

            for (Staff staff : wardStaff) {
                String shiftType = shifts[shiftIndex % shifts.length];
                scheduleShift(staff.getId(), wardId, currentDate, shiftType,
                        "Auto-generated weekly schedule");
                shiftIndex++;
            }
        }
    }

    // NEW: Get staff assigned to a specific ward (based on department)
    private List<Staff> getStaffAssignedToWard(Long wardId) {
        Ward ward = wardRepository.findById(wardId)
                .orElseThrow(() -> new RuntimeException("Ward not found"));
        return staffRepository.findByDepartmentId(ward.getDepartment().getId());
    }

    // Helper methods to get shift times from department settings
    private LocalTime getShiftStartTime(String shiftType, Department department) {
        return switch (shiftType.toUpperCase()) {
            case "MORNING" -> LocalTime.parse(department.getMorningShiftStart());
            case "EVENING" -> LocalTime.parse(department.getEveningShiftStart());
            case "NIGHT" -> LocalTime.parse(department.getNightShiftStart());
            default -> LocalTime.of(8, 0); // Default morning shift
        };
    }

    private LocalTime getShiftEndTime(String shiftType, Department department) {
        return switch (shiftType.toUpperCase()) {
            case "MORNING" -> LocalTime.parse(department.getMorningShiftEnd());
            case "EVENING" -> LocalTime.parse(department.getEveningShiftEnd());
            case "NIGHT" -> LocalTime.parse(department.getNightShiftEnd());
            default -> LocalTime.of(16, 0); // Default morning shift end
        };
    }

    public ShiftSchedule getShiftById(Long scheduleId) {
        return shiftScheduleRepository.findById(scheduleId)
                .orElseThrow(() -> new RuntimeException("Shift schedule not found"));
    }

    public void deleteShift(Long scheduleId) {
        if (shiftScheduleRepository.existsById(scheduleId)) {
            shiftScheduleRepository.deleteById(scheduleId);
        } else {
            throw new RuntimeException("Shift schedule not found");
        }
    }

    // UPDATED: Get available staff for a specific ward
    public List<Staff> getAvailableStaffForWard(Long wardId, LocalDate date, String shiftType) {
        Ward ward = wardRepository.findById(wardId)
                .orElseThrow(() -> new RuntimeException("Ward not found"));
        List<Staff> departmentStaff = staffRepository.findByDepartmentId(ward.getDepartment().getId());

        // Get existing shifts for the date
        List<ShiftSchedule> existingSchedules = shiftScheduleRepository.findByScheduleDate(date);

        return departmentStaff.stream()
                .filter(staff -> existingSchedules.stream()
                        .noneMatch(schedule -> schedule.getStaff().getId().equals(staff.getId()) &&
                                schedule.getScheduleDate().equals(date) &&
                                schedule.getShiftType().equals(shiftType)))
                .collect(Collectors.toList());
    }

    // Add method to get today's shifts count
    public Map<String, Object> getTodayShiftStatistics() {
        Map<String, Object> stats = new HashMap<>();
        LocalDate today = LocalDate.now();

        List<ShiftSchedule> todayShifts = shiftScheduleRepository.findByScheduleDate(today);
        stats.put("totalShifts", todayShifts.size());
        stats.put("scheduledShifts", todayShifts.stream().filter(s -> "SCHEDULED".equals(s.getStatus())).count());
        stats.put("completedShifts", todayShifts.stream().filter(s -> "COMPLETED".equals(s.getStatus())).count());
        stats.put("activeShifts", todayShifts.stream().filter(s -> "ACTIVE".equals(s.getStatus())).count());

        return stats;
    }
}