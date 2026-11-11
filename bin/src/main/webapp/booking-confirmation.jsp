<%@ page contentType="text/html;charset=UTF-8" %>
<%
    if (session.getAttribute("userId") == null) { response.sendRedirect("login.jsp"); return; }
%>
<!DOCTYPE html><html><head><title>Booking Confirmation</title><link rel="stylesheet" href="css/style.css"></head>
<body><div class="form-box"><h2>Booking Confirmed!</h2>
<p>Your booking has been created successfully.</p>
<h3>Booking ID: <%= request.getParameter("id") %></h3>
<p>Please save this booking ID for future reference.</p>
<a class="btn" href="my-bookings">View My Bookings</a></div></body></html>
