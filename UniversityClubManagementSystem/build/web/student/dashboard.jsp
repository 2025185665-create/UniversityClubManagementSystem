<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page session="true" %>
<%
    String role = (String) session.getAttribute("role");
    if(role == null || !role.equals("student")) {
        response.sendRedirect("../login.jsp");
    }
    String studentId = (String) session.getAttribute("userId");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Campus Buzz</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">
<div class="container mx-auto p-6">
    <h1 class="text-3xl font-bold mb-6">Campus Buzz</h1>

    <!-- Available Clubs -->
    <div class="mb-8">
        <h2 class="text-2xl font-bold mb-4">Available Clubs</h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <%
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                try {
                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                    conn = DriverManager.getConnection("jdbc:derby://localhost:1527/ucmsdb","user","pass");
                    ps = conn.prepareStatement("SELECT * FROM clubs");
                    rs = ps.executeQuery();
                    while(rs.next()){
                        String clubId = rs.getString("clubId");
                        String clubName = rs.getString("clubName");
                        String desc = rs.getString("description");
                        String image = rs.getString("image"); // optional column
            %>
            <div class="bg-white p-4 shadow rounded">
                <img src="<%=image != null ? image : "https://via.placeholder.com/150" %>" class="w-full h-32 object-cover rounded mb-2">
                <h3 class="font-bold text-lg"><%=clubName%></h3>
                <p class="text-gray-700"><%=desc%></p>
            </div>
            <%
                    }
                } catch(Exception e){ out.print(e); }
                finally { if(rs!=null) rs.close(); if(ps!=null) ps.close(); if(conn!=null) conn.close(); }
            %>
        </div>
    </div>

    <!-- Student Registered Clubs -->
    <div class="mb-8">
        <h2 class="text-2xl font-bold mb-4">My Registered Clubs</h2>
        <ul class="list-disc pl-5">
            <%
                try {
                    conn = DriverManager.getConnection("jdbc:derby://localhost:1527/ucmsdb","user","pass");
                    ps = conn.prepareStatement(
                        "SELECT c.clubName FROM club_membership cm JOIN clubs c ON cm.clubId=c.clubId WHERE cm.studentId=?"
                    );
                    ps.setString(1, studentId);
                    rs = ps.executeQuery();
                    while(rs.next()){
                        out.print("<li>"+rs.getString("clubName")+"</li>");
                    }
                } catch(Exception e){} finally { if(rs!=null) rs.close(); if(ps!=null) ps.close(); if(conn!=null) conn.close(); }
            %>
        </ul>
    </div
