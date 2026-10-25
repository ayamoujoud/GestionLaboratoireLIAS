package dao;

import model.HistoriqueAffiliation;
import java.sql.*;
import java.util.*;

public class HistoriqueAffiliationDAO {

    // Enregistrer une nouvelle affiliation
    public void enregistrer(HistoriqueAffiliation h) throws Exception {
        String sql = "INSERT INTO historique_affiliation (membre_id, date_debut, motif) VALUES (?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, h.getMembreId());
            ps.setString(2, h.getDateDebut());
            ps.setString(3, h.getMotif());
            ps.executeUpdate();
        }
    }

    // Clôturer l'affiliation active (mettre une date de fin)
    public void cloturer(int membreId, String dateFin) throws Exception {
        String sql = "UPDATE historique_affiliation SET date_fin = ? " +
                     "WHERE membre_id = ? AND date_fin IS NULL";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, dateFin);
            ps.setInt(2, membreId);
            ps.executeUpdate();
        }
    }

    // Récupérer l'historique d'un membre
    public List<HistoriqueAffiliation> getParMembre(int membreId) throws Exception {
        List<HistoriqueAffiliation> liste = new ArrayList<>();
        String sql = "SELECT * FROM historique_affiliation " +
                     "WHERE membre_id = ? ORDER BY date_debut DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, membreId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                HistoriqueAffiliation h = new HistoriqueAffiliation();
                h.setId(rs.getInt("id"));
                h.setMembreId(rs.getInt("membre_id"));
                h.setDateDebut(rs.getString("date_debut"));
                h.setDateFin(rs.getString("date_fin"));
                h.setMotif(rs.getString("motif"));
                liste.add(h);
            }
        }
        return liste;
    }

    // Récupérer tous les historiques (pour l'admin)
    public List<HistoriqueAffiliation> getTous() throws Exception {
        List<HistoriqueAffiliation> liste = new ArrayList<>();
        String sql = "SELECT h.*, m.nom, m.prenom FROM historique_affiliation h " +
                     "JOIN membre m ON h.membre_id = m.id " +
                     "ORDER BY h.date_debut DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                HistoriqueAffiliation h = new HistoriqueAffiliation();
                h.setId(rs.getInt("id"));
                h.setMembreId(rs.getInt("membre_id"));
                h.setDateDebut(rs.getString("date_debut"));
                h.setDateFin(rs.getString("date_fin"));
                h.setMotif(rs.getString("motif"));
                liste.add(h);
            }
        }
        return liste;
    }
}