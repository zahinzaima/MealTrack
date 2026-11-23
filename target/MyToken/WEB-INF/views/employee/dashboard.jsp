<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="My Dashboard" />
<%@ include file="../header.jsp" %>

<!-- Employee Sidebar -->
<div class="sidebar">
    <div class="sidebar-logo">
        <h2>🍽 MyToken</h2>
        <p>Employee Panel</p>
    </div>
    <div class="nav-section">
        <div class="nav-label">Main Menu</div>
        <a href="${pageContext.request.contextPath}/employee/dashboard" class="nav-item active">
            <span class="icon">🏠</span> Home
        </a>
        <a href="${pageContext.request.contextPath}/employee/monthly-due" class="nav-item">
            <span class="icon">💰</span> Monthly Due
        </a>
    </div>
</div>

<div class="topbar">
    <h3>My Dashboard</h3>
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
    <div class="stats-grid" style="grid-template-columns: repeat(3,1fr);">
        <div class="stat-card">
            <div class="stat-number">${myBookings.size()}</div>
            <div class="stat-label">Total Bookings</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">৳ <fmt:formatNumber value="${monthlyTotal}" pattern="#,##0"/></div>
            <div class="stat-label">This Month's Due</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">${availableTokens.size()}</div>
            <div class="stat-label">Tomorrow's Tokens</div>
        </div>
    </div>

    <!-- Buy Token Section -->
    <div class="card">
        <div class="card-title">🎫 Available Tokens for Tomorrow</div>
        <c:choose>
            <c:when test="${empty availableTokens}">
                <p style="color:#999; text-align:center; padding:20px;">
                    No tokens available for tomorrow.
                </p>
            </c:when>
            <c:otherwise>
                <div style="display:grid; grid-template-columns: repeat(3,1fr); gap:15px;">
                    <c:forEach var="token" items="${availableTokens}">
                        <div style="border:1.5px solid #eee; border-radius:10px; padding:15px;">
                            <div style="font-weight:600; color:#333;">${token.tokenName}</div>
                            <div style="color:#999; font-size:13px; margin:5px 0;">${token.canteenName}</div>
                            <span class="badge badge-${token.category.toLowerCase()}">${token.category}</span>
                            <div style="font-size:18px; font-weight:700; color:#e91e8c; margin:10px 0;">
                                ৳ ${token.price}
                            </div>
                            <button onclick="openBookingModal(${token.tokenId}, '${token.tokenName}', ${token.price})"
                                    class="btn btn-primary" style="width:100%;">Buy Token</button>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- My Bookings -->
    <div class="card">
        <div class="card-title">📋 My Bookings</div>
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
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="booking" items="${myBookings}" varStatus="i">
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
                        <td>
                            <span class="badge badge-${booking.status.toLowerCase()}">
                                ${booking.status}
                            </span>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty myBookings}">
                    <tr>
                        <td colspan="8" style="text-align:center; color:#999; padding:30px;">
                            No bookings yet.
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<!-- Booking Modal -->
<div id="bookingModal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%;
     background:rgba(0,0,0,0.5); z-index:1000; justify-content:center; align-items:center;">
    <div style="background:white; border-radius:12px; padding:30px; width:400px; max-width:90%;">
        <h3 style="margin-bottom:20px; color:#333;">Buy Token</h3>
        <form action="${pageContext.request.contextPath}/employee/booking" method="post">
            <input type="hidden" name="action" value="single" />
            <input type="hidden" name="tokenId" id="modalTokenId" />

            <div class="form-group">
                <label>Token</label>
                <input type="text" id="modalTokenName" class="form-control" readonly />
            </div>
            <div class="form-group">
                <label>Booking Date *</label>
                <input type="date" name="bookingDate" class="form-control"
                       id="modalDate" required />
            </div>
            <div class="form-group">
                <label>Quantity</label>
                <input type="number" name="quantity" class="form-control"
                       value="1" min="1" max="5" required />
            </div>

            <div style="display:flex; gap:10px; margin-top:15px;">
                <button type="submit" class="btn btn-primary">Confirm</button>
                <button type="button" onclick="closeModal()" class="btn btn-secondary">Cancel</button>
            </div>
        </form>
    </div>
</div>

<script>
function openBookingModal(tokenId, tokenName, price) {
    document.getElementById('modalTokenId').value = tokenId;
    document.getElementById('modalTokenName').value = tokenName + ' - ৳' + price;
    // Set tomorrow as default date
    let tomorrow = new Date();
    tomorrow.setDate(tomorrow.getDate() + 1);
    document.getElementById('modalDate').value = tomorrow.toISOString().split('T')[0];
    document.getElementById('bookingModal').style.display = 'flex';
}
function closeModal() {
    document.getElementById('bookingModal').style.display = 'none';
}
</script>

</body>
</html>