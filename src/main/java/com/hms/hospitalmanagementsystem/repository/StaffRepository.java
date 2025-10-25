package com.hms.hospitalmanagementsystem.repository;

import com.hms.hospitalmanagementsystem.entity.Staff;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface StaffRepository extends JpaRepository<Staff, Long> {

    // Staff type and department queries
    List<Staff> findByStaffType(String staffType);
    List<Staff> findByDepartmentId(Long departmentId);
    List<Staff> findByIsActiveTrue();

    // Name search
    @Query("SELECT s FROM Staff s WHERE s.firstName LIKE %:name% OR s.lastName LIKE %:name%")
    List<Staff> findByNameContaining(@Param("name") String name);

    // Count active staff by type
    @Query("SELECT COUNT(s) FROM Staff s WHERE s.staffType = :staffType AND s.isActive = true")
    Long countActiveStaffByType(@Param("staffType") String staffType);

    // ✅ REPLACED: findByUser with findByProfileId
    @Query("SELECT s FROM Staff s WHERE s.id = :profileId")
    Optional<Staff> findByProfileId(@Param("profileId") Long profileId);

    // ✅ ADD: Find staff by user ID
    @Query("SELECT s FROM Staff s WHERE s.id IN (SELECT u.profileId FROM User u WHERE u.id = :userId AND u.role = 'STAFF')")
    Optional<Staff> findByUserId(@Param("userId") Long userId);

    // Existing methods
    Optional<Staff> findByEmployeeId(String employeeId);
    List<Staff> findByStaffTypeAndIsActiveTrue(String staffType);

    // ✅ ADD: Additional useful methods
    @Query("SELECT s FROM Staff s WHERE s.isActive = true ORDER BY s.firstName, s.lastName")
    List<Staff> findAllActiveStaff();

    @Query("SELECT DISTINCT s.staffType FROM Staff s WHERE s.isActive = true")
    List<String> findDistinctStaffTypes();

    @Query("SELECT s FROM Staff s WHERE s.assignedShift = :shift AND s.isActive = true")
    List<Staff> findByShiftAndActive(@Param("shift") String shift);

    @Query("SELECT s FROM Staff s WHERE s.department.id = :departmentId AND s.isActive = true")
    List<Staff> findByDepartmentAndActive(@Param("departmentId") Long departmentId);

    // Find staff by qualification
    @Query("SELECT s FROM Staff s WHERE s.qualification LIKE %:qualification% AND s.isActive = true")
    List<Staff> findByQualificationContaining(@Param("qualification") String qualification);

    // Count staff by department
    @Query("SELECT COUNT(s) FROM Staff s WHERE s.department.id = :departmentId AND s.isActive = true")
    Long countActiveStaffByDepartment(@Param("departmentId") Long departmentId);
}