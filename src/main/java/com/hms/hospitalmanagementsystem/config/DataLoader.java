package com.hms.hospitalmanagementsystem.config;

import com.hms.hospitalmanagementsystem.entity.*;
import com.hms.hospitalmanagementsystem.repository.*;
import com.hms.hospitalmanagementsystem.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Component
public class DataLoader implements CommandLineRunner {

    @Autowired private UserService userService;
    @Autowired private PasswordEncoder passwordEncoder;
    @Autowired private UserRepository userRepository;
    @Autowired private PatientRepository patientRepository;
    @Autowired private DoctorRepository doctorRepository;
    @Autowired private WardRepository wardRepository;
    @Autowired private BedRepository bedRepository;
    @Autowired private AdmissionRepository admissionRepository;
    @Autowired private AppointmentRepository appointmentRepository;
    @Autowired private LabTestRepository labTestRepository;
    @Autowired private LabDepartmentRepository labDepartmentRepository;
    @Autowired private PrescriptionRepository prescriptionRepository;
    @Autowired private ShiftScheduleRepository shiftScheduleRepository;

    // ADD THESE NEW REPOSITORIES FOR DEPARTMENT AND STAFF
    @Autowired private DepartmentRepository departmentRepository;
    @Autowired private StaffRepository staffRepository;

    @Override
    public void run(String... args) throws Exception {
        System.out.println("=== DATA LOADER STARTED ===");

        // Create sample data only if database is empty
        if (userRepository.count() == 0) {
            createDefaultUsers();
            createSamplePatients();
            createSampleDoctors(); // UNCOMMENTED THIS LINE
            createSampleDepartmentsAndStaff(); // ADD THIS LINE
            createSampleWardsAndBeds();
            createSampleAppointments();
            createSampleAdmissions();
            createSampleShiftSchedules();
            System.out.println("✅ Sample data created successfully");
        } else {
            System.out.println("ℹ️ Database already contains data");
        }

        System.out.println("=== DATA LOADER COMPLETED ===");
        verifyData();
    }

    private void createDefaultUsers() {
        System.out.println("=== CREATING DEFAULT USERS ===");

        // Create Admin user
        User admin = new User();
        admin.setUsername("admin");
        admin.setPassword(passwordEncoder.encode("admin123"));
        admin.setEmail("admin@hospital.com");
        admin.setRole("ADMIN");
        admin.setProfileId(1L);
        userRepository.save(admin);
        System.out.println("✅ ADMIN user created: admin / admin123");

        // Create Doctor user
        User doctorUser = new User();
        doctorUser.setUsername("doctor");
        doctorUser.setPassword(passwordEncoder.encode("doctor123"));
        doctorUser.setEmail("doctor@hospital.com");
        doctorUser.setRole("DOCTOR");
        doctorUser.setProfileId(1L); // Links to first doctor
        userRepository.save(doctorUser);
        System.out.println("✅ DOCTOR user created: doctor / doctor123");

        // Create Staff user
        User staff = new User();
        staff.setUsername("staff");
        staff.setPassword(passwordEncoder.encode("staff123"));
        staff.setEmail("staff@hospital.com");
        staff.setRole("STAFF");
        staff.setProfileId(1L);
        userRepository.save(staff);
        System.out.println("✅ STAFF user created: staff / staff123");

        // Create Patient user
        User patientUser = new User();
        patientUser.setUsername("patient");
        patientUser.setPassword(passwordEncoder.encode("patient123"));
        patientUser.setEmail("patient@hospital.com");
        patientUser.setRole("PATIENT");
        patientUser.setProfileId(1L); // Links to first patient
        userRepository.save(patientUser);
        System.out.println("✅ PATIENT user created: patient / patient123");

        // ✅ ADD LAB TECHNICIAN USER
        // In createDefaultUsers() method, make sure this exists:
        User labTechUser = new User();
        labTechUser.setUsername("labtech");
        labTechUser.setPassword(passwordEncoder.encode("labtech123"));
        labTechUser.setEmail("labtech@hospital.com");
        labTechUser.setRole("LAB_TECH");
        labTechUser.setProfileId(1L);
        userRepository.save(labTechUser);
        System.out.println("✅ LAB TECHNICIAN user created: labtech / labtech123");

        User wardManager = new User();
        wardManager.setUsername("wardmanager");
        wardManager.setPassword(passwordEncoder.encode("ward123"));
        wardManager.setEmail("wardmanager@hospital.com");
        wardManager.setRole("WARD_MANAGER");
        wardManager.setProfileId(1L);
        userRepository.save(wardManager);
        System.out.println("✅ WARD MANAGER user created: wardmanager / ward123");

        // In createDefaultUsers() method, add:
        User receptionist = new User();
        receptionist.setUsername("receptionist");
        receptionist.setPassword(passwordEncoder.encode("receptionist123"));
        receptionist.setEmail("receptionist@hospital.com");
        receptionist.setRole("RECEPTIONIST");
        receptionist.setProfileId(1L);
        userRepository.save(receptionist);
        System.out.println("✅ RECEPTIONIST user created: receptionist / receptionist123");
    }

    private void createSamplePatients() {
        System.out.println("=== CREATING SAMPLE PATIENTS ===");

        Patient[] patients = {
                new Patient("John", "Smith", LocalDate.of(1985, 5, 15), "Male", "0771234567", "123 Main St, Colombo", "john.smith@email.com"),
                new Patient("Mary", "Johnson", LocalDate.of(1990, 8, 22), "Female", "0772345678", "456 Oak Ave, Kandy", "mary.j@email.com"),
                new Patient("David", "Brown", LocalDate.of(1978, 12, 5), "Male", "0773456789", "789 Palm Rd, Galle", "david.b@email.com"),
                new Patient("Sarah", "Wilson", LocalDate.of(1995, 3, 30), "Female", "0774567890", "321 Pine St, Jaffna", "sarah.w@email.com"),
                new Patient("Robert", "Davis", LocalDate.of(1982, 7, 18), "Male", "0775678901", "654 Cedar Ln, Negombo", "robert.d@email.com")
        };

        for (Patient patient : patients) {
            patientRepository.save(patient);
            System.out.println("✅ Created patient: " + patient.getFirstName() + " " + patient.getLastName());
        }
    }

    // UNCOMMENT AND FIX THIS METHOD
    private void createSampleDoctors() {
        System.out.println("=== CREATING SAMPLE DOCTORS ===");

        // Create doctors without department first (department will be assigned later)
        Doctor[] doctors = {
                new Doctor("Dr. Kamal Perera", "Cardiology", "0771111111", "kamal.perera@hospital.com", "Room 101", null),
                new Doctor("Dr. Nimali Fernando", "Pediatrics", "0772222222", "nimali.fernando@hospital.com", "Room 102", null),
                new Doctor("Dr. Sunil Rathnayake", "Neurology", "0773333333", "sunil.r@hospital.com", "Room 103", null),
                new Doctor("Dr. Priya Silva", "Dermatology", "0774444444", "priya.silva@hospital.com", "Room 104", null),
                new Doctor("Dr. Anura Bandara", "Orthopedics", "0775555555", "anura.b@hospital.com", "Room 105", null)
        };

        for (Doctor doctor : doctors) {
            doctorRepository.save(doctor);
            System.out.println("✅ Created doctor: " + doctor.getName() + " - " + doctor.getSpecialization());
        }
    }


    private void createBedsForWard(Ward ward, int numberOfBeds) {
        for (int i = 1; i <= numberOfBeds; i++) {
            Bed bed = new Bed();
            bed.setBedNumber(ward.getWardNumber() + "-B" + i);
            bed.setStatus("AVAILABLE");
            bed.setWard(ward);
            bedRepository.save(bed);
        }
    }

    private void createSampleAppointments() {
        System.out.println("=== CREATING SAMPLE APPOINTMENTS ===");

        // Get sample patients and doctors
        Patient patient1 = patientRepository.findById(1L).orElse(null);
        Patient patient2 = patientRepository.findById(2L).orElse(null);
        Doctor doctor1 = doctorRepository.findById(1L).orElse(null);
        Doctor doctor2 = doctorRepository.findById(2L).orElse(null);

        if (patient1 != null && doctor1 != null) {
            Appointment appointment1 = new Appointment(patient1, doctor1,
                    LocalDateTime.now().plusDays(1), "Regular checkup", "SCHEDULED");
            appointmentRepository.save(appointment1);

            Appointment appointment2 = new Appointment(patient2, doctor2,
                    LocalDateTime.now().plusDays(2), "Consultation", "SCHEDULED");
            appointmentRepository.save(appointment2);

            System.out.println("✅ Created sample appointments");
        }
    }

    private void createSampleAdmissions() {
        System.out.println("=== CREATING SAMPLE ADMISSIONS ===");

        // Get first patient and available bed
        Patient patient = patientRepository.findById(1L).orElse(null);
        Ward ward = wardRepository.findById(1L).orElse(null);
        Bed bed = bedRepository.findAvailableBedsByWardId(1L).stream().findFirst().orElse(null);

        if (patient != null && ward != null && bed != null) {
            Admission admission = new Admission();
            admission.setPatient(patient);
            admission.setWard(ward);
            admission.setBed(bed);
            admission.setAdmissionDate(LocalDateTime.now().minusDays(2));
            admission.setStatus("ADMITTED");
            admission.setReason("Fever and cough");

            // Update bed status
            bed.setStatus("OCCUPIED");
            bed.setPatient(patient);
            bed.setAdmissionDate(LocalDateTime.now().minusDays(2));
            bedRepository.save(bed);

            // Update ward available beds
            ward.setAvailableBeds(ward.getAvailableBeds() - 1);
            wardRepository.save(ward);

            admissionRepository.save(admission);
            System.out.println("✅ Created sample admission for patient: " + patient.getFirstName());
        }
    }

    private void verifyData() {
        System.out.println("=== DATABASE VERIFICATION ===");
        System.out.println("Total Users: " + userRepository.count());
        System.out.println("Total Patients: " + patientRepository.count());
        System.out.println("Total Doctors: " + doctorRepository.count());
        System.out.println("Total Wards: " + wardRepository.count());
        System.out.println("Total Beds: " + bedRepository.count());
        System.out.println("Total Admissions: " + admissionRepository.count());
        System.out.println("Total Appointments: " + appointmentRepository.count());

        // ADD DEPARTMENT AND STAFF VERIFICATION
        System.out.println("Total Departments: " + departmentRepository.count());
        System.out.println("Total Staff: " + staffRepository.count());
    }

    private void createSampleDepartmentsAndStaff() {
        System.out.println("=== CREATING SAMPLE DEPARTMENTS AND STAFF ===");

        // Create Departments
        Department[] departments = {
                new Department("Cardiology", "Heart and cardiovascular diseases",
                        "Dr. Kamal Perera", "0771111111", "cardiology@hospital.com", "Block A, Floor 1"),
                new Department("Pediatrics", "Child healthcare and development",
                        "Dr. Nimali Fernando", "0772222222", "pediatrics@hospital.com", "Block B, Floor 1"),
                new Department("Neurology", "Nervous system disorders",
                        "Dr. Sunil Rathnayake", "0773333333", "neurology@hospital.com", "Block A, Floor 2"),
                new Department("Orthopedics", "Bone and joint conditions",
                        "Dr. Anura Bandara", "0775555555", "orthopedics@hospital.com", "Block C, Floor 1")
        };

        for (Department dept : departments) {
            departmentRepository.save(dept);
            System.out.println("✅ Created department: " + dept.getName());
        }

        // ✅ ADD LABORATORY DEPARTMENT
        Department labDept = new Department("Laboratory", "Diagnostic testing and analysis",
                "Dr. Lab Manager", "0776666666", "laboratory@hospital.com", "Block D, Floor 1");
        departmentRepository.save(labDept);
        System.out.println("✅ Created department: " + labDept.getName());

        // Create Nursing Staff
        Staff[] nurses = {
                new Staff("Samanthi", "Kumari", "NURSE", LocalDate.of(1990, 5, 15),
                        "Female", "0776666666", "samanthi@hospital.com", "RN, BSc Nursing", departments[0]),
                new Staff("Priyantha", "Silva", "NURSE", LocalDate.of(1988, 8, 22),
                        "Male", "0777777777", "priyantha@hospital.com", "RN, Diploma Nursing", departments[1]),
                new Staff("Chamindi", "Perera", "NURSE", LocalDate.of(1992, 3, 10),
                        "Female", "0778888888", "chamindi@hospital.com", "RN, BSc Nursing", departments[2])
        };

        for (Staff nurse : nurses) {
            staffRepository.save(nurse);
            System.out.println("✅ Created nurse: " + nurse.getFirstName() + " " + nurse.getLastName());
        }

            // Create Departments (existing code...)

            // Create Receptionists - ADD THIS SECTION
        // Create Receptionists - FIXED: Generate unique employee IDs
        Staff[] receptionists = {
                new Staff("Nimal", "Rajapaksa", "RECEPTIONIST",
                        LocalDate.of(1985, 12, 5), "Male", "0779999999",
                        "nimal@hospital.com", "Diploma in Office Admin"),
                new Staff("Kusum", "Wijewardena", "RECEPTIONIST",
                        LocalDate.of(1991, 7, 18), "Female", "0770000000",
                        "kusum@hospital.com", "Degree in Management"),
                new Staff("Saman", "Perera", "RECEPTIONIST",
                        LocalDate.of(1993, 3, 15), "Male", "0771111222",
                        "saman@hospital.com", "Certificate in Healthcare Admin")
        };

        // FIX: Generate unique employee IDs for each receptionist
        for (int i = 0; i < receptionists.length; i++) {
            Staff receptionist = receptionists[i];
            receptionist.setEmployeeId("REC" + (i + 1)); // REC1, REC2, REC3
            receptionist.setAssignedShift("MORNING");
            receptionist.setShiftStartTime("08:00");
            receptionist.setShiftEndTime("16:00");
            receptionist.setWorkingDays("MON-FRI");
            staffRepository.save(receptionist);
            System.out.println("✅ Created receptionist: " + receptionist.getFirstName() + " " + receptionist.getLastName() + " (ID: " + receptionist.getEmployeeId() + ")");
        }

            // Rest of existing code for nurses, lab technicians...

        // ✅ ADD LAB TECHNICIANS
        Staff[] labTechnicians = {
                new Staff("Damsana", "D.V.", "LAB_TECH", LocalDate.of(1993, 4, 15),
                        "Female", "0771112222", "damsana@hospital.com", "BSc in Medical Laboratory Science", labDept),
                new Staff("Ravindu", "Perera", "LAB_TECH", LocalDate.of(1991, 8, 22),
                        "Male", "0771112223", "ravindu@hospital.com", "Diploma in Laboratory Technology", labDept),
                new Staff("Nadeesha", "Silva", "LAB_TECH", LocalDate.of(1994, 12, 10),
                        "Female", "0771112224", "nadeesha@hospital.com", "MSc in Clinical Pathology", labDept)
        };

        for (Staff labTech : labTechnicians) {
            staffRepository.save(labTech);
            System.out.println("✅ Created lab technician: " + labTech.getFirstName() + " " + labTech.getLastName());
        }

        // Update Doctors with Departments
        List<Doctor> doctors = doctorRepository.findAll();
        List<Department> savedDepartments = departmentRepository.findAll();

        for (int i = 0; i < doctors.size() && i < savedDepartments.size(); i++) {
            doctors.get(i).setDepartment(savedDepartments.get(i));
            doctorRepository.save(doctors.get(i));
            System.out.println("✅ Assigned doctor to department: " + doctors.get(i).getName() + " → " + savedDepartments.get(i).getName());
        }
    }

    // In DataLoader.java - Fix the createSampleWardsAndBeds method
    private void createSampleWardsAndBeds() {
        System.out.println("=== CREATING SAMPLE WARDS AND BEDS ===");

        // Get departments first
        List<Department> departments = departmentRepository.findAll();
        if (departments.isEmpty()) {
            System.out.println("❌ No departments found! Creating sample departments first...");
            createSampleDepartmentsAndStaff(); // Ensure departments exist
            departments = departmentRepository.findAll();
        }

        String[][] wardData = {
                {"W-101", "GENERAL", "General Ward - First Floor", "20", "150.00", "1"},
                {"W-201", "ICU", "Intensive Care Unit", "10", "500.00", "1"},
                {"W-301", "PEDIATRIC", "Pediatric Ward", "15", "200.00", "2"},
                {"W-401", "SURGICAL", "Surgical Ward", "12", "300.00", "3"},
                {"W-501", "MATERNITY", "Maternity Ward", "8", "250.00", "4"}
        };

        for (String[] data : wardData) {
            Ward ward = new Ward();
            ward.setWardNumber(data[0]);
            ward.setWardType(data[1]);
            ward.setDescription(data[2]);
            ward.setTotalBeds(Integer.parseInt(data[3]));
            ward.setAvailableBeds(Integer.parseInt(data[3]));
            ward.setChargePerDay(Double.parseDouble(data[4]));

            // Assign department - FIX: Properly find and assign department
            Long deptId = Long.parseLong(data[5]);
            Department department = departments.stream()
                    .filter(dept -> dept.getId().equals(deptId))
                    .findFirst()
                    .orElse(null);

            if (department != null) {
                ward.setDepartment(department);
                System.out.println("✅ Assigning ward " + data[0] + " to department: " + department.getName());
            } else {
                // Fallback to first department if specified department not found
                ward.setDepartment(departments.get(0));
                System.out.println("⚠️ Department ID " + deptId + " not found. Assigning to first department: " + departments.get(0).getName());
            }

            Ward savedWard = wardRepository.save(ward);
            createBedsForWard(savedWard, Integer.parseInt(data[3]));
            System.out.println("✅ Created ward: " + data[0] + " with " + data[3] + " beds");
        }
    }
    // In DataLoader.java - Add this method to fix existing wards
    private void fixExistingWards() {
        System.out.println("=== FIXING EXISTING WARDS ===");

        List<Ward> wards = wardRepository.findAll();
        List<Department> departments = departmentRepository.findAll();

        if (departments.isEmpty()) {
            System.out.println("❌ No departments available to assign to wards");
            return;
        }

        int fixedCount = 0;
        for (Ward ward : wards) {
            if (ward.getDepartment() == null) {
                // Assign to first department as default
                ward.setDepartment(departments.get(0));
                wardRepository.save(ward);
                fixedCount++;
                System.out.println("✅ Fixed ward " + ward.getWardNumber() + " - assigned to " + departments.get(0).getName());
            }
        }

        if (fixedCount > 0) {
            System.out.println("✅ Fixed " + fixedCount + " wards with missing departments");
        } else {
            System.out.println("ℹ️ All wards already have departments assigned");
        }
    }

    // In DataLoader.java - Simplify the lab data creation
    private void createSampleLabData() {
        System.out.println("=== CREATING SAMPLE LAB DATA ===");

        // Create sample lab tests
        List<Patient> patients = patientRepository.findAll();
        List<Doctor> doctors = doctorRepository.findAll();
        List<Staff> labTechnicians = staffRepository.findByStaffType("LAB_TECH");

        if (!patients.isEmpty() && !doctors.isEmpty()) {
            String[][] testData = {
                    {"Complete Blood Count", "BLOOD", "NORMAL", "Routine blood test"},
                    {"Lipid Profile", "BLOOD", "NORMAL", "Cholesterol check"},
                    {"Liver Function Test", "BLOOD", "NORMAL", "Liver enzyme analysis"},
                    {"Urine Analysis", "URINE", "NORMAL", "Routine urine test"},
                    {"Thyroid Profile", "BLOOD", "NORMAL", "Thyroid hormone levels"}
            };

            for (String[] testInfo : testData) {
                LabTest labTest = new LabTest(
                        patients.get(0), // First patient
                        doctors.get(0),  // First doctor
                        testInfo[0],
                        testInfo[1],
                        testInfo[2]
                );
                labTest.setDescription(testInfo[3]);

                // Assign some tests to technicians
                if (!labTechnicians.isEmpty() && Math.random() > 0.5) {
                    labTest.setLabTechnician(labTechnicians.get(0));
                    labTest.setStatus("IN_PROGRESS");
                    labTest.setCollectionDate(LocalDateTime.now().minusHours(2));
                }

                labTestRepository.save(labTest);
                System.out.println("✅ Created lab test: " + testInfo[0]);
            }
        }
    }

    private void createSamplePrescriptions() {
        System.out.println("=== CREATING SAMPLE PRESCRIPTIONS ===");

        // Get sample patients and doctors
        Patient patient1 = patientRepository.findById(1L).orElse(null);
        Patient patient2 = patientRepository.findById(2L).orElse(null);
        Doctor doctor1 = doctorRepository.findById(1L).orElse(null);
        Doctor doctor2 = doctorRepository.findById(2L).orElse(null);

        if (patient1 != null && doctor1 != null) {
            Prescription[] prescriptions = {
                    new Prescription(patient1, doctor1, "Amoxicillin", "500mg", "Three times daily", "7 days", "Take with food"),
                    new Prescription(patient1, doctor1, "Paracetamol", "500mg", "Every 6 hours", "5 days", "As needed for pain"),
                    new Prescription(patient2, doctor2, "Ibuprofen", "400mg", "Three times daily", "3 days", "Take with meals")
            };

            for (Prescription prescription : prescriptions) {
                prescriptionRepository.save(prescription);
                System.out.println("✅ Created prescription: " + prescription.getMedicationName());
            }
        }
    }

    private void createSampleShiftSchedules() {
        System.out.println("=== CREATING SAMPLE SHIFT SCHEDULES ===");

        List<Staff> staffList = staffRepository.findAll();
        List<Ward> wards = wardRepository.findAll();

        if (staffList.isEmpty() || wards.isEmpty()) {
            System.out.println("❌ No staff or wards found for creating schedules");
            return;
        }

        LocalDate today = LocalDate.now();

        // Create shifts for the next 7 days
        for (int i = 0; i < 7; i++) {
            LocalDate scheduleDate = today.plusDays(i);

            for (Staff staff : staffList) {
                // Assign shifts randomly
                String[] shiftTypes = {"MORNING", "EVENING", "NIGHT"};
                String shiftType = shiftTypes[i % shiftTypes.length];

                Ward ward = wards.get(i % wards.size());

                ShiftSchedule shift = new ShiftSchedule();
                shift.setStaff(staff);
                shift.setWard(ward);
                shift.setScheduleDate(scheduleDate);
                shift.setShiftType(shiftType);
                shift.setStatus("SCHEDULED");
                shift.setStartTime(java.time.LocalTime.of(8, 0)); // Default time
                shift.setEndTime(java.time.LocalTime.of(16, 0));  // Default time
                shift.setNotes("Regular shift assignment");

                shiftScheduleRepository.save(shift);
                System.out.println("✅ Created shift for " + staff.getFirstName() + " on " + scheduleDate + " - " + shiftType);
            }
        }
    }


}