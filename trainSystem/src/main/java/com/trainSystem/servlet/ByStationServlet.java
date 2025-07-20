package com.trainSystem.pkg.servlet;

import com.trainSystem.pkg.dao.ScheduleDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

public class ByStationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String station = req.getParameter("station");
        try {
            List<Map<String,Object>> res = new ScheduleDAO().byStation(station);
            req.setAttribute("list", res);
            req.getRequestDispatcher("/rep/repSchedules.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
