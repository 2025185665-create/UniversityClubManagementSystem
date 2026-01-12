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
    <title>Club Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100 font-sans">
<div class="container mx-auto p-6">

    <h1 class="text-2xl font-bold mb-4">Club Management</h1>

    <!-- ADD CLUB FORM -->
    <form action="../add_club" method="post" 
          class="bg-white p-4 rounded shadow mb-6 flex gap-4">
        <input name="clubId" placeholder="Club ID" required class="p-2 border rounded w-1/5">
        <input name="clubName" placeholder="Club Name" required class="p-2 border rounded w-2/5">
        <input name="description" placeholder="Description" class="p-2 border rounded w-2/5">
        <input name="category" placeholder="Category" class="p-2 border rounded w-1/5">
        <button class="bg-green-500 text-white px-4 rounded">Add</button>
    </form>

    <!-- CLUB TABLE -->
    <table class="min-w-full bg-white shadow rounded">
        <thead class="bg-gray-800 text-white">
        <tr>
            <th class="py-2 px-4">Club ID</th>
            <th class="py-2 px-4">Club Name</th>
            <th class="py-2 px-4">Description</th>
            <th class="py-2 px-4">Category</th>
            <th class="py-2 px-4">Actions</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach var="c" items="${clubs}">
            <tr class="border-b">
                <td class="py-2 px-4">${c.clubId}</td>
                <td class="py-2 px-4">${c.clubName}</td>
                <td class="py-2 px-4">${c.description}</td>
                <td class="py-2 px-4">${c.category}</td>
                <td class="py-2 px-4 space-x-2">

                    <!-- EDIT INLINE -->
                    <form action="../edit_club" method="post" class="inline">
                        <input type="hidden" name="clubId" value="${c.clubId}">
                        <input name="clubName" value="${c.clubName}" class="border p-1 text-sm">
                        <input name="description" value="${c.description}" class="border p-1 text-sm">
                        <input name="category" value="${c.category}" class="border p-1 text-sm">
                        <button class="bg-yellow-400 px-2 py-1 text-white rounded">Update</button>
                    </form>

                    <!-- DELETE -->
                    <a href="../delete_club?clubId=${c.clubId}" 
                       class="bg-red-500 px-2 py-1 text-white rounded"
                       onclick="return confirm('Delete this club?');">
                        Delete
                    </a>

                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <a href="dashboard.jsp" class="mt-4 inline-block text-blue-600">Back to Dashboard</a>

</div>
</body>
</html>
