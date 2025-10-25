package com.hms.hospitalmanagementsystem.service;

import com.hms.hospitalmanagementsystem.entity.LabDepartment;
import com.hms.hospitalmanagementsystem.repository.LabDepartmentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class LabDepartmentService {

    @Autowired
    private LabDepartmentRepository labDepartmentRepository;

    public List<LabDepartment> getAllLabDepartments() {
        return labDepartmentRepository.findAll();
    }

    public LabDepartment getLabDepartmentById(Long id) {
        Optional<LabDepartment> department = labDepartmentRepository.findById(id);
        return department.orElse(null);
    }

    public LabDepartment saveLabDepartment(LabDepartment labDepartment) {
        return labDepartmentRepository.save(labDepartment);
    }

    public void deleteLabDepartment(Long id) {
        labDepartmentRepository.deleteById(id);
    }

    public List<LabDepartment> searchLabDepartments(String name) {
        return labDepartmentRepository.findByNameContainingIgnoreCase(name);
    }
}