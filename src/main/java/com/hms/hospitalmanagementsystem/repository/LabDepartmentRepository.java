package com.hms.hospitalmanagementsystem.repository;

import com.hms.hospitalmanagementsystem.entity.LabDepartment;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface LabDepartmentRepository extends JpaRepository<LabDepartment, Long> {
    Optional<LabDepartment> findByName(String name);
    List<LabDepartment> findByNameContainingIgnoreCase(String name);
}