// ShiftScheduleRepository.java - Update for ward-based queries
package com.hms.hospitalmanagementsystem.repository;

import com.hms.hospitalmanagementsystem.entity.ShiftSchedule;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.time.LocalDate;
import java.util.List;

public interface ShiftScheduleRepository extends JpaRepository<ShiftSchedule, Long> {

    // UPDATED: Ward-based queries instead of department-based
    List<ShiftSchedule> findByWardId(Long wardId);
    List<ShiftSchedule> findByStaffId(Long staffId);
    List<ShiftSchedule> findByScheduleDateBetween(LocalDate startDate, LocalDate endDate);
    List<ShiftSchedule> findByScheduleDate(LocalDate date);

    // NEW: Ward-based queries
    @Query("SELECT s FROM ShiftSchedule s WHERE s.ward.id = :wardId AND s.scheduleDate = :date")
    List<ShiftSchedule> findTodaySchedulesByWard(Long wardId, LocalDate date);

    @Query("SELECT s FROM ShiftSchedule s WHERE s.ward.department.id = :departmentId AND s.scheduleDate = :date")
    List<ShiftSchedule> findTodaySchedulesByDepartment(Long departmentId, LocalDate date);

    List<ShiftSchedule> findByStaffIdAndScheduleDateBetween(Long staffId, LocalDate startDate, LocalDate endDate);

    @Query("SELECT COUNT(s) FROM ShiftSchedule s WHERE s.ward.id = :wardId AND s.scheduleDate = :date AND s.shiftType = :shiftType")
    Long countStaffScheduledForShift(Long wardId, LocalDate date, String shiftType);

    @Query("SELECT s FROM ShiftSchedule s WHERE s.staff.id = :staffId AND s.scheduleDate = :date")
    List<ShiftSchedule> findByStaffIdAndScheduleDate(Long staffId, LocalDate date);
}