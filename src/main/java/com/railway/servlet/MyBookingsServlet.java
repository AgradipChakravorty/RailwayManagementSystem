package com.railway.servlet;

import com.railway.dao.BookingDAO;
import com.railway.model.Booking;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/my-bookings")
public class MyBookingsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        List<Booking> allBookings = new BookingDAO().getUserBookings(userId);

        int confirmedCount = 0;
        int cancelledCount = 0;
        for (Booking b : allBookings) {
            if ("CONFIRMED".equalsIgnoreCase(b.getStatus())) {
                confirmedCount++;
            } else if ("CANCELLED".equalsIgnoreCase(b.getStatus())) {
                cancelledCount++;
            }
        }

        String statusFilter = request.getParameter("status");
        List<Booking> filteredBookings = new ArrayList<>();

        if (statusFilter != null && ("CONFIRMED".equalsIgnoreCase(statusFilter) || "CANCELLED".equalsIgnoreCase(statusFilter))) {
            for (Booking b : allBookings) {
                if (statusFilter.equalsIgnoreCase(b.getStatus())) {
                    filteredBookings.add(b);
                }
            }
        } else {
            filteredBookings = allBookings;
            statusFilter = "ALL";
        }

        request.setAttribute("totalCount", allBookings.size());
        request.setAttribute("confirmedCount", confirmedCount);
        request.setAttribute("cancelledCount", cancelledCount);
        request.setAttribute("currentStatus", statusFilter);
        request.setAttribute("bookings", filteredBookings);

        request.getRequestDispatcher("my-bookings.jsp").forward(request, response);
    }
}