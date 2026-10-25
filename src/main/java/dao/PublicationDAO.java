package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Publication;

public class PublicationDAO {

    Connection con = DBConnection.getConnection();

    public void ajouterPublication(Publication p) {

        try {

            String sql = "INSERT INTO publication(titre, auteur, annee, equipe, type) VALUES (?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, p.getTitre());
            ps.setString(2, p.getAuteur());
            ps.setInt(3, p.getAnnee());
            ps.setString(4, p.getEquipe());
            ps.setString(5, p.getType());

            ps.executeUpdate();

            System.out.println("Publication ajoutée");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Publication> getAllPublications() {

        List<Publication> liste = new ArrayList<>();

        try {

            String sql = "SELECT * FROM publication";

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){

                Publication p = new Publication();

                p.setId(rs.getInt("id"));
                p.setTitre(rs.getString("titre"));
                p.setAuteur(rs.getString("auteur"));
                p.setAnnee(rs.getInt("annee"));
                p.setEquipe(rs.getString("equipe"));
                p.setType(rs.getString("type"));

                liste.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return liste;
    }
    public void supprimerPublication(int id) {
        try {
            String sql = "DELETE FROM publication WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();

            System.out.println("Publication supprimée");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public Publication getPublicationById(int id) {

        Publication p = new Publication();

        try {

            String sql = "SELECT * FROM publication WHERE id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){

                p.setId(rs.getInt("id"));
                p.setTitre(rs.getString("titre"));
                p.setAuteur(rs.getString("auteur"));
                p.setAnnee(rs.getInt("annee"));
                p.setEquipe(rs.getString("equipe"));
                p.setType(rs.getString("type"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return p;
    }
    public void modifierPublication(Publication p) {

        try {

            String sql = "UPDATE publication SET titre=?, auteur=?, annee=?, equipe=?, type=? WHERE id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, p.getTitre());
            ps.setString(2, p.getAuteur());
            ps.setInt(3, p.getAnnee());
            ps.setString(4, p.getEquipe());
            ps.setString(5, p.getType());
            ps.setInt(6, p.getId());

            ps.executeUpdate();

            System.out.println("Publication modifiée");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public int countPublications() {
        int count = 0;

        try {
            String sql = "SELECT COUNT(*) FROM publication";
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
    public List<Publication> listerParAnnee(int annee) throws Exception {
        List<Publication> liste = new ArrayList<>();
        String sql = "SELECT * FROM publication WHERE annee = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, annee);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Publication p = new Publication();
                p.setId(rs.getInt("id"));
                p.setTitre(rs.getString("titre"));
                p.setAuteur(rs.getString("auteur"));
                p.setAnnee(rs.getInt("annee"));
                p.setEquipe(rs.getString("equipe"));
                p.setType(rs.getString("type"));
                liste.add(p);
            }
        }
        return liste;
    }
}