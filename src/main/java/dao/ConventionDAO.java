package dao;

import model.Convention;
import java.sql.*;
import java.util.*;

public class ConventionDAO {

    public void ajouter(Convention c) throws Exception {
        String sql = "INSERT INTO convention (titre, partenaire, type_convention, date_signature, date_fin, description) VALUES (?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, c.getTitre());
            ps.setString(2, c.getPartenaire());
            ps.setString(3, c.getTypeConvention());
            ps.setString(4, c.getDateSignature());
            ps.setString(5, c.getDateFin());
            ps.setString(6, c.getDescription());
            ps.executeUpdate();
        }
    }

    public List<Convention> listerToutes() throws Exception {
        List<Convention> liste = new ArrayList<>();
        String sql = "SELECT * FROM convention ORDER BY date_signature DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Convention c = new Convention();
                c.setId(rs.getInt("id"));
                c.setTitre(rs.getString("titre"));
                c.setPartenaire(rs.getString("partenaire"));
                c.setTypeConvention(rs.getString("type_convention"));
                c.setDateSignature(rs.getString("date_signature"));
                c.setDateFin(rs.getString("date_fin"));
                c.setDescription(rs.getString("description"));
                c.setDocumentPath(rs.getString("document_path"));
                liste.add(c);
            }
        }
        return liste;
    }

    public void supprimer(int id) throws Exception {
        String sql = "DELETE FROM convention WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public int compter() throws Exception {
        String sql = "SELECT COUNT(*) FROM convention";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }
}