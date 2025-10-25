package com.hms.hospitalmanagementsystem.repository;

import com.hms.hospitalmanagementsystem.entity.LabTest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface LabTestRepository extends JpaRepository<LabTest, Long> {
    List<LabTest> findByPatientId(Long patientId);
    List<LabTest> findByDoctorId(Long doctorId);
    List<LabTest> findByLabTechnicianId(Long labTechnicianId);
    List<LabTest> findByStatus(String status);
    List<LabTest> findByTestType(String testType);
    List<LabTest> findByPriority(String priority);
    Optional<LabTest> findById(Long id);
    // Add this method to LabTestRepository.java
    List<LabTest> findByPatientIdAndStatus(Long patientId, String status);

    @Query("SELECT lt FROM LabTest lt WHERE lt.requestedDate BETWEEN :startDate AND :endDate")
    List<LabTest> findTestsBetweenDates(LocalDateTime startDate, LocalDateTime endDate);

    @Query("SELECT lt FROM LabTest lt WHERE lt.status = 'REQUESTED' OR lt.status = 'IN_PROGRESS'")
    List<LabTest> findPendingTests();

    @Query("SELECT COUNT(lt) FROM LabTest lt WHERE lt.status = 'COMPLETED' AND lt.completedDate BETWEEN :startDate AND :endDate")
    Long countCompletedTestsByDateRange(LocalDateTime startDate, LocalDateTime endDate);

    @Query("SELECT lt FROM LabTest lt WHERE lt.isAbnormal = true AND lt.status = 'COMPLETED'")
    List<LabTest> findAbnormalResults();

    // Use the correct field names that exist in your LabTest entity
//    @Query("SELECT lt FROM LabTest lt WHERE lt.status = 'PENDING' AND lt.requestingDoctor.id = :doctorId")
//    List<LabTest> findPendingTestsByDoctorId(Long doctorId);
//
//    @Query("SELECT lt FROM LabTest lt WHERE lt.resultStatus = 'ABNORMAL' AND lt.requestingDoctor.id = :doctorId")
//    List<LabTest> findAbnormalResultsByDoctorId(Long doctorId);
}