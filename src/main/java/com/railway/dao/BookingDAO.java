package com.railway.dao;

import com.railway.model.Booking;
import com.railway.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    // Booking and seat update happen in one transaction.
    public int bookTicket(int userId, int trainId, String date,
                          String passengerName, int age) {
        String checkSql = "SELECT available_seats, fare FROM trains WHERE train_id=? FOR UPDATE";
        String insertSql = "INSERT INTO bookings(user_id,train_id,journey_date," +
                "passenger_name,passenger_age,fare,status) VALUES(?,?,?,?,?,?,'CONFIRMED')";
        String updateSql = "UPDATE trains SET available_seats=available_seats-1 " +
                "WHERE train_id=? AND available_seats>0";

        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false);

            try (PreparedStatement check = con.prepareStatement(checkSql)) {
                check.setInt(1, trainId);
                ResultSet rs = check.executeQuery();

                if (!rs.next() || rs.getInt("available_seats") <= 0) {
                    con.rollback();
                    return 0;
                }

                double fare = rs.getDouble("fare");

                try (PreparedStatement update = con.prepareStatement(updateSql);
                     PreparedStatement insert = con.prepareStatement(insertSql,
                             Statement.RETURN_GENERATED_KEYS)) {
                    update.setInt(1, trainId);
                    if (update.executeUpdate() == 0) {
                        con.rollback();
                        return 0;
                    }

                    insert.setInt(1, userId);
                    insert.setInt(2, trainId);
                    insert.setDate(3, Date.valueOf(date));
                    insert.setString(4, passengerName);
                    insert.setInt(5, age);
                    insert.setDouble(6, fare);
                    insert.executeUpdate();

                    ResultSet keys = insert.getGeneratedKeys();
                    if (keys.next()) {
                        int bookingId = keys.getInt(1);
                        con.commit();
                        return bookingId;
                    }
                }
                con.rollback();
            } catch (Exception e) {
                con.rollback();
                System.out.println("Booking error: " + e.getMessage());
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }

    public List<Booking> getUserBookings(int userId) {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.*,t.train_name,t.source,t.destination FROM bookings b " +
                "JOIN trains t ON b.train_id=t.train_id WHERE b.user_id=? ORDER BY b.booking_id DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(readBooking(rs));
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public Booking getBookingById(int bookingId, int userId) {
        String sql = "SELECT b.*,t.train_name,t.source,t.destination FROM bookings b " +
                "JOIN trains t ON b.train_id=t.train_id WHERE b.booking_id=? AND b.user_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return readBooking(rs);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    private Booking readBooking(ResultSet rs) throws SQLException {
        Booking b = new Booking();
        b.setBookingId(rs.getInt("booking_id"));
        b.setTrainName(rs.getString("train_name"));
        b.setSource(rs.getString("source"));
        b.setDestination(rs.getString("destination"));
        b.setJourneyDate(rs.getString("journey_date"));
        b.setPassengerName(rs.getString("passenger_name"));
        b.setPassengerAge(rs.getInt("passenger_age"));
        b.setStatus(rs.getString("status"));
        b.setFare(rs.getDouble("fare"));
        return b;
    }

    // Only the owner of a booking can cancel it.
    public boolean cancelBooking(int bookingId, int userId) {
        String findSql = "SELECT train_id,status FROM bookings WHERE booking_id=? AND user_id=? FOR UPDATE";
        String cancelSql = "UPDATE bookings SET status='CANCELLED' WHERE booking_id=?";
        String seatSql = "UPDATE trains SET available_seats=available_seats+1 WHERE train_id=?";
        String recordSql = "INSERT INTO cancellations(booking_id,reason) VALUES(?,'Cancelled by user')";

        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false);

            try (PreparedStatement find = con.prepareStatement(findSql)) {
                find.setInt(1, bookingId);
                find.setInt(2, userId);
                ResultSet rs = find.executeQuery();

                if (!rs.next() || !"CONFIRMED".equals(rs.getString("status"))) {
                    con.rollback();
                    return false;
                }

                int trainId = rs.getInt("train_id");
                try (PreparedStatement cancel = con.prepareStatement(cancelSql);
                     PreparedStatement seat = con.prepareStatement(seatSql);
                     PreparedStatement record = con.prepareStatement(recordSql)) {
                    cancel.setInt(1, bookingId);
                    cancel.executeUpdate();

                    seat.setInt(1, trainId);
                    seat.executeUpdate();

                    record.setInt(1, bookingId);
                    record.executeUpdate();

                    con.commit();
                    return true;
                }
            } catch (Exception e) {
                con.rollback();
                System.out.println("Cancellation error: " + e.getMessage());
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
}
