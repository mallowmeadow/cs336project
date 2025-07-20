package com.trainSystem.pkg.servlet;

import com.trainSystem.pkg.dao.ScheduleDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;

public class EditScheduleServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String id   = req.getParameter("id");
        Timestamp dep = Timestamp.valueOf(req.getParameter("departure"));
        Timestamp arr = Timestamp.valueOf(req.getParameter("arrival"));
        float fare   = Float.parseFloat(req.getParameter("fare"));

        try {
            new ScheduleDAO().update(id, dep, arr, fare);
            resp.sendRedirect(req.getContextPath() + "/rep/repSchedule.jsp");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
