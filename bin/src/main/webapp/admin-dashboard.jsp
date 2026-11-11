
<%@ page contentType="text/html;charset=UTF-8" %>

<%
if (session.getAttribute("userId") == null ||
    !"ADMIN".equals(session.getAttribute("role"))) {

    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">
</head>

<body>

<nav class="top">
    <b>Admin Dashboard</b>

    <a href="<%= request.getContextPath() %>/home.jsp">Home</a>

    <a href="<%= request.getContextPath() %>/logout">Logout</a>
</nav>

<div class="container">

    <h2>System Overview</h2>

    <div class="stats">

        <div class="stat">
            Users
            <h2>${userCount}</h2>
        </div>

        <div class="stat">
            Trains
            <h2>${trainCount}</h2>
        </div>

        <div class="stat">
            Bookings
            <h2>${bookingCount}</h2>
        </div>

        <div class="stat">
            Cancellations
            <h2>${cancelCount}</h2>
        </div>

    </div>

    <h3>Manage System Data</h3>

    <p>
        <a href="<%= request.getContextPath() %>/admin/trains">
            Manage Trains
        </a>

        |

        <a href="<%= request.getContextPath() %>/admin/stations">
            Manage Stations
        </a>

        |

        <a href="<%= request.getContextPath() %>/admin/data?type=users">
            Registered Users
        </a>

        |

        <a href="<%= request.getContextPath() %>/admin/data?type=bookings">
            All Bookings
        </a>

        |

        <a href="<%= request.getContextPath() %>/admin/data?type=cancellations">
            Cancellation Records
        </a>
    </p>

</div>

</body>
</html>
