// BedService.java
package com.hms.hospitalmanagementsystem.service;

import com.hms.hospitalmanagementsystem.entity.Bed;
import com.hms.hospitalmanagementsystem.entity.Ward;
import com.hms.hospitalmanagementsystem.repository.BedRepository;
import com.hms.hospitalmanagementsystem.repository.WardRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class BedService {

    @Autowired
    private BedRepository bedRepository;

    @Autowired
    private WardRepository wardRepository;

    @Autowired
    private WardService wardService;

    public List<Bed> getAllBeds() {
        return bedRepository.findAll();
    }

    public Bed getBedById(Long id) {
        Optional<Bed> bed = bedRepository.findById(id);
        return bed.orElse(null);
    }

    public Bed saveBed(Bed bed) {
        return bedRepository.save(bed);
    }

    public void deleteBed(Long id) {
        bedRepository.deleteById(id);
    }

    public List<Bed> getBedsByWardId(Long wardId) {
        return bedRepository.findByWardId(wardId);
    }

    public List<Bed> getAvailableBedsByWardId(Long wardId) {
        try {
            System.out.println("DEBUG: Service - Getting available beds for ward: " + wardId);
            List<Bed> beds = bedRepository.findAvailableBedsByWardId(wardId);
            System.out.println("DEBUG: Service - Found " + beds.size() + " beds");
            return beds;
        } catch (Exception e) {
            System.err.println("ERROR in getAvailableBedsByWardId: " + e.getMessage());
            return List.of();
        }
    }

    public List<Bed> getBedsByStatus(String status) {
        return bedRepository.findByStatus(status);
    }

    public Bed assignPatientToBed(Long bedId, Long patientId) {
        Optional<Bed> bedOpt = bedRepository.findById(bedId);
        if (bedOpt.isPresent()) {
            Bed bed = bedOpt.get();
            if ("AVAILABLE".equals(bed.getStatus())) {
                // In a real scenario, you would fetch the patient entity here
                // For now, we'll just update the status
                bed.setStatus("OCCUPIED");
                return bedRepository.save(bed);
            }
        }
        return null;
    }

    // Add this method to your existing BedService.java
    public void updateWardBedCounts(Long wardId) {
        try {
            Ward ward = wardService.getWardById(wardId);
            if (ward != null) {
                // Count total beds for this ward
                List<Bed> wardBeds = getBedsByWardId(wardId);
                int totalBeds = wardBeds.size();

                // Count available beds (status = AVAILABLE)
                long availableBeds = wardBeds.stream()
                        .filter(bed -> "AVAILABLE".equals(bed.getStatus()))
                        .count();

                // Update ward counts
                ward.setTotalBeds(totalBeds);
                ward.setAvailableBeds((int) availableBeds);
                wardService.saveWard(ward);

                System.out.println("DEBUG: Updated ward " + ward.getWardNumber() +
                        " - Total: " + totalBeds + ", Available: " + availableBeds);
            }
        } catch (Exception e) {
            System.err.println("ERROR updating ward bed counts: " + e.getMessage());
            e.printStackTrace();
        }
    }
    public Bed dischargePatientFromBed(Long bedId) {
        Optional<Bed> bedOpt = bedRepository.findById(bedId);
        if (bedOpt.isPresent()) {
            Bed bed = bedOpt.get();
            bed.setStatus("AVAILABLE");
            bed.setPatient(null);
            bed.setDischargeDate(java.time.LocalDateTime.now());
            return bedRepository.save(bed);
        }
        return null;
    }

    public void initializeBedsForWard(Ward ward, int numberOfBeds) {
        for (int i = 1; i <= numberOfBeds; i++) {
            Bed bed = new Bed();
            bed.setBedNumber(ward.getWardNumber() + "-B" + i);
            bed.setStatus("AVAILABLE");
            bed.setWard(ward);
            bedRepository.save(bed);
        }
    }
    public List<Bed> getAvailableBedsByWard(Long wardId) {
        try {
            return bedRepository.findByWardIdAndStatus(wardId, "AVAILABLE");
        } catch (Exception e) {
            // Log the error
            System.err.println("Error fetching available beds for ward " + wardId + ": " + e.getMessage());
            return List.of(); // Return empty list instead of null
        }
    }
}