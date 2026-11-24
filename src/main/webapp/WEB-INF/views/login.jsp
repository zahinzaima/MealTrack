<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="color-scheme" content="light only">
    <title>MyToken - Login</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            color-scheme: light;
            font-family: 'Segoe UI', sans-serif;
            background: #f5f5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .login-container {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 400px;
        }
        .logo { text-align: center; margin-bottom: 30px; }
        .logo h1 { color: #e91e8c; font-size: 28px; font-weight: 700; }
        .logo p { color: #666; font-size: 14px; margin-top: 5px; }
        .form-group { margin-bottom: 20px; }
        .form-group label {
            display: block;
            margin-bottom: 6px;
            color: #333;
            font-size: 14px;
            font-weight: 500;
        }
        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 1.5px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            outline: none;
            background: white !important;
            -webkit-appearance: none;
            appearance: none;
        }
        input:-webkit-autofill,
        input:-webkit-autofill:hover,
        input:-webkit-autofill:focus {
            -webkit-box-shadow: 0 0 0px 1000px white inset !important;
            box-shadow: 0 0 0px 1000px white inset !important;
            -webkit-text-fill-color: #333 !important;
        }
        .form-group input:focus { border-color: #e91e8c; }
        .btn-login {
            width: 100%;
            padding: 13px;
            background: #e91e8c !important;
            background-color: #e91e8c !important;
            color: white !important;
            border: none !important;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
        }
        .btn-login:hover {
            background: #c2185b !important;
            background-color: #c2185b !important;
        }
        .error-msg {
            background: #fce4ec;
            color: #c62828;
            padding: 10px 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
            border-left: 4px solid #e91e8c;
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="logo">
        <h1>🍽 MyToken</h1>
        <p>Lunch Token Management System</p>
    </div>
    <% if (request.getAttribute("error") != null) { %>
        <div class="error-msg"><%= request.getAttribute("error") %></div>
    <% } %>
    <form action="<%= request.getContextPath() %>/login" method="post">
        <div class="form-group">
            <label>Email Address</label>
            <input type="email" name="email" placeholder="Enter your email" required />
        </div>
        <div class="form-group">
            <label>PIN</label>
            <input type="password" name="pin" placeholder="Enter your PIN" required />
        </div>
        <input type="submit" class="btn-login" value="Login" />
    </form>
</div>
</body>
</html>