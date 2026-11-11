package com.railway.servlet;

import com.railway.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            response.sendRedirect("../login.jsp");
            return;
        }

        try (Connection con = DBConnection.getConnection()) {
            request.setAttribute("userCount", count(con, "users"));
            request.setAttribute("trainCount", count(con, "trains"));
            request.setAttribute("bookingCount", count(con, "bookings"));
            request.setAttribute("cancelCount", count(con, "cancellations"));
        } catch (SQLException e) {
            throw new ServletException(e);
        }
        request.getRequestDispatcher("/admin-dashboard.jsp").forward(request, response);
    }

    private int count(Connection con, String table) throws SQLException {
        // Table names are fixed here, not received from the user.
        try (Statement st = con.createStatement();
             ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM " + table)) {
            rs.next();
            return rs.getInt(1);
        }
    }
}
