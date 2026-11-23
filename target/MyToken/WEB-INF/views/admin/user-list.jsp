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
        <h2>User List</h2>
        <a href="${pageContext.request.contextPath}/admin/user?action=create"
           class="btn btn-primary">+ Add User</a>
    </div>

    <div class="card">
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Department</th>
                    <th>Designation</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="user" items="${users}" varStatus="i">
                    <tr>
                        <td>${i.count}</td>
                        <td>${user.name}</td>
                        <td>${user.email}</td>
                        <td>
                            <span class="badge ${user.role == 'ADMIN' ? 'badge-dry' : 'badge-regular'}">
                                ${user.role}
                            </span>
                        </td>
                        <td>${user.department}</td>
                        <td>${user.designation}</td>
                        <td>
                            <span class="badge badge-${user.status.toLowerCase()}">
                                ${user.status}
                            </span>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/user?action=edit&id=${user.userId}"
                               class="btn btn-secondary btn-sm">Edit</a>
                            <c:choose>
                                <c:when test="${user.status == 'ACTIVE'}">
                                    <a href="${pageContext.request.contextPath}/admin/user?action=toggle&id=${user.userId}&status=INACTIVE"
                                       class="btn btn-danger btn-sm">Deactivate</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/admin/user?action=toggle&id=${user.userId}&status=ACTIVE"
                                       class="btn btn-success btn-sm">Activate</a>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty users}">
                    <tr>
                        <td colspan="8" style="text-align:center; color:#999; padding:30px;">
                            No users found.
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>