<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html><html><head><title>Login</title><link rel="stylesheet" href="css/style.css"></head>
<body><div class="form-box"><h2>Login</h2>
<p class="error">${error}</p><p class="success">${param.message}</p>
<form action="login" method="post">
<label>Email</label><input type="email" name="email" required>
<label>Password</label><input type="password" name="password" required>
<button type="submit">Login</button>
</form><p>New user? <a href="register.jsp">Create account</a></p></div></body></html>
