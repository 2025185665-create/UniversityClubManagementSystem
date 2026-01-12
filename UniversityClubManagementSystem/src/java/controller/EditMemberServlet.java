package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/edit_member")
public class EditMemberServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String studentId = request.getParameter("studentId");
        String clubId = request.getParameter("clubId");
        String joinDate = request.getParameter("joinDate");

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:derby://localhost:1527/ucmsdb", "user", "pass");

            String sql = "UPDATE club_membership SET joinDate=? WHERE studentId=? AND clubId=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setDate(1, Date.valueOf(joinDate));
            ps.setString(2, studentId);
            ps.setString(3, clubId);
            ps.executeUpdate();

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        // 🔁 Back to list page
        response.sendRedirect("club_membership");
    }
}
