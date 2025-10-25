package com.hms.hospitalmanagementsystem.controller;

import com.hms.hospitalmanagementsystem.entity.Bed;
import com.hms.hospitalmanagementsystem.service.BedService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/beds")
public class BedApiController {

    @Autowired
    private BedService bedService;

    @GetMapping("/available/{wardId}")
    public ResponseEntity<List<Bed>> getAvailableBedsByWard(@PathVariable Long wardId) {
        try {
            System.out.println("DEBUG: Fetching available beds for ward: " + wardId);
            List<Bed> availableBeds = bedService.getAvailableBedsByWardId(wardId);
            System.out.println("DEBUG: Found " + availableBeds.size() + " available beds");
            return ResponseEntity.ok(availableBeds);
        } catch (Exception e) {
            System.err.println("ERROR: Failed to fetch available beds for ward " + wardId + ": " + e.getMessage());
            return ResponseEntity.ok(List.of()); // Return empty list instead of error
        }
    }
}