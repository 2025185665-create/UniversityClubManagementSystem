<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%
    String role = (String) session.getAttribute("role");
    if(role == null || !role.equals("admin")) {
        response.sendRedirect("../login.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">
    <div class="container mx-auto p-6">
        <h1 class="text-3xl font-bold mb-6">Admin Dashboard</h1>

        <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
            <a href="club_management.jsp" class="bg-blue-500 text-white p-6 rounded shadow hover:bg-blue-600 text-center">Club Management</a>
            <a href="club_membership.jsp" class="bg-green-500 text-white p-6 rounded shadow hover:bg-green-600 text-center">Club Membership Management</a>
            <a href="event_management.jsp" class="bg-purple-500 text-white p-6 rounded shadow hover:bg-purple-600 text-center">Event Management</a>
            <a href="dashboard_chart.jsp" class="bg-yellow-500 text-white p-6 rounded shadow hover:bg-yellow-600 text-center">Dashboard</a>
        </div>

        <form action="../logout" method="post">
            <button type="submit" class="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600">Logout</button>
        </form>
    </div>
</body>
</html>
