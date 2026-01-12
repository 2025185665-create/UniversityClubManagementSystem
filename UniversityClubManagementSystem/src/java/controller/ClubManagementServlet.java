package controller;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/club_management")
public class ClubManagementServlet extends HttpServlet {

    public static class Club {
        public String clubId;
        public String clubName;
        public String description;
        public String category;
        public Club(String id, String name, String desc, String cat){
            this.clubId = id;
            this.clubName = name;
            this.description = desc;
            this.category = cat;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Club> clubs = new ArrayList<>();

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:derby://localhost:1527/ucmsdb", "user", "pass");

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM clubs");
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                clubs.add(new Club(
                        rs.getString("clubId"),
                        rs.getString("clubName"),
                        rs.getString("description"),
                        rs.getString("category")
                ));
            }

            rs.close(); ps.close(); conn.close();
        } catch(Exception e){ e.printStackTrace(); }

        request.setAttribute("clubs", clubs);
        request.getRequestDispatcher("admin/club_management.jsp").forward(request, response);
    }
}
