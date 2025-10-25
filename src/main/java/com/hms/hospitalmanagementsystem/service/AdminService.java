package com.hms.hospitalmanagementsystem.service;

import com.hms.hospitalmanagementsystem.entity.Appointment;
import com.hms.hospitalmanagementsystem.entity.Ward;
import com.hms.hospitalmanagementsystem.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class AdminService {

    @Autowired private UserRepository userRepository;
    @Autowired private PatientRepository patientRepository;
    @Autowired private DoctorRepository doctorRepository;
    @Autowired private AppointmentRepository appointmentRepository;
    @Autowired private AdmissionRepository admissionRepository;
    @Autowired private WardRepository wardRepository;
    @Autowired private BedRepository bedRepository;

    public Map<String, Object> getSystemStatistics() {
        Map<String, Object> stats = new HashMap<>();

        // Real database counts
        stats.put("totalUsers", userRepository.count());
        stats.put("totalPatients", patientRepository.count());
        stats.put("totalDoctors", doctorRepository.count());
        stats.put("totalAppointments", appointmentRepository.count());

        Long currentAdmissions = admissionRepository.countCurrentAdmissions();
        stats.put("currentAdmissions", currentAdmissions != null ? currentAdmissions : 0);

        stats.put("totalWards", wardRepository.count());
        stats.put("totalBeds", bedRepository.count());

        // Role-based counts from database
        stats.put("adminCount", userRepository.countByRole("ADMIN"));
        stats.put("doctorCount", userRepository.countByRole("DOCTOR"));
        stats.put("staffCount", userRepository.countByRole("STAFF"));
        stats.put("patientUserCount", userRepository.countByRole("PATIENT"));

        return stats;
    }

    public Map<String, Object> getFinancialReport() {
        Map<String, Object> report = new HashMap<>();

        // Calculate financial data from admissions and wards
        double totalRevenue = 0.0;
        double pendingPayments = 0.0;
        double todayRevenue = 0.0;
        double monthlyRevenue = 0.0;

        // Sample calculation based on admissions (simplified)
        for (Ward ward : wardRepository.findAll()) {
            Long occupiedBeds = bedRepository.countBedsByWardId(ward.getId()) -
                    bedRepository.findAvailableBedsByWardId(ward.getId()).size();
            totalRevenue += occupiedBeds * ward.getChargePerDay() * 30; // 30 days estimate
            monthlyRevenue += occupiedBeds * ward.getChargePerDay() * 30;
            todayRevenue += occupiedBeds * ward.getChargePerDay();
        }

        report.put("totalRevenue", String.format("%.2f", totalRevenue));
        report.put("pendingPayments", String.format("%.2f", totalRevenue * 0.2)); // 20% pending
        report.put("todayRevenue", String.format("%.2f", todayRevenue));
        report.put("monthlyRevenue", String.format("%.2f", monthlyRevenue));

        return report;
    }

    public Map<String, Object> getAppointmentStatistics() {
        Map<String, Object> stats = new HashMap<>();

        // Get today's date for filtering
        LocalDate today = LocalDate.now();
        LocalDateTime todayStart = today.atStartOfDay();
        LocalDateTime todayEnd = today.atTime(23, 59, 59);

        try {
            // Use the repository methods to get actual counts from database
            Long scheduledToday = appointmentRepository.countByAppointmentDateTimeBetweenAndStatus(
                    todayStart, todayEnd, "SCHEDULED");
            stats.put("scheduledToday", scheduledToday != null ? scheduledToday : 0);

            Long completedToday = appointmentRepository.countByAppointmentDateTimeBetweenAndStatus(
                    todayStart, todayEnd, "COMPLETED");
            stats.put("completedToday", completedToday != null ? completedToday : 0);

            Long cancelledToday = appointmentRepository.countByAppointmentDateTimeBetweenAndStatus(
                    todayStart, todayEnd, "CANCELLED");
            stats.put("cancelledToday", cancelledToday != null ? cancelledToday : 0);

            // Get total appointments for current month
            Long totalThisMonth = appointmentRepository.countAppointmentsThisMonth();
            stats.put("totalThisMonth", totalThisMonth != null ? totalThisMonth : 0);

        } catch (Exception e) {
            // Fallback using alternative methods if the specific ones don't work
            try {
                // Alternative approach using existing methods
                List<Appointment> todayAppointments = appointmentRepository.findByAppointmentDateTimeBetween(todayStart, todayEnd);

                long scheduled = todayAppointments.stream().filter(a -> "SCHEDULED".equals(a.getStatus())).count();
                long completed = todayAppointments.stream().filter(a -> "COMPLETED".equals(a.getStatus())).count();
                long cancelled = todayAppointments.stream().filter(a -> "CANCELLED".equals(a.getStatus())).count();

                stats.put("scheduledToday", scheduled);
                stats.put("completedToday", completed);
                stats.put("cancelledToday", cancelled);

                // For monthly count, use count method with date range
                LocalDateTime monthStart = today.withDayOfMonth(1).atStartOfDay();
                LocalDateTime monthEnd = today.withDayOfMonth(today.lengthOfMonth()).atTime(23, 59, 59);
                Long monthlyCount = appointmentRepository.countByAppointmentDateTimeBetween(monthStart, monthEnd);
                stats.put("totalThisMonth", monthlyCount != null ? monthlyCount : 0);

            } catch (Exception ex) {
                // Final fallback
                stats.put("scheduledToday", 0);
                stats.put("completedToday", 0);
                stats.put("cancelledToday", 0);
                stats.put("totalThisMonth", 0);
            }
        }

        return stats;
    }

    public Map<String, Object> getWardOccupancy() {
        Map<String, Object> occupancy = new HashMap<>();

        for (Ward ward : wardRepository.findAll()) {
            Long totalBeds = bedRepository.countBedsByWardId(ward.getId());
            Long availableBeds = (long) bedRepository.findAvailableBedsByWardId(ward.getId()).size();
            Long occupiedBeds = totalBeds - availableBeds;

            double occupancyRate = totalBeds > 0 ? (occupiedBeds.doubleValue() / totalBeds.doubleValue()) * 100 : 0;

            Map<String, Object> wardStats = new HashMap<>();
            wardStats.put("totalBeds", totalBeds);
            wardStats.put("availableBeds", availableBeds);
            wardStats.put("occupiedBeds", occupiedBeds);
            wardStats.put("occupancyRate", String.format("%.1f", occupancyRate));

            occupancy.put(ward.getWardNumber(), wardStats);
        }

        return occupancy;
    }
    // In AdminService.java - Add this method
    public Map<String, Object> getReportSummary() {
        Map<String, Object> summary = new HashMap<>();

        // Basic counts for dashboard
        summary.put("totalPatients", patientRepository.count());
        summary.put("totalDoctors", doctorRepository.count());
        summary.put("totalAppointments", appointmentRepository.count());
        summary.put("currentAdmissions", admissionRepository.countCurrentAdmissions());

        // Financial summary for current month
        LocalDate startOfMonth = LocalDate.now().withDayOfMonth(1);
        LocalDate endOfMonth = LocalDate.now();

        List<Appointment> paidAppointmentsThisMonth = appointmentRepository.findByPaymentStatus("PAID").stream()
                .filter(app -> app.getPaymentDate() != null &&
                        app.getPaymentDate().toLocalDate().getMonth() == LocalDate.now().getMonth())
                .collect(Collectors.toList());

        double monthlyRevenue = paidAppointmentsThisMonth.stream()
                .mapToDouble(Appointment::getTotalFee)
                .sum();

        summary.put("monthlyRevenue", monthlyRevenue);
        summary.put("paidAppointmentsThisMonth", paidAppointmentsThisMonth.size());

        return summary;
    }
}