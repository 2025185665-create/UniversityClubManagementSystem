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

@WebServlet("/add_member")
public class AddMemberServlet extends HttpServlet {

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

            String sql = "INSERT INTO club_membership (studentId, clubId, joinDate) VALUES (?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, studentId);
            ps.setString(2, clubId);
            ps.setDate(3, Date.valueOf(joinDate));
            ps.executeUpdate();

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        // 🔁 Back to list page
        response.sendRedirect("club_membership");
    }
}
