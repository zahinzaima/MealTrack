package com.mytoken.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.mytoken.model.Canteen;
import com.mytoken.util.DBConnection;

public class CanteenDAO {

    public List<Canteen> getAllCanteens() {
        List<Canteen> canteens = new ArrayList<>();
        String sql = "SELECT * FROM canteens ORDER BY name";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                canteens.add(mapCanteen(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return canteens;
    }

    public List<Canteen> getActiveCanteens() {
        List<Canteen> canteens = new ArrayList<>();
        String sql = "SELECT * FROM canteens WHERE status='ACTIVE' ORDER BY name";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                canteens.add(mapCanteen(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return canteens;
    }

    public boolean addCanteen(Canteen canteen) {
        String sql = "INSERT INTO canteens (name, opening_time, closing_time, status) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, canteen.getName());
            ps.setString(2, canteen.getOpeningTime());
            ps.setString(3, canteen.getClosingTime());
            ps.setString(4, canteen.getStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateCanteen(Canteen canteen) {
        String sql = "UPDATE canteens SET name=?, opening_time=?, closing_time=?, status=? WHERE canteen_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, canteen.getName());
            ps.setString(2, canteen.getOpeningTime());
            ps.setString(3, canteen.getClosingTime());
            ps.setString(4, canteen.getStatus());
            ps.setInt(5, canteen.getCanteenId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Canteen getCanteenById(int canteenId) {
        String sql = "SELECT * FROM canteens WHERE canteen_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, canteenId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapCanteen(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateStatus(int canteenId, String status) {
        String sql = "UPDATE canteens SET status=? WHERE canteen_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, canteenId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Canteen mapCanteen(ResultSet rs) throws SQLException {
        Canteen canteen = new Canteen();
        canteen.setCanteenId(rs.getInt("canteen_id"));
        canteen.setName(rs.getString("name"));
        canteen.setOpeningTime(rs.getString("opening_time"));
        canteen.setClosingTime(rs.getString("closing_time"));
        canteen.setStatus(rs.getString("status"));
        return canteen;
    }
}