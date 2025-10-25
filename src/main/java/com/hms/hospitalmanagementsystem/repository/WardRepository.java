// WardRepository.java - Add department-based methods
package com.hms.hospitalmanagementsystem.repository;

import com.hms.hospitalmanagementsystem.entity.Ward;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;
import java.util.Optional;

public interface WardRepository extends JpaRepository<Ward, Long> {
    Optional<Ward> findByWardNumber(String wardNumber);
    List<Ward> findByWardTypeContainingIgnoreCase(String wardType);
    List<Ward> findByAvailableBedsGreaterThan(int minBeds);


    // NEW: Department-based queries
    List<Ward> findByDepartmentId(Long departmentId);

    @Query("SELECT w FROM Ward w WHERE w.availableBeds > 0 ORDER BY w.wardType")
    List<Ward> findAvailableWards();

    @Query("SELECT w FROM Ward w WHERE w.department.id = :departmentId AND w.availableBeds > 0")
    List<Ward> findAvailableWardsByDepartmentId(Long departmentId);

    @Query("SELECT COUNT(b) FROM Bed b WHERE b.ward.id = :wardId AND b.status = 'OCCUPIED'")
    Long countOccupiedBedsByWardId(Long wardId);
}