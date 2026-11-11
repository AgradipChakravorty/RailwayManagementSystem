package com.railway.servlet;

import com.railway.dao.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/my-bookings")
public class MyBookingsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = (Integer) session.getAttribute("userId");
        request.setAttribute("bookings", new BookingDAO().getUserBookings(userId));
        request.getRequestDispatcher("my-bookings.jsp").forward(request, response);
    }
}
