package com.hms.hospitalmanagementsystem.repository;

import com.hms.hospitalmanagementsystem.entity.Department;
import com.hms.hospitalmanagementsystem.entity.Doctor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface DoctorRepository extends JpaRepository<Doctor, Long> {

    // Existing search methods
    List<Doctor> findBySpecializationContainingIgnoreCase(String specialization);
    List<Doctor> findByNameContainingIgnoreCase(String name);

    // Department management methods
    List<Doctor> findByDepartmentId(Long departmentId);
    List<Doctor> findByIsActiveTrue();
    List<Doctor> findBySpecialization(String specialization);

    @Query("SELECT d FROM Doctor d WHERE d.department IS NOT NULL")
    List<Doctor> findDoctorsWithDepartment();

    @Query("SELECT COUNT(d) FROM Doctor d WHERE d.department.id = :departmentId")
    Long countByDepartmentId(@Param("departmentId") Long departmentId);

    @Query("SELECT d FROM Doctor d WHERE d.shiftSchedule = :shiftSchedule")
    List<Doctor> findByShiftSchedule(@Param("shiftSchedule") String shiftSchedule);

    // Find by email or contact number
    @Query("SELECT d FROM Doctor d WHERE d.email = :email OR d.contactNumber = :identifier")
    Optional<Doctor> findByEmailOrContactNumber(@Param("identifier") String identifier);

    // Find doctor by username (through User profile link)
    @Query("SELECT d FROM Doctor d WHERE d.id IN (SELECT u.profileId FROM User u WHERE u.username = :username AND u.role = 'DOCTOR')")
    Optional<Doctor> findByUsername(@Param("username") String username);

    // Comprehensive lookup method
    @Query("SELECT d FROM Doctor d WHERE d.email = :identifier OR d.name LIKE %:identifier%")
    List<Doctor> findByIdentifier(@Param("identifier") String identifier);

    // ✅ REPLACED: findByUser with findByProfileId
    @Query("SELECT d FROM Doctor d WHERE d.id = :profileId")
    Optional<Doctor> findByProfileId(@Param("profileId") Long profileId);

    // ✅ ADD: Find doctor by user ID
    @Query("SELECT d FROM Doctor d WHERE d.id IN (SELECT u.profileId FROM User u WHERE u.id = :userId AND u.role = 'DOCTOR')")
    Optional<Doctor> findByUserId(@Param("userId") Long userId);

    // Existing methods
    Optional<Doctor> findByEmail(String email);
    List<Doctor> findByDepartmentAndIsActiveTrue(Department department);

    // ✅ ADD: Additional useful methods
    @Query("SELECT d FROM Doctor d WHERE d.isActive = true AND d.department IS NOT NULL ORDER BY d.name")
    List<Doctor> findAllActiveDoctorsWithDepartment();

    @Query("SELECT DISTINCT d.specialization FROM Doctor d WHERE d.isActive = true")
    List<String> findDistinctSpecializations();
}