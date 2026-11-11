package com.railway.dao;

import com.railway.util.DBConnection;
import com.railway.util.PasswordUtil;
import java.sql.*;

public class UserDAO {

    public boolean register(String name, String email, String password, String phone) {
        String sql = "INSERT INTO users(name,email,password,phone,role) VALUES(?,?,?,?, 'USER')";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, PasswordUtil.hashPassword(password));
            ps.setString(4, phone);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Registration error: " + e.getMessage());
            return false;
        }
    }

    public int login(String email, String password) {
        String sql = "SELECT user_id FROM users WHERE email=? AND password=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, PasswordUtil.hashPassword(password));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("user_id");
            }
        } catch (SQLException e) {
            System.out.println("Login error: " + e.getMessage());
        }
        return 0;
    }

    public String getRole(int userId) {
        String sql = "SELECT role FROM users WHERE user_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getString("role");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return "";
    }
}
