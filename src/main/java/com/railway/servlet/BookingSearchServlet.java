package com.railway.servlet;

import com.railway.dao.BookingDAO;
import com.railway.model.Booking;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/search-booking")
public class BookingSearchServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            int userId = (Integer) session.getAttribute("userId");
            Booking booking = new BookingDAO().getBookingById(bookingId, userId);
            request.setAttribute("booking", booking);
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Enter a valid booking ID.");
        }
        request.getRequestDispatcher("booking-search-result.jsp").forward(request, response);
    }
}
