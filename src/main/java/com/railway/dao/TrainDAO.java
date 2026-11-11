package com.railway.dao;

import com.railway.model.Train;
import com.railway.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TrainDAO {

    private Train makeTrain(ResultSet rs) throws SQLException {
        Train t = new Train();
        t.setTrainId(rs.getInt("train_id"));
        t.setTrainName(rs.getString("train_name"));
        t.setSource(rs.getString("source"));
        t.setDestination(rs.getString("destination"));
        t.setDepartureTime(rs.getString("departure_time"));
        t.setArrivalTime(rs.getString("arrival_time"));
        t.setTotalSeats(rs.getInt("total_seats"));
        t.setAvailableSeats(rs.getInt("available_seats"));
        t.setFare(rs.getDouble("fare"));
        return t;
    }

    public List<Train> getAllTrains() {
        List<Train> list = new ArrayList<>();
        String sql = "SELECT * FROM trains ORDER BY train_id";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(makeTrain(rs));
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public List<Train> searchTrains(String source, String destination) {
        List<Train> list = new ArrayList<>();
        String sql = "SELECT * FROM trains WHERE LOWER(source)=LOWER(?) " +
                     "AND LOWER(destination)=LOWER(?) AND available_seats > 0";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, source);
            ps.setString(2, destination);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(makeTrain(rs));
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public boolean addTrain(Train t) {
        String sql = "INSERT INTO trains(train_name,source,destination,departure_time," +
                "arrival_time,total_seats,available_seats,fare) VALUES(?,?,?,?,?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, t.getTrainName());
            ps.setString(2, t.getSource());
            ps.setString(3, t.getDestination());
            ps.setString(4, t.getDepartureTime());
            ps.setString(5, t.getArrivalTime());
            ps.setInt(6, t.getTotalSeats());
            ps.setInt(7, t.getTotalSeats());
            ps.setDouble(8, t.getFare());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Add train error: " + e.getMessage());
            return false;
        }
    }

    public boolean updateTrain(Train t) {
        String sql = "UPDATE trains SET train_name=?,source=?,destination=?,departure_time=?," +
                "arrival_time=?,fare=? WHERE train_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, t.getTrainName());
            ps.setString(2, t.getSource());
            ps.setString(3, t.getDestination());
            ps.setString(4, t.getDepartureTime());
            ps.setString(5, t.getArrivalTime());
            ps.setDouble(6, t.getFare());
            ps.setInt(7, t.getTrainId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Update train error: " + e.getMessage());
            return false;
        }
    }

    public boolean deleteTrain(int id) {
        String sql = "DELETE FROM trains WHERE train_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Delete train error: " + e.getMessage());
            return false;
        }
    }
}
