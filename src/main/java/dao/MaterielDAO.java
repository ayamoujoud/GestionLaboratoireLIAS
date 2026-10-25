package dao;

import model.Materiel;
import java.sql.*;
import java.util.*;

public class MaterielDAO {

    public void ajouter(Materiel m) throws Exception {
        String sql = "INSERT INTO materiel (designation, quantite_totale, date_arrivage, description) VALUES (?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, m.getDesignation());
            ps.setInt(2, m.getQuantiteTotale());
            ps.setString(3, m.getDateArrivage());
            ps.setString(4, m.getDescription());
            ps.executeUpdate();
        }
    }

    public List<Materiel> getStock() throws Exception {
        List<Materiel> liste = new ArrayList<>();
        String sql = "SELECT m.*, COALESCE(SUM(d.quantite),0) as distribue " +
                     "FROM materiel m LEFT JOIN distribution_materiel d ON m.id=d.materiel_id " +
                     "GROUP BY m.id";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Materiel m = new Materiel();
                m.setId(rs.getInt("id"));
                m.setDesignation(rs.getString("designation"));
                m.setQuantiteTotale(rs.getInt("quantite_totale"));
                m.setDateArrivage(rs.getString("date_arrivage"));
                m.setDescription(rs.getString("description"));
                m.setQuantiteDistribuee(rs.getInt("distribue"));
                liste.add(m);
            }
        }
        return liste;
    }

    public void distribuer(int materielId, int membreId, int quantite, String date) throws Exception {
        String sql = "INSERT INTO distribution_materiel (materiel_id, membre_id, quantite, date_distribution) VALUES (?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, materielId);
            ps.setInt(2, membreId);
            ps.setInt(3, quantite);
            ps.setString(4, date);
            ps.executeUpdate();
        }
    }

    public List<Map<String, Object>> getHistoriqueDistributions() throws Exception {
        List<Map<String, Object>> liste = new ArrayList<>();
        String sql = "SELECT d.*, mat.designation, m.nom, m.prenom " +
                     "FROM distribution_materiel d " +
                     "JOIN materiel mat ON d.materiel_id = mat.id " +
                     "JOIN membre m ON d.membre_id = m.id " +
                     "ORDER BY d.date_distribution DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> row = new LinkedHashMap<>();
                row.put("designation", rs.getString("designation"));
                row.put("membre", rs.getString("prenom") + " " + rs.getString("nom"));
                row.put("quantite", rs.getInt("quantite"));
                row.put("date", rs.getString("date_distribution"));
                liste.add(row);
            }
        }
        return liste;
    }

    public int countStock() throws Exception {
        String sql = "SELECT COUNT(*) FROM materiel";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }
}