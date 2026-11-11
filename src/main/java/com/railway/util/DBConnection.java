
package com.railway.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
            "jdbc:mysql://localhost:3306/railway_college_db?useSSL=false&serverTimezone=Asia/Kolkata";

    private static final String USER = "root";
    private static final String PASSWORD = "Claptoneric1";

    public static Connection getConnection() throws SQLException {

        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found!", e);
        }

        // Establish database connection
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
