<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*,com.railway.model.Booking" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Bookings</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<nav class="top">
    <b>My Bookings</b>
    <div>
        <a href="my-bookings">All Bookings</a>
        <a href="my-bookings?status=CONFIRMED">Confirmed</a>
        <a href="my-bookings?status=CANCELLED">Cancelled</a>
        <a href="home.jsp">Home</a>
    </div>
</nav>

<div class="container">
    <%
        String msg = request.getParameter("message");
        String msgType = request.getParameter("type");
        if (msg != null && !msg.trim().isEmpty()) {
            String alertClass = "error".equalsIgnoreCase(msgType) ? "error" : "success";
    %>
        <p class="<%= alertClass %>"><b><%= msg %></b></p>
    <%
        }
        Integer totalCount = (Integer) request.getAttribute("totalCount");
        Integer confirmedCount = (Integer) request.getAttribute("confirmedCount");
        Integer cancelledCount = (Integer) request.getAttribute("cancelledCount");
        if (totalCount != null) {
    %>
        <div class="stats" style="margin-bottom: 22px;">
            <div class="stat">
                <b>Total Bookings</b>
                <p style="font-size: 22px; margin: 8px 0 0;"><%= totalCount %></p>
            </div>
            <div class="stat">
                <b>Confirmed</b>
                <p class="success" style="font-size: 22px; margin: 8px 0 0;"><%= confirmedCount %></p>
            </div>
            <div class="stat">
                <b>Cancelled</b>
                <p class="error" style="font-size: 22px; margin: 8px 0 0;"><%= cancelledCount %></p>
            </div>
        </div>
    <% } %>

    <form action="search-booking" method="post" class="search-form">
        <div>
            <label>Search booking by ID</label>
            <input type="number" name="bookingId" min="1" placeholder="Enter Booking ID" required>
        </div>
        <button type="submit" style="margin-bottom: 8px;">Search Booking</button>
    </form>

    <%
        List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
        if (bookings == null || bookings.isEmpty()) {
    %>
        <p>You have no bookings in this view.</p>
    <%
        } else {
    %>
        <table>
            <tr>
                <th>ID</th>
                <th>Train</th>
                <th>Route</th>
                <th>Date</th>
                <th>Passenger</th>
                <th>Age</th>
                <th>Fare</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
            <% for (Booking b : bookings) { %>
            <tr>
                <td>#<%= b.getBookingId() %></td>
                <td><%= b.getTrainName() %></td>
                <td><%= b.getSource() %> → <%= b.getDestination() %></td>
                <td><%= b.getJourneyDate() %></td>
                <td><%= b.getPassengerName() %></td>
                <td><%= b.getPassengerAge() %></td>
                <td>₹<%= String.format("%.2f", b.getFare()) %></td>
                <td>
                    <span class="<%= "CONFIRMED".equalsIgnoreCase(b.getStatus()) ? "success" : "error" %>">
                        <b><%= b.getStatus() %></b>
                    </span>
                </td>
                <td>
                    <% if ("CONFIRMED".equalsIgnoreCase(b.getStatus())) { %>
                        <form action="cancel-booking" method="post" onsubmit="return confirm('Cancel booking #<%= b.getBookingId() %>?');">
                            <input type="hidden" name="bookingId" value="<%= b.getBookingId() %>">
                            <button type="submit" class="danger">Cancel</button>
                        </form>
                    <% } else { %>
                        -
                    <% } %>
                </td>
            </tr>
            <% } %>
        </table>
    <% } %>
</div>
</body>
</html>