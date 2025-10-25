// WardService.java - Remove the medicalStaffService dependency
package com.hms.hospitalmanagementsystem.service;

import com.hms.hospitalmanagementsystem.entity.Ward;
import com.hms.hospitalmanagementsystem.entity.Bed;
import com.hms.hospitalmanagementsystem.repository.BedRepository;
import com.hms.hospitalmanagementsystem.repository.WardRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class WardService {

    @Autowired
    private WardRepository wardRepository;

    @Autowired
    private BedRepository bedRepository;

    // Remove the medicalStaffService dependency

    public List<Ward> getAllWards() {
        return wardRepository.findAll();
    }

    public Ward getWardById(Long id) {
        Optional<Ward> ward = wardRepository.findById(id);
        return ward.orElse(null);
    }

    // Add this method to WardService.java
    public void synchronizeAllWardBedCounts() {
        List<Ward> allWards = getAllWards();
        for (Ward ward : allWards) {
            updateWardBedCount(ward.getId());
        }
    }

    public Ward saveWard(Ward ward) {
        try {
            System.out.println("DEBUG: Saving ward - ID: " + ward.getId() + ", Number: " + ward.getWardNumber());

            // Validate available beds don't exceed total beds
            if (ward.getAvailableBeds() > ward.getTotalBeds()) {
                ward.setAvailableBeds(ward.getTotalBeds());
            }

            // Ensure available beds is not negative
            if (ward.getAvailableBeds() < 0) {
                ward.setAvailableBeds(0);
            }

            Ward savedWard = wardRepository.save(ward);
            System.out.println("DEBUG: Ward saved successfully - ID: " + savedWard.getId());
            return savedWard;

        } catch (Exception e) {
            System.err.println("ERROR in saveWard: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    public void deleteWard(Long id) {
        wardRepository.deleteById(id);
    }

    public List<Ward> getAvailableWards() {
        return wardRepository.findAvailableWards();
    }

    public List<Ward> getAvailableWardsByDepartment(Long departmentId) {
        return wardRepository.findAvailableWardsByDepartmentId(departmentId);
    }

    public List<Ward> getWardsByDepartment(Long departmentId) {
        return wardRepository.findByDepartmentId(departmentId);
    }

    public List<Ward> getWardsByType(String wardType) {
        return wardRepository.findByWardTypeContainingIgnoreCase(wardType);
    }

    public Ward updateWardBedCount(Long wardId) {
        Optional<Ward> wardOpt = wardRepository.findById(wardId);
        if (wardOpt.isPresent()) {
            Ward ward = wardOpt.get();
            Long occupiedBeds = wardRepository.countOccupiedBedsByWardId(wardId);
            ward.setAvailableBeds(ward.getTotalBeds() - occupiedBeds.intValue());
            return wardRepository.save(ward);
        }
        return null;
    }

    public List<Bed> getAvailableBedsByWardId(Long wardId) {
        return bedRepository.findByWardIdAndOccupiedFalse(wardId);
    }
    public void updateBedStatus(Long bedId, String status) {
        Bed bed = bedRepository.findById(bedId)
                .orElseThrow(() -> new RuntimeException("Bed not found"));
        bed.setStatus(status);
        bedRepository.save(bed);
    }
}
