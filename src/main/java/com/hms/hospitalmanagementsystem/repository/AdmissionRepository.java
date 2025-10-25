// AdmissionRepository.java
package com.hms.hospitalmanagementsystem.repository;

import com.hms.hospitalmanagementsystem.entity.Admission;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface AdmissionRepository extends JpaRepository<Admission, Long> {
    List<Admission> findByPatientId(Long patientId);
    List<Admission> findByStatus(String status);
    Optional<Admission> findByPatientIdAndStatus(Long patientId, String status);
    List<Admission> findByAdmittingDoctorId(Long doctorId);

    @Query("SELECT a FROM Admission a WHERE a.admissionDate BETWEEN :startDate AND :endDate")
    List<Admission> findAdmissionsBetweenDates(LocalDateTime startDate, LocalDateTime endDate);

    @Query("SELECT a FROM Admission a WHERE a.dischargeDate IS NULL")
    List<Admission> findCurrentAdmissions();

    @Query("SELECT COUNT(a) FROM Admission a WHERE a.status = 'ADMITTED'")
    Long countCurrentAdmissions();

    @Query("SELECT a FROM Admission a WHERE a.admittingDoctor.id = :doctorId AND a.dischargeDate IS NULL")
    List<Admission> findCurrentAdmissionsByDoctor(Long doctorId);

    @Query("SELECT COUNT(a) FROM Admission a WHERE a.admittingDoctor.id = :doctorId")
    Long countByAdmittingDoctorId(Long doctorId);

    @Query("SELECT COUNT(a) FROM Admission a WHERE a.admittingDoctor.id = :doctorId AND a.dischargeDate IS NULL")
    Long countCurrentAdmissionsByDoctor(Long doctorId);

    @Query("SELECT COUNT(a) FROM Admission a WHERE a.admittingDoctor.id = :doctorId " +
            "AND a.dischargeDate >= :startOfMonth AND a.dischargeDate <= :endOfMonth")
    Long countDischargedThisMonthByDoctor(@Param("doctorId") Long doctorId,
                                          @Param("startOfMonth") LocalDateTime startOfMonth,
                                          @Param("endOfMonth") LocalDateTime endOfMonth);

    @Query("SELECT a FROM Admission a WHERE a.admittingDoctor.id = :doctorId " +
            "AND a.status = 'ADMITTED' ORDER BY a.admissionDate DESC")
    List<Admission> findActiveAdmissionsByDoctor(Long doctorId);

    @Query("SELECT COUNT(a) FROM Admission a WHERE a.admittingDoctor.id = :doctorId " +
            "AND a.dischargeDate IS NOT NULL " +
            "AND YEAR(a.dischargeDate) = YEAR(CURRENT_DATE) " +
            "AND MONTH(a.dischargeDate) = MONTH(CURRENT_DATE)")
    Long countDischargedThisMonthByDoctor(@Param("doctorId") Long doctorId);

    // Alternative method if the above doesn't work with your database
    @Query("SELECT COUNT(a) FROM Admission a WHERE a.admittingDoctor.id = :doctorId " +
            "AND a.dischargeDate BETWEEN :startDate AND :endDate")
    Long countDischargedByDoctorInDateRange(@Param("doctorId") Long doctorId,
                                            @Param("startDate") LocalDateTime startDate,
                                            @Param("endDate") LocalDateTime endDate);

    // Add to AdmissionRepository.java
    @Query("SELECT COUNT(a) FROM Admission a WHERE a.admittingDoctor.id = :doctorId AND a.status = :status")
    Long countByAdmittingDoctorIdAndStatus(@Param("doctorId") Long doctorId, @Param("status") String status);

}