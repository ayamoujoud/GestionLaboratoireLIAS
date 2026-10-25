package controller;

import dao.*;
import model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/recherche")
public class RechercheServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String q = request.getParameter("q");
        if (q == null) q = "";
        q = q.trim();

        request.setAttribute("q", q);
        request.setAttribute("currentPage", "recherche");

        if (!q.isEmpty()) {
            try {
                String terme = "%" + q + "%";
                Connection conn = DBConnection.getConnection();

                // Recherche membres
                List<Membre> membres = new ArrayList<>();
                PreparedStatement ps = conn.prepareStatement(
                    "SELECT * FROM membre WHERE nom LIKE ? OR prenom LIKE ? OR email LIKE ? LIMIT 10");
                ps.setString(1, terme); ps.setString(2, terme); ps.setString(3, terme);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Membre m = new Membre();
                    m.setId(rs.getInt("id"));
                    m.setNom(rs.getString("nom"));
                    m.setPrenom(rs.getString("prenom"));
                    m.setEmail(rs.getString("email"));
                    m.setStatut(rs.getString("statut"));
                    m.setEquipe(rs.getString("equipe"));
                    membres.add(m);
                }

                // Recherche publications
                List<Publication> publications = new ArrayList<>();
                ps = conn.prepareStatement(
                    "SELECT * FROM publication WHERE titre LIKE ? OR auteur LIKE ? LIMIT 10");
                ps.setString(1, terme); ps.setString(2, terme);
                rs = ps.executeQuery();
                while (rs.next()) {
                    Publication p = new Publication();
                    p.setId(rs.getInt("id"));
                    p.setTitre(rs.getString("titre"));
                    p.setAuteur(rs.getString("auteur"));
                    p.setAnnee(rs.getInt("annee"));
                    p.setType(rs.getString("type"));
                    publications.add(p);
                }

                // Recherche événements
                List<Evenement> evenements = new ArrayList<>();
                ps = conn.prepareStatement(
                    "SELECT * FROM evenement WHERE titre LIKE ? OR lieu LIKE ? LIMIT 10");
                ps.setString(1, terme); ps.setString(2, terme);
                rs = ps.executeQuery();
                while (rs.next()) {
                    Evenement e = new Evenement();
                    e.setId(rs.getInt("id"));
                    e.setTitre(rs.getString("titre"));
                    e.setType(rs.getString("type"));
                    e.setLieu(rs.getString("lieu"));
                    e.setDateDebut(rs.getString("date_debut"));
                    evenements.add(e);
                }

                // Recherche documents
                List<Map<String,String>> documents = new ArrayList<>();
                ps = conn.prepareStatement(
                    "SELECT * FROM document WHERE titre LIKE ? OR type LIKE ? LIMIT 10");
                ps.setString(1, terme); ps.setString(2, terme);
                rs = ps.executeQuery();
                while (rs.next()) {
                    Map<String,String> doc = new LinkedHashMap<>();
                    doc.put("id", String.valueOf(rs.getInt("id")));
                    doc.put("titre", rs.getString("titre"));
                    doc.put("type", rs.getString("type"));
                    doc.put("chemin", rs.getString("chemin_fichier"));
                    documents.add(doc);
                }

                request.setAttribute("resMembres", membres);
                request.setAttribute("resPublications", publications);
                request.setAttribute("resEvenements", evenements);
                request.setAttribute("resDocuments", documents);

                int total = membres.size() + publications.size() + evenements.size() + documents.size();
                request.setAttribute("totalResultats", total);

            } catch (Exception e) {
                throw new ServletException(e);
            }
        }

        request.getRequestDispatcher("/recherche.jsp").forward(request, response);
    }
}