package com.railway.servlet;

import com.railway.dao.BookingDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import java.io.IOException;

@WebServlet("/cancel-booking")
public class CancelBookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int userId = (Integer) session.getAttribute("userId");
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            boolean done = new BookingDAO().cancelBooking(bookingId, userId);
            response.sendRedirect("my-bookings?message=" +
                    (done ? "Booking cancelled." : "Cancellation not possible."));
        } catch (Exception e) {
            response.sendRedirect("my-bookings?message=Invalid booking ID.");
        }
    }
}
