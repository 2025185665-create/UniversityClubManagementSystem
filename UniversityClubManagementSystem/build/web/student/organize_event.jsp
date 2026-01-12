<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    String role = (String) session.getAttribute("role");
    if(role == null || !role.equals("student")) {
        response.sendRedirect("../login.jsp");
    }
    String studentId = (String) session.getAttribute("userId");
    String message = "";
    if(request.getMethod().equalsIgnoreCase("POST")){
        String eventName = request.getParameter("eventName");
        String clubId = request.getParameter("clubId");
        String location = request.getParameter("location");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String desc = request.getParameter("description");

        try{
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/ucmsdb","user","pass");

            // Get club name
            PreparedStatement ps1 = conn.prepareStatement("SELECT clubName FROM clubs WHERE clubId=?");
            ps1.setString(1, clubId);
            ResultSet rs1 = ps1.executeQuery();
            String clubName = "";
            if(rs1.next()){ clubName = rs1.getString("clubName"); }
            rs1.close(); ps1.close();

            PreparedStatement ps = conn.prepareStatement("INSERT INTO events(eventName, clubName, location, date, time, description) VALUES(?,?,?,?,?,?)");
            ps.setString(1,eventName);
            ps.setString(2,clubName);
            ps.setString(3,location);
            ps.setString(4,date);
            ps.setString(5,time);
            ps.setString(6,desc);
            ps.executeUpdate();
            ps.close(); conn.close();
            message = "Event organized successfully!";
        }catch(Exception e){ message = "Error: "+e.getMessage(); }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Organize Event</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">
<div class="container mx-auto p-6">
    <h1 class="text-3xl font-bold mb-6">Organize Event</h1>

    <p class="text-green-600 mb-4"><%=message%></p>

    <form method="post" class="bg-white p-6 shadow rounded max-w-md">
        <label class="block mb-2 font-bold">Event Name</label>
        <input type="text" name="eventName" class="w-full border p-2 mb-4" required>

        <label class="block mb-2 font-bold">Select Club</label>
        <select name="clubId" class="w-full border p-2 mb-4">
            <%
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                try{
                    conn = DriverManager.getConnection("jdbc:derby://localhost:1527/ucmsdb","user","pass");
                    ps = conn.prepareStatement("SELECT * FROM club_membership cm JOIN clubs c ON cm.clubId=c.clubId WHERE cm.studentId=?");
                    ps.setString(1,studentId);
                    rs = ps.executeQuery();
                    while(rs.next()){
                        out.print("<option value='"+rs.getString("clubId")+"'>"+rs.getString("clubName")+"</option>");
                    }
                } catch(Exception e){} finally { if(rs!=null) rs.close(); if(ps!=null) ps.close(); if(conn!=null) conn.close(); }
            %>
        </select>

        <label class="block mb-2 font-bold">Location</label>
        <input type="text" name="location" class="w-full border p-2 mb-4" required>

        <label class="block mb-2 font-bold">Date</label>
        <input type="date" name="date" class="w-full border p-2 mb-4" required>

        <label class="block mb-2 font-bold">Time</label>
        <input type="time" name="time" class="w-full border p-2 mb-4" required>

        <label class="block mb-2 font-bold">Description</label>
        <textarea name="description" class="w-full border p-2 mb-4" required></textarea>

        <button type="submit" class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600">Organize Event</button>
    </form>

    <a href="dashboard.jsp" class="mt-4 inline-block text-blue-600 hover:underline">Back to Dashboard</a>
</div>
</body>
</html>
