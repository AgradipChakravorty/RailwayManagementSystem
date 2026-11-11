
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>

<%
String contextPath = request.getContextPath();

if (session.getAttribute("userId") == null ||
    !"ADMIN".equals(session.getAttribute("role"))) {
    response.sendRedirect(contextPath + "/login.jsp");
    return;
}

List<Map<String,String>> rows =
    (List<Map<String,String>>) request.getAttribute("rows");

String type = (String) request.getAttribute("type");

if (type == null || type.trim().isEmpty()) {
    type = request.getParameter("type");
}

if (type == null || type.trim().isEmpty()) {
    type = "records";
}

String pageTitle = "Admin Records";

if ("users".equalsIgnoreCase(type)) {
    pageTitle = "Registered Users";
} else if ("bookings".equalsIgnoreCase(type)) {
    pageTitle = "All Bookings";
} else if ("cancellations".equalsIgnoreCase(type)) {
    pageTitle = "Cancellation Records";
}
%>

<!DOCTYPE html>
<html>
<head>

<title><%= pageTitle %> | Railway Management</title>

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
    font-size: 21px;
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

/* Main container */
.container {
    max-width: 1250px;
    margin: 35px auto;
    padding: 0 20px;
}

.page-heading {
    margin-bottom: 25px;
}

.page-heading h1 {
    color: #173b59;
    font-size: 29px;
    margin: 0 0 8px;
}

.page-heading p {
    color: #718096;
    margin: 0;
}

/* Records panel */
.panel {
    background: white;
    padding: 28px;
    border-radius: 12px;
    box-shadow: 0 4px 18px rgba(20,50,80,0.07);
}

.panel-heading {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 22px;
    flex-wrap: wrap;
    gap: 12px;
}

.panel-heading h2 {
    color: #173b59;
    font-size: 21px;
    margin: 0;
}

.record-count {
    background: #e9f4f7;
    color: #17677a;
    padding: 8px 14px;
    border-radius: 20px;
    font-size: 13px;
    font-weight: bold;
}

/* Table */
.table-wrapper {
    width: 100%;
    overflow-x: auto;
    border: 1px solid #e3eaf1;
    border-radius: 8px;
}

table {
    width: 100%;
    border-collapse: collapse;
    min-width: 600px;
}

th {
    background: #173b59;
    color: white;
    padding: 16px;
    text-align: left;
    font-size: 13px;
    text-transform: capitalize;
    white-space: nowrap;
}

td {
    padding: 15px 16px;
    border-bottom: 1px solid #e7edf3;
    font-size: 14px;
    color: #425466;
}

tbody tr:nth-child(even) {
    background: #f7fafc;
}

tbody tr:hover {
    background: #edf5fa;
}

tbody tr:last-child td {
    border-bottom: none;
}

/* Empty state */
.empty {
    text-align: center;
    padding: 55px 20px;
    background: #f8fafc;
    border-radius: 8px;
}

.empty h3 {
    color: #173b59;
    margin-bottom: 8px;
}

.empty p {
    color: #718096;
    margin: 0;
}

@media (max-width: 650px) {
    .top {
        padding: 16px 20px;
    }

    .top b {
        font-size: 17px;
    }

    .container {
        margin: 22px auto;
    }

    .panel {
        padding: 18px;
    }

    .page-heading h1 {
        font-size: 24px;
    }
}
</style>

</head>

<body>

<nav class="top">

    <b>🚆 Railway Management System</b>

    <a href="<%= contextPath %>/admin/dashboard">
        Dashboard
    </a>

</nav>

<div class="container">

    <div class="page-heading">

        <h1><%= pageTitle %></h1>

        <p>
            View and monitor railway management system records.
        </p>

    </div>

    <div class="panel">

        <div class="panel-heading">

            <h2><%= pageTitle %></h2>

            <% if (rows != null && !rows.isEmpty()) { %>

                <span class="record-count">
                    <%= rows.size() %> Records
                </span>

            <% } else { %>

                <span class="record-count">
                    0 Records
                </span>

            <% } %>

        </div>

        <% if (rows != null && !rows.isEmpty()) { %>

        <div class="table-wrapper">

            <table>

                <thead>
                    <tr>

                        <% for (String key : rows.get(0).keySet()) { %>

                            <th><%= key %></th>

                        <% } %>

                    </tr>
                </thead>

                <tbody>

                    <% for (Map<String,String> row : rows) { %>

                        <tr>

                            <% for (String key : rows.get(0).keySet()) { %>

                                <td>
                                    <%= row.get(key) == null ? "-" : row.get(key) %>
                                </td>

                            <% } %>

                        </tr>

                    <% } %>

                </tbody>

            </table>

        </div>

        <% } else { %>

            <div class="empty">

                <h3>No Records Found</h3>

                <p>
                    There are currently no records available in this section.
                </p>

            </div>

        <% } %>

    </div>

</div>

</body>
</html>
