package com.trainSystem.pkg.dao;

import com.trainSystem.pkg.util.DBUtil;
import java.sql.*;

public class AnswerDAO {

    public void add(String quesId, String repSsn, String body) throws Exception {
        String sql = "INSERT INTO EmployeeReply"
                   + "(reply_id,ques_id,employee_ssn,reply,reply_date)"
                   + "VALUES(UUID(),?,?,?,NOW())";
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, quesId);
            ps.setString(2, repSsn);
            ps.setString(3, body);
            ps.executeUpdate();
        }
    }
}
