package com.hms.hospitalmanagementsystem.service;

import com.hms.hospitalmanagementsystem.entity.Appointment;
import com.hms.hospitalmanagementsystem.repository.AppointmentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class AppointmentService {

    @Autowired
    private AppointmentRepository appointmentRepository;

    @Autowired
    private PaymentService paymentService;

    public List<Appointment> getAllAppointments() {
        return appointmentRepository.findAll();
    }

    public Appointment getAppointmentById(Long id) {
        return appointmentRepository.findById(id).orElse(null);
    }

    public List<Appointment> getAppointmentsByPatientId(Long patientId) {
        return appointmentRepository.findByPatientId(patientId);
    }

    public List<Appointment> getAppointmentsByDoctorId(Long doctorId) {
        return appointmentRepository.findByDoctorId(doctorId);
    }

    public Appointment saveAppointment(Appointment appointment) {
        return appointmentRepository.save(appointment);
    }

    public List<Appointment> getTodaysAppointmentsByDoctor(Long doctorId) {
        // Get today's date at start and end of day
        LocalDateTime startOfDay = LocalDate.now().atStartOfDay();
        LocalDateTime endOfDay = LocalDate.now().atTime(23, 59, 59);

        // Use existing repository method or create a new one
        return appointmentRepository.findByDoctorIdAndAppointmentDateTimeBetween(doctorId, startOfDay, endOfDay);
    }


    public Appointment createAppointmentWithFee(Long patientId, Long doctorId,
                                                String appointmentDateTime, String reason,
                                                String doctorSpecialization) {
        // Calculate consultation fee based on doctor specialization
        Double consultationFee = paymentService.calculateConsultationFee(doctorSpecialization);

        // Create appointment (this would need proper patient and doctor objects)
        Appointment appointment = new Appointment();
        appointment.setConsultationFee(consultationFee);
        appointment.setPaymentStatus("PENDING");
        appointment.setStatus("SCHEDULED");
        // Set other appointment properties...

        return appointmentRepository.save(appointment);
    }

    public List<Appointment> getAppointmentsByPaymentStatus(String paymentStatus) {
        return appointmentRepository.findByPaymentStatus(paymentStatus);
    }

    public Double getTotalRevenue() {
        List<Appointment> paidAppointments = appointmentRepository.findByPaymentStatus("PAID");
        return paidAppointments.stream()
                .mapToDouble(Appointment::getConsultationFee)
                .sum();
    }

    public List<Appointment> getTodaysAppointments() {
        LocalDate today = LocalDate.now();
        return appointmentRepository.findByAppointmentDateTimeBetween(
                today.atStartOfDay(),
                today.atTime(23, 59, 59)
        );
    }

    public List<Appointment> getAppointmentsByDate(LocalDate date) {
        return appointmentRepository.findByAppointmentDateTimeBetween(
                date.atStartOfDay(),
                date.atTime(23, 59, 59)
        );
    }

    public List<Appointment> getUpcomingAppointments() {
        return appointmentRepository.findByAppointmentDateTimeAfterOrderByAppointmentDateTimeAsc(
                LocalDateTime.now()
        );
    }
    public void deleteAppointment(Long appointmentId) {
        appointmentRepository.deleteById(appointmentId);
    }

    public Long countTodaysAppointments() {
        LocalDate today = LocalDate.now();
        return appointmentRepository.countByAppointmentDateTimeBetween(
                today.atStartOfDay(),
                today.atTime(23, 59, 59)
        );
    }

    public boolean isValidAppointmentTime(LocalDateTime dateTime) {
        if (dateTime == null) return false;

        // Check if it's Sunday (day 7)
        if (dateTime.getDayOfWeek().getValue() == 7) {
            return false;
        }

        // Check time is between 4 PM (16:00) and 10 PM (22:00)
        int hour = dateTime.getHour();
        return hour >= 16 && hour < 22;
    }



    public int getMaxRescheduleCount() {
        return 2; // Maximum 2 reschedules allowed
    }
    // In AppointmentService.java - add this method
    public List<Appointment> getPendingDoctorAppointments(Long doctorId) {
        return appointmentRepository.findByDoctorIdAndStatus(doctorId, "PENDING_DOCTOR");
    }

    // Update the isTimeSlotAvailable method to exclude PENDING_DOCTOR appointments from availability check
    public boolean isTimeSlotAvailable(Long doctorId, LocalDateTime dateTime, Long excludeAppointmentId) {
        if (doctorId == null || dateTime == null) return false;

        // Define appointment duration (30 minutes)
        LocalDateTime slotStart = dateTime;
        LocalDateTime slotEnd = dateTime.plusMinutes(30);

        // Get all appointments for this doctor on the same day
        LocalDateTime dayStart = dateTime.toLocalDate().atStartOfDay();
        LocalDateTime dayEnd = dateTime.toLocalDate().atTime(23, 59, 59);

        List<Appointment> doctorAppointments = appointmentRepository
                .findByDoctorIdAndAppointmentDateTimeBetween(doctorId, dayStart, dayEnd);

        // Check for overlapping appointments
        for (Appointment existingAppointment : doctorAppointments) {
            // Skip the appointment we're excluding (for rescheduling)
            if (excludeAppointmentId != null && existingAppointment.getId().equals(excludeAppointmentId)) {
                continue;
            }

            LocalDateTime existingStart = existingAppointment.getAppointmentDateTime();
            LocalDateTime existingEnd = existingStart.plusMinutes(30);

            // Check if time slots overlap
            boolean overlaps = (slotStart.isBefore(existingEnd) && slotEnd.isAfter(existingStart));

            // Consider both SCHEDULED and PENDING_DOCTOR appointments as occupying the slot
            if (overlaps && ("SCHEDULED".equals(existingAppointment.getStatus()) ||
                    "PENDING_DOCTOR".equals(existingAppointment.getStatus()))) {
                return false; // Time slot is not available
            }
        }

        return true; // Time slot is available
    }

}