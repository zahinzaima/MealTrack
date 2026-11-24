<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar">
    <div class="sidebar-logo">
        <h2>🍽️ MyToken</h2>
        <p>Admin Panel</p>
    </div>

    <div class="nav-section">
        <div class="nav-label">Main Menu</div>
        <a href="${pageContext.request.contextPath}/admin/dashboard"
           class="nav-item ${pageTitle == 'Dashboard' ? 'active' : ''}">
            <span class="icon">🏠</span> Home
        </a>
    </div>

    <div class="nav-section">
        <div class="nav-label">Management</div>
        <a href="${pageContext.request.contextPath}/admin/canteen"
           class="nav-item ${pageTitle == 'Canteen Manager' ? 'active' : ''}">
            <span class="icon">👨‍🍳</span> Canteen Manager
        </a>
        <a href="${pageContext.request.contextPath}/admin/token"
           class="nav-item ${pageTitle == 'Token Manager' ? 'active' : ''}">
            <span class="icon">🍱</span> Token Management
        </a>
    </div>

    <div class="nav-section">
        <div class="nav-label">User Access Management</div>
        <a href="${pageContext.request.contextPath}/admin/user"
           class="nav-item ${pageTitle == 'User Management' ? 'active' : ''}">
            <span class="icon">👥</span> User Management
        </a>
    </div>
</div>