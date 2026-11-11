<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*,com.railway.model.Booking" %>
<!DOCTYPE html><html><head><title>My Bookings</title><link rel="stylesheet" href="css/style.css"></head>
<body><nav class="top"><b>My Bookings</b><a href="home.jsp">Home</a></nav><div class="container">
<p class="success">${param.message}</p>
<form action="search-booking" method="post" class="search-form">
<div><label>Search booking by ID</label><input type="number" name="bookingId" min="1" required></div>
<button type="submit">Search Booking</button>
</form>
<% List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
   if (bookings == null || bookings.isEmpty()) { %><p>You have no bookings yet.</p><% } else { %>
<table><tr><th>ID</th><th>Train</th><th>Route</th><th>Date</th><th>Passenger</th><th>Fare</th><th>Status</th><th>Action</th></tr>
<% for (Booking b : bookings) { %><tr>
<td><%= b.getBookingId() %></td><td><%= b.getTrainName() %></td>
<td><%= b.getSource() %> → <%= b.getDestination() %></td><td><%= b.getJourneyDate() %></td>
<td><%= b.getPassengerName() %></td><td>₹<%= b.getFare() %></td><td><%= b.getStatus() %></td><td>
<% if ("CONFIRMED".equals(b.getStatus())) { %>
<form action="cancel-booking" method="post" onsubmit="return confirm('Cancel this booking?');">
<input type="hidden" name="bookingId" value="<%= b.getBookingId() %>"><button class="danger">Cancel</button></form>
<% } else { %> - <% } %></td></tr><% } %></table><% } %></div></body></html>
