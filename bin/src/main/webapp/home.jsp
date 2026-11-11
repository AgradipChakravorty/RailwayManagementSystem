<%@ page contentType="text/html;charset=UTF-8" %>
<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html><html><head><title>Home</title><link rel="stylesheet" href="css/style.css"></head>
<body><nav class="top"><b>Railway Management System</b>
<span>Welcome! <a href="my-bookings">My Bookings</a>
<% if ("ADMIN".equals(session.getAttribute("role"))) { %>
<a href="admin/dashboard">Admin</a><a href="admin/trains">Manage Trains</a>
<% } %><a href="logout">Logout</a></span></nav>
<div class="container"><h2>Find a Train</h2><p class="error">${param.error}</p>
<form action="search-trains" method="post" class="search-form">
<div><label>From</label><input name="source" placeholder="Kolkata" required></div>
<div><label>To</label><input name="destination" placeholder="Delhi" required></div>
<div><label>Journey date</label><input type="date" name="journeyDate" required></div>
<button type="submit">Search Trains</button>
</form></div></body></html>
