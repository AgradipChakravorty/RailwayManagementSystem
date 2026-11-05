
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>Railway Management System</title>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/common.css">
</head>

<body>

    <!-- Common Header -->
    <jsp:include page="jsp/header.jsp" />

    <!-- Main Homepage -->
    <main class="hero">

        <h1>Welcome to Railway Management System</h1>

        <p>
            Book your train tickets, explore trains and manage
            your railway journeys with ease.
        </p>

        <div class="hero-buttons">
            <a href="jsp/train/searchTrain.jsp" class="btn primary">
                Search Trains
            </a>

            <a href="jsp/auth/login.jsp" class="btn secondary">
                Login
            </a>
        </div>

    </main>

    <!-- Common Footer -->
    <jsp:include page="jsp/footer.jsp" />

</body>
</html>
