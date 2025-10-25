package com.hms.hospitalmanagementsystem.repository;

import com.hms.hospitalmanagementsystem.entity.Prescription;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;

public interface PrescriptionRepository extends JpaRepository<Prescription, Long> {
    List<Prescription> findByPatientId(Long patientId);
    List<Prescription> findByDoctorId(Long doctorId);
    List<Prescription> findByPatientIdAndIsActiveTrue(Long patientId);
    List<Prescription> findByStatus(String status);

    @Query("SELECT p FROM Prescription p WHERE p.patient.id = :patientId AND p.status = 'ACTIVE'")
    List<Prescription> findActivePrescriptionsByPatient(Long patientId);

    @Query("SELECT COUNT(p) FROM Prescription p WHERE p.patient.id = :patientId AND p.status = 'ACTIVE'")
    Long countActivePrescriptionsByPatient(Long patientId);

    @Query("SELECT p FROM Prescription p WHERE p.doctor.id = :doctorId AND p.status = 'ACTIVE'")
    List<Prescription> findActivePrescriptionsByDoctor(Long doctorId);
}