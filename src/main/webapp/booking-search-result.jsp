<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.railway.model.Booking" %>
<!DOCTYPE html><html><head><title>Booking Search</title><link rel="stylesheet" href="css/style.css"></head>
<body><nav class="top"><b>Booking Search</b><a href="my-bookings">My Bookings</a></nav>
<div class="container"><p class="error">${message}</p>
<% Booking b = (Booking) request.getAttribute("booking");
if (b == null) { %><p>No booking found with that ID in your account.</p><% } else { %>
<h2>Booking #<%= b.getBookingId() %></h2>
<p>Train: <%= b.getTrainName() %></p>
<p>Route: <%= b.getSource() %> to <%= b.getDestination() %></p>
<p>Journey date: <%= b.getJourneyDate() %></p>
<p>Passenger: <%= b.getPassengerName() %></p>
<p>Status: <%= b.getStatus() %></p>
<p>Fare: ₹<%= b.getFare() %></p>
<% } %></div></body></html>
