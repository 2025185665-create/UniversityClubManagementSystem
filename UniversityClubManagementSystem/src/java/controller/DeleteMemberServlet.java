package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/delete_member")
public class DeleteMemberServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 🔐 session check (admin only)
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String studentId = request.getParameter("studentId");
        String clubId = request.getParameter("clubId");

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(
                    "jdbc:derby://localhost:1527/ucmsdb", "user", "pass");

            String sql = "DELETE FROM club_membership WHERE studentId = ? AND clubId = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, studentId);
            ps.setString(2, clubId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }

        // 🔁 back to club management page
        response.sendRedirect("admin/club_management.jsp");
    }
}
