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
        String clubId = request.getParameter("clubId");
        try{
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/ucmsdb","user","pass");
            PreparedStatement ps = conn.prepareStatement("INSERT INTO club_membership(studentId, clubId, joinDate) VALUES(?,?,CURRENT_DATE)");
            ps.setString(1, studentId);
            ps.setString(2, clubId);
            ps.executeUpdate();
            ps.close(); conn.close();
            message = "Successfully registered!";
        }catch(Exception e){ message="Error: "+e.getMessage(); }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register Club</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">
<div class="container mx-auto p-6">
    <h1 class="text-3xl font-bold mb-6">Register Club</h1>

    <p class="text-green-600 mb-4"><%=message%></p>

    <form method="post" class="bg-white p-6 shadow rounded max-w-md">
        <label class="block mb-2 font-bold">Select Club</label>
        <select name="clubId" class="w-full border p-2 mb-4">
            <%
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                try{
                    conn = DriverManager.getConnection("jdbc:derby://localhost:1527/ucmsdb","user","pass");
                    ps = conn.prepareStatement("SELECT * FROM clubs");
                    rs = ps.executeQuery();
                    while(rs.next()){
                        out.print("<option value='"+rs.getString("clubId")+"'>"+rs.getString("clubName")+"</option>");
                    }
                } catch(Exception e){} finally { if(rs!=null) rs.close(); if(ps!=null) ps.close(); if(conn!=null) conn.close(); }
            %>
        </select>
        <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">Register</button>
    </form>

    <a href="dashboard.jsp" class="mt-4 inline-block text-blue-600 hover:underline">Back to Dashboard</a>
</div>
</body>
</html>
