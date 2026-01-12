<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.sql.*" %>
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
    <title>Event Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">
<div class="container mx-auto p-6">
    <h1 class="text-2xl font-bold mb-6">Event Management</h1>

    <a href="add_event.jsp" class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600 mb-4 inline-block">Add New Event</a>

    <table class="min-w-full bg-white shadow rounded">
        <thead class="bg-gray-800 text-white">
        <tr>
            <th class="py-2 px-4">Event Name</th>
            <th class="py-2 px-4">Club Name</th>
            <th class="py-2 px-4">Location</th>
            <th class="py-2 px-4">Date</th>
            <th class="py-2 px-4">Time</th>
            <th class="py-2 px-4">Description</th>
            <th class="py-2 px-4">Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                conn = DriverManager.getConnection("jdbc:derby://localhost:1527/ucmsdb","user","pass");
                ps = conn.prepareStatement("SELECT * FROM events");
                rs = ps.executeQuery();
                while(rs.next()){
                    String eventName = rs.getString("eventName");
                    String clubName = rs.getString("clubName");
                    String location = rs.getString("location");
                    String date = rs.getString("date");
                    String time = rs.getString("time");
                    String desc = rs.getString("description");
        %>
        <tr class="border-b">
            <td class="py-2 px-4"><%=eventName%></td>
            <td class="py-2 px-4"><%=clubName%></td>
            <td class="py-2 px-4"><%=location%></td>
            <td class="py-2 px-4"><%=date%></td>
            <td class="py-2 px-4"><%=time%></td>
            <td class="py-2 px-4"><%=desc%></td>
            <td class="py-2 px-4 space-x-2">
                <a href="edit_event.jsp?id=<%=eventName%>" class="bg-yellow-400 text-white px-2 py-1 rounded hover:bg-yellow-500">Edit</a>
                <a href="delete_event?id=<%=eventName%>" class="bg-red-500 text-white px-2 py-1 rounded hover:bg-red-600">Delete</a>
            </td>
        </tr>
        <%
                }
            } catch(Exception e){ out.print(e); }
            finally { if(rs!=null) rs.close(); if(ps!=null) ps.close(); if(conn!=null) conn.close(); }
        %>
        </tbody>
    </table>

    <a href="dashboard.jsp" class="mt-4 inline-block text-blue-600 hover:underline">Back to Dashboard</a>
</div>
</body>
</html>
