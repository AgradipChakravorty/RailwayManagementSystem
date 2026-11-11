
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*,com.railway.model.Train" %>

<%
String contextPath = request.getContextPath();

if (session.getAttribute("userId") == null ||
    !"ADMIN".equals(session.getAttribute("role"))) {
    response.sendRedirect(contextPath + "/login.jsp");
    return;
}

List<Train> trains = (List<Train>) request.getAttribute("trains");
%>

<!DOCTYPE html>
<html>
<head>
<title>Manage Trains | Railway Management</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<style>
* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, Helvetica, sans-serif;
    background: #f3f6fa;
    color: #243447;
}

/* Navigation */
.top {
    background: #173b59;
    color: white;
    padding: 20px 5%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 3px 10px rgba(0,0,0,0.12);
}

.top b {
    font-size: 22px;
}

.top a {
    color: white;
    text-decoration: none;
    background: #245779;
    padding: 10px 18px;
    border-radius: 6px;
    font-weight: bold;
}

.top a:hover {
    background: #34769e;
}

/* Main content */
.container {
    max-width: 1150px;
    margin: 35px auto;
    padding: 0 20px;
}

.page-heading {
    margin-bottom: 25px;
}

.page-heading h1 {
    margin: 0 0 8px;
    color: #173b59;
    font-size: 29px;
}

.page-heading p {
    color: #718096;
    margin: 0;
}

/* Panels */
.panel {
    background: white;
    padding: 28px;
    margin-bottom: 30px;
    border-radius: 12px;
    box-shadow: 0 4px 18px rgba(20,50,80,0.07);
}

.panel h2 {
    color: #173b59;
    margin-top: 0;
    margin-bottom: 22px;
    font-size: 22px;
}

/* Add/update form */
.grid-form {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 16px;
}

.grid-form input {
    width: 100%;
    padding: 13px 14px;
    border: 1px solid #d5dee8;
    border-radius: 7px;
    font-size: 14px;
    background: #fff;
}

.grid-form input:focus {
    outline: none;
    border-color: #168b9b;
    box-shadow: 0 0 0 3px rgba(22,139,155,0.12);
}

.grid-form button {
    grid-column: 1 / -1;
}

button {
    border: none;
    border-radius: 7px;
    padding: 12px 20px;
    font-size: 14px;
    font-weight: bold;
    cursor: pointer;
    background: #078b9a;
    color: white;
    transition: 0.2s;
}

button:hover {
    background: #06717e;
}

/* Train cards */
.train-card {
    background: #fff;
    border: 1px solid #e0e7ef;
    border-left: 5px solid #078b9a;
    border-radius: 10px;
    padding: 22px;
    margin-bottom: 18px;
    box-shadow: 0 3px 12px rgba(20,50,80,0.05);
}

.train-card h3 {
    color: #173b59;
    margin: 0 0 15px;
    font-size: 19px;
}

.route {
    font-size: 16px;
    font-weight: bold;
    color: #334e68;
    margin-bottom: 12px;
}

.train-info {
    display: flex;
    flex-wrap: wrap;
    gap: 12px;
    margin-bottom: 18px;
}

.info-item {
    background: #f1f6fa;
    padding: 9px 13px;
    border-radius: 6px;
    color: #42566b;
    font-size: 13px;
}

.train-actions {
    display: flex;
    align-items: center;
    flex-wrap: wrap;
    gap: 12px;
}

details {
    flex: 1;
    min-width: 200px;
}

summary {
    cursor: pointer;
    color: #087e8b;
    font-weight: bold;
    padding: 10px 0;
}

.update-form {
    margin-top: 15px;
    padding: 18px;
    background: #f7fafc;
    border-radius: 8px;
}

.danger {
    background: #d64545;
}

.danger:hover {
    background: #b92f2f;
}

.delete-form {
    margin: 0;
}

/* Empty state */
.empty {
    text-align: center;
    color: #718096;
    padding: 35px;
    background: #f8fafc;
    border-radius: 8px;
}

/* Responsive */
@media (max-width: 650px) {
    .grid-form {
        grid-template-columns: 1fr;
    }

    .grid-form button {
        grid-column: auto;
    }

    .top {
        padding: 16px 20px;
    }

    .top b {
        font-size: 17px;
    }

    .panel {
        padding: 19px;
    }

    .train-actions {
        flex-direction: column;
        align-items: stretch;
    }

    details {
        width: 100%;
    }
}
</style>
</head>

<body>

<nav class="top">
    <b> Railway Management System</b>
    <a href="<%= contextPath %>/admin/dashboard">Dashboard</a>
</nav>

<div class="container">

    <div class="page-heading">
        <h1>Train Management</h1>
        <p>Add, update and manage railway train information.</p>
    </div>

    <!-- Add Train -->
    <div class="panel">
        <h2>➕ Add New Train</h2>

        <form action="<%= contextPath %>/admin/trains"
              method="post" class="grid-form">

            <input type="hidden" name="action" value="add">

            <input name="trainName"
                   placeholder="Train name" required>

            <input name="source"
                   placeholder="Source station" required>

            <input name="destination"
                   placeholder="Destination station" required>

            <input type="time" name="departureTime" required>

            <input type="time" name="arrivalTime" required>

            <input type="number" name="totalSeats"
                   placeholder="Total seats" min="1" required>

            <input type="number" step="0.01" name="fare"
                   placeholder="Fare (₹)" min="0" required>

            <button type="submit">Add Train</button>

        </form>
    </div>

    <!-- All Trains -->
    <div class="panel">

        <h2>All Trains</h2>

        <% if (trains == null || trains.isEmpty()) { %>

            <div class="empty">
                <h3>No trains available</h3>
                <p>Add a train using the form above.</p>
            </div>

        <% } else {
            for (Train t : trains) { %>

            <div class="train-card">

                <h3>
                    <%= t.getTrainName() %>
                    <span style="color:#718096;font-weight:normal;">
                        (Train <%= t.getTrainId() %>)
                    </span>
                </h3>

                <div class="route">
                    <%= t.getSource() %> &nbsp; → &nbsp;
                    <%= t.getDestination() %>
                </div>

                <div class="train-info">

                    <div class="info-item">
                        Departure: <%= t.getDepartureTime() %>
                    </div>

                    <div class="info-item">
                        Arrival: <%= t.getArrivalTime() %>
                    </div>

                    <div class="info-item">
                        Seats: <%= t.getAvailableSeats() %> /
                        <%= t.getTotalSeats() %>
                    </div>

                    <div class="info-item">
                        Fare: ₹<%= t.getFare() %>
                    </div>

                </div>

                <div class="train-actions">

                    <!-- Update Train -->
                    <details>
                        <summary> Update Train Details</summary>

                        <div class="update-form">

                            <form action="<%= contextPath %>/admin/trains"
                                  method="post" class="grid-form">

                                <input type="hidden" name="action"
                                       value="update">

                                <input type="hidden" name="trainId"
                                       value="<%= t.getTrainId() %>">

                                <input name="trainName"
                                       value="<%= t.getTrainName() %>" required>

                                <input name="source"
                                       value="<%= t.getSource() %>" required>

                                <input name="destination"
                                       value="<%= t.getDestination() %>" required>

                                <input type="time" name="departureTime"
                                       value="<%= t.getDepartureTime() %>" required>

                                <input type="time" name="arrivalTime"
                                       value="<%= t.getArrivalTime() %>" required>

                                <input type="number" name="totalSeats"
                                       value="<%= t.getTotalSeats() %>"
                                       min="1" required>

                                <input type="number" step="0.01"
                                       name="fare" value="<%= t.getFare() %>"
                                       min="0" required>

                                <button type="submit">Save Changes</button>

                            </form>

                        </div>
                    </details>

                    <!-- Delete Train -->
                    <form action="<%= contextPath %>/admin/trains"
                          method="post" class="delete-form"
                          onsubmit="return confirm('Delete this train?');">

                        <input type="hidden" name="action"
                               value="delete">

                        <input type="hidden" name="trainId"
                               value="<%= t.getTrainId() %>">

                        <button type="submit" class="danger">
                            Delete Train
                        </button>

                    </form>

                </div>

            </div>

        <% } } %>

    </div>

</div>

</body>
</html>
