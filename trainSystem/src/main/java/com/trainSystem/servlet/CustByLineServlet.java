package com.trainSystem.pkg.servlet;

import com.trainSystem.pkg.util.DBUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

public class CustByLineServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String line = req.getParameter("line");
        String date = req.getParameter("date"); // yyyy‑mm‑dd

        String sql = "SELECT username, first_name, last_name "
                   + "FROM CustomersByLineDate "
                   + "WHERE transit_id=? AND travel_date=?";

        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, line);
            ps.setString(2, date);
            ResultSet rs = ps.executeQuery();
            List<Map<String,Object>> list = new ArrayList<>();
            while (rs.next()) {
                Map<String,Object> m = new HashMap<>();
                m.put("user", rs.getString(1));
                m.put("first", rs.getString(2));
                m.put("last", rs.getString(3));
                list.add(m);
            }
            req.setAttribute("list", list);
            req.getRequestDispatcher("/rep/repCustomers.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
