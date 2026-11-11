<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*,com.railway.model.Train" %>
<!DOCTYPE html><html><head><title>Search Results</title><link rel="stylesheet" href="css/style.css"></head>
<body><nav class="top"><b>Search Results</b><a href="home.jsp">Back</a></nav><div class="container">
<h2>Available Trains</h2>
<% List<Train> trains = (List<Train>) request.getAttribute("trains");
   String journeyDate = (String) request.getAttribute("journeyDate");
   if (trains == null || trains.isEmpty()) { %><p>No trains found for this route.</p><% } else {
   for (Train t : trains) { %>
<div class="train-card"><h3><%= t.getTrainName() %> (Train <%= t.getTrainId() %>)</h3>
<p><%= t.getSource() %> → <%= t.getDestination() %></p>
<p><%= t.getDepartureTime() %> - <%= t.getArrivalTime() %> |
Seats: <%= t.getAvailableSeats() %> | Fare: ₹<%= t.getFare() %></p>
<form action="book-ticket" method="post">
<input type="hidden" name="trainId" value="<%= t.getTrainId() %>">
<input type="hidden" name="journeyDate" value="<%= journeyDate %>">
<input name="passengerName" placeholder="Passenger name" required>
<input type="number" name="passengerAge" placeholder="Age" min="1" max="120" required>
<button type="submit">Book Ticket</button>
</form></div>
<% } } %></div></body></html>
