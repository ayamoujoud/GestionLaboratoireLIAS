package dao;

import model.DemandeAdhesion;
import java.sql.*;
import java.util.*;

public class DemandeAdhesionDAO {

    public void soumettre(DemandeAdhesion d) throws SQLException {
        String sql = "INSERT INTO demande_adhesion "
                + "(nom, prenom, email, etablissement, motivation, statut) "
                + "VALUES (?, ?, ?, ?, ?, 'EN_ATTENTE')";

        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, d.getNom());
            ps.setString(2, d.getPrenom());
            ps.setString(3, d.getEmail());
            ps.setString(4, d.getEtablissement());
            ps.setString(5, d.getMotivation());

            ps.executeUpdate();
        }
    }

    public List<DemandeAdhesion> listerEnAttente() throws SQLException {
        List<DemandeAdhesion> liste = new ArrayList<>();

        String sql = "SELECT * FROM demande_adhesion "
                + "WHERE statut = 'EN_ATTENTE' "
                + "ORDER BY date_demande DESC";

        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                DemandeAdhesion d = new DemandeAdhesion();

                d.setId(rs.getInt("id"));
                d.setNom(rs.getString("nom"));
                d.setPrenom(rs.getString("prenom"));
                d.setEmail(rs.getString("email"));
                d.setEtablissement(rs.getString("etablissement"));
                d.setMotivation(rs.getString("motivation"));
                d.setStatut(rs.getString("statut"));

                liste.add(d);
            }
        }

        return liste;
    }

    public void traiter(int id, String decision, int adminId) throws SQLException {

        if (!"ACCEPTE".equals(decision) && !"REFUSE".equals(decision)) {
            throw new SQLException("Décision invalide : " + decision);
        }

        Connection c = null;

        try {
            c = DBConnection.getConnection();
            c.setAutoCommit(false);

            String sqlUpdate = "UPDATE demande_adhesion "
                    + "SET statut = ?, traitee_par = ?, date_traitement = NOW() "
                    + "WHERE id = ?";

            try (PreparedStatement ps = c.prepareStatement(sqlUpdate)) {
                ps.setString(1, decision);
                ps.setInt(2, adminId);
                ps.setInt(3, id);
                ps.executeUpdate();
            }

            if ("ACCEPTE".equals(decision)) {
                creerCompteMembre(c, id);
            }

            c.commit();

        } catch (Exception e) {
            if (c != null) {
                c.rollback();
            }
            throw new SQLException(e);
        } finally {
            if (c != null) {
                c.setAutoCommit(true);
                c.close();
            }
        }
    }

    private void creerCompteMembre(Connection c, int demandeId) throws SQLException {

        String sqlSelect = "SELECT * FROM demande_adhesion WHERE id = ?";

        try (PreparedStatement ps = c.prepareStatement(sqlSelect)) {

            ps.setInt(1, demandeId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                String nom = rs.getString("nom");
                String prenom = rs.getString("prenom");
                String email = rs.getString("email");
                String etablissement = rs.getString("etablissement");

                String checkSql = "SELECT id FROM utilisateur WHERE email = ?";
                try (PreparedStatement check = c.prepareStatement(checkSql)) {
                    check.setString(1, email);
                    ResultSet exist = check.executeQuery();

                    if (exist.next()) {
                        throw new SQLException("Un utilisateur existe déjà avec cet email : " + email);
                    }
                }

                String insertMembre = "INSERT INTO membre "
                        + "(nom, prenom, email, etablissement, laboratoire_origine, "
                        + "type_membre, role_gouvernance, etat_compte, date_entree) "
                        + "VALUES (?, ?, ?, ?, ?, 'PERMANENT', 'MEMBRE', 'ACTIF', CURDATE())";

                int membreId;

                try (PreparedStatement psMembre =
                             c.prepareStatement(insertMembre, Statement.RETURN_GENERATED_KEYS)) {

                    psMembre.setString(1, nom);
                    psMembre.setString(2, prenom);
                    psMembre.setString(3, email);
                    psMembre.setString(4, etablissement);
                    psMembre.setString(5, etablissement);

                    psMembre.executeUpdate();

                    ResultSet keys = psMembre.getGeneratedKeys();

                    if (keys.next()) {
                        membreId = keys.getInt(1);
                    } else {
                        throw new SQLException("Impossible de récupérer l'id du membre créé.");
                    }
                }

                String motDePasseTemp = "Lias" + nom + "2026";

                String insertUser = "INSERT INTO utilisateur "
                        + "(email, mot_de_passe, role, etat_compte, type_membre, membre_id) "
                        + "VALUES (?, ?, 'MEMBRE', 'ACTIF', 'PERMANENT', ?)";

                try (PreparedStatement psUser = c.prepareStatement(insertUser)) {
                    psUser.setString(1, email);
                    psUser.setString(2, motDePasseTemp);
                    psUser.setInt(3, membreId);
                    psUser.executeUpdate();
                }

                System.out.println("Compte créé pour : " + email);
                System.out.println("Mot de passe temporaire : " + motDePasseTemp);
            }
        }
    }
}