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
        <h2>Canteen List</h2>
        <a href="${pageContext.request.contextPath}/admin/canteen?action=create"
           class="btn btn-primary">+ Create Canteen</a>
    </div>

    <div class="card">
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Canteen Name</th>
                    <th>Opening Time</th>
                    <th>Closing Time</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="canteen" items="${canteens}" varStatus="i">
                    <tr>
                        <td>${i.count}</td>
                        <td>${canteen.name}</td>
                        <td>${canteen.openingTime}</td>
                        <td>${canteen.closingTime}</td>
                        <td>
                            <span class="badge badge-${canteen.status.toLowerCase()}">
                                ${canteen.status}
                            </span>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/canteen?action=edit&id=${canteen.canteenId}"
                               class="btn btn-secondary btn-sm">Edit</a>
                            <c:choose>
                                <c:when test="${canteen.status == 'ACTIVE'}">
                                    <a href="${pageContext.request.contextPath}/admin/canteen?action=toggle&id=${canteen.canteenId}&status=INACTIVE"
                                       class="btn btn-danger btn-sm">Deactivate</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/admin/canteen?action=toggle&id=${canteen.canteenId}&status=ACTIVE"
                                       class="btn btn-success btn-sm">Activate</a>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty canteens}">
                    <tr>
                        <td colspan="6" style="text-align:center; color:#999; padding:30px;">
                            No canteens found. Create one!
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>