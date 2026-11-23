<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Canteen Manager" />
<%@ include file="../header.jsp" %>
<%@ include file="../admin-sidebar.jsp" %>

<div class="topbar">
    <h3>Canteen Manager</h3>
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
        <h2>${canteen == null ? 'Create Canteen' : 'Edit Canteen'}</h2>
        <a href="${pageContext.request.contextPath}/admin/canteen"
           class="btn btn-secondary">← Back to List</a>
    </div>

    <div class="card" style="max-width: 600px;">
        <form action="${pageContext.request.contextPath}/admin/canteen" method="post">
            <input type="hidden" name="action" value="${canteen == null ? 'create' : 'edit'}" />
            <c:if test="${canteen != null}">
                <input type="hidden" name="canteenId" value="${canteen.canteenId}" />
            </c:if>

            <div class="form-group">
                <label>Canteen Name *</label>
                <input type="text" name="name" class="form-control"
                       value="${canteen.name}" placeholder="Enter canteen name" required />
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Opening Time *</label>
                    <input type="time" name="openingTime" class="form-control"
                           value="${canteen.openingTime}" required />
                </div>
                <div class="form-group">
                    <label>Closing Time *</label>
                    <input type="time" name="closingTime" class="form-control"
                           value="${canteen.closingTime}" required />
                </div>
            </div>

            <div class="form-group">
                <label>Status</label>
                <select name="status" class="form-control">
                    <option value="ACTIVE" ${canteen.status == 'ACTIVE' ? 'selected' : ''}>Active</option>
                    <option value="INACTIVE" ${canteen.status == 'INACTIVE' ? 'selected' : ''}>Inactive</option>
                </select>
            </div>

            <div style="display:flex; gap:10px; margin-top:10px;">
                <button type="submit" class="btn btn-primary">
                    ${canteen == null ? 'Create Canteen' : 'Update Canteen'}
                </button>
                <a href="${pageContext.request.contextPath}/admin/canteen"
                   class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>
</div>

</body>
</html>