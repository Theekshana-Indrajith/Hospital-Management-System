// BedRepository.java
package com.hms.hospitalmanagementsystem.repository;

import com.hms.hospitalmanagementsystem.entity.Bed;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;
import java.util.Optional;

public interface BedRepository extends JpaRepository<Bed, Long> {
    List<Bed> findByWardId(Long wardId);
    List<Bed> findByStatus(String status);
    Optional<Bed> findByBedNumberAndWardId(String bedNumber, Long wardId);
    List<Bed> findByWardIdAndOccupiedFalse(Long wardId);
    // Add to BedRepository.java
    List<Bed> findByWardIdAndStatus(Long wardId, String status);


    @Query("SELECT b FROM Bed b WHERE b.ward.id = :wardId AND b.status = 'AVAILABLE'")
    List<Bed> findAvailableBedsByWardId(Long wardId);

    @Query("SELECT b FROM Bed b WHERE b.patient.id = :patientId AND b.status = 'OCCUPIED'")
    Optional<Bed> findOccupiedBedByPatientId(Long patientId);

    @Query("SELECT COUNT(b) FROM Bed b WHERE b.ward.id = :wardId")
    Long countBedsByWardId(Long wardId);
}