package com.hms.hospitalmanagementsystem.filter;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import java.io.IOException;

@Component
public class SessionAuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String requestURI = httpRequest.getRequestURI();

        // Allow public URLs
        if (requestURI.equals("/") || requestURI.equals("/login") || requestURI.equals("/register") ||
                requestURI.startsWith("/css/") || requestURI.startsWith("/js/") || requestURI.startsWith("/images/")) {
            chain.doFilter(request, response);
            return;
        }

        // Check if user is logged in
        if (session != null && session.getAttribute("username") != null) {
            // User is authenticated
            chain.doFilter(request, response);
        } else {
            // Redirect to login page
            httpResponse.sendRedirect("/login");
        }
    }
}