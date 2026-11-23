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
        <h2>Token List</h2>
        <a href="${pageContext.request.contextPath}/admin/token?action=create"
           class="btn btn-primary">+ Create New Token</a>
    </div>

    <div class="card">
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Token Name</th>
                    <th>Token ID</th>
                    <th>Canteen</th>
                    <th>Category</th>
                    <th>Days</th>
                    <th>Price</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="token" items="${tokens}" varStatus="i">
                    <tr>
                        <td>${i.count}</td>
                        <td>${token.tokenName}</td>
                        <td><small style="color:#999;">${token.tokenCode}</small></td>
                        <td>${token.canteenName}</td>
                        <td>
                            <span class="badge badge-${token.category.toLowerCase()}">
                                ${token.category}
                            </span>
                        </td>
                        <td><small>${token.availableDays}</small></td>
                        <td>৳ ${token.price}</td>
                        <td>
                            <span class="badge badge-${token.status.toLowerCase()}">
                                ${token.status}
                            </span>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/token?action=edit&id=${token.tokenId}"
                               class="btn btn-secondary btn-sm">Edit</a>
                            <c:choose>
                                <c:when test="${token.status == 'ACTIVE'}">
                                    <a href="${pageContext.request.contextPath}/admin/token?action=toggle&id=${token.tokenId}&status=INACTIVE"
                                       class="btn btn-danger btn-sm">Deactivate</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/admin/token?action=toggle&id=${token.tokenId}&status=ACTIVE"
                                       class="btn btn-success btn-sm">Activate</a>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty tokens}">
                    <tr>
                        <td colspan="9" style="text-align:center; color:#999; padding:30px;">
                            No tokens found. Create one!
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>