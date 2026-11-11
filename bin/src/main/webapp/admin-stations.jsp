
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>

<%
String contextPath = request.getContextPath();

if (session.getAttribute("userId") == null ||
    !"ADMIN".equals(session.getAttribute("role"))) {
    response.sendRedirect(contextPath + "/login.jsp");
    return;
}

List<String[]> stations =
    (List<String[]>) request.getAttribute("stations");
%>

<!DOCTYPE html>
<html>
<head>
<title>Station Management | Railway Management</title>
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
    margin: 0;
    color: #718096;
}

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

/* Form styling */
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
}

.grid-form input:focus {
    outline: none;
    border-color: #078b9a;
    box-shadow: 0 0 0 3px rgba(7,139,154,0.12);
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

.grid-form button {
    grid-column: 1 / -1;
}

/* Station table */
.table-wrapper {
    width: 100%;
    overflow-x: auto;
}

table {
    width: 100%;
    border-collapse: collapse;
    min-width: 550px;
}

th {
    background: #173b59;
    color: white;
    text-align: left;
    padding: 15px;
    font-size: 14px;
}

td {
    padding: 15px;
    border-bottom: 1px solid #e5ebf1;
    font-size: 14px;
}

tr:hover td {
    background: #f5f9fc;
}

.station-id {
    font-weight: bold;
    color: #078b9a;
}

.city-tag {
    background: #e9f4f7;
    color: #17677a;
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: bold;
}

.delete-form {
    margin: 0;
}

.danger {
    background: #d64545;
    padding: 9px 15px;
}

.danger:hover {
    background: #b92f2f;
}

.empty {
    text-align: center;
    padding: 35px;
    color: #718096;
    background: #f8fafc;
    border-radius: 8px;
}

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
}
</style>
</head>

<body>

<nav class="top">
    <b>🚆 Railway Management System</b>
    <a href="<%= contextPath %>/admin/dashboard">Dashboard</a>
</nav>

<div class="container">

    <div class="page-heading">
        <h1>Station Management</h1>
        <p>Add and manage railway stations and their locations.</p>
    </div>

    <!-- Add Station -->
    <div class="panel">

        <h2>➕ Add New Station</h2>

        <form action="<%= contextPath %>/admin/stations"
              method="post" class="grid-form">

            <input type="hidden" name="action" value="add">

            <input name="stationName"
                   placeholder="Enter station name" required>

            <input name="city"
                   placeholder="Enter city" required>

            <button type="submit">Add Station</button>

        </form>

    </div>

    <!-- Station List -->
    <div class="panel">

        <h2>All Railway Stations</h2>

        <% if (stations == null || stations.isEmpty()) { %>

            <div class="empty">
                <h3>No stations found</h3>
                <p>Add a station using the form above.</p>
            </div>

        <% } else { %>

        <div class="table-wrapper">

            <table>

                <thead>
                    <tr>
                        <th>Station ID</th>
                        <th>Station Name</th>
                        <th>City</th>
                        <th>Action</th>
                    </tr>
                </thead>

                <tbody>

                <% for (String[] s : stations) { %>

                    <tr>

                        <td class="station-id">
                            <%= s[0] %>
                        </td>

                        <td>
                            <strong><%= s[1] %></strong>
                        </td>

                        <td>
                            <span class="city-tag">
                                <%= s[2] %>
                            </span>
                        </td>

                        <td>

                            <form action="<%= contextPath %>/admin/stations"
                                  method="post"
                                  class="delete-form"
                                  onsubmit="return confirm('Delete this station?');">

                                <input type="hidden" name="action"
                                       value="delete">

                                <input type="hidden" name="stationId"
                                       value="<%= s[0] %>">

                                <button type="submit" class="danger">
                                    Delete
                                </button>

                            </form>

                        </td>

                    </tr>

                <% } %>

                </tbody>

            </table>

        </div>

        <% } %>

    </div>

</div>

</body>
</html>
