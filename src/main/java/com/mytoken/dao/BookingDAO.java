package com.mytoken.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.mytoken.model.Booking;
import com.mytoken.util.DBConnection;

public class BookingDAO {

    public boolean addBooking(Booking booking) {
        String sql = "INSERT INTO bookings (user_id, token_id, booking_date, quantity, total_price, status) " +
                     "VALUES (?, ?, ?, ?, ?, 'ACTIVE')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, booking.getUserId());
            ps.setInt(2, booking.getTokenId());
            ps.setDate(3, booking.getBookingDate());
            ps.setInt(4, booking.getQuantity());
            ps.setDouble(5, booking.getTotalPrice());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isAlreadyBooked(int userId, int tokenId, Date bookingDate) {
        String sql = "SELECT COUNT(*) FROM bookings WHERE user_id=? AND token_id=? " +
                     "AND booking_date=? AND status='ACTIVE'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, tokenId);
            ps.setDate(3, bookingDate);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Booking> getBookingsByUser(int userId) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.*, u.name as user_name, t.token_name, t.category, " +
                     "c.name as canteen_name FROM bookings b " +
                     "JOIN users u ON b.user_id = u.user_id " +
                     "JOIN tokens t ON b.token_id = t.token_id " +
                     "JOIN canteens c ON t.canteen_id = c.canteen_id " +
                     "WHERE b.user_id=? ORDER BY b.booking_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                bookings.add(mapBooking(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    public List<Booking> getBookingsByUserAndMonth(int userId, int month, int year) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.*, u.name as user_name, t.token_name, t.category, " +
                     "c.name as canteen_name FROM bookings b " +
                     "JOIN users u ON b.user_id = u.user_id " +
                     "JOIN tokens t ON b.token_id = t.token_id " +
                     "JOIN canteens c ON t.canteen_id = c.canteen_id " +
                     "WHERE b.user_id=? AND MONTH(b.booking_date)=? " +
                     "AND YEAR(b.booking_date)=? AND b.status='ACTIVE' " +
                     "ORDER BY b.booking_date";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, month);
            ps.setInt(3, year);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                bookings.add(mapBooking(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    public List<Booking> getTodayBookings() {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.*, u.name as user_name, t.token_name, t.category, " +
                     "c.name as canteen_name FROM bookings b " +
                     "JOIN users u ON b.user_id = u.user_id " +
                     "JOIN tokens t ON b.token_id = t.token_id " +
                     "JOIN canteens c ON t.canteen_id = c.canteen_id " +
                     "WHERE b.booking_date = CURDATE() AND b.status='ACTIVE'";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                bookings.add(mapBooking(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    public double getMonthlyTotal(int userId, int month, int year) {
        String sql = "SELECT SUM(total_price) FROM bookings WHERE user_id=? " +
                     "AND MONTH(booking_date)=? AND YEAR(booking_date)=? AND status='ACTIVE'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, month);
            ps.setInt(3, year);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getDouble(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    public boolean cancelBooking(int bookingId, int userId) {
        String sql = "UPDATE bookings SET status='CANCELLED' WHERE booking_id=? AND user_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Booking mapBooking(ResultSet rs) throws SQLException {
        Booking booking = new Booking();
        booking.setBookingId(rs.getInt("booking_id"));
        booking.setUserId(rs.getInt("user_id"));
        booking.setUserName(rs.getString("user_name"));
        booking.setTokenId(rs.getInt("token_id"));
        booking.setTokenName(rs.getString("token_name"));
        booking.setCanteenName(rs.getString("canteen_name"));
        booking.setCategory(rs.getString("category"));
        booking.setBookingDate(rs.getDate("booking_date"));
        booking.setQuantity(rs.getInt("quantity"));
        booking.setTotalPrice(rs.getDouble("total_price"));
        booking.setStatus(rs.getString("status"));
        return booking;
    }
}