package dao;

import model.BesoinMateriel;
import java.sql.*;
import java.util.*;

public class BesoinMaterielDAO {

    // Soumettre un besoin
    public void soumettre(BesoinMateriel b) throws Exception {
        String sql = "INSERT INTO besoin_materiel (membre_id, description, quantite, statut) " +
                     "VALUES (?, ?, ?, 'en_attente')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, b.getMembreId());
            ps.setString(2, b.getDescription());
            ps.setInt(3, b.getQuantite());
            ps.executeUpdate();
        }
    }

    // Lister tous les besoins (admin)
    public List<BesoinMateriel> listerTous() throws Exception {
        List<BesoinMateriel> liste = new ArrayList<>();
        String sql = "SELECT b.*, CONCAT(m.prenom,' ',m.nom) as nom_membre " +
                     "FROM besoin_materiel b " +
                     "JOIN membre m ON b.membre_id = m.id " +
                     "ORDER BY b.date_demande DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                liste.add(mapper(rs));
            }
        }
        return liste;
    }

    // Lister les besoins d'un membre
    public List<BesoinMateriel> listerParMembre(int membreId) throws Exception {
        List<BesoinMateriel> liste = new ArrayList<>();
        String sql = "SELECT b.*, CONCAT(m.prenom,' ',m.nom) as nom_membre " +
                     "FROM besoin_materiel b " +
                     "JOIN membre m ON b.membre_id = m.id " +
                     "WHERE b.membre_id = ? ORDER BY b.date_demande DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, membreId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                liste.add(mapper(rs));
            }
        }
        return liste;
    }

    // Valider ou refuser un besoin
    public void traiter(int id, String decision, int traitePar) throws Exception {
        String sql = "UPDATE besoin_materiel " +
                     "SET statut=?, traite_par=?, date_traitement=NOW() WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, decision);
            ps.setInt(2, traitePar);
            ps.setInt(3, id);
            ps.executeUpdate();
        }
    }

    // Compter les besoins en attente
    public int countEnAttente() throws Exception {
        String sql = "SELECT COUNT(*) FROM besoin_materiel WHERE statut='en_attente'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    private BesoinMateriel mapper(ResultSet rs) throws SQLException {
        BesoinMateriel b = new BesoinMateriel();
        b.setId(rs.getInt("id"));
        b.setMembreId(rs.getInt("membre_id"));
        b.setNomMembre(rs.getString("nom_membre"));
        b.setDescription(rs.getString("description"));
        b.setQuantite(rs.getInt("quantite"));
        b.setStatut(rs.getString("statut"));
        b.setDateDemande(rs.getString("date_demande"));
        b.setDateTraitement(rs.getString("date_traitement"));
        return b;
    }
}