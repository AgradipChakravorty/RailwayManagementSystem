package com.railway.servlet;

import com.railway.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.LinkedHashMap;

@WebServlet("/admin/data")
public class AdminDataServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            response.sendRedirect("../login.jsp");
            return;
        }

        String type = request.getParameter("type");
        List<Map<String, String>> rows = new ArrayList<>();
        String sql;

        if ("users".equals(type)) {
            sql = "SELECT user_id,name,email,phone,role FROM users ORDER BY user_id DESC";
        } else if ("cancellations".equals(type)) {
            sql = "SELECT c.cancellation_id,c.booking_id,c.cancelled_at,c.reason " +
                  "FROM cancellations c ORDER BY c.cancellation_id DESC";
        } else {
            sql = "SELECT booking_id,user_id,train_id,journey_date,passenger_name,status,fare " +
                  "FROM bookings ORDER BY booking_id DESC";
            type = "bookings";
        }

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            ResultSetMetaData md = rs.getMetaData();
            while (rs.next()) {
                Map<String, String> row = new LinkedHashMap<>();
                for (int i = 1; i <= md.getColumnCount(); i++) {
                    row.put(md.getColumnLabel(i), rs.getString(i));
                }
                rows.add(row);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        request.setAttribute("rows", rows);
        request.setAttribute("type", type);
        request.getRequestDispatcher("/admin-data.jsp").forward(request, response);
    }
}
