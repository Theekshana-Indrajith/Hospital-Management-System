package com.hms.hospitalmanagementsystem.config;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collection;

@Component
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
        Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();

        for (GrantedAuthority authority : authorities) {
            if (authority.getAuthority().equals("ROLE_ADMIN")) {
                response.sendRedirect("/admin/dashboard");
                return;
            } else if (authority.getAuthority().equals("ROLE_DOCTOR")) {
                response.sendRedirect("/doctor/dashboard");
                return;
            } else if (authority.getAuthority().equals("ROLE_PATIENT")) {
                response.sendRedirect("/patient/dashboard");
                return;
            } else if (authority.getAuthority().equals("ROLE_STAFF")) {
                response.sendRedirect("/staff/dashboard");
                return;
            } else if (authority.getAuthority().equals("ROLE_LAB_TECH")) { // ✅ FIXED
                response.sendRedirect("/lab-technician/dashboard");
                return;
            } else if (authority.getAuthority().equals("ROLE_WARD_MANAGER")) { // ✅ NEW
                response.sendRedirect("/ward-manager/dashboard");
                return;
            } else if (authority.getAuthority().equals("ROLE_RECEPTIONIST")) {
                response.sendRedirect("/receptionist/dashboard");
                return;
            }
        }

        // Default redirect if no role matches
        response.sendRedirect("/dashboard");
    }
}


