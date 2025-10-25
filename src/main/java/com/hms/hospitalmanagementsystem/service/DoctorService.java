package com.hms.hospitalmanagementsystem.service;

import com.hms.hospitalmanagementsystem.entity.Doctor;
import com.hms.hospitalmanagementsystem.repository.DoctorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class DoctorService {

    @Autowired
    private DoctorRepository doctorRepository;

    public List<Doctor> getAllDoctors() {
        return doctorRepository.findAll();
    }

    public Doctor getDoctorById(Long id) {
        Optional<Doctor> doctor = doctorRepository.findById(id);
        return doctor.orElse(null);
    }

    public Doctor saveDoctor(Doctor doctor) {
        return doctorRepository.save(doctor);
    }

    public void deleteDoctor(Long id) {
        doctorRepository.deleteById(id);
    }

    public List<Doctor> searchDoctors(String specialization) {
        return doctorRepository.findBySpecializationContainingIgnoreCase(specialization);
    }
    public List<Doctor> getDoctorsBySpecialization(String specialization) {
        return doctorRepository.findBySpecialization(specialization);
    }

    public List<Doctor> getActiveDoctors() {
        return doctorRepository.findByIsActiveTrue();
    }

    // In DoctorService.java - Add these methods
    // Add these methods to DoctorService.java
    public Doctor getDoctorByUsername(String username) {
        Optional<Doctor> doctor = doctorRepository.findByUsername(username);
        return doctor.orElse(null);
    }

    public Long getDoctorIdByUsername(String username) {
        Optional<Doctor> doctor = doctorRepository.findByUsername(username);
        return doctor.map(Doctor::getId).orElse(null);
    }
}