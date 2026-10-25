package dao;

import model.Mandat;
import java.sql.*;
import java.util.*;

public class MandatDAO {

    public void ajouterMandat(Mandat m) throws Exception {
        // Clôturer l'ancien mandat actif du même rôle
        String sqlCloture = "UPDATE mandat SET actif=false, date_fin=? WHERE role=? AND actif=true";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sqlCloture)) {
            ps.setString(1, m.getDateDebut());
            ps.setString(2, m.getRole());
            ps.executeUpdate();
        }
        // Créer le nouveau mandat
        String sql = "INSERT INTO mandat (membre_id, role, equipe, date_debut, actif) VALUES (?,?,?,?,true)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, m.getMembreId());
            ps.setString(2, m.getRole());
            ps.setString(3, m.getEquipe());
            ps.setString(4, m.getDateDebut());
            ps.executeUpdate();
        }
    }

    public List<Mandat> getMandatsActifs() throws Exception {
        List<Mandat> liste = new ArrayList<>();
        String sql = "SELECT man.*, mem.nom, mem.prenom FROM mandat man " +
                     "JOIN membre mem ON man.membre_id = mem.id WHERE man.actif=true ORDER BY man.role";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Mandat m = new Mandat();
                m.setId(rs.getInt("id"));
                m.setMembreId(rs.getInt("membre_id"));
                m.setNomMembre(rs.getString("nom"));
                m.setPrenomMembre(rs.getString("prenom"));
                m.setRole(rs.getString("role"));
                m.setEquipe(rs.getString("equipe"));
                m.setDateDebut(rs.getString("date_debut"));
                m.setActif(true);
                liste.add(m);
            }
        }
        return liste;
    }

    public List<Mandat> getHistorique() throws Exception {
        List<Mandat> liste = new ArrayList<>();
        String sql = "SELECT man.*, mem.nom, mem.prenom FROM mandat man " +
                     "JOIN membre mem ON man.membre_id = mem.id ORDER BY man.date_debut DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Mandat m = new Mandat();
                m.setId(rs.getInt("id"));
                m.setMembreId(rs.getInt("membre_id"));
                m.setNomMembre(rs.getString("nom"));
                m.setPrenomMembre(rs.getString("prenom"));
                m.setRole(rs.getString("role"));
                m.setEquipe(rs.getString("equipe"));
                m.setDateDebut(rs.getString("date_debut"));
                m.setDateFin(rs.getString("date_fin"));
                m.setActif(rs.getBoolean("actif"));
                liste.add(m);
            }
        }
        return liste;
    }
}