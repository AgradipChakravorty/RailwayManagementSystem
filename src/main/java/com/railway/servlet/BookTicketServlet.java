package com.railway.servlet;

import com.railway.dao.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/book-ticket")
public class BookTicketServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int userId = (Integer) session.getAttribute("userId");
            int trainId = Integer.parseInt(request.getParameter("trainId"));
            String date = request.getParameter("journeyDate");
            String passengerName = request.getParameter("passengerName");
            int age = Integer.parseInt(request.getParameter("passengerAge"));

            if (date == null || LocalDate.parse(date).isBefore(LocalDate.now())
                    || passengerName == null || passengerName.isBlank()
                    || age < 1 || age > 120) {
                response.sendRedirect("home.jsp?error=Please enter valid passenger details.");
                return;
            }

            int bookingId = new BookingDAO().bookTicket(userId, trainId, date, passengerName, age);
            if (bookingId > 0) {
                response.sendRedirect("booking-confirmation.jsp?id=" + bookingId);
            } else {
                response.sendRedirect("home.jsp?error=No seats available or booking failed.");
            }
        } catch (Exception e) {
            response.sendRedirect("home.jsp?error=Invalid booking details.");
        }
    }
}
