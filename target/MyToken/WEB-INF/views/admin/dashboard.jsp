<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Dashboard" />
<%@ include file="../header.jsp" %>
<%@ include file="../admin-sidebar.jsp" %>

<div class="topbar">
    <h3>Dashboard</h3>
    <div class="topbar-right">
        <div class="user-info">
            <span class="user-name">${sessionScope.userName}</span>
            <span class="user-role">${sessionScope.userRole}</span>
        </div>
        <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Logout</a>
    </div>
</div>

<div class="main-content">

    <c:if test="${param.success != null}">
        <div class="alert alert-success">${param.success}</div>
    </c:if>
    <c:if test="${param.error != null}">
        <div class="alert alert-error">${param.error}</div>
    </c:if>

    <!-- Stats -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-number">${todayBookingCount}</div>
            <div class="stat-label">Today's Bookings</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">${totalUsers}</div>
            <div class="stat-label">Total Users</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">${totalCanteens}</div>
            <div class="stat-label">Total Canteens</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">${totalTokens}</div>
            <div class="stat-label">Total Tokens</div>
        </div>
    </div>

    <!-- Today's Bookings -->
    <div class="card">
        <div class="card-title">📋 Today's Booking List</div>
        <c:choose>
            <c:when test="${empty todayBookings}">
                <p style="color:#999; text-align:center; padding:30px;">
                    No bookings for today.
                </p>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Employee</th>
                            <th>Token</th>
                            <th>Canteen</th>
                            <th>Category</th>
                            <th>Qty</th>
                            <th>Amount</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="booking" items="${todayBookings}" varStatus="i">
                            <tr>
                                <td>${i.count}</td>
                                <td>${booking.userName}</td>
                                <td>${booking.tokenName}</td>
                                <td>${booking.canteenName}</td>
                                <td>
                                    <span class="badge badge-${booking.category.toLowerCase()}">
                                        ${booking.category}
                                    </span>
                                </td>
                                <td>${booking.quantity}</td>
                                <td>৳ <fmt:formatNumber value="${booking.totalPrice}" pattern="#,##0.00"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</div>

</body>
</html>