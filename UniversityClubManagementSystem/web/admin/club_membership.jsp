<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>

<%
    if (!"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Membership Management</title>
    <link rel="stylesheet" href="../css/style.css">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">
<div class="container mx-auto p-6">

    <h1 class="text-2xl font-bold mb-4">Membership Management</h1>

    <nav class="mb-6">
        <a href="dashboard.jsp" class="text-blue-600 hover:underline">Dashboard</a> |
        <a href="club_management.jsp" class="text-blue-600 hover:underline">Club Management</a> |
        <a href="club_membership.jsp" class="text-blue-600 hover:underline">Membership Management</a> |
        <a href="event_management.jsp" class="text-blue-600 hover:underline">Event Management</a> |
        <a href="../logout.jsp" class="text-blue-600 hover:underline">Logout</a>
    </nav>

    <!-- ADD STUDENT TO CLUB -->
    <form action="../add_member" method="post" class="bg-white p-4 rounded shadow mb-6 flex gap-4">
        <input name="studentId" placeholder="Student ID" required class="p-2 border rounded w-1/4">
        <input name="studentName" placeholder="Student Name" required class="p-2 border rounded w-1/4">
        <input name="clubId" placeholder="Club ID" required class="p-2 border rounded w-1/4">
        <input type="date" name="joinDate" required class="p-2 border rounded w-1/4">
        <button class="bg-green-500 text-white px-4 rounded">Add</button>
    </form>

    <!-- MEMBERSHIP TABLE -->
    <table class="min-w-full bg-white shadow rounded">
        <thead class="bg-gray-800 text-white">
        <tr>
            <th class="py-2 px-4">Student ID</th>
            <th class="py-2 px-4">Club ID</th>
            <th class="py-2 px-4">Student Name</th>
            <th class="py-2 px-4">Join Date</th>
            <th class="py-2 px-4">Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="m" items="${memberships}">
            <tr class="border-b">
                <td class="py-2 px-4">${m.studentId}</td>
                <td class="py-2 px-4">${m.clubId}</td>
                <td class="py-2 px-4">${m.studentName}</td>
                <td class="py-2 px-4">${m.joinDate}</td>
                <td class="py-2 px-4 space-x-2">

                    <!-- EDIT JOIN DATE INLINE -->
                    <form action="../edit_member" method="post" class="inline">
                        <input type="hidden" name="studentId" value="${m.studentId}">
                        <input type="hidden" name="clubId" value="${m.clubId}">
                        <input type="date" name="joinDate" value="${m.joinDate}" class="border p-1 text-sm">
                        <button class="bg-yellow-400 px-2 py-1 text-white rounded">Update</button>
                    </form>

                    <!-- DELETE -->
                    <a href="../delete_member?studentId=${m.studentId}&clubId=${m.clubId}"
                       class="bg-red-500 px-2 py-1 text-white rounded"
                       onclick="return confirm('Delete this membership?');">
                        Delete
                    </a>

                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

</div>
</body>
</html>
