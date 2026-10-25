package dao;

import model.Message;
import java.sql.*;
import java.util.*;

public class MessageDAO {

    public void envoyer(Message msg) throws Exception {
        String sql = "INSERT INTO message (expediteur_id, destinataire_id, equipe_dest, contenu) VALUES (?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, msg.getExpediteurId());
            if (msg.getDestinatataireId() > 0) {
                ps.setInt(2, msg.getDestinatataireId());
            } else {
                ps.setNull(2, Types.INTEGER);
            }
            ps.setString(3, msg.getEquipeDest());
            ps.setString(4, msg.getContenu());
            ps.executeUpdate();
        }
    }

    public List<Message> getMessagesRecus(int userId) throws Exception {
        List<Message> liste = new ArrayList<>();
        String sql = "SELECT m.*, u.email as exp_email, " +
                     "mem.nom as exp_nom, mem.prenom as exp_prenom " +
                     "FROM message m " +
                     "JOIN utilisateur u ON m.expediteur_id = u.id " +
                     "LEFT JOIN membre mem ON u.membre_id = mem.id " +
                     "WHERE m.destinataire_id = ? " +
                     "ORDER BY m.date_envoi DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Message msg = new Message();
                msg.setId(rs.getInt("id"));
                msg.setExpediteurId(rs.getInt("expediteur_id"));
                String nom = rs.getString("exp_nom");
                String prenom = rs.getString("exp_prenom");
                msg.setNomExpediteur(nom != null ? prenom + " " + nom : rs.getString("exp_email"));
                msg.setContenu(rs.getString("contenu"));
                msg.setDateEnvoi(rs.getString("date_envoi"));
                msg.setLu(rs.getBoolean("lu"));
                liste.add(msg);
            }
        }
        return liste;
    }

    public List<Message> getMessagesEnvoyes(int userId) throws Exception {
        List<Message> liste = new ArrayList<>();
        String sql = "SELECT m.*, mem.nom as dest_nom, mem.prenom as dest_prenom " +
                     "FROM message m " +
                     "LEFT JOIN utilisateur u2 ON m.destinataire_id = u2.id " +
                     "LEFT JOIN membre mem ON u2.membre_id = mem.id " +
                     "WHERE m.expediteur_id = ? " +
                     "ORDER BY m.date_envoi DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Message msg = new Message();
                msg.setId(rs.getInt("id"));
                String nom = rs.getString("dest_nom");
                String prenom = rs.getString("dest_prenom");
                msg.setNomDestinataire(nom != null ? prenom + " " + nom :
                    (rs.getString("equipe_dest") != null ? "Équipe : " + rs.getString("equipe_dest") : "Tous"));
                msg.setContenu(rs.getString("contenu"));
                msg.setDateEnvoi(rs.getString("date_envoi"));
                msg.setLu(rs.getBoolean("lu"));
                liste.add(msg);
            }
        }
        return liste;
    }

    public void marquerLu(int messageId) throws Exception {
        String sql = "UPDATE message SET lu=true WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, messageId);
            ps.executeUpdate();
        }
    }

    public int countNonLus(int userId) throws Exception {
        String sql = "SELECT COUNT(*) FROM message WHERE destinataire_id=? AND lu=false";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }
}