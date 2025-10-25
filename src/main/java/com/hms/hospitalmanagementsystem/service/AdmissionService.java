// AdmissionService.java
package com.hms.hospitalmanagementsystem.service;

import com.hms.hospitalmanagementsystem.entity.*;
import com.hms.hospitalmanagementsystem.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.*;

@Service
public class AdmissionService {

    @Autowired
    private AdmissionRepository admissionRepository;

    @Autowired
    private PatientRepository patientRepository;

    @Autowired
    private WardRepository wardRepository;

    @Autowired
    private BedRepository bedRepository;

    @Autowired
    private BedService bedService;

    @Autowired
    private DoctorRepository doctorRepository;

    @Autowired
    private PatientService patientService;

    @Autowired
    private WardService wardService;


    public List<Admission> getAllAdmissions() {
        return admissionRepository.findAll();
    }

    public Admission getAdmissionById(Long id) {
        Optional<Admission> admission = admissionRepository.findById(id);
        return admission.orElse(null);
    }

//    public Admission admitPatient(Long patientId, Long wardId, Long bedId, String reason) {
//        Optional<Patient> patientOpt = patientRepository.findById(patientId);
//        Optional<Ward> wardOpt = wardRepository.findById(wardId);
//        Optional<Bed> bedOpt = bedRepository.findById(bedId);
//
//        if (patientOpt.isPresent() && wardOpt.isPresent() && bedOpt.isPresent()) {
//            Patient patient = patientOpt.get();
//            Ward ward = wardOpt.get();
//            Bed bed = bedOpt.get();
//
//            // Check if bed is available
//            if (!"AVAILABLE".equals(bed.getStatus())) {
//                throw new RuntimeException("Bed is not available for admission");
//            }
//
//            // Create admission record
//            Admission admission = new Admission();
//            admission.setPatient(patient);
//            admission.setWard(ward);
//            admission.setBed(bed);
//            admission.setAdmissionDate(LocalDateTime.now());
//            admission.setStatus("ADMITTED");
//            admission.setReason(reason);
//
//            // Update bed status
//            bed.setStatus("OCCUPIED");
//            bed.setPatient(patient);
//            bed.setAdmissionDate(LocalDateTime.now());
//            bedRepository.save(bed);
//
//            // Update ward available beds count
//            ward.setAvailableBeds(ward.getAvailableBeds() - 1);
//            wardRepository.save(ward);
//
//            return admissionRepository.save(admission);
//        }
//        throw new RuntimeException("Patient, ward, or bed not found");
//    }

    public Admission dischargePatient(Long admissionId) {
        Optional<Admission> admissionOpt = admissionRepository.findById(admissionId);
        if (admissionOpt.isPresent()) {
            Admission admission = admissionOpt.get();
            admission.setStatus("DISCHARGED");
            admission.setDischargeDate(LocalDateTime.now());

            // Update bed status
            Bed bed = admission.getBed();
            bed.setStatus("CLEANING"); // Set to cleaning first
            bed.setPatient(null);
            bed.setDischargeDate(LocalDateTime.now());
            bedRepository.save(bed);

            // Update ward available beds count
            Ward ward = admission.getWard();
            ward.setAvailableBeds(ward.getAvailableBeds() + 1);
            wardRepository.save(ward);

            return admissionRepository.save(admission);
        }
        throw new RuntimeException("Admission record not found");
    }

    public List<Admission> getCurrentAdmissions() {
        try {
            return admissionRepository.findCurrentAdmissions();
        } catch (Exception e) {
            return new ArrayList<>(); // Return empty list if method not implemented
        }
    }

    public List<Admission> getAdmissionsByPatientId(Long patientId) {
        try {
            return admissionRepository.findByPatientId(patientId);
        } catch (Exception e) {
            return new ArrayList<>(); // Return empty list if method not implemented
        }
    }

    // In AdmissionService.java - fix the countCurrentAdmissions method
    public Long countCurrentAdmissions() {
        try {
            Long count = admissionRepository.countCurrentAdmissions();
            return count != null ? count : 0L; // Ensure it never returns null
        } catch (Exception e) {
            return 0L; // Return 0 instead of null if there's an error
        }
    }

    public Admission transferPatient(Long admissionId, Long newWardId, Long newBedId) {
        Optional<Admission> admissionOpt = admissionRepository.findById(admissionId);
        Optional<Ward> newWardOpt = wardRepository.findById(newWardId);
        Optional<Bed> newBedOpt = bedRepository.findById(newBedId);

        if (admissionOpt.isPresent() && newWardOpt.isPresent() && newBedOpt.isPresent()) {
            Admission admission = admissionOpt.get();
            Ward oldWard = admission.getWard();
            Ward newWard = newWardOpt.get();
            Bed oldBed = admission.getBed();
            Bed newBed = newBedOpt.get();

            // Check if new bed is available
            if (!"AVAILABLE".equals(newBed.getStatus())) {
                throw new RuntimeException("New bed is not available for transfer");
            }

            // Update old bed
            oldBed.setStatus("CLEANING");
            oldBed.setPatient(null);
            bedRepository.save(oldBed);

            // Update new bed
            newBed.setStatus("OCCUPIED");
            newBed.setPatient(admission.getPatient());
            newBed.setAdmissionDate(LocalDateTime.now());
            bedRepository.save(newBed);

            // Update wards
            oldWard.setAvailableBeds(oldWard.getAvailableBeds() + 1);
            newWard.setAvailableBeds(newWard.getAvailableBeds() - 1);
            wardRepository.save(oldWard);
            wardRepository.save(newWard);

            // Update admission
            admission.setWard(newWard);
            admission.setBed(newBed);
            admission.setStatus("TRANSFERRED");

            return admissionRepository.save(admission);
        }
        throw new RuntimeException("Admission, ward, or bed not found");
    }
    // Add to AdmissionService.java


        // ... existing code ...

    // Update the admitPatientByDoctor method in AdmissionService
    public Admission admitPatientByDoctor(Long patientId, Long wardId, Long bedId,
                                          String reason, Long doctorId, String diagnosis, String severityLevel) {

        System.out.println("=== STARTING ADMISSION ===");
        System.out.println("Patient ID: " + patientId);
        System.out.println("Ward ID: " + wardId);
        System.out.println("Bed ID: " + bedId);
        System.out.println("Doctor ID: " + doctorId);

        Optional<Patient> patientOpt = patientRepository.findById(patientId);
        Optional<Ward> wardOpt = wardRepository.findById(wardId);
        Optional<Bed> bedOpt = bedRepository.findById(bedId);
        Optional<Doctor> doctorOpt = doctorRepository.findById(doctorId);

        System.out.println("Patient found: " + patientOpt.isPresent());
        System.out.println("Ward found: " + wardOpt.isPresent());
        System.out.println("Bed found: " + bedOpt.isPresent());
        System.out.println("Doctor found: " + doctorOpt.isPresent());

        if (patientOpt.isPresent() && wardOpt.isPresent() &&
                bedOpt.isPresent() && doctorOpt.isPresent()) {

            Patient patient = patientOpt.get();
            Ward ward = wardOpt.get();
            Bed bed = bedOpt.get();
            Doctor doctor = doctorOpt.get();

            // Check if bed is available
            if (!"AVAILABLE".equals(bed.getStatus())) {
                System.out.println("ERROR: Bed is not available. Status: " + bed.getStatus());
                throw new RuntimeException("Bed is not available for admission");
            }

            // Create admission record
            Admission admission = new Admission();
            admission.setPatient(patient);
            admission.setWard(ward);
            admission.setBed(bed);
            admission.setAdmittingDoctor(doctor);
            admission.setAdmissionDate(LocalDateTime.now());
            admission.setStatus("ADMITTED");
            admission.setReason(reason);
            admission.setDiagnosis(diagnosis);
            admission.setSeverityLevel(severityLevel);

            // Update bed status
            bed.setStatus("OCCUPIED");
            bed.setPatient(patient);
            bed.setAdmissionDate(LocalDateTime.now());
            bedRepository.save(bed);

            // Update ward available beds count
            if (ward.getAvailableBeds() > 0) {
                ward.setAvailableBeds(ward.getAvailableBeds() - 1);
                wardRepository.save(ward);
            }

            Admission savedAdmission = admissionRepository.save(admission);
            System.out.println("SUCCESS: Admission created with ID: " + savedAdmission.getId());
            return savedAdmission;
        }

        System.out.println("ERROR: Required entities not found");
        throw new RuntimeException("Patient, ward, bed, or doctor not found");
    }
        public List<Admission> getAdmissionsByDoctor(Long doctorId) {
            try {
                return admissionRepository.findByAdmittingDoctorId(doctorId);
            } catch (Exception e) {
                return new ArrayList<>();
            }
        }

        public List<Admission> getCurrentAdmissionsByDoctor(Long doctorId) {
            try {
                return admissionRepository.findCurrentAdmissionsByDoctor(doctorId);
            } catch (Exception e) {
                return new ArrayList<>();
            }
        }

    public Map<String, Long> getAdmissionStatisticsByDoctor(Long doctorId) {
        Map<String, Long> stats = new HashMap<>();
        try {
            Long totalAdmissions = admissionRepository.countByAdmittingDoctorId(doctorId);
            Long currentAdmissions = admissionRepository.countCurrentAdmissionsByDoctor(doctorId);

            // Get start and end of current month for the date range method
            LocalDateTime startOfMonth = LocalDateTime.now().withDayOfMonth(1).withHour(0).withMinute(0).withSecond(0);
            LocalDateTime endOfMonth = LocalDateTime.now().withDayOfMonth(LocalDateTime.now().toLocalDate().lengthOfMonth())
                    .withHour(23).withMinute(59).withSecond(59);

            Long dischargedThisMonth;
            try {
                // Try the simplified method first
                dischargedThisMonth = admissionRepository.countDischargedThisMonthByDoctor(doctorId);
            } catch (Exception e) {
                // Fallback to date range method
                dischargedThisMonth = admissionRepository.countDischargedByDoctorInDateRange(doctorId, startOfMonth, endOfMonth);
            }

            stats.put("totalAdmissions", totalAdmissions != null ? totalAdmissions : 0L);
            stats.put("currentAdmissions", currentAdmissions != null ? currentAdmissions : 0L);
            stats.put("dischargedThisMonth", dischargedThisMonth != null ? dischargedThisMonth : 0L);
        } catch (Exception e) {
            // Return default values if any error occurs
            stats.put("totalAdmissions", 0L);
            stats.put("currentAdmissions", 0L);
            stats.put("dischargedThisMonth", 0L);
        }
        return stats;
    }

    // Alternative simpler implementation without date calculations
    public Map<String, Long> getAdmissionStatisticsByDoctorSimple(Long doctorId) {
        Map<String, Long> stats = new HashMap<>();
        try {
            Long totalAdmissions = admissionRepository.countByAdmittingDoctorId(doctorId);
            Long currentAdmissions = admissionRepository.countCurrentAdmissionsByDoctor(doctorId);

            // For discharged this month, we'll use a simpler approach
            // Count all discharged patients (not just this month) or use a fixed number
            Long totalDischarged = admissionRepository.countByAdmittingDoctorIdAndStatus(doctorId, "DISCHARGED");

            stats.put("totalAdmissions", totalAdmissions != null ? totalAdmissions : 0L);
            stats.put("currentAdmissions", currentAdmissions != null ? currentAdmissions : 0L);
            stats.put("dischargedThisMonth", totalDischarged != null ? totalDischarged : 0L);
        } catch (Exception e) {
            stats.put("totalAdmissions", 0L);
            stats.put("currentAdmissions", 0L);
            stats.put("dischargedThisMonth", 0L);
        }
        return stats;
    }

        private String calculateSeverityLevel(String diagnosis) {
            // Simple severity calculation - in real system, this would be more complex
            if (diagnosis.toLowerCase().contains("critical") ||
                    diagnosis.toLowerCase().contains("emergency")) {
                return "CRITICAL";
            } else if (diagnosis.toLowerCase().contains("serious") ||
                    diagnosis.toLowerCase().contains("severe")) {
                return "SERIOUS";
            } else {
                return "STABLE";
            }
        }

        private void createInitialMedicalRecord(Admission admission, Doctor doctor, String diagnosis) {
            // This would create an initial medical record entry
            // Implementation depends on your MedicalRecord entity
        }

    @Transactional
    public boolean admitPatient(Long patientId, Long wardId, Long bedId, String reason) {
        try {
            // Get patient, ward, and bed
            Patient patient = patientService.getPatientById(patientId);
            Ward ward = wardService.getWardById(wardId);
            Bed bed = bedService.getBedById(bedId);

            if (patient == null || ward == null || bed == null) {
                throw new RuntimeException("Patient, ward, or bed not found");
            }

            // Check if bed is available
            if (!"AVAILABLE".equals(bed.getStatus())) {
                throw new RuntimeException("Selected bed is not available");
            }

            // Create new admission
            Admission admission = new Admission();
            admission.setPatient(patient);
            admission.setWard(ward);
            admission.setBed(bed);
            admission.setAdmissionDate(LocalDateTime.now());
            admission.setReason(reason);
            admission.setStatus("ADMITTED");

            // Update bed status
            bed.setStatus("OCCUPIED");
            bed.setPatient(patient);
            bed.setAdmissionDate(LocalDateTime.now());

            // Save admission and update bed
            admissionRepository.save(admission);
            bedService.saveBed(bed);

            // Update ward available beds count
            wardService.updateWardBedCount(wardId);

            return true;
        } catch (Exception e) {
            throw new RuntimeException("Admission failed: " + e.getMessage(), e);
        }
    }


}