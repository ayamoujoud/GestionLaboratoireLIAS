package dao;

import java.sql.*;
import java.util.*;

public class DocumentDAO {

    public void ajouter(String titre, String type, String cheminFichier,
                        Integer evenementId, int uploadedPar) throws Exception {
        String sql = "INSERT INTO document (titre, type, chemin_fichier, evenement_id, uploaded_par) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, titre);
            ps.setString(2, type);
            ps.setString(3, cheminFichier);
            if (evenementId != null) {
                ps.setInt(4, evenementId);
            } else {
                ps.setNull(4, java.sql.Types.INTEGER);
            }
            ps.setInt(5, uploadedPar);
            ps.executeUpdate();
        }
    }

    public List<Map<String, Object>> listerTous() throws Exception {
        List<Map<String, Object>> liste = new ArrayList<>();
        String sql = "SELECT d.*, m.nom, m.prenom FROM document d " +
                     "LEFT JOIN membre m ON d.uploaded_par = m.id " +
                     "ORDER BY d.id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> doc = new LinkedHashMap<>();
                doc.put("id", rs.getInt("id"));
                doc.put("titre", rs.getString("titre"));
                doc.put("type", rs.getString("type"));
                doc.put("cheminFichier", rs.getString("chemin_fichier"));
                doc.put("evenementId", rs.getObject("evenement_id"));
                doc.put("uploadedPar", rs.getInt("uploaded_par"));
                doc.put("nomUploaded", rs.getString("prenom") + " " + rs.getString("nom"));
                liste.add(doc);
            }
        }
        return liste;
    }

    public List<Map<String, Object>> listerParEvenement(int evenementId) throws Exception {
        List<Map<String, Object>> liste = new ArrayList<>();
        String sql = "SELECT d.*, m.nom, m.prenom FROM document d " +
                     "LEFT JOIN membre m ON d.uploaded_par = m.id " +
                     "WHERE d.evenement_id = ? ORDER BY d.id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, evenementId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> doc = new LinkedHashMap<>();
                doc.put("id", rs.getInt("id"));
                doc.put("titre", rs.getString("titre"));
                doc.put("type", rs.getString("type"));
                doc.put("cheminFichier", rs.getString("chemin_fichier"));
                doc.put("nomUploaded", rs.getString("prenom") + " " + rs.getString("nom"));
                liste.add(doc);
            }
        }
        return liste;
    }
}