package com.trainSystem.pkg.servlet;

import com.trainSystem.pkg.dao.ScheduleDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;

public class DeleteScheduleServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String id = req.getParameter("id");

        try {
            new ScheduleDAO().delete(id);
            resp.sendRedirect(req.getContextPath() + "/rep/repSchedule.jsp");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
