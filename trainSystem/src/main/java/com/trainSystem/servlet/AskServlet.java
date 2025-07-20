package com.trainSystem.pkg.servlet;

import com.trainSystem.pkg.dao.QuestionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AskServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String cust = req.getParameter("customer");
        String subj = req.getParameter("subject");      // keep if you added column
        String body = req.getParameter("question");

        try {
            new QuestionDAO().add(cust, subj, body);
            resp.sendRedirect(req.getContextPath() + "/customer/faq.jsp");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
