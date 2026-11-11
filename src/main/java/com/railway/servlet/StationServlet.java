package com.railway.servlet;

import com.railway.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/stations")
public class StationServlet extends HttpServlet {
    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && "ADMIN".equals(session.getAttribute("role"));
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendRedirect("../login.jsp");
            return;
        }

        List<String[]> stations = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM stations ORDER BY station_id");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                stations.add(new String[]{String.valueOf(rs.getInt("station_id")),
                        rs.getString("station_name"), rs.getString("city")});
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
        request.setAttribute("stations", stations);
        request.getRequestDispatcher("/admin-stations.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendRedirect("../login.jsp");
            return;
        }

        String action = request.getParameter("action");
        try (Connection con = DBConnection.getConnection()) {
            if ("delete".equals(action)) {
                try (PreparedStatement ps = con.prepareStatement(
                        "DELETE FROM stations WHERE station_id=?")) {
                    ps.setInt(1, Integer.parseInt(request.getParameter("stationId")));
                    ps.executeUpdate();
                }
            } else {
                try (PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO stations(station_name,city) VALUES(?,?)")) {
                    ps.setString(1, request.getParameter("stationName"));
                    ps.setString(2, request.getParameter("city"));
                    ps.executeUpdate();
                }
            }
        } catch (SQLException e) {
            System.out.println("Station management error: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/admin/stations");
    }
}
