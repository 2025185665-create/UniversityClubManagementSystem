<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
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
    <title>Admin Dashboard Analytics</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="bg-gray-100 font-sans">
<div class="container mx-auto p-6">
    <h1 class="text-3xl font-bold mb-6">Dashboard Analytics</h1>

    <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
        <!-- Pie Chart -->
        <div class="bg-white p-6 shadow rounded">
            <h2 class="text-xl font-bold mb-4">Most Active Clubs</h2>
            <canvas id="clubPieChart"></canvas>
        </div>

        <!-- Upcoming Events -->
        <div class="bg-white p-6 shadow rounded">
            <h2 class="text-xl font-bold mb-4">Upcoming Events</h2>
            <ul class="list-disc pl-5">
            <%
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                try {
                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                    conn = DriverManager.getConnection("jdbc:derby://localhost:1527/ucmsdb","user","pass");
                    ps = conn.prepareStatement("SELECT * FROM events ORDER BY date ASC FETCH FIRST 5 ROWS ONLY");
                    rs = ps.executeQuery();
                    while(rs.next()){
                        String eventName = rs.getString("eventName");
                        String clubName = rs.getString("clubName");
                        String date = rs.getString("date");
            %>
                <li class="mb-2"><strong><%=eventName%></strong> by <%=clubName%> on <%=date%></li>
            <%
                    }
                } catch(Exception e){ out.print(e); }
                finally { if(rs!=null) rs.close(); if(ps!=null) ps.close(); if(conn!=null) conn.close(); }
            %>
            </ul>
        </div>
    </div>

    <a href="dashboard.jsp" class="mt-4 inline-block text-blue-600 hover:underline">Back to Dashboard</a>
</div>

<script>
    // Prepare data for pie chart
    <% 
        Map<String,Integer> clubCount = new HashMap<>();
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/ucmsdb","user","pass");
            ps = conn.prepareStatement("SELECT clubId, COUNT(studentId) as memberCount FROM club_membership GROUP BY clubId");
            rs = ps.executeQuery();
            while(rs.next()){
                clubCount.put(rs.getString("clubId"), rs.getInt("memberCount"));
            }
        } catch(Exception e){ } finally { if(rs!=null) rs.close(); if(ps!=null) ps.close(); if(conn!=null) conn.close(); }
    %>

    const data = {
        labels: [<%= clubCount.keySet().stream().map(k -> "\"" + k + "\"").reduce((a,b)->a+","+b).orElse("") %>],
        datasets: [{
            label: 'Members',
            data: [<%= clubCount.values().stream().map(String::valueOf).reduce((a,b)->a+","+b).orElse("") %>],
            backgroundColor: ['#3B82F6', '#10B981', '#F59E0B', '#8B5CF6', '#EF4444', '#F97316', '#14B8A6'],
        }]
    };

    const config = {
        type: 'pie',
        data: data,
    };

    new Chart(
        document.getElementById('clubPieChart'),
        config
    );
</script>
</body>
</html>
