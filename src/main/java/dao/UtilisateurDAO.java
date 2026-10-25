package dao;

import java.sql.*;
import model.Utilisateur;

public class UtilisateurDAO {

    Connection con = DBConnection.getConnection();

    public Utilisateur login(String email, String motDePasse) {
        Utilisateur u = null;
        try {
            String sql = "SELECT u.*, m.statut as statut_membre, m.etat_compte " +
                         "FROM utilisateur u " +
                         "LEFT JOIN membre m ON u.membre_id = m.id " +
                         "WHERE u.email = ? AND u.mot_de_passe = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, motDePasse);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Vérifier que le compte n'est pas gelé/désactivé
                String etatCompte = rs.getString("etat_compte");
                if ("gelé".equals(etatCompte) || "desactive".equals(etatCompte)) {
                    return null; // Compte bloqué
                }

                u = new Utilisateur();
                u.setId(rs.getInt("id"));
                u.setEmail(rs.getString("email"));
                u.setRole(rs.getString("role"));
                u.setStatut(rs.getString("statut_membre"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return u;
    }

    public void creer(String email, String motDePasseClair, String role, Integer membreId) throws Exception {
        String sql = "INSERT INTO utilisateur (email, mot_de_passe, role, membre_id) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, motDePasseClair);
            ps.setString(3, role);
            if (membreId != null) ps.setInt(4, membreId);
            else ps.setNull(4, Types.INTEGER);
            ps.executeUpdate();
        }
    }
}