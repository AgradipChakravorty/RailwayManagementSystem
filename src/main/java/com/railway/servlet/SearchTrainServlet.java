package com.railway.servlet;

import com.railway.dao.TrainDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/search-trains")
public class SearchTrainServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String source = request.getParameter("source");
        String destination = request.getParameter("destination");
        String journeyDate = request.getParameter("journeyDate");

        request.setAttribute("trains", new TrainDAO().searchTrains(source, destination));
        request.setAttribute("journeyDate", journeyDate);
        request.getRequestDispatcher("search-results.jsp").forward(request, response);
    }
}
