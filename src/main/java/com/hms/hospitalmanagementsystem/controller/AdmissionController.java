// AdmissionController.java
package com.hms.hospitalmanagementsystem.controller;

import com.hms.hospitalmanagementsystem.entity.Admission;
import com.hms.hospitalmanagementsystem.entity.Patient;
import com.hms.hospitalmanagementsystem.service.AdmissionService;
import com.hms.hospitalmanagementsystem.service.PatientService;
import com.hms.hospitalmanagementsystem.service.WardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@Controller
@RequestMapping("/admissions")
public class AdmissionController {

    @Autowired
    private AdmissionService admissionService;

    @Autowired
    private PatientService patientService;

    @Autowired
    private WardService wardService;

    @GetMapping
    public String listAdmissions(Model model) {
        List<Admission> admissions = admissionService.getAllAdmissions();
        model.addAttribute("admissions", admissions);
        return "admissions/admissions";
    }

    @GetMapping("/current")
    public String listCurrentAdmissions(Model model) {
        List<Admission> currentAdmissions = admissionService.getCurrentAdmissions();
        model.addAttribute("admissions", currentAdmissions);
        return "admissions/current-admissions";
    }

    @GetMapping("/admit")
    public String showAdmitForm(Model model) {
        List<Patient> patients = patientService.getAllPatients();
        model.addAttribute("patients", patients);
        model.addAttribute("wards", wardService.getAvailableWards());
        return "admissions/admit-patient";
    }

    @PostMapping("/admit")
    public String admitPatient(@RequestParam Long patientId,
                               @RequestParam Long wardId,
                               @RequestParam Long bedId,
                               @RequestParam String reason) {
        try {
            admissionService.admitPatient(patientId, wardId, bedId, reason);
            return "redirect:/admissions/current";
        } catch (Exception e) {
            return "redirect:/admissions/admit?error=" + e.getMessage();
        }
    }

    @GetMapping("/discharge/{admissionId}")
    public String dischargePatient(@PathVariable Long admissionId) {
        try {
            admissionService.dischargePatient(admissionId);
            return "redirect:/admissions/current";
        } catch (Exception e) {
            return "redirect:/admissions?error=" + e.getMessage();
        }
    }

    @GetMapping("/patient/{patientId}")
    public String getPatientAdmissions(@PathVariable Long patientId, Model model) {
        List<Admission> patientAdmissions = admissionService.getAdmissionsByPatientId(patientId);
        Patient patient = patientService.getPatientById(patientId);
        model.addAttribute("admissions", patientAdmissions);
        model.addAttribute("patient", patient);
        return "admissions/patient-admissions";
    }
}