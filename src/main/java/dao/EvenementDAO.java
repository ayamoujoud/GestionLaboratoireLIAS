package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Evenement;

public class EvenementDAO {

    public void ajouterEvenement(Evenement e) {
        String sql = "INSERT INTO evenement(titre, type, lieu, date_debut, date_fin) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, e.getTitre());
            ps.setString(2, e.getType());
            ps.setString(3, e.getLieu());
            ps.setString(4, e.getDateDebut());
            ps.setString(5, e.getDateFin());

            ps.executeUpdate();
            System.out.println("Événement ajouté");

        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public List<Evenement> getAllEvenements() {
        List<Evenement> liste = new ArrayList<>();
        String sql = "SELECT * FROM evenement";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Evenement e = new Evenement();
                e.setId(rs.getInt("id"));
                e.setTitre(rs.getString("titre"));
                e.setType(rs.getString("type"));
                e.setLieu(rs.getString("lieu"));
                e.setDateDebut(rs.getString("date_debut"));
                e.setDateFin(rs.getString("date_fin"));
                liste.add(e);
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return liste;
    }

    public Evenement getEvenementById(int id) {
        Evenement e = new Evenement();
        String sql = "SELECT * FROM evenement WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                e.setId(rs.getInt("id"));
                e.setTitre(rs.getString("titre"));
                e.setType(rs.getString("type"));
                e.setLieu(rs.getString("lieu"));
                e.setDateDebut(rs.getString("date_debut"));
                e.setDateFin(rs.getString("date_fin"));
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return e;
    }

    public void supprimerEvenement(int id) {
        String sql = "DELETE FROM evenement WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
            System.out.println("Événement supprimé");

        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public void modifierEvenement(Evenement e) {
        String sql = "UPDATE evenement SET titre=?, type=?, lieu=?, date_debut=?, date_fin=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, e.getTitre());
            ps.setString(2, e.getType());
            ps.setString(3, e.getLieu());
            ps.setString(4, e.getDateDebut());
            ps.setString(5, e.getDateFin());
            ps.setInt(6, e.getId());

            ps.executeUpdate();
            System.out.println("Événement modifié");

        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public int countEvenements() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM evenement";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) count = rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public List<Evenement> listerParAnnee(int annee) throws Exception {
        List<Evenement> liste = new ArrayList<>();
        String sql = "SELECT * FROM evenement WHERE YEAR(date_debut)=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, annee);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Evenement e = new Evenement();
                e.setId(rs.getInt("id"));
                e.setTitre(rs.getString("titre"));
                liste.add(e);
            }
        }

        return liste;
    }
}