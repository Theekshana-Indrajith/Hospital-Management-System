package com.hms.hospitalmanagementsystem.service;

import com.hms.hospitalmanagementsystem.entity.Appointment;
import com.hms.hospitalmanagementsystem.entity.LabTest;
import com.hms.hospitalmanagementsystem.entity.Patient;
import com.hms.hospitalmanagementsystem.entity.Prescription;
import com.hms.hospitalmanagementsystem.repository.AppointmentRepository;
import com.hms.hospitalmanagementsystem.repository.LabTestRepository;
import com.hms.hospitalmanagementsystem.repository.PatientRepository;
import com.hms.hospitalmanagementsystem.repository.PrescriptionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class PatientService {

    @Autowired
    private PatientRepository patientRepository;

    @Autowired
    private PrescriptionService prescriptionService;

    @Autowired
    private LabTestService labTestService;

    @Autowired
    private AppointmentRepository appointmentRepository;

    @Autowired
    private LabTestRepository labTestRepository;

    @Autowired
    private PrescriptionRepository prescriptionRepository;


    public List<Patient> getAllPatients() {
        return patientRepository.findAll();
    }

    public Patient getPatientById(Long id) {
        Optional<Patient> patient = patientRepository.findById(id);
        return patient.orElse(null);
    }
    public int getAllUsersCount() {
        // This should be in UserService, adding here for simplicity
        return patientRepository.findAll().size(); // This is just a placeholder
    }
    public List<Appointment> getAppointmentsByPatientId(Long patientId) {
        try {
            return appointmentRepository.findByPatientId(patientId);
        } catch (Exception e) {
            return new ArrayList<>();
        }
    }


    public Patient savePatient(Patient patient) {
        return patientRepository.save(patient);
    }

    public void deletePatient(Long id) {
        patientRepository.deleteById(id);
    }


    // Add to your existing PatientService.java
    public List<Patient> getNewPatientsThisWeek() {
        LocalDate weekStart = LocalDate.now().with(DayOfWeek.MONDAY);
        // If your Patient entity has registrationDate field, use that
        // Otherwise, we'll return all patients for demo
        return patientRepository.findAll().stream()
                .limit(10) // Return first 10 patients as "new" for demo
                .collect(Collectors.toList());
    }

    public List<Patient> getRecentPatients(int count) {
        return patientRepository.findAll().stream()
                .limit(count)
                .collect(Collectors.toList());
    }

    public List<Patient> searchPatients(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return patientRepository.findAll();
        }
        return patientRepository.findByFirstNameContainingOrLastNameContainingOrEmailContainingOrContactNumberContaining(
                keyword, keyword, keyword, keyword
        );
    }

    public Long countPatientsRegisteredThisWeek() {
        LocalDate weekStart = LocalDate.now().with(DayOfWeek.MONDAY);
        // For demo, return approximate count
        return patientRepository.count();
    }
    // Add to PatientService.java
    public Long countPrescriptionsByPatient(Long patientId) {
        return prescriptionService.getPrescriptionsByPatient(patientId).stream().count();
    }

    public Long countLabTestsByPatient(Long patientId) {
        return labTestService.getTestsByPatient(patientId).stream().count();
    }

    public List<LabTest> getTestsByPatient(Long patientId) {
        try {
            return labTestRepository.findByPatientId(patientId);
        } catch (Exception e) {
            return new ArrayList<>();
        }
    }

    public List<Prescription> getPrescriptionsByPatient(Long patientId) {
        try {
            return prescriptionRepository.findByPatientId(patientId);
        } catch (Exception e) {
            return new ArrayList<>();
        }
    }

    public Map<Long, Long> getPrescriptionCountsForPatients(List<Patient> patients) {
        Map<Long, Long> prescriptionCounts = new HashMap<>();
        for (Patient patient : patients) {
            Long count = countPrescriptionsByPatient(patient.getId());
            prescriptionCounts.put(patient.getId(), count);
        }
        return prescriptionCounts;
    }

    public Map<Long, Long> getLabTestCountsForPatients(List<Patient> patients) {
        Map<Long, Long> labTestCounts = new HashMap<>();
        for (Patient patient : patients) {
            Long count = countLabTestsByPatient(patient.getId());
            labTestCounts.put(patient.getId(), count);
        }
        return labTestCounts;
    }

    public List<Patient> getPatientsWithRecentAppointments(Long doctorId) {
        try {
            // Get appointments for this doctor from the last 30 days
            LocalDateTime startDate = LocalDateTime.now().minusDays(30);
            List<Appointment> recentAppointments = appointmentRepository
                    .findByDoctorIdAndAppointmentDateTimeAfter(doctorId, startDate);

            // Extract unique patients
            return recentAppointments.stream()
                    .map(Appointment::getPatient)
                    .distinct()
                    .collect(Collectors.toList());
        } catch (Exception e) {
            return new ArrayList<>();
        }
    }

    // Alternative method if you want all patients (fallback)
    public List<Patient> getAllPatientsForAdmission() {
        return patientRepository.findAll();
    }


}