package dao;

import model.Equipe;
import java.sql.*;
import java.util.*;

public class EquipeDAO {

    public void ajouterEquipe(Equipe e) throws SQLException {
        String sql = "INSERT INTO equipe (nom, description, chef_id, date_creation) VALUES (?,?,?,CURDATE())";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, e.getNom());
            ps.setString(2, e.getDescription());
            if (e.getChefId() > 0) ps.setInt(3, e.getChefId());
            else ps.setNull(3, Types.INTEGER);
            ps.executeUpdate();

            ResultSet keys = ps.getGeneratedKeys();
            int equipeId = -1;
            if (keys.next()) {
                equipeId = keys.getInt(1);
            }

            // Si un chef est désigné dès la création, on ouvre son mandat
            if (e.getChefId() > 0 && equipeId > 0) {
                ouvrirMandatChef(e.getChefId(), e.getNom());
            }
        }
    }

    public List<Equipe> getAllEquipes() throws SQLException {
        List<Equipe> liste = new ArrayList<>();

        // Nombre de membres = compte des membres dont le champ "equipe" correspond
        // au nom de l'équipe (le rattachement membre <-> équipe se fait par nom,
        // comme le reste du projet utilise déjà membre.equipe en VARCHAR).
        String sql = "SELECT eq.*, m.nom AS nom_chef, m.prenom AS prenom_chef, " +
                     "(SELECT COUNT(*) FROM membre mb WHERE mb.equipe = eq.nom) AS nb_membres " +
                     "FROM equipe eq " +
                     "LEFT JOIN membre m ON eq.chef_id = m.id " +
                     "ORDER BY eq.nom";

        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                liste.add(mapRow(rs));
            }
        }
        return liste;
    }

    public Equipe getEquipeById(int id) throws SQLException {
        Equipe e = new Equipe();
        String sql = "SELECT eq.*, m.nom AS nom_chef, m.prenom AS prenom_chef, " +
                     "(SELECT COUNT(*) FROM membre mb WHERE mb.equipe = eq.nom) AS nb_membres " +
                     "FROM equipe eq " +
                     "LEFT JOIN membre m ON eq.chef_id = m.id " +
                     "WHERE eq.id = ?";

        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                e = mapRow(rs);
            }
        }
        return e;
    }

    public void modifierEquipe(Equipe e) throws SQLException {
        // On récupère l'ancien chef pour savoir si le chef a changé
        Equipe ancienne = getEquipeById(e.getId());
        boolean chefChange = ancienne.getChefId() != e.getChefId();

        String sql = "UPDATE equipe SET nom=?, description=?, chef_id=? WHERE id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, e.getNom());
            ps.setString(2, e.getDescription());
            if (e.getChefId() > 0) ps.setInt(3, e.getChefId());
            else ps.setNull(3, Types.INTEGER);
            ps.setInt(4, e.getId());
            ps.executeUpdate();
        }

        // Si le chef a changé, on clôture l'ancien mandat et on ouvre le nouveau
        // (l'historique des mandats est conservé, rien n'est supprimé - §7 du
        // cahier des charges : "aucun changement ne supprime les données").
        if (chefChange && e.getChefId() > 0) {
            ouvrirMandatChef(e.getChefId(), e.getNom());
        }
    }

    public void supprimerEquipe(int id) throws SQLException {
        String sql = "DELETE FROM equipe WHERE id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public int countEquipes() throws SQLException {
        String sql = "SELECT COUNT(*) FROM equipe";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    /**
     * Clôture le mandat "CHEF_EQUIPE" actif précédent pour cette équipe
     * (s'il existe) et ouvre un nouveau mandat pour le nouveau chef.
     * Utilise la même table "mandat" que la gouvernance du laboratoire,
     * avec equipe = nom de l'équipe.
     */
    private void ouvrirMandatChef(int nouveauChefId, String nomEquipe) throws SQLException {
        String sqlCloture = "UPDATE mandat SET actif=false, date_fin=CURDATE() " +
                             "WHERE role='CHEF_EQUIPE' AND equipe=? AND actif=true";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sqlCloture)) {
            ps.setString(1, nomEquipe);
            ps.executeUpdate();
        }

        String sqlInsert = "INSERT INTO mandat (membre_id, role, equipe, date_debut, actif) " +
                            "VALUES (?, 'CHEF_EQUIPE', ?, CURDATE(), true)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sqlInsert)) {
            ps.setInt(1, nouveauChefId);
            ps.setString(2, nomEquipe);
            ps.executeUpdate();
        }
    }

    private Equipe mapRow(ResultSet rs) throws SQLException {
        Equipe e = new Equipe();
        e.setId(rs.getInt("id"));
        e.setNom(rs.getString("nom"));
        e.setDescription(rs.getString("description"));
        e.setChefId(rs.getInt("chef_id"));
        e.setNomChef(rs.getString("nom_chef"));
        e.setPrenomChef(rs.getString("prenom_chef"));
        e.setDateCreation(rs.getString("date_creation"));
        e.setNbMembres(rs.getInt("nb_membres"));
        return e;
    }
}
