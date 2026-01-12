<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%
    String role = (String) session.getAttribute("role");
    if(role == null || !role.equals("admin")){
        response.sendRedirect("../login.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Membership Management</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <h1>Membership Management</h1>
    <nav>
        <a href="dashboard.jsp">Dashboard</a> |
        <a href="clubManagement.jsp">Club Management</a> |
        <a href="membershipManagement.jsp">Membership Management</a> |
        <a href="eventManagement.jsp">Event Management</a> |
        <a href="../logout.jsp">Logout</a>
    </nav>
    <hr>
    
    <h2>Add Student to Club</h2>
    <form action="MembershipServlet" method="post">
        <input type="hidden" name="action" value="add">
        Student ID: <input type="text" name="student_id"><br>
        Student Name: <input type="text" name="student_name"><br>
        Club ID: <input type="text" name="club_id"><br>
        <input type="submit" value="Add Student">
    </form>

    <h2>All Members</h2>
    <table border="1">
        <tr>
            <th>Student ID</th><th>Club ID</th><th>Name</th><th>Join Date</th><th>Actions</th>
        </tr>
        <%-- Populate via Servlet later --%>
    </table>
</body>
</html>
