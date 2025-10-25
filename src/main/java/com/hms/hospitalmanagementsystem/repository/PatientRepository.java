package com.hms.hospitalmanagementsystem.repository;

import com.hms.hospitalmanagementsystem.entity.Patient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface PatientRepository extends JpaRepository<Patient, Long> {

    // Existing search methods
    List<Patient> findByLastNameContainingIgnoreCase(String lastName);
    List<Patient> findByFirstNameContainingIgnoreCase(String firstName);

    // Medical information queries
    List<Patient> findByBloodType(String bloodType);
    List<Patient> findByAllergiesContaining(String allergy);
    List<Patient> findByEmergencyContactNameIsNotNull();

    // Comprehensive search
    List<Patient> findByFirstNameContainingOrLastNameContainingOrEmailContainingOrContactNumberContaining(
            String firstName, String lastName, String email, String contactNumber);

    // Date-based queries
    @Query("SELECT p FROM Patient p WHERE p.dateOfBirth >= :sinceDate")
    List<Patient> findPatientsRegisteredAfter(@Param("sinceDate") LocalDate sinceDate);

    // ✅ REPLACED: findByUser with findByProfileId
    @Query("SELECT p FROM Patient p WHERE p.id = :profileId")
    Optional<Patient> findByProfileId(@Param("profileId") Long profileId);

    // ✅ ADD: Find patient by user ID
    @Query("SELECT p FROM Patient p WHERE p.id IN (SELECT u.profileId FROM User u WHERE u.id = :userId AND u.role = 'PATIENT')")
    Optional<Patient> findByUserId(@Param("userId") Long userId);

    // Existing methods
    Optional<Patient> findByEmail(String email);
    List<Patient> findByContactNumber(String contactNumber);

    // ✅ ADD: Additional useful methods
    @Query("SELECT p FROM Patient p WHERE LOWER(CONCAT(p.firstName, ' ', p.lastName)) LIKE LOWER(CONCAT('%', :name, '%'))")
    List<Patient> findByFullNameContainingIgnoreCase(@Param("name") String name);

    @Query("SELECT COUNT(p) FROM Patient p WHERE p.dateOfBirth BETWEEN :startDate AND :endDate")
    Long countPatientsByAgeRange(@Param("startDate") LocalDate startDate, @Param("endDate") LocalDate endDate);

    @Query("SELECT p FROM Patient p WHERE p.gender = :gender")
    List<Patient> findByGender(@Param("gender") String gender);

    // Find patients with upcoming birthdays
    @Query("SELECT p FROM Patient p WHERE MONTH(p.dateOfBirth) = :month AND DAY(p.dateOfBirth) = :day")
    List<Patient> findByBirthdayMonthAndDay(@Param("month") int month, @Param("day") int day);
}