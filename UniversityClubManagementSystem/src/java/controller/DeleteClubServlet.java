package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/delete_club")
public class DeleteClubServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String clubId = request.getParameter("clubId");

        try{
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:derby://localhost:1527/ucmsdb","user","pass");

            String sql = "DELETE FROM clubs WHERE clubId=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, clubId);
            ps.executeUpdate();

            ps.close(); conn.close();
        } catch(Exception e){ e.printStackTrace(); }

        response.sendRedirect("club_management");
    }
}
