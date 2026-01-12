package controller;

import model.ClubMembership;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/club_membership")
public class ClubMembershipServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<ClubMembership> memberships = new ArrayList<>();

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:derby://localhost:1527/ucmsdb","user","pass");

            String sql = "SELECT cm.studentId, cm.clubId, u.fullname, cm.joinDate " +
                         "FROM club_membership cm " +
                         "JOIN users u ON cm.studentId = u.userId";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                ClubMembership m = new ClubMembership();
                m.setStudentId(rs.getString("studentId"));
                m.setClubId(rs.getString("clubId"));
                m.setStudentName(rs.getString("fullname"));
                m.setJoinDate(rs.getDate("joinDate"));
                memberships.add(m);
            }

            rs.close();
            ps.close();
            conn.close();

        } catch(Exception e){
            e.printStackTrace();
        }

        // Forward list to JSP
        request.setAttribute("memberships", memberships);
        request.getRequestDispatcher("admin/club_membership.jsp").forward(request, response);
    }
}
