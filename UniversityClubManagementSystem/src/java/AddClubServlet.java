package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/add_club")
public class AddClubServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String clubId = request.getParameter("clubId");
        String clubName = request.getParameter("clubName");
        String description = request.getParameter("description");
        String category = request.getParameter("category");

        try{
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:derby://localhost:1527/ucmsdb","user","pass");

            String sql = "INSERT INTO clubs (clubId, clubName, description, category) VALUES (?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, clubId);
            ps.setString(2, clubName);
            ps.setString(3, description);
            ps.setString(4, category);
            ps.executeUpdate();

            ps.close(); conn.close();
        } catch(Exception e){ e.printStackTrace(); }

        response.sendRedirect("club_management");
    }
}
