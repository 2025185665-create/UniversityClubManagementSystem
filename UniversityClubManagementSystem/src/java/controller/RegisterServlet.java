package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {

        String fullname = request.getParameter("fullname");
        String userId = request.getParameter("userId");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        try{
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/ucmsdb","user","pass");
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO users(fullname,userId,email,password,role) VALUES(?,?,?,?,?)"
            );
            ps.setString(1,fullname);
            ps.setString(2,userId);
            ps.setString(3,email);
            ps.setString(4,password);
            ps.setString(5,role);

            ps.executeUpdate();
            ps.close(); conn.close();

            request.setAttribute("message","Registration successful! Please login.");
            request.getRequestDispatcher("login.jsp").forward(request, response);

        } catch(Exception e){
            throw new ServletException(e);
        }
    }
}
