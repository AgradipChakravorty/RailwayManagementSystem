package com.railway.servlet;

import com.railway.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO dao = new UserDAO();
        int userId = dao.login(email, password);

        if (userId > 0) {
            HttpSession session = request.getSession();
            session.setAttribute("userId", userId);
            session.setAttribute("role", dao.getRole(userId));
            session.setAttribute("email", email);
            response.sendRedirect("home.jsp");
        } else {
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
