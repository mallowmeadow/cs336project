package com.trainSystem.pkg.servlet;

import com.trainSystem.pkg.dao.QuestionDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

public class SearchFAQServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String kw = req.getParameter("kw") == null ? "" : req.getParameter("kw");

        try {
            List<Map<String,Object>> res = new QuestionDAO().answered(kw);
            req.setAttribute("list", res);
            req.getRequestDispatcher("/customer/faq.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
