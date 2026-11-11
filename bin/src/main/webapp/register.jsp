<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html><html><head><title>Register</title><link rel="stylesheet" href="css/style.css"></head>
<body><div class="form-box"><h2>Create Account</h2><p class="error">${error}</p>
<form action="register" method="post">
<label>Full name</label><input type="text" name="name" required>
<label>Email</label><input type="email" name="email" required>
<label>Phone</label><input type="text" name="phone" required>
<label>Password (minimum 6 characters)</label><input type="password" name="password" minlength="6" required>
<button type="submit">Register</button>
</form><p>Already registered? <a href="login.jsp">Login</a></p></div></body></html>
