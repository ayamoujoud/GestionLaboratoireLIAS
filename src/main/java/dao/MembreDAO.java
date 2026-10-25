package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Membre;

public class MembreDAO {

    Connection con = DBConnection.getConnection();

    public void ajouterMembre(Membre m) {

        try {

            String sql = "INSERT INTO membre(nom, prenom, email, statut, etablissement, laboratoire_origine, biographie, centres_interet, equipe) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, m.getNom());
            ps.setString(2, m.getPrenom());
            ps.setString(3, m.getEmail());
            ps.setString(4, m.getStatut());
            ps.setString(5, m.getEtablissement());
            ps.setString(6, m.getLaboratoireOrigine());
            ps.setString(7, m.getBiographie());
            ps.setString(8, m.getCentresInteret());
            ps.setString(9, m.getEquipe());
            ps.executeUpdate();

            System.out.println("Membre ajouté");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public List<Membre> getAllMembres() {
        List<Membre> liste = new ArrayList<>();

        try {
            String sql = "SELECT * FROM membre";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Membre m = new Membre();

                m.setId(rs.getInt("id"));
                m.setNom(rs.getString("nom"));
                m.setPrenom(rs.getString("prenom"));
                m.setEmail(rs.getString("email"));
                m.setStatut(rs.getString("statut"));
                m.setEtablissement(rs.getString("etablissement"));
                m.setLaboratoireOrigine(rs.getString("laboratoire_origine"));
                m.setBiographie(rs.getString("biographie"));
                m.setCentresInteret(rs.getString("centres_interet"));
                m.setEquipe(rs.getString("equipe"));
                liste.add(m);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return liste;
    }
    public void supprimerMembre(int id) {
        try {
            String sql = "UPDATE membre SET statut='ANCIEN' WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();

            System.out.println("Membre désactivé");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public Membre getMembreById(int id) {

        Membre m = new Membre();

        try {

            String sql = "SELECT * FROM membre WHERE id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){

                m.setId(rs.getInt("id"));
                m.setNom(rs.getString("nom"));
                m.setPrenom(rs.getString("prenom"));
                m.setEmail(rs.getString("email"));
                m.setStatut(rs.getString("statut"));

                m.setEtablissement(rs.getString("etablissement"));
                m.setLaboratoireOrigine(rs.getString("laboratoire_origine"));
                m.setBiographie(rs.getString("biographie"));
                m.setCentresInteret(rs.getString("centres_interet"));
                m.setEquipe(rs.getString("equipe"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return m;
    }
    public void modifierMembre(Membre m) {

        try {

            String sql = "UPDATE membre SET nom=?, prenom=?, email=?, statut=?, etablissement=?, laboratoire_origine=?, biographie=?, centres_interet=?, equipe=? WHERE id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, m.getNom());
            ps.setString(2, m.getPrenom());
            ps.setString(3, m.getEmail());
            ps.setString(4, m.getStatut());
            ps.setString(5, m.getEtablissement());
            ps.setString(6, m.getLaboratoireOrigine());
            ps.setString(7, m.getBiographie());
            ps.setString(8, m.getCentresInteret());
            ps.setString(9, m.getEquipe());
            ps.setInt(10, m.getId());

            ps.executeUpdate();

            System.out.println("Membre modifié");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public int countMembres() {
        int count = 0;

        try {
            String sql = "SELECT COUNT(*) FROM membre";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }
    public List<Membre> listerActifs() throws Exception {

        List<Membre> liste = new ArrayList<>();

        // Exclure les membres dont le statut est ANCIEN
        String sql = "SELECT * FROM membre WHERE statut <> 'ANCIEN'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Membre m = new Membre();

                m.setId(rs.getInt("id"));
                m.setNom(rs.getString("nom"));
                m.setPrenom(rs.getString("prenom"));
                m.setEmail(rs.getString("email"));
                m.setStatut(rs.getString("statut"));
                m.setEtablissement(rs.getString("etablissement"));
                m.setEquipe(rs.getString("equipe"));

                liste.add(m);
            }
        }

        return liste;
    }
    public int compter() throws Exception {

        String sql = "SELECT COUNT(*) FROM membre";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        }

        return 0;
    }
}
