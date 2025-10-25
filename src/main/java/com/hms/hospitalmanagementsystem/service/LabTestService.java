package com.hms.hospitalmanagementsystem.service;

import com.hms.hospitalmanagementsystem.entity.LabTest;
import com.hms.hospitalmanagementsystem.entity.Patient;
import com.hms.hospitalmanagementsystem.entity.Doctor;
import com.hms.hospitalmanagementsystem.entity.Staff;
import com.hms.hospitalmanagementsystem.repository.LabTestRepository;
import com.hms.hospitalmanagementsystem.repository.PatientRepository;
import com.hms.hospitalmanagementsystem.repository.DoctorRepository;
import com.hms.hospitalmanagementsystem.repository.StaffRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class LabTestService {

    @Autowired
    private LabTestRepository labTestRepository;

    @Autowired
    private PatientRepository patientRepository;

    @Autowired
    private DoctorRepository doctorRepository;

    @Autowired
    private StaffRepository staffRepository;

    public List<LabTest> getAllLabTests() {
        return labTestRepository.findAll();
    }

    public LabTest getLabTestById(Long id) {
        Optional<LabTest> labTest = labTestRepository.findById(id);
        return labTest.orElse(null);
    }

    public LabTest saveLabTest(LabTest labTest) {
        return labTestRepository.save(labTest);
    }

    public LabTest requestLabTest(Long patientId, Long doctorId, String testName, String testType, String priority) {
        Patient patient = patientRepository.findById(patientId).orElse(null);
        Doctor doctor = doctorRepository.findById(doctorId).orElse(null);

        if (patient != null && doctor != null) {
            LabTest labTest = new LabTest(patient, doctor, testName, testType, priority);
            return labTestRepository.save(labTest);
        }
        throw new RuntimeException("Patient or Doctor not found");
    }

    public LabTest assignLabTechnician(Long testId, Long labTechnicianId) {
        Optional<LabTest> testOpt = labTestRepository.findById(testId);
        Optional<Staff> technicianOpt = staffRepository.findById(labTechnicianId);

        if (testOpt.isPresent() && technicianOpt.isPresent()) {
            LabTest labTest = testOpt.get();
            labTest.setLabTechnician(technicianOpt.get());
            labTest.setStatus("IN_PROGRESS");
            labTest.setCollectionDate(LocalDateTime.now());
            return labTestRepository.save(labTest);
        }
        throw new RuntimeException("Lab test or technician not found");
    }

    public LabTest updateTestResults(Long testId, String results, String normalRange, String units, String findings, String notes) {
        Optional<LabTest> testOpt = labTestRepository.findById(testId);
        if (testOpt.isPresent()) {
            LabTest labTest = testOpt.get();
            labTest.setResults(results);
            labTest.setNormalRange(normalRange);
            labTest.setUnits(units);
            labTest.setFindings(findings);
            labTest.setNotes(notes);
            labTest.setStatus("COMPLETED");
            labTest.setCompletedDate(LocalDateTime.now());

            // Simple abnormality detection
            if (findings != null && findings.toLowerCase().contains("abnormal")) {
                labTest.setIsAbnormal(true);
            }

            return labTestRepository.save(labTest);
        }
        throw new RuntimeException("Lab test not found");
    }

    public List<LabTest> getTestsByPatient(Long patientId) {
        return labTestRepository.findByPatientId(patientId);
    }

    public List<LabTest> getTestsByDoctor(Long doctorId) {
        return labTestRepository.findByDoctorId(doctorId);
    }

    public List<LabTest> getTestsByTechnician(Long technicianId) {
        return labTestRepository.findByLabTechnicianId(technicianId);
    }

    public List<LabTest> getPendingTests() {
        return labTestRepository.findPendingTests();
    }

    public List<LabTest> getCompletedTests() {
        return labTestRepository.findByStatus("COMPLETED");
    }

    public List<LabTest> getAbnormalResults() {
        return labTestRepository.findAbnormalResults();
    }

    public Long getTodayCompletedTests() {
        LocalDateTime startOfDay = LocalDateTime.now().withHour(0).withMinute(0).withSecond(0);
        LocalDateTime endOfDay = LocalDateTime.now().withHour(23).withMinute(59).withSecond(59);
        return labTestRepository.countCompletedTestsByDateRange(startOfDay, endOfDay);
    }

    public void deleteLabTest(Long id) {
        labTestRepository.deleteById(id);
    }

    public List<LabTest> getPendingTestsByPatient(Long patientId) {
        try {
            return labTestRepository.findByPatientIdAndStatus(patientId, "PENDING");
        } catch (Exception e) {
            return new ArrayList<>();
        }
    }

    // Add these methods to LabTestService.java

//    public List<LabTest> getPendingTestsByDoctor(Long doctorId) {
//        try {
//            return labTestRepository.findPendingTestsByDoctorId(doctorId);
//        } catch (Exception e) {
//            System.err.println("Error getting pending tests for doctor " + doctorId + ": " + e.getMessage());
//            return new ArrayList<>();
//        }
//    }

//    public List<LabTest> getAbnormalResultsByDoctor(Long doctorId) {
//        try {
//            return labTestRepository.findAbnormalResultsByDoctorId(doctorId);
//        } catch (Exception e) {
//            System.err.println("Error getting abnormal results for doctor " + doctorId + ": " + e.getMessage());
//            return new ArrayList<>();
//        }
//    }
    public LabTest getTestById(Long id) {
        return labTestRepository.findById(id).orElse(null);
    }
}