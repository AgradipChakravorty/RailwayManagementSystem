package com.railway.servlet;

import com.railway.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");

        if (name == null || email == null || password == null ||
                name.isBlank() || email.isBlank() || password.length() < 6) {
            request.setAttribute("error", "Enter valid details. Password must be at least 6 characters.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        boolean done = new UserDAO().register(name, email, password, phone);
        if (done) {
            response.sendRedirect("login.jsp?message=Registration successful. Please login.");
        } else {
            request.setAttribute("error", "Registration failed. Email may already be registered.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
