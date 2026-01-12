package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {

        String userId = request.getParameter("userId");
        String password = request.getParameter("password");

        try{
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/ucmsdb","app","app");
            PreparedStatement ps = conn.prepareStatement("SELECT fullname, role FROM users WHERE userId=? AND password=?");
            ps.setString(1,userId);
            ps.setString(2,password);
            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                HttpSession session = request.getSession();
                session.setAttribute("userId", userId);
                session.setAttribute("fullname", rs.getString("fullname"));
                session.setAttribute("role", rs.getString("role"));

                if(rs.getString("role").equalsIgnoreCase("admin")){
                    response.sendRedirect("admin/dashboard.jsp");
                } else {
                    response.sendRedirect("student/dashboard.jsp");
                }
            } else {
                request.setAttribute("error", "Invalid credentials");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

            rs.close(); ps.close(); conn.close();
        } catch(Exception e){
            throw new ServletException(e);
        }
    }
}
