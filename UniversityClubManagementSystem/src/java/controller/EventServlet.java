package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class EventServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String action = request.getParameter("action");

        try{
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/ucmsdb","user","pass");

            if("add".equals(action)){
                String clubName = request.getParameter("clubName");
                PreparedStatement ps = conn.prepareStatement(
                    "INSERT INTO events(eventName, clubName, location, date, time, description) VALUES(?,?,?,?,?,?)"
                );
                ps.setString(1,request.getParameter("eventName"));
                ps.setString(2,clubName);
                ps.setString(3,request.getParameter("location"));
                ps.setString(4,request.getParameter("date"));
                ps.setString(5,request.getParameter("time"));
                ps.setString(6,request.getParameter("description"));
                ps.executeUpdate(); ps.close();
            } else if("edit".equals(action)){
                PreparedStatement ps = conn.prepareStatement(
                    "UPDATE events SET eventName=?, clubName=?, location=?, date=?, time=?, description=? WHERE eventId=?"
                );
                ps.setString(1,request.getParameter("eventName"));
                ps.setString(2,request.getParameter("clubName"));
                ps.setString(3,request.getParameter("location"));
                ps.setString(4,request.getParameter("date"));
                ps.setString(5,request.getParameter("time"));
                ps.setString(6,request.getParameter("description"));
                ps.setString(7,request.getParameter("eventId"));
                ps.executeUpdate(); ps.close();
            } else if("delete".equals(action)){
                PreparedStatement ps = conn.prepareStatement(
                    "DELETE FROM events WHERE eventId=?"
                );
                ps.setString(1,request.getParameter("eventId"));
                ps.executeUpdate(); ps.close();
            }

            conn.close();
            response.sendRedirect("admin/event_management.jsp");
        } catch(Exception e){
            throw new ServletException(e);
        }
    }
}
