package com.hms.hospitalmanagementsystem.controller;

import com.hms.hospitalmanagementsystem.entity.Admission;
import com.hms.hospitalmanagementsystem.entity.Bed;
import com.hms.hospitalmanagementsystem.entity.Patient;
import com.hms.hospitalmanagementsystem.entity.Ward;
import com.hms.hospitalmanagementsystem.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/ward-manager")
public class WardManagerController {

    @Autowired
    private WardService wardService;

    @Autowired
    private MedicalStaffService medicalStaffService;

    @Autowired
    private AdmissionService admissionService;

    @Autowired
    private PatientService patientService;

    @Autowired
    private BedService bedService;

    @GetMapping("/dashboard")
    public String wardManagerDashboard(HttpSession session, Model model) {
        if (!validateWardManager(session)) {
            return "redirect:/access-denied";
        }

        List<Ward> wards = wardService.getAllWards();

        // Calculate statistics
        long totalWards = wards.size();
        long totalBeds = wards.stream().mapToInt(Ward::getTotalBeds).sum();
        long availableBeds = wards.stream().mapToInt(Ward::getAvailableBeds).sum();
        double occupancyRate = totalBeds > 0 ? ((totalBeds - availableBeds) / (double) totalBeds) * 100 : 0;

        model.addAttribute("username", session.getAttribute("username"));
        model.addAttribute("totalWards", totalWards);
        model.addAttribute("totalBeds", totalBeds);
        model.addAttribute("availableBeds", availableBeds);
        model.addAttribute("occupancyRate", String.format("%.1f", occupancyRate));
        model.addAttribute("wards", wards);

        return "ward-manager/dashboard";
    }

    // Ward Management (moved from AdminController)
    @GetMapping("/wards")
    public String manageWards(HttpSession session, Model model) {
        if (!validateWardManager(session)) {
            return "redirect:/access-denied";
        }

        List<Ward> wards = wardService.getAllWards();
        List<Bed> allBeds = bedService.getAllBeds(); // Add this line

        model.addAttribute("wards", wards);
        model.addAttribute("allBeds", allBeds); // Add this line
        model.addAttribute("departments", medicalStaffService.getAllDepartments());
        model.addAttribute("ward", new Ward());
        model.addAttribute("pageTitle", "Ward Management");
        return "ward-manager/wards";
    }

    @PostMapping("/wards/add")
    public String addWard(@ModelAttribute Ward ward, @RequestParam Long departmentId, HttpSession session) {
        if (!validateWardManager(session)) {
            return "redirect:/access-denied";
        }

        var department = medicalStaffService.getDepartmentById(departmentId);
        if (department != null) {
            ward.setAvailableBeds(ward.getTotalBeds());
            ward.setDepartment(department);
            Ward savedWard = wardService.saveWard(ward);

            // AUTO-INITIALIZE BEDS when ward is created
            try {
                for (int i = 1; i <= savedWard.getTotalBeds(); i++) {
                    Bed bed = new Bed();
                    bed.setBedNumber(savedWard.getWardNumber() + "-B" + i);
                    bed.setStatus("AVAILABLE");
                    bed.setWard(savedWard);
                    bedService.saveBed(bed);
                }
                // Update ward bed counts
                bedService.updateWardBedCounts(savedWard.getId());
                return "redirect:/ward-manager/wards?success=Ward created successfully with " + savedWard.getTotalBeds() + " beds initialized";
            } catch (Exception e) {
                return "redirect:/ward-manager/wards?error=Ward created but failed to initialize beds: " + e.getMessage();
            }
        } else {
            return "redirect:/ward-manager/wards?error=Department not found";
        }
    }

//    @GetMapping("/wards/delete/{id}")
//    public String deleteWard(@PathVariable Long id, HttpSession session) {
//        if (!validateWardManager(session)) {
//            return "redirect:/access-denied";
//        }
//
//        try {
//            Ward ward = wardService.getWardById(id);
//            if (ward != null) {
//                // Check if there are any beds in this ward that are occupied
//                List<Bed> wardBeds = bedService.getBedsByWardId(id);
//                boolean hasOccupiedBeds = wardBeds.stream()
//                        .anyMatch(bed -> "OCCUPIED".equals(bed.getStatus()));
//
//                if (hasOccupiedBeds) {
//                    return "redirect:/ward-manager/wards?error=Cannot delete ward with occupied beds. Please discharge patients first.";
//                }
//
//                // Delete all beds associated with this ward first
//                for (Bed bed : wardBeds) {
//                    bedService.deleteBed(bed.getId());
//                }
//
//                // Then delete the ward
//                wardService.deleteWard(id);
//                return "redirect:/ward-manager/wards?success=Ward deleted successfully";
//            } else {
//                return "redirect:/ward-manager/wards?error=Ward not found";
//            }
//        } catch (Exception e) {
//            System.err.println("ERROR deleting ward: " + e.getMessage());
//            e.printStackTrace();
//            return "redirect:/ward-manager/wards?error=Failed to delete ward: " + e.getMessage();
//        }
//    }

    @GetMapping("/wards/delete/{id}")
    public String deleteWard(@PathVariable Long id, HttpSession session) {
        if (!validateWardManager(session)) {
            return "redirect:/access-denied";
        }

        try {
            Ward ward = wardService.getWardById(id);
            if (ward != null) {
                // Check if there are any beds in this ward that are occupied
                List<Bed> wardBeds = bedService.getBedsByWardId(id);
                boolean hasOccupiedBeds = wardBeds.stream()
                        .anyMatch(bed -> "OCCUPIED".equals(bed.getStatus()));

                if (hasOccupiedBeds) {
                    return "redirect:/ward-manager/wards?error=Cannot delete ward with occupied beds. Please discharge patients first.";
                }

                // Delete all beds associated with this ward first
                for (Bed bed : wardBeds) {
                    bedService.deleteBed(bed.getId());
                }

                // Then delete the ward
                wardService.deleteWard(id);
                return "redirect:/ward-manager/wards?success=Ward deleted successfully";
            } else {
                return "redirect:/ward-manager/wards?error=Ward not found";
            }
        } catch (Exception e) {
            System.err.println("ERROR deleting ward: " + e.getMessage());
            e.printStackTrace();
            return "redirect:/ward-manager/wards?error=Failed to delete ward: " + e.getMessage();
        }
    }
    @GetMapping("/wards/edit/{id}")
    public String editWardForm(@PathVariable Long id, Model model, HttpSession session) {
        if (!validateWardManager(session)) {
            return "redirect:/access-denied";
        }

        Ward ward = wardService.getWardById(id);
        model.addAttribute("ward", ward);
        model.addAttribute("departments", medicalStaffService.getAllDepartments());
        model.addAttribute("username", session.getAttribute("username"));
        return "ward-manager/edit-ward";
    }

    @PostMapping("/wards/update/{id}")
    public String updateWard(@PathVariable Long id,
                             @RequestParam String wardNumber,
                             @RequestParam String wardType,
                             @RequestParam String description,
                             @RequestParam int totalBeds,
                             @RequestParam int availableBeds,
                             @RequestParam double chargePerDay,
                             @RequestParam Long departmentId,
                             HttpSession session) {
        if (!validateWardManager(session)) {
            return "redirect:/access-denied";
        }

        try {
            System.out.println("DEBUG: Updating ward ID: " + id);
            System.out.println("DEBUG: Ward Number: " + wardNumber);
            System.out.println("DEBUG: Ward Type: " + wardType);
            System.out.println("DEBUG: Total Beds: " + totalBeds);
            System.out.println("DEBUG: Available Beds: " + availableBeds);
            System.out.println("DEBUG: Charge Per Day: " + chargePerDay);
            System.out.println("DEBUG: Department ID: " + departmentId);

            // Get existing ward
            Ward existingWard = wardService.getWardById(id);
            if (existingWard == null) {
                return "redirect:/ward-manager/wards?error=Ward not found";
            }

            // Get current actual bed count
            List<Bed> currentBeds = bedService.getBedsByWardId(id);
            int currentBedCount = currentBeds.size();

            // Store old total beds for comparison
            int oldTotalBeds = existingWard.getTotalBeds();

            // Update ward properties
            existingWard.setWardNumber(wardNumber);
            existingWard.setWardType(wardType);
            existingWard.setDescription(description);
            existingWard.setTotalBeds(totalBeds);
            existingWard.setAvailableBeds(availableBeds);
            existingWard.setChargePerDay(chargePerDay);

            // Set department
            var department = medicalStaffService.getDepartmentById(departmentId);
            if (department != null) {
                existingWard.setDepartment(department);
            } else {
                return "redirect:/ward-manager/wards?error=Department not found";
            }

            // Save the updated ward
            Ward savedWard = wardService.saveWard(existingWard);
            System.out.println("DEBUG: Ward updated successfully");

            // AUTO-INITIALIZE BEDS: If total beds increased or no beds exist
            if (totalBeds > currentBedCount) {
                int bedsToCreate = totalBeds - currentBedCount;
                System.out.println("DEBUG: Creating " + bedsToCreate + " new beds for ward");

                for (int i = 1; i <= bedsToCreate; i++) {
                    Bed newBed = new Bed();
                    newBed.setBedNumber(savedWard.getWardNumber() + "-B" + (currentBedCount + i));
                    newBed.setStatus("AVAILABLE");
                    newBed.setWard(savedWard);
                    bedService.saveBed(newBed);
                }

                // Update ward bed counts after creating new beds
                bedService.updateWardBedCounts(id);
                System.out.println("DEBUG: " + bedsToCreate + " new beds created and synchronized");
            }
            // If total beds decreased, we don't delete beds automatically for safety
            // The user can manually delete extra beds if needed

            return "redirect:/ward-manager/wards?success=Ward updated successfully" +
                    (totalBeds > currentBedCount ? " and " + (totalBeds - currentBedCount) + " new beds created" : "");

        } catch (Exception e) {
            System.err.println("ERROR updating ward: " + e.getMessage());
            e.printStackTrace();
            return "redirect:/ward-manager/wards?error=Failed to update ward: " + e.getMessage();
        }
    }
    @GetMapping("/wards/available")
    public String showAvailableWards(Model model, HttpSession session) {
        if (!validateWardManager(session)) {
            return "redirect:/access-denied";
        }

        List<Ward> availableWards = wardService.getAvailableWards();
        model.addAttribute("wards", availableWards);
        model.addAttribute("username", session.getAttribute("username"));
        return "ward-manager/available-wards";
    }

    // Bed Management (moved from BedController)
    // Bed Management - Exclusive to Ward Manager
    @GetMapping("/beds")
    public String manageBeds(HttpSession session, Model model) {
        if (!validateWardManager(session)) {
            return "redirect:/access-denied";
        }

        List<Ward> wards = wardService.getAllWards();
        List<Bed> allBeds = bedService.getAllBeds();

        // Calculate statistics from actual bed data
        long totalBeds = allBeds.size();
        long availableBeds = allBeds.stream().filter(bed -> "AVAILABLE".equals(bed.getStatus())).count();
        long occupiedBeds = allBeds.stream().filter(bed -> "OCCUPIED".equals(bed.getStatus())).count();
        long maintenanceBeds = allBeds.stream().filter(bed -> "MAINTENANCE".equals(bed.getStatus())).count();
        long cleaningBeds = allBeds.stream().filter(bed -> "CLEANING".equals(bed.getStatus())).count();

        // Debug output to verify data
        System.out.println("DEBUG: Total beds: " + totalBeds);
        System.out.println("DEBUG: Available beds: " + availableBeds);
        System.out.println("DEBUG: Occupied beds: " + occupiedBeds);
        System.out.println("DEBUG: Maintenance beds: " + maintenanceBeds);
        System.out.println("DEBUG: Cleaning beds: " + cleaningBeds);

        // Verify ward data
        for (Ward ward : wards) {
            System.out.println("DEBUG: Ward " + ward.getWardNumber() +
                    " - Total: " + ward.getTotalBeds() +
                    ", Available: " + ward.getAvailableBeds());
        }

        model.addAttribute("wards", wards);
        model.addAttribute("allBeds", allBeds);
        model.addAttribute("totalBeds", totalBeds);
        model.addAttribute("availableBeds", availableBeds);
        model.addAttribute("occupiedBeds", occupiedBeds);
        model.addAttribute("maintenanceBeds", maintenanceBeds);
        model.addAttribute("cleaningBeds", cleaningBeds);
        model.addAttribute("username", session.getAttribute("username"));
        model.addAttribute("pageTitle", "Bed Management");

        return "ward-manager/beds";
    }

    @GetMapping("/beds/ward/{wardId}")
    public String viewWardBeds(@PathVariable Long wardId, HttpSession session, Model model) {
        if (!validateWardManager(session)) {
            return "redirect:/access-denied";
        }

        Ward ward = wardService.getWardById(wardId);
        List<Bed> beds = bedService.getBedsByWardId(wardId);

        // Categorize beds by status
        List<Bed> availableBeds = beds.stream().filter(bed -> "AVAILABLE".equals(bed.getStatus())).collect(Collectors.toList());
        List<Bed> occupiedBeds = beds.stream().filter(bed -> "OCCUPIED".equals(bed.getStatus())).collect(Collectors.toList());
        List<Bed> maintenanceBeds = beds.stream().filter(bed -> "MAINTENANCE".equals(bed.getStatus())).collect(Collectors.toList());
        List<Bed> cleaningBeds = beds.stream().filter(bed -> "CLEANING".equals(bed.getStatus())).collect(Collectors.toList());

        model.addAttribute("ward", ward);
        model.addAttribute("beds", beds);
        model.addAttribute("availableBeds", availableBeds);
        model.addAttribute("occupiedBeds", occupiedBeds);
        model.addAttribute("maintenanceBeds", maintenanceBeds);
        model.addAttribute("cleaningBeds", cleaningBeds);
        model.addAttribute("username", session.getAttribute("username"));
        model.addAttribute("pageTitle", "Beds in " + ward.getWardNumber());

        return "ward-manager/ward-beds";
    }

    @GetMapping("/beds/add")
    public String showAddBedForm(HttpSession session, Model model) {
        if (!validateWardManager(session)) {
            return "redirect:/access-denied";
        }

        List<Ward> wards = wardService.getAllWards();
        model.addAttribute("wards", wards);
        model.addAttribute("bed", new Bed());
        model.addAttribute("username", session.getAttribute("username"));
        model.addAttribute("pageTitle", "Add New Bed");

        return "ward-manager/add-bed";
    }

    @PostMapping("/beds/add")
    public String addBed(@RequestParam Long wardId,
                         @RequestParam String bedNumber,
                         @RequestParam String status,
                         HttpSession session) {
        if (!validateWardManager(session)) {
            return "redirect:/access-denied";
        }

        try {
            Ward ward = wardService.getWardById(wardId);
            if (ward != null) {
                Bed bed = new Bed();
                bed.setBedNumber(bedNumber);
                bed.setStatus(status);
                bed.setWard(ward);
                bedService.saveBed(bed);

                // UPDATE: Synchronize ward bed counts after adding new bed
                bedService.updateWardBedCounts(wardId);

                return "redirect:/ward-manager/beds/ward/" + wardId + "?success=Bed added successfully";
            }
            return "redirect:/ward-manager/beds/add?error=Ward not found";
        } catch (Exception e) {
            return "redirect:/ward-manager/beds/add?error=Failed to add bed: " + e.getMessage();
        }
    }
    @GetMapping("/beds/edit/{bedId}")
    public String showEditBedForm(@PathVariable Long bedId, HttpSession session, Model model) {
        if (!validateWardManager(session)) {
            return "redirect:/access-denied";
        }

        Bed bed = bedService.getBedById(bedId);
        List<Ward> wards = wardService.getAllWards();

        model.addAttribute("bed", bed);
        model.addAttribute("wards", wards);
        model.addAttribute("username", session.getAttribute("username"));
        model.addAttribute("pageTitle", "Edit Bed - " + (bed != null ? bed.getBedNumber() : ""));

        return "ward-manager/edit-bed";
    }

    @PostMapping("/beds/update/{bedId}")
    public String updateBed(@PathVariable Long bedId,
                            @RequestParam Long wardId,
                            @RequestParam String bedNumber,
                            @RequestParam String status,
                            HttpSession session) {
        if (!validateWardManager(session)) {
            return "redirect:/access-denied";
        }

        try {
            Bed bed = bedService.getBedById(bedId);
            Ward ward = wardService.getWardById(wardId);

            if (bed != null && ward != null) {
                bed.setBedNumber(bedNumber);
                bed.setStatus(status);
                bed.setWard(ward);
                bedService.saveBed(bed);

                return "redirect:/ward-manager/beds/ward/" + wardId + "?success=Bed updated successfully";
            }
            return "redirect:/ward-manager/beds/edit/" + bedId + "?error=Bed or Ward not found";
        } catch (Exception e) {
            return "redirect:/ward-manager/beds/edit/" + bedId + "?error=Failed to update bed: " + e.getMessage();
        }
    }

    @GetMapping("/beds/delete/{bedId}")
    public String deleteBed(@PathVariable Long bedId, HttpSession session) {
        if (!validateWardManager(session)) {
            return "redirect:/access-denied";
        }

        try {
            Bed bed = bedService.getBedById(bedId);
            if (bed != null) {
                Long wardId = bed.getWard().getId();

                // Check if bed is occupied
                if ("OCCUPIED".equals(bed.getStatus())) {
                    return "redirect:/ward-manager/beds/ward/" + wardId + "?error=Cannot delete occupied bed";
                }

                bedService.deleteBed(bedId);

                // UPDATE: Synchronize ward bed counts after deleting bed
                bedService.updateWardBedCounts(wardId);

                return "redirect:/ward-manager/beds/ward/" + wardId + "?success=Bed deleted successfully";
            }
            return "redirect:/ward-manager/beds?error=Bed not found";
        } catch (Exception e) {
            return "redirect:/ward-manager/beds?error=Failed to delete bed: " + e.getMessage();
        }
    }
    @PostMapping("/beds/update-status")
    public String updateBedStatus(@RequestParam Long bedId,
                                  @RequestParam String status,
                                  HttpSession session) {
        if (!validateWardManager(session)) {
            return "redirect:/access-denied";
        }

        try {
            Bed bed = bedService.getBedById(bedId);
            if (bed != null) {
                // Special handling for status changes
                if ("OCCUPIED".equals(status) && bed.getPatient() == null) {
                    return "redirect:/ward-manager/beds/ward/" + bed.getWard().getId() + "?error=Cannot set bed to occupied without a patient";
                }

                bed.setStatus(status);
                bedService.saveBed(bed);

                // UPDATE: Synchronize ward bed counts after status change
                bedService.updateWardBedCounts(bed.getWard().getId());

                return "redirect:/ward-manager/beds/ward/" + bed.getWard().getId() + "?success=Bed status updated to " + status;
            }
            return "redirect:/ward-manager/beds?error=Bed not found";
        } catch (Exception e) {
            return "redirect:/ward-manager/beds?error=Failed to update bed status: " + e.getMessage();
        }
    }
    @GetMapping("/beds/synchronize-ward-counts")
    public String synchronizeWardCounts(@RequestParam Long wardId, HttpSession session) {
        if (!validateWardManager(session)) {
            return "redirect:/access-denied";
        }

        try {
            bedService.updateWardBedCounts(wardId);
            return "redirect:/ward-manager/beds/ward/" + wardId + "?success=Ward bed counts synchronized successfully";
        } catch (Exception e) {
            return "redirect:/ward-manager/beds/ward/" + wardId + "?error=Failed to synchronize ward counts: " + e.getMessage();
        }
    }

    // Add this method to your WardManagerController
    @GetMapping("/beds/initialize-ward-beds")
    public String initializeWardBeds(@RequestParam Long wardId, HttpSession session) {
        if (!validateWardManager(session)) {
            return "redirect:/access-denied";
        }

        try {
            Ward ward = wardService.getWardById(wardId);
            if (ward != null) {
                // Get current bed count
                List<Bed> currentBeds = bedService.getBedsByWardId(wardId);
                int currentBedCount = currentBeds.size();
                int bedsToCreate = ward.getTotalBeds() - currentBedCount;

                if (bedsToCreate > 0) {
                    // Create missing beds
                    for (int i = 1; i <= bedsToCreate; i++) {
                        Bed bed = new Bed();
                        bed.setBedNumber(ward.getWardNumber() + "-B" + (currentBedCount + i));
                        bed.setStatus("AVAILABLE");
                        bed.setWard(ward);
                        bedService.saveBed(bed);
                    }
                    // Update ward counts
                    bedService.updateWardBedCounts(wardId);
                    return "redirect:/ward-manager/wards?success=" + bedsToCreate + " beds initialized for ward " + ward.getWardNumber();
                } else {
                    return "redirect:/ward-manager/wards?info=No beds need to be initialized for ward " + ward.getWardNumber();
                }
            }
            return "redirect:/ward-manager/wards?error=Ward not found";
        } catch (Exception e) {
            return "redirect:/ward-manager/wards?error=Failed to initialize beds: " + e.getMessage();
        }
    }
    @GetMapping("/beds/status/{status}")
    public String viewBedsByStatus(@PathVariable String status, HttpSession session, Model model) {
        if (!validateWardManager(session)) {
            return "redirect:/access-denied";
        }

        List<Bed> beds = bedService.getBedsByStatus(status.toUpperCase());

        model.addAttribute("beds", beds);
        model.addAttribute("status", status);
        model.addAttribute("username", session.getAttribute("username"));
        model.addAttribute("pageTitle", status + " Beds");

        return "ward-manager/beds-by-status";
    }

    private boolean validateWardManager(HttpSession session) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        boolean isValid = username != null && "WARD_MANAGER".equals(role);
        System.out.println("DEBUG: WardManager validation - username: " + username + ", role: " + role + ", valid: " + isValid);
        return isValid;
    }

    // Admission Management - Exclusive to Ward Manager
    @GetMapping("/admissions")
    public String manageAdmissions(HttpSession session, Model model) {
        if (!validateWardManager(session)) {
            return "redirect:/access-denied";
        }

        // Get current admissions from database
        List<Admission> currentAdmissions = admissionService.getCurrentAdmissions();
        List<Patient> patients = patientService.getAllPatients();
        List<Ward> availableWards = wardService.getAvailableWards();

        model.addAttribute("currentAdmissions", currentAdmissions);
        model.addAttribute("patients", patients);
        model.addAttribute("availableWards", availableWards);
        model.addAttribute("pageTitle", "Admission Management");
        model.addAttribute("username", session.getAttribute("username"));

        return "ward-manager/admissions";
    }

    @GetMapping("/admissions/admit")
    public String showAdmitForm(HttpSession session, Model model) {
        if (!validateWardManager(session)) {
            return "redirect:/access-denied";
        }

        List<Patient> patients = patientService.getAllPatients();
        List<Ward> availableWards = wardService.getAvailableWards();

        model.addAttribute("patients", patients);
        model.addAttribute("availableWards", availableWards);
        model.addAttribute("username", session.getAttribute("username"));
        model.addAttribute("pageTitle", "Admit Patient");

        return "ward-manager/admit-patient";
    }

    @PostMapping("/admissions/admit")
    public String admitPatient(@RequestParam Long patientId,
                               @RequestParam Long wardId,
                               @RequestParam Long bedId,
                               @RequestParam String reason,
                               HttpSession session) {
        if (!validateWardManager(session)) {
            return "redirect:/access-denied";
        }

        try {
            boolean success = admissionService.admitPatient(patientId, wardId, bedId, reason);
            if (success) {
                return "redirect:/ward-manager/admissions?success=Patient admitted successfully";
            } else {
                return "redirect:/ward-manager/admissions/admit?error=Failed to admit patient: Bed might be occupied or not available";
            }
        } catch (Exception e) {
            e.printStackTrace(); // Add this for debugging
            return "redirect:/ward-manager/admissions/admit?error=Failed to admit patient: " + e.getMessage();
        }
    }

    @PostMapping("/admissions/discharge")
    public String dischargePatient(@RequestParam Long admissionId, HttpSession session) {
        if (!validateWardManager(session)) {
            return "redirect:/access-denied";
        }

        try {
            admissionService.dischargePatient(admissionId);
            return "redirect:/ward-manager/admissions?success=Patient discharged successfully";
        } catch (Exception e) {
            return "redirect:/ward-manager/admissions?error=Failed to discharge patient: " + e.getMessage();
        }
    }

    @GetMapping("/admissions/patient/{patientId}")
    public String viewPatientAdmissions(@PathVariable Long patientId, HttpSession session, Model model) {
        if (!validateWardManager(session)) {
            return "redirect:/access-denied";
        }

        List<Admission> patientAdmissions = admissionService.getAdmissionsByPatientId(patientId);
        Patient patient = patientService.getPatientById(patientId);

        model.addAttribute("admissions", patientAdmissions);
        model.addAttribute("patient", patient);
        model.addAttribute("username", session.getAttribute("username"));
        model.addAttribute("pageTitle", "Patient Admission History");

        return "ward-manager/patient-admissions";
    }

    @GetMapping("/admissions/transfer/{admissionId}")
    public String showTransferForm(@PathVariable Long admissionId, HttpSession session, Model model) {
        if (!validateWardManager(session)) {
            return "redirect:/access-denied";
        }

        Admission admission = admissionService.getAdmissionById(admissionId);
        List<Ward> availableWards = wardService.getAvailableWards();

        model.addAttribute("admission", admission);
        model.addAttribute("availableWards", availableWards);
        model.addAttribute("username", session.getAttribute("username"));
        model.addAttribute("pageTitle", "Transfer Patient");

        return "ward-manager/transfer-patient";
    }

    @PostMapping("/admissions/transfer")
    public String transferPatient(@RequestParam Long admissionId,
                                  @RequestParam Long newWardId,
                                  @RequestParam Long newBedId,
                                  HttpSession session) {
        if (!validateWardManager(session)) {
            return "redirect:/access-denied";
        }

        try {
            admissionService.transferPatient(admissionId, newWardId, newBedId);
            return "redirect:/ward-manager/admissions?success=Patient transferred successfully";
        } catch (Exception e) {
            return "redirect:/ward-manager/admissions?error=Failed to transfer patient: " + e.getMessage();
        }
    }
}