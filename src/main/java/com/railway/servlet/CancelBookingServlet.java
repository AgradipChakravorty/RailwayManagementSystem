package com.railway.servlet;

import com.railway.dao.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet("/cancel-booking")
public class CancelBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("my-bookings");
    }

    @Override
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

            if (done) {
                String msg = URLEncoder.encode("Booking #" + bookingId + " cancelled successfully.", StandardCharsets.UTF_8);
                response.sendRedirect("my-bookings?message=" + msg + "&type=success");
            } else {
                String msg = URLEncoder.encode("Cancellation not possible.", StandardCharsets.UTF_8);
                response.sendRedirect("my-bookings?message=" + msg + "&type=error");
            }
        } catch (Exception e) {
            String msg = URLEncoder.encode("Invalid booking ID.", StandardCharsets.UTF_8);
            response.sendRedirect("my-bookings?message=" + msg + "&type=error");
        }
    }
}