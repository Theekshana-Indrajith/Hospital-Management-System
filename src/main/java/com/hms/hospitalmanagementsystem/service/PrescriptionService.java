package com.hms.hospitalmanagementsystem.service;

import com.hms.hospitalmanagementsystem.entity.Prescription;
import com.hms.hospitalmanagementsystem.entity.Patient;
import com.hms.hospitalmanagementsystem.entity.Doctor;
import com.hms.hospitalmanagementsystem.repository.PrescriptionRepository;
import com.hms.hospitalmanagementsystem.repository.PatientRepository;
import com.hms.hospitalmanagementsystem.repository.DoctorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class PrescriptionService {

    @Autowired
    private PrescriptionRepository prescriptionRepository;

    @Autowired
    private PatientRepository patientRepository;

    @Autowired
    private DoctorRepository doctorRepository;

    public List<Prescription> getAllPrescriptions() {
        return prescriptionRepository.findAll();
    }

    public Prescription getPrescriptionById(Long id) {
        Optional<Prescription> prescription = prescriptionRepository.findById(id);
        return prescription.orElse(null);
    }

    public Prescription savePrescription(Prescription prescription) {
        prescription.setUpdatedAt(LocalDateTime.now());
        return prescriptionRepository.save(prescription);
    }

    public Prescription createPrescription(Long patientId, Long doctorId, String medicationName,
                                           String dosage, String frequency, String duration,
                                           String instructions) {
        try {
            Patient patient = patientRepository.findById(patientId)
                    .orElseThrow(() -> new RuntimeException("Patient not found with ID: " + patientId));
            Doctor doctor = doctorRepository.findById(doctorId)
                    .orElseThrow(() -> new RuntimeException("Doctor not found with ID: " + doctorId));

            Prescription prescription = new Prescription(patient, doctor, medicationName,
                    dosage, frequency, duration, instructions);
            return prescriptionRepository.save(prescription);
        } catch (Exception e) {
            System.out.println("ERROR creating prescription: " + e.getMessage());
            throw new RuntimeException("Failed to create prescription: " + e.getMessage());
        }
    }

    public List<Prescription> getPrescriptionsByPatient(Long patientId) {
        return prescriptionRepository.findByPatientId(patientId);
    }

    public List<Prescription> getActivePrescriptionsByPatient(Long patientId) {
        return prescriptionRepository.findActivePrescriptionsByPatient(patientId);
    }

    public List<Prescription> getPrescriptionsByDoctor(Long doctorId) {
        return prescriptionRepository.findByDoctorId(doctorId);
    }

    public List<Prescription> getActivePrescriptionsByDoctor(Long doctorId) {
        return prescriptionRepository.findActivePrescriptionsByDoctor(doctorId);
    }

    public Long getActivePrescriptionCountByPatient(Long patientId) {
        return prescriptionRepository.countActivePrescriptionsByPatient(patientId);
    }

    public Prescription updatePrescriptionStatus(Long prescriptionId, String status) {
        Optional<Prescription> prescriptionOpt = prescriptionRepository.findById(prescriptionId);
        if (prescriptionOpt.isPresent()) {
            Prescription prescription = prescriptionOpt.get();
            prescription.setStatus(status);
            prescription.setUpdatedAt(LocalDateTime.now());
            return prescriptionRepository.save(prescription);
        }
        throw new RuntimeException("Prescription not found");
    }


    public void deletePrescription(Long id) {
        prescriptionRepository.deleteById(id);
    }
}