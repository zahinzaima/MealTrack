<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="User Management" />
<%@ include file="../header.jsp" %>
<%@ include file="../admin-sidebar.jsp" %>

<div class="topbar">
    <h3>User Management</h3>
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
        <h2>${editUser == null ? 'Add New User' : 'Edit User'}</h2>
        <a href="${pageContext.request.contextPath}/admin/user"
           class="btn btn-secondary">← Back to List</a>
    </div>

    <div class="card" style="max-width: 600px;">
        <form action="${pageContext.request.contextPath}/admin/user" method="post">
            <input type="hidden" name="action" value="${editUser == null ? 'create' : 'edit'}" />
            <c:if test="${editUser != null}">
                <input type="hidden" name="userId" value="${editUser.userId}" />
            </c:if>

            <div class="form-row">
                <div class="form-group">
                    <label>Full Name *</label>
                    <input type="text" name="name" class="form-control"
                           value="${editUser.name}" placeholder="Enter full name" required />
                </div>
                <div class="form-group">
                    <label>Email *</label>
                    <input type="email" name="email" class="form-control"
                           value="${editUser.email}" placeholder="Enter email" required />
                </div>
            </div>

            <c:if test="${editUser == null}">
                <div class="form-group">
                    <label>PIN *</label>
                    <input type="password" name="pin" class="form-control"
                           placeholder="Enter PIN (min 4 digits)" required />
                </div>
            </c:if>

            <div class="form-row">
                <div class="form-group">
                    <label>Role *</label>
                    <select name="role" class="form-control" required>
                        <option value="EMPLOYEE" ${editUser.role == 'EMPLOYEE' ? 'selected' : ''}>Employee</option>
                        <option value="ADMIN" ${editUser.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Status</label>
                    <select name="status" class="form-control">
                        <option value="ACTIVE" ${editUser.status == 'ACTIVE' || editUser == null ? 'selected' : ''}>Active</option>
                        <option value="INACTIVE" ${editUser.status == 'INACTIVE' ? 'selected' : ''}>Inactive</option>
                    </select>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Department</label>
                    <input type="text" name="department" class="form-control"
                           value="${editUser.department}" placeholder="e.g. IT, HR, Finance" />
                </div>
                <div class="form-group">
                    <label>Designation</label>
                    <input type="text" name="designation" class="form-control"
                           value="${editUser.designation}" placeholder="e.g. Engineer, Manager" />
                </div>
            </div>

            <div style="display:flex; gap:10px; margin-top:10px;">
                <button type="submit" class="btn btn-primary">
                    ${editUser == null ? 'Add User' : 'Update User'}
                </button>
                <a href="${pageContext.request.contextPath}/admin/user"
                   class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>
</div>

</body>
</html>