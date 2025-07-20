package com.trainSystem.pkg.dao;

import com.trainSystem.pkg.util.DBUtil;
import java.sql.*;
import java.util.*;

public class ScheduleDAO {

    public void update(String id, Timestamp dep, Timestamp arr, float fare) throws Exception {
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(
                 "UPDATE TrainSchedule SET departure_datetime=?, arrival_datetime=?, train_fare=? "
               + "WHERE trainschedule_id=?")) {
            ps.setTimestamp(1, dep);
            ps.setTimestamp(2, arr);
            ps.setFloat(3, fare);
            ps.setString(4, id);
            ps.executeUpdate();
        }
    }

    public void delete(String id) throws Exception {
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(
                 "DELETE FROM TrainSchedule WHERE trainschedule_id=?")) {
            ps.setString(1, id);
            ps.executeUpdate();
        }
    }

    public List<Map<String,Object>> by
