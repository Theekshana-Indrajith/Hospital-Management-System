// WardController.java - Handle department assignment in controller
package com.hms.hospitalmanagementsystem.controller;

import com.hms.hospitalmanagementsystem.entity.Department;
import com.hms.hospitalmanagementsystem.entity.Ward;
import com.hms.hospitalmanagementsystem.service.WardService;
import com.hms.hospitalmanagementsystem.service.MedicalStaffService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@Controller
@RequestMapping("/wards")
public class WardController {

    @Autowired
    private WardService wardService;

    @Autowired
    private MedicalStaffService medicalStaffService;

    @GetMapping
    public String listWards(Model model, HttpSession session) {
        if (!validateAdmin(session)) {
            return "redirect:/access-denied";
        }

        List<Ward> wards = wardService.getAllWards();
        List<Department> departments = medicalStaffService.getAllDepartments();

        model.addAttribute("wards", wards);
        model.addAttribute("departments", departments);
        model.addAttribute("ward", new Ward());
        model.addAttribute("username", session.getAttribute("username"));
        return "wards/wards";
    }

    @PostMapping("/add")
    public String addWard(@ModelAttribute Ward ward, @RequestParam Long departmentId, HttpSession session) {
        if (!validateAdmin(session)) {
            return "redirect:/access-denied";
        }

        // Handle department assignment in controller
        var department = medicalStaffService.getDepartmentById(departmentId);
        if (department != null) {
            ward.setDepartment(department);
            wardService.saveWard(ward);
            return "redirect:/wards?success=Ward created successfully";
        } else {
            return "redirect:/wards?error=Department not found";
        }
    }

    @GetMapping("/edit/{id}")
    public String editWardForm(@PathVariable Long id, Model model, HttpSession session) {
        if (!validateAdmin(session)) {
            return "redirect:/access-denied";
        }

        Ward ward = wardService.getWardById(id);
        model.addAttribute("ward", ward);
        model.addAttribute("departments", medicalStaffService.getAllDepartments());
        model.addAttribute("username", session.getAttribute("username"));
        return "wards/edit-ward";
    }

    @PostMapping("/update/{id}")
    public String updateWard(@PathVariable Long id, @ModelAttribute Ward ward,
                             @RequestParam Long departmentId, HttpSession session) {
        if (!validateAdmin(session)) {
            return "redirect:/access-denied";
        }

        ward.setId(id);
        var department = medicalStaffService.getDepartmentById(departmentId);
        if (department != null) {
            ward.setDepartment(department);
            wardService.saveWard(ward);
            return "redirect:/wards?success=Ward updated successfully";
        } else {
            return "redirect:/wards?error=Department not found";
        }
    }

    @GetMapping("/delete/{id}")
    public String deleteWard(@PathVariable Long id, HttpSession session) {
        if (!validateAdmin(session)) {
            return "redirect:/access-denied";
        }

        wardService.deleteWard(id);
        return "redirect:/wards?success=Ward deleted successfully";
    }

    @GetMapping("/available")
    public String showAvailableWards(Model model, HttpSession session) {
        if (!validateAdmin(session)) {
            return "redirect:/access-denied";
        }

        List<Ward> availableWards = wardService.getAvailableWards();
        model.addAttribute("wards", availableWards);
        model.addAttribute("username", session.getAttribute("username"));
        return "wards/available-wards";
    }

    @GetMapping("/department/{departmentId}")
    public String showWardsByDepartment(@PathVariable Long departmentId, Model model, HttpSession session) {
        if (!validateAdmin(session)) {
            return "redirect:/access-denied";
        }

        List<Ward> departmentWards = wardService.getWardsByDepartment(departmentId);
        var department = medicalStaffService.getDepartmentById(departmentId);
        model.addAttribute("wards", departmentWards);
        model.addAttribute("department", department);
        model.addAttribute("username", session.getAttribute("username"));
        return "wards/department-wards";
    }

    private boolean validateAdmin(HttpSession session) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        return username != null && "ADMIN".equals(role);
    }
}