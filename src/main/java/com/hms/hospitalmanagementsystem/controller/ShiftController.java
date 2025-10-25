// ShiftController.java - Complete ward-based implementation
package com.hms.hospitalmanagementsystem.controller;

import com.hms.hospitalmanagementsystem.entity.ShiftSchedule;
import com.hms.hospitalmanagementsystem.entity.Staff;
import com.hms.hospitalmanagementsystem.service.MedicalStaffService;
import com.hms.hospitalmanagementsystem.service.ShiftService;
import com.hms.hospitalmanagementsystem.service.WardService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/shift-management")
public class ShiftController {

    @Autowired
    private MedicalStaffService medicalStaffService;

    @Autowired
    private ShiftService shiftService;

    @Autowired
    private WardService wardService;

    // In ShiftController.java - Fix the wardShifts method
    @GetMapping("/ward/{wardId}")
    public String wardShifts(@PathVariable Long wardId,
                             @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date,
                             HttpSession session, Model model) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        if (date == null) {
            date = LocalDate.now();
        }

        List<ShiftSchedule> shifts = shiftService.getWardSchedules(wardId, date);
        var ward = wardService.getWardById(wardId);

        // FIX: Check if ward and department are not null
        if (ward == null) {
            model.addAttribute("error", "Ward not found");
            return "redirect:/medical-staff/shifts";
        }

        // FIX: Handle null department gracefully
        List<Staff> staffList = new ArrayList<>();
        if (ward.getDepartment() != null) {
            staffList = medicalStaffService.getStaffByDepartment(ward.getDepartment().getId());
        } else {
            // If department is null, get all staff as fallback
            staffList = medicalStaffService.getAllStaff();
            model.addAttribute("warning", "Ward is not assigned to any department. Showing all staff.");
        }

        model.addAttribute("shifts", shifts);
        model.addAttribute("ward", ward);
        model.addAttribute("selectedDate", date);
        model.addAttribute("selectedDateString", date.toString());
        model.addAttribute("staffList", staffList);
        model.addAttribute("shiftTypes", new String[]{"MORNING", "EVENING", "NIGHT"});
        model.addAttribute("username", session.getAttribute("username"));

        return "medical-staff/ward-shifts";
    }

    // UPDATED: Assign shift to a specific ward
    @PostMapping("/assign")
    public String assignShift(@RequestParam Long staffId,
                              @RequestParam Long wardId, // Changed from departmentId to wardId
                              @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate scheduleDate,
                              @RequestParam String shiftType,
                              @RequestParam(required = false) String notes,
                              HttpSession session) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        try {
            shiftService.scheduleShift(staffId, wardId, scheduleDate, shiftType, notes);
            return "redirect:/medical-staff/shifts/ward/" + wardId + "?date=" + scheduleDate + "&success=Shift assigned successfully";
        } catch (Exception e) {
            return "redirect:/medical-staff/shifts?error=Failed to assign shift: " + e.getMessage();
        }
    }

    // Staff Individual Schedule
    @GetMapping("/staff/{staffId}")
    public String staffSchedule(@PathVariable Long staffId,
                                @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
                                @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate,
                                HttpSession session, Model model) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        if (startDate == null) {
            startDate = LocalDate.now().withDayOfMonth(1);
        }
        if (endDate == null) {
            endDate = LocalDate.now().withDayOfMonth(LocalDate.now().lengthOfMonth());
        }

        List<ShiftSchedule> shifts = shiftService.getStaffSchedule(staffId, startDate, endDate);
        model.addAttribute("shifts", shifts);
        model.addAttribute("staff", medicalStaffService.getStaffById(staffId));
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);

        return "medical-staff/staff-schedule";
    }

    // UPDATED: Generate weekly schedule for a ward
    @PostMapping("/generate-weekly")
    public String generateWeeklySchedule(@RequestParam Long wardId, HttpSession session) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        try {
            shiftService.generateWeeklySchedule(wardId, LocalDate.now());
            return "redirect:/medical-staff/shifts/ward/" + wardId + "?success=Weekly schedule generated successfully";
        } catch (Exception e) {
            return "redirect:/medical-staff/shifts/ward/" + wardId + "?error=Failed to generate schedule: " + e.getMessage();
        }
    }

    // Update Shift Status
    @PostMapping("/update-status")
    public String updateShiftStatus(@RequestParam Long scheduleId,
                                    @RequestParam String status,
                                    HttpSession session) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        try {
            shiftService.updateShiftStatus(scheduleId, status);
            return "redirect:/medical-staff/shifts?success=Shift status updated successfully";
        } catch (Exception e) {
            return "redirect:/medical-staff/shifts?error=Failed to update shift status: " + e.getMessage();
        }
    }

    // Delete Shift
    @GetMapping("/delete/{scheduleId}")
    public String deleteShift(@PathVariable Long scheduleId, HttpSession session) {
        if (!validateAdmin(session)) return "redirect:/access-denied";

        try {
            ShiftSchedule shift = shiftService.getShiftById(scheduleId);
            Long wardId = shift.getWard().getId();
            shiftService.deleteShift(scheduleId);
            return "redirect:/medical-staff/shifts/ward/" + wardId + "?success=Shift deleted successfully";
        } catch (Exception e) {
            return "redirect:/medical-staff/shifts?error=Failed to delete shift: " + e.getMessage();
        }
    }

    private boolean validateAdmin(HttpSession session) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        return username != null && "ADMIN".equals(role);
    }
}