package com.mytoken.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.mytoken.model.Token;
import com.mytoken.util.DBConnection;

public class TokenDAO {

    public List<Token> getAllTokens() {
        List<Token> tokens = new ArrayList<>();
        String sql = "SELECT t.*, c.name as canteen_name FROM tokens t " +
                     "JOIN canteens c ON t.canteen_id = c.canteen_id ORDER BY t.token_name";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                tokens.add(mapToken(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tokens;
    }

    public List<Token> getTokensByDate(java.util.Date date) {
        List<Token> tokens = new ArrayList<>();
        java.util.Calendar cal = java.util.Calendar.getInstance();
        cal.setTime(date);
        String[] days = {"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"};
        String dayName = days[cal.get(java.util.Calendar.DAY_OF_WEEK) - 1];

        String sql = "SELECT t.*, c.name as canteen_name FROM tokens t " +
                     "JOIN canteens c ON t.canteen_id = c.canteen_id " +
                     "WHERE t.status = 'ACTIVE' AND c.status = 'ACTIVE' " +
                     "AND t.available_days LIKE ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + dayName + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                tokens.add(mapToken(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tokens;
    }

    public boolean addToken(Token token) {
        String sql = "INSERT INTO tokens (token_code, token_name, canteen_id, category, price, available_days, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token.getTokenCode());
            ps.setString(2, token.getTokenName());
            ps.setInt(3, token.getCanteenId());
            ps.setString(4, token.getCategory());
            ps.setDouble(5, token.getPrice());
            ps.setString(6, token.getAvailableDays());
            ps.setString(7, token.getStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateToken(Token token) {
        String sql = "UPDATE tokens SET token_code=?, token_name=?, canteen_id=?, " +
                     "category=?, price=?, available_days=?, status=? WHERE token_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token.getTokenCode());
            ps.setString(2, token.getTokenName());
            ps.setInt(3, token.getCanteenId());
            ps.setString(4, token.getCategory());
            ps.setDouble(5, token.getPrice());
            ps.setString(6, token.getAvailableDays());
            ps.setString(7, token.getStatus());
            ps.setInt(8, token.getTokenId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Token getTokenById(int tokenId) {
        String sql = "SELECT t.*, c.name as canteen_name FROM tokens t " +
                     "JOIN canteens c ON t.canteen_id = c.canteen_id WHERE t.token_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, tokenId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapToken(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateStatus(int tokenId, String status) {
        String sql = "UPDATE tokens SET status=? WHERE token_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, tokenId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Token mapToken(ResultSet rs) throws SQLException {
        Token token = new Token();
        token.setTokenId(rs.getInt("token_id"));
        token.setTokenCode(rs.getString("token_code"));
        token.setTokenName(rs.getString("token_name"));
        token.setCanteenId(rs.getInt("canteen_id"));
        token.setCanteenName(rs.getString("canteen_name"));
        token.setCategory(rs.getString("category"));
        token.setPrice(rs.getDouble("price"));
        token.setAvailableDays(rs.getString("available_days"));
        token.setStatus(rs.getString("status"));
        return token;
    }
}