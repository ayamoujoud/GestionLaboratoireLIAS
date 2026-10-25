package dao;

import model.ProcesVerbal;
import java.sql.*;
import java.util.*;

public class PVDAO {

    public void ajouter(ProcesVerbal pv) throws Exception {
        String sql = "INSERT INTO pv (date_reunion, ordre_du_jour, pv_path, cree_par) VALUES (?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, pv.getDateReunion());
            ps.setString(2, pv.getOrdreDuJour());
            ps.setString(3, pv.getPvPath());
            ps.setInt(4, pv.getCreePar());
            ps.executeUpdate();
        }
    }

    public List<ProcesVerbal> listerTous() throws Exception {
        List<ProcesVerbal> liste = new ArrayList<>();
        String sql = "SELECT pv.*, u.email as email_createur FROM pv pv " +
                "LEFT JOIN utilisateur u ON pv.cree_par = u.id " +
                "ORDER BY pv.date_reunion DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ProcesVerbal pv = new ProcesVerbal();
                pv.setId(rs.getInt("id"));
                pv.setDateReunion(rs.getString("date_reunion"));
                pv.setOrdreDuJour(rs.getString("ordre_du_jour"));
                pv.setPvPath(rs.getString("pv_path"));
                pv.setCreePar(rs.getInt("cree_par"));
                pv.setNomCreateur(rs.getString("email_createur"));
                pv.setDateUpload(rs.getString("date_upload"));
                liste.add(pv);
            }
        }
        return liste;
    }

    public void supprimer(int id) throws Exception {
        String sql = "DELETE FROM pv WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}