<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Monthly Due" />
<%@ include file="../header.jsp" %>

<!-- Employee Sidebar -->
<div class="sidebar">
    <div class="sidebar-logo">
        <h2>🍽 MyToken</h2>
        <p>Employee Panel</p>
    </div>
    <div class="nav-section">
        <div class="nav-label">Main Menu</div>
        <a href="${pageContext.request.contextPath}/employee/dashboard" class="nav-item">
            <span class="icon">🏠</span> Home
        </a>
        <a href="${pageContext.request.contextPath}/employee/monthly-due" class="nav-item active">
            <span class="icon">💰</span> Monthly Due
        </a>
    </div>
</div>

<div class="topbar">
    <h3>Monthly Due Statement</h3>
    <div class="topbar-right">
        <div class="user-info">
            <span class="user-name">${sessionScope.userName}</span>
            <span class="user-role">${sessionScope.userRole}</span>
        </div>
        <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Logout</a>
    </div>
</div>

<div class="main-content">

    <!-- Month Filter -->
    <div class="card" style="margin-bottom:20px;">
        <form action="${pageContext.request.contextPath}/employee/monthly-due" method="get"
              style="display:flex; gap:15px; align-items:flex-end;">
            <div class="form-group" style="margin:0;">
                <label>Month</label>
                <select name="month" class="form-control">
                    <c:forEach begin="1" end="12" var="m">
                        <option value="${m}" ${selectedMonth == m ? 'selected' : ''}>
                            <fmt:parseDate value="${m}" pattern="M" var="monthDate"/>
                            <fmt:formatDate value="${monthDate}" pattern="MMMM"/>
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group" style="margin:0;">
                <label>Year</label>
                <select name="year" class="form-control">
                    <option value="2026" ${selectedYear == 2026 ? 'selected' : ''}>2026</option>
                    <option value="2025" ${selectedYear == 2025 ? 'selected' : ''}>2025</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Filter</button>
        </form>
    </div>

    <!-- Total Due Card -->
    <div style="background: linear-gradient(135deg, #e91e8c, #c2185b);
                border-radius:12px; padding:25px; color:white; margin-bottom:20px;
                display:flex; justify-content:space-between; align-items:center;">
        <div>
            <div style="font-size:14px; opacity:0.8;">Total Due for Month</div>
            <div style="font-size:36px; font-weight:700; margin-top:5px;">
                ৳ <fmt:formatNumber value="${totalAmount}" pattern="#,##0.00"/>
            </div>
        </div>
        <div style="font-size:48px; opacity:0.3;">💰</div>
    </div>

    <!-- Booking Details -->
    <div class="card">
        <div class="card-title">📋 Booking Details</div>
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Date</th>
                    <th>Token</th>
                    <th>Canteen</th>
                    <th>Category</th>
                    <th>Qty</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="booking" items="${bookings}" varStatus="i">
                    <tr>
                        <td>${i.count}</td>
                        <td>${booking.bookingDate}</td>
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
                <c:if test="${empty bookings}">
                    <tr>
                        <td colspan="7" style="text-align:center; color:#999; padding:30px;">
                            No bookings for this month.
                        </td>
                    </tr>
                </c:if>
                <c:if test="${!empty bookings}">
                    <tr style="background:#fce4ec;">
                        <td colspan="6" style="text-align:right; font-weight:700; color:#333;">
                            Total:
                        </td>
                        <td style="font-weight:700; color:#e91e8c;">
                            ৳ <fmt:formatNumber value="${totalAmount}" pattern="#,##0.00"/>
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>