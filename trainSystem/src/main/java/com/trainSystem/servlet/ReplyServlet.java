package com.trainSystem.pkg.servlet;

import com.trainSystem.pkg.util.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class ReplyServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String qid  = req.getParameter("ques_id");
        String rep  = (String) req.getSession().getAttribute("repSsn");  // store ssn at login
        String body = req.getParameter("reply");

        String sql = "INSERT INTO EmployeeReply(reply_id,ques_id,employee_ssn,reply,reply_date)"
                   + "VALUES(UUID(),?,?,?,NOW())";

        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, qid);
            ps.setString(2, rep);
            ps.setString(3, body);
            ps.executeUpdate();
            resp.sendRedirect(req.getContextPath() + "/rep/inbox.jsp");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
