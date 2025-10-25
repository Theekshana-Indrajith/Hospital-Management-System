// BedController.java
package com.hms.hospitalmanagementsystem.controller;

import com.hms.hospitalmanagementsystem.entity.Bed;
import com.hms.hospitalmanagementsystem.entity.Ward;
import com.hms.hospitalmanagementsystem.service.BedService;
import com.hms.hospitalmanagementsystem.service.WardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@Controller
@RequestMapping("/beds")
public class BedController {

    @Autowired
    private BedService bedService;

    @Autowired
    private WardService wardService;

    @GetMapping
    public String listBeds(Model model) {
        List<Bed> beds = bedService.getAllBeds();
        List<Ward> wards = wardService.getAllWards();
        model.addAttribute("beds", beds);
        model.addAttribute("wards", wards);
        model.addAttribute("bed", new Bed());
        return "beds/beds";
    }

    @GetMapping("/ward/{wardId}")
    public String listBedsByWard(@PathVariable Long wardId, Model model) {
        List<Bed> beds = bedService.getBedsByWardId(wardId);
        Ward ward = wardService.getWardById(wardId);
        model.addAttribute("beds", beds);
        model.addAttribute("ward", ward);
        return "beds/ward-beds";
    }

    @PostMapping("/add")
    public String addBed(@RequestParam Long wardId,
                         @RequestParam String bedNumber,
                         @RequestParam String status) {
        Ward ward = wardService.getWardById(wardId);
        if (ward != null) {
            Bed bed = new Bed();
            bed.setBedNumber(bedNumber);
            bed.setStatus(status);
            bed.setWard(ward);
            bedService.saveBed(bed);
        }
        return "redirect:/beds";
    }

    @GetMapping("/status/{status}")
    public String listBedsByStatus(@PathVariable String status, Model model) {
        List<Bed> beds = bedService.getBedsByStatus(status.toUpperCase());
        model.addAttribute("beds", beds);
        model.addAttribute("status", status);
        return "beds/beds-by-status";
    }

    @GetMapping("/available/{wardId}")
    public String showAvailableBeds(@PathVariable Long wardId, Model model) {
        List<Bed> availableBeds = bedService.getAvailableBedsByWardId(wardId);
        Ward ward = wardService.getWardById(wardId);
        model.addAttribute("beds", availableBeds);
        model.addAttribute("ward", ward);
        return "beds/available-beds";
    }

    @GetMapping("/assign/{bedId}")
    public String assignBedToPatient(@PathVariable Long bedId, Model model) {
        Bed bed = bedService.getBedById(bedId);
        // In a real scenario, you would fetch patients list here
        model.addAttribute("bed", bed);
        return "beds/assign-bed";
    }

    @PostMapping("/assign")
    public String assignPatientToBed(@RequestParam Long bedId, @RequestParam Long patientId) {
        bedService.assignPatientToBed(bedId, patientId);
        return "redirect:/beds";
    }

    @GetMapping("/discharge/{bedId}")
    public String dischargePatientFromBed(@PathVariable Long bedId) {
        bedService.dischargePatientFromBed(bedId);
        return "redirect:/beds";
    }
}