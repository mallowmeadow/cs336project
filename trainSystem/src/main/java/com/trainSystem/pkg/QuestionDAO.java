package com.trainSystem.pkg.dao;

import com.trainSystem.pkg.util.DBUtil;
import java.sql.*;
import java.util.*;

public class QuestionDAO {

    // 1. add new customer question
    public void add(String customerId, String body) throws Exception {
        String sql = "INSERT INTO CustomerQuestions"
                   + "(ques_id,customer_id,question,question_date)"
                   + "VALUES(UUID(),?,?,NOW())";
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, customerId);
            ps.setString(2, body);
            ps.executeUpdate();
        }
    }

    // 2. answered Q&A (keyword may be blank)
    public List<Map<String,Object>> answered(String kw) throws Exception {
        String sql = "SELECT q.question, r.reply "
                   + "FROM CustomerQuestions q "
                   + "JOIN EmployeeReply r USING(ques_id) "
                   + "WHERE q.question LIKE ? OR r.reply LIKE ?";
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, "%" + kw + "%");
            ps.setString(2, "%" + kw + "%");
            return rows(ps);
        }
    }

    // 3. unanswered questions
    public List<Map<String,Object>> open() throws Exception {
        String sql = "SELECT * FROM CustomerQuestions "
                   + "WHERE ques_id NOT IN (SELECT ques_id FROM EmployeeReply)";
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            return rows(ps);
        }
    }

    /* ---------- tiny helper ---------- */
    private List<Map<String,Object>> rows(PreparedStatement ps) throws Exception {
        ResultSet rs = ps.executeQuery();
        List<Map<String,Object>> list = new ArrayList<>();
        ResultSetMetaData md = rs.getMetaData();
        int n = md.getColumnCount();
        while (rs.next()) {
            Map<String,Object> m = new HashMap<>();
            for (int i=1;i<=n;i++) m.put(md.getColumnLabel(i), rs.getObject(i));
            list.add(m);
        }
        return list;
    }
}
