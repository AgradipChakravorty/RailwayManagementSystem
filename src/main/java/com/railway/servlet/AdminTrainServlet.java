package com.railway.servlet;

import com.railway.dao.TrainDAO;
import com.railway.model.Train;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/trains")
public class AdminTrainServlet extends HttpServlet {

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession s = request.getSession(false);
        return s != null && "ADMIN".equals(s.getAttribute("role"));
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendRedirect("../login.jsp");
            return;
        }
        request.setAttribute("trains", new TrainDAO().getAllTrains());
        request.getRequestDispatcher("/admin-trains.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendRedirect("../login.jsp");
            return;
        }

        try {
            String action = request.getParameter("action");
            TrainDAO dao = new TrainDAO();

            if ("delete".equals(action)) {
                dao.deleteTrain(Integer.parseInt(request.getParameter("trainId")));
            } else {
                Train t = new Train();
                t.setTrainName(request.getParameter("trainName"));
                t.setSource(request.getParameter("source"));
                t.setDestination(request.getParameter("destination"));
                t.setDepartureTime(request.getParameter("departureTime"));
                t.setArrivalTime(request.getParameter("arrivalTime"));
                t.setTotalSeats(Integer.parseInt(request.getParameter("totalSeats")));
                t.setAvailableSeats(Integer.parseInt(request.getParameter("totalSeats")));
                t.setFare(Double.parseDouble(request.getParameter("fare")));

                if ("update".equals(action)) {
                    t.setTrainId(Integer.parseInt(request.getParameter("trainId")));
                    dao.updateTrain(t);
                } else {
                    dao.addTrain(t);
                }
            }
        } catch (Exception e) {
            System.out.println("Train management error: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/admin/trains");
    }
}
