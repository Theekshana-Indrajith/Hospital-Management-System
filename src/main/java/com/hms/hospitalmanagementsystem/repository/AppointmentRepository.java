package com.hms.hospitalmanagementsystem.repository;

import com.hms.hospitalmanagementsystem.entity.Appointment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;

public interface AppointmentRepository extends JpaRepository<Appointment, Long> {
    List<Appointment> findByPatientId(Long patientId);
    List<Appointment> findByDoctorId(Long doctorId);

    // NEW: Payment-related queries
    List<Appointment> findByPaymentStatus(String paymentStatus);
    List<Appointment> findByPaymentMethod(String paymentMethod);
    List<Appointment> findByDoctorIdAndAppointmentDateTimeAfter(Long doctorId, LocalDateTime dateTime);
    List<Appointment> findByDoctorIdAndAppointmentDateTimeBetween(Long doctorId, LocalDateTime start, LocalDateTime end);

    @Query("SELECT a FROM Appointment a WHERE a.paymentStatus = 'PAID' AND a.appointmentDateTime BETWEEN :startDate AND :endDate")
    List<Appointment> findPaidAppointmentsBetweenDates(@Param("startDate") LocalDateTime startDate, @Param("endDate") LocalDateTime endDate);

    @Query("SELECT SUM(a.consultationFee) FROM Appointment a WHERE a.paymentStatus = 'PAID'")
    Double getTotalPaidAmount();

    @Query("SELECT a.paymentMethod, COUNT(a) FROM Appointment a WHERE a.paymentStatus = 'PAID' GROUP BY a.paymentMethod")
    List<Object[]> getPaymentMethodStatistics();

    // Add to your existing AppointmentRepository
    List<Appointment> findByAppointmentDateTimeBetween(LocalDateTime start, LocalDateTime end);
    List<Appointment> findByAppointmentDateTimeAfterOrderByAppointmentDateTimeAsc(LocalDateTime dateTime);
    Long countByAppointmentDateTimeBetween(LocalDateTime start, LocalDateTime end);
    Long countByStatus(String status);
    List<Appointment> findByDoctorIdAndAppointmentDateTime(Long doctorId, LocalDateTime dateTime);

    // In AppointmentRepository.java - add this method
    List<Appointment> findByDoctorIdAndStatus(Long doctorId, String status);

    // In AppointmentRepository.java - Add this method
    @Query("SELECT a FROM Appointment a WHERE a.doctor.id = :doctorId AND a.appointmentDateTime BETWEEN :start AND :end AND a.status = 'SCHEDULED'")
    List<Appointment> findScheduledAppointmentsByDoctorAndTimeRange(@Param("doctorId") Long doctorId, @Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

    // ADD THESE METHODS FOR ADMIN SERVICE
    Long countByAppointmentDateTimeBetweenAndStatus(LocalDateTime start, LocalDateTime end, String status);

    @Query("SELECT COUNT(a) FROM Appointment a WHERE a.appointmentDateTime BETWEEN :start AND :end")
    Long countAppointmentsByDateRange(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

    // Count appointments by status
    @Query("SELECT COUNT(a) FROM Appointment a WHERE a.status = :status AND a.appointmentDateTime BETWEEN :start AND :end")
    Long countByStatusAndAppointmentDateTimeBetween(@Param("status") String status, @Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

    // Get today's appointments count by status
    @Query("SELECT COUNT(a) FROM Appointment a WHERE a.status = :status AND DATE(a.appointmentDateTime) = CURRENT_DATE")
    Long countByStatusAndAppointmentDateToday(@Param("status") String status);

    // Get monthly appointments count
    @Query("SELECT COUNT(a) FROM Appointment a WHERE YEAR(a.appointmentDateTime) = YEAR(CURRENT_DATE) AND MONTH(a.appointmentDateTime) = MONTH(CURRENT_DATE)")
    Long countAppointmentsThisMonth();

    @Query("SELECT a FROM Appointment a WHERE a.doctor.id = :doctorId AND DATE(a.appointmentDateTime) = CURRENT_DATE")
    List<Appointment> findByDoctorIdAndAppointmentDate(@Param("doctorId") Long doctorId);

    // ADD THIS MISSING METHOD TO FIX THE ERROR
    List<Appointment> findByPatientIdAndPaymentStatus(@Param("patientId") Long patientId, @Param("paymentStatus") String paymentStatus);

    // Additional useful payment methods
    @Query("SELECT a FROM Appointment a WHERE a.patient.id = :patientId AND a.paymentStatus = 'PAID' ORDER BY a.paymentDate DESC")
    List<Appointment> findPaidAppointmentsByPatient(@Param("patientId") Long patientId);

    @Query("SELECT COUNT(a) FROM Appointment a WHERE a.patient.id = :patientId AND a.paymentStatus = 'PAID'")
    Long countPaidAppointmentsByPatient(@Param("patientId") Long patientId);

    @Query("SELECT SUM(a.totalFee) FROM Appointment a WHERE a.patient.id = :patientId AND a.paymentStatus = 'PAID'")
    Double getTotalPaidAmountByPatient(@Param("patientId") Long patientId);

    // Get appointments by payment method and status
    List<Appointment> findByPaymentMethodAndPaymentStatus(String paymentMethod, String paymentStatus);

    // Get recent paid appointments
    List<Appointment> findByPaymentStatusOrderByPaymentDateDesc(String paymentStatus);

    // Get appointments with payment date range
    @Query("SELECT a FROM Appointment a WHERE a.paymentStatus = 'PAID' AND a.paymentDate BETWEEN :startDate AND :endDate")
    List<Appointment> findPaidAppointmentsByPaymentDateRange(@Param("startDate") LocalDateTime startDate, @Param("endDate") LocalDateTime endDate);
}