package com.hms.hospitalmanagementsystem.service;

import com.hms.hospitalmanagementsystem.entity.Appointment;
import com.hms.hospitalmanagementsystem.entity.Patient;
import com.hms.hospitalmanagementsystem.repository.AdmissionRepository;
import com.hms.hospitalmanagementsystem.repository.AppointmentRepository;
import com.hms.hospitalmanagementsystem.repository.PatientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ReceptionistService {

    @Autowired
    private AppointmentRepository appointmentRepository;

    @Autowired
    private PatientRepository patientRepository;

    // Add to ReceptionistService.java
    @Autowired
    private AdmissionRepository admissionRepository;

    public Map<String, Object> getDashboardStatistics() {
        Map<String, Object> stats = new HashMap<>();

        try {
            // Today's appointments count
            Long todaysAppointments = appointmentRepository.countByAppointmentDateTimeBetween(
                    LocalDate.now().atStartOfDay(),
                    LocalDate.now().atTime(23, 59, 59)
            );
            stats.put("todayAppointments", todaysAppointments != null ? todaysAppointments : 0L);

            // Total appointments count
            Long totalAppointments = appointmentRepository.count();
            stats.put("totalAppointments", totalAppointments != null ? totalAppointments : 0L);

            // New patients count
            Long newPatients = patientRepository.count();
            stats.put("newPatients", newPatients != null ? newPatients : 0L);

            // Current admissions count
            Long currentAdmissions = admissionRepository.countCurrentAdmissions();
            stats.put("currentAdmissions", currentAdmissions != null ? currentAdmissions : 0L);

            // Placeholder values
            stats.put("pendingRegistrations", 5L);
            stats.put("onlineDoctorsCount", 8L);
            stats.put("availableRooms", 12L);
            stats.put("pendingPayments", 3L);

        } catch (Exception e) {
            // Default values if there's an error
            stats.put("todayAppointments", 0L);
            stats.put("totalAppointments", 0L);
            stats.put("newPatients", 0L);
            stats.put("currentAdmissions", 0L);
            stats.put("pendingRegistrations", 0L);
            stats.put("onlineDoctorsCount", 0L);
            stats.put("availableRooms", 0L);
            stats.put("pendingPayments", 0L);
        }

        return stats;
    }

    public List<Appointment> getTodaysAppointmentsList() {
        try {
            return appointmentRepository.findByAppointmentDateTimeBetween(
                    LocalDate.now().atStartOfDay(),
                    LocalDate.now().atTime(23, 59, 59)
            );
        } catch (Exception e) {
            return List.of(); // Return empty list if error
        }
    }

    public List<Patient> getRecentPatientsList(int count) {
        try {
            List<Patient> allPatients = patientRepository.findAll();
            return allPatients.subList(0, Math.min(count, allPatients.size()));
        } catch (Exception e) {
            return List.of(); // Return empty list if error
        }
    }
}