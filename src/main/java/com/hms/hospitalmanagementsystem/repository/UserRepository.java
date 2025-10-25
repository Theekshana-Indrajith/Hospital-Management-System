package com.hms.hospitalmanagementsystem.repository;

import com.hms.hospitalmanagementsystem.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    // ==================== BASIC CRUD & AUTHENTICATION ====================

    Optional<User> findByUsername(String username);
    Optional<User> findByEmail(String email);
    boolean existsByUsername(String username);
    boolean existsByEmail(String email);

    // ==================== ROLE-BASED QUERIES ====================

    List<User> findByRole(String role);

    @Query("SELECT COUNT(u) FROM User u WHERE u.role = :role")
    long countByRole(@Param("role") String role);

    User findByProfileIdAndRole(Long profileId, String role);

    // ==================== PROFILE LINKING QUERIES ====================

    @Query("SELECT u FROM User u WHERE u.profileId = :profileId")
    Optional<User> findByProfileId(@Param("profileId") Long profileId);

    @Query("SELECT COUNT(u) > 0 FROM User u WHERE u.profileId = :profileId AND u.role = :role")
    boolean existsByProfileIdAndRole(@Param("profileId") Long profileId, @Param("role") String role);

    @Query("SELECT u FROM User u WHERE u.profileId IS NOT NULL")
    List<User> findAllUsersWithProfile();

    // ==================== SPECIFIC ROLE QUERIES ====================

    @Query("SELECT u FROM User u WHERE u.role = 'DOCTOR'")
    List<User> findAllDoctors();

    @Query("SELECT u FROM User u WHERE u.role = 'PATIENT'")
    List<User> findAllPatients();

    @Query("SELECT u FROM User u WHERE u.role = 'STAFF'")
    List<User> findAllStaff();

    @Query("SELECT u FROM User u WHERE u.role = 'ADMIN'")
    List<User> findAllAdmins();

    @Query("SELECT u FROM User u WHERE u.role = 'NURSE'")
    List<User> findAllNurses();

    @Query("SELECT u FROM User u WHERE u.role = 'LAB_TECH'")
    List<User> findAllLabTechs();

    @Query("SELECT u FROM User u WHERE u.role = 'RECEPTIONIST'")
    List<User> findAllReceptionists();

    @Query("SELECT u FROM User u WHERE u.role = 'WARD_MANAGER'")
    List<User> findAllWardManagers();

    // ==================== SEARCH & FILTER QUERIES ====================

    @Query("SELECT u FROM User u WHERE u.username LIKE %:keyword% OR u.email LIKE %:keyword%")
    List<User> findByUsernameOrEmailContaining(@Param("keyword") String keyword);

    @Query("SELECT u FROM User u WHERE u.role = :role AND (u.username LIKE %:keyword% OR u.email LIKE %:keyword%)")
    List<User> findByRoleAndUsernameOrEmailContaining(@Param("role") String role, @Param("keyword") String keyword);

    // ==================== STATUS & VALIDATION QUERIES ====================

    @Query("SELECT COUNT(u) FROM User u WHERE u.role = 'PATIENT'")
    long countAllPatients();

    @Query("SELECT COUNT(u) FROM User u WHERE u.role = 'DOCTOR'")
    long countAllDoctors();

    @Query("SELECT COUNT(u) FROM User u WHERE u.role = 'STAFF'")
    long countAllStaff();

    @Query("SELECT u FROM User u WHERE u.profileId IS NULL")
    List<User> findUsersWithoutProfile();

    // ==================== UTILITY QUERIES ====================

    @Query("SELECT DISTINCT u.role FROM User u")
    List<String> findDistinctRoles();

    @Query("SELECT u FROM User u ORDER BY u.role, u.username")
    List<User> findAllOrderByRoleAndUsername();

    @Query("SELECT u.role, COUNT(u) FROM User u GROUP BY u.role")
    List<Object[]> countUsersByRole();

    // ==================== SECURITY & ACCESS QUERIES ====================

    @Query("SELECT u.role FROM User u WHERE u.username = :username")
    Optional<String> findRoleByUsername(@Param("username") String username);

    @Query("SELECT u.id FROM User u WHERE u.username = :username")
    Optional<Long> findUserIdByUsername(@Param("username") String username);

    @Query("SELECT u.profileId FROM User u WHERE u.username = :username AND u.role = :role")
    Optional<Long> findProfileIdByUsernameAndRole(@Param("username") String username, @Param("role") String role);

    // ==================== BULK OPERATIONS ====================

    @Query("SELECT u FROM User u WHERE u.id IN :userIds")
    List<User> findUsersByIds(@Param("userIds") List<Long> userIds);

    @Query("SELECT u FROM User u WHERE u.role IN :roles")
    List<User> findByRoles(@Param("roles") List<String> roles);
}