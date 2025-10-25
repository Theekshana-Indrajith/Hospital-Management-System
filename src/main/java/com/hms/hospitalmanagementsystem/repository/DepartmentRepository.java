package com.hms.hospitalmanagementsystem.repository;

import com.hms.hospitalmanagementsystem.entity.Department;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;
import java.util.Optional;

public interface DepartmentRepository extends JpaRepository<Department, Long> {
    Optional<Department> findByName(String name);
    List<Department> findByNameContainingIgnoreCase(String name);

    @Query("SELECT d FROM Department d WHERE SIZE(d.doctors) > 0")
    List<Department> findDepartmentsWithDoctors();

    @Query("SELECT COUNT(d) FROM Doctor d WHERE d.department.id = :departmentId")
    Long countDoctorsByDepartmentId(Long departmentId);
}