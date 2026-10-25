package dao;

import model.Notification;
import java.sql.*;
import java.util.*;

public class NotificationDAO {

    public void creer(int membreId, String type, String message) throws Exception {
        String sql = "INSERT INTO notification (membre_id, type, message) VALUES (?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, membreId);
            ps.setString(2, type);
            ps.setString(3, message);
            ps.executeUpdate();
        }
    }

    // Notifier tous les membres actifs
    public void notifierTous(String type, String message) throws Exception {
        String sql = "INSERT INTO notification (membre_id, type, message) " +
                     "SELECT id, ?, ? FROM membre WHERE etat_compte = 'actif'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, type);
            ps.setString(2, message);
            ps.executeUpdate();
        }
    }

    public List<Notification> getNotifications(int membreId) throws Exception {
        List<Notification> liste = new ArrayList<>();
        String sql = "SELECT * FROM notification WHERE membre_id = ? " +
                     "ORDER BY date_creation DESC LIMIT 30";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, membreId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Notification n = new Notification();
                n.setId(rs.getInt("id"));
                n.setMembreId(rs.getInt("membre_id"));
                n.setType(rs.getString("type"));
                n.setMessage(rs.getString("message"));
                n.setLu(rs.getBoolean("lu"));
                n.setDateCreation(rs.getString("date_creation"));
                liste.add(n);
            }
        }
        return liste;
    }

    public int countNonLues(int membreId) throws Exception {
        String sql = "SELECT COUNT(*) FROM notification WHERE membre_id=? AND lu=false";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, membreId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    public void marquerToutesLues(int membreId) throws Exception {
        String sql = "UPDATE notification SET lu=true WHERE membre_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, membreId);
            ps.executeUpdate();
        }
    }

    public void marquerLue(int notifId) throws Exception {
        String sql = "UPDATE notification SET lu=true WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, notifId);
            ps.executeUpdate();
        }
    }
}