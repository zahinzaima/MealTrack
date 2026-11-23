<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Token Manager" />
<%@ include file="../header.jsp" %>
<%@ include file="../admin-sidebar.jsp" %>

<div class="topbar">
    <h3>Token Manager</h3>
    <div class="topbar-right">
        <div class="user-info">
            <span class="user-name">${sessionScope.userName}</span>
            <span class="user-role">${sessionScope.userRole}</span>
        </div>
        <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Logout</a>
    </div>
</div>

<div class="main-content">
    <div class="page-header">
        <h2>${token == null ? 'Create Token' : 'Edit Token'}</h2>
        <a href="${pageContext.request.contextPath}/admin/token"
           class="btn btn-secondary">← Back to List</a>
    </div>

    <div class="card" style="max-width: 650px;">
        <form action="${pageContext.request.contextPath}/admin/token" method="post">
            <input type="hidden" name="action" value="${token == null ? 'create' : 'edit'}" />
            <c:if test="${token != null}">
                <input type="hidden" name="tokenId" value="${token.tokenId}" />
            </c:if>

            <div class="form-row">
                <div class="form-group">
                    <label>Token ID *</label>
                    <input type="text" name="tokenCode" class="form-control"
                           value="${token.tokenCode}" placeholder="e.g. TKN-001" required />
                </div>
                <div class="form-group">
                    <label>Token Name *</label>
                    <input type="text" name="tokenName" class="form-control"
                           value="${token.tokenName}" placeholder="e.g. Regular Lunch" required />
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Canteen *</label>
                    <select name="canteenId" class="form-control" required>
                        <option value="">Select Canteen</option>
                        <c:forEach var="canteen" items="${canteens}">
                            <option value="${canteen.canteenId}"
                                ${token.canteenId == canteen.canteenId ? 'selected' : ''}>
                                ${canteen.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>Price (৳) *</label>
                    <input type="number" name="price" class="form-control"
                           value="${token.price}" placeholder="0.00"
                           step="0.01" min="0" required />
                </div>
            </div>

            <div class="form-group">
                <label>Token Category *</label>
                <div style="display:flex; gap:20px; margin-top:8px;">
                    <label style="display:flex; align-items:center; gap:8px; cursor:pointer;">
                        <input type="radio" name="category" value="REGULAR"
                               ${token == null || token.category == 'REGULAR' ? 'checked' : ''} />
                        Regular Food
                    </label>
                    <label style="display:flex; align-items:center; gap:8px; cursor:pointer;">
                        <input type="radio" name="category" value="DRY"
                               ${token.category == 'DRY' ? 'checked' : ''} />
                        Dry Food
                    </label>
                </div>
            </div>

            <div class="form-group">
                <label>Available Days *</label>
                <div style="display:flex; gap:10px; margin-top:8px; flex-wrap:wrap;">
                    <c:forEach var="day" items="${['Sun','Mon','Tue','Wed','Thu','Fri','Sat']}">
                        <label style="cursor:pointer;">
                            <input type="checkbox" name="days" value="${day}"
                                   ${token.availableDays.contains(day) ? 'checked' : ''} />
                            <span style="padding:6px 12px; background:#f5f5f5; border-radius:20px;
                                         font-size:13px; margin-left:4px;">${day}</span>
                        </label>
                    </c:forEach>
                </div>
            </div>

            <div class="form-group">
                <label>Status</label>
                <select name="status" class="form-control">
                    <option value="ACTIVE" ${token.status == 'ACTIVE' || token == null ? 'selected' : ''}>Active</option>
                    <option value="INACTIVE" ${token.status == 'INACTIVE' ? 'selected' : ''}>Inactive</option>
                </select>
            </div>

            <div style="display:flex; gap:10px; margin-top:10px;">
                <button type="submit" class="btn btn-primary">
                    ${token == null ? 'Create Token' : 'Update Token'}
                </button>
                <a href="${pageContext.request.contextPath}/admin/token"
                   class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>
</div>

</body>
</html>