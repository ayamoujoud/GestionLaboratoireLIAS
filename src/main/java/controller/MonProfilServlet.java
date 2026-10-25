package controller;

import dao.HistoriqueAffiliationDAO;
import dao.MembreDAO;
import model.Membre;
import model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/monProfil")
public class MonProfilServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Utilisateur user    = (Utilisateur) session.getAttribute("user");

        if (user == null) { response.sendRedirect("login.jsp"); return; }

        try {
            MembreDAO membreDAO = new MembreDAO();
            Membre membre = membreDAO.getMembreById(user.getId());
            request.setAttribute("membre", membre);

            // Charger l'historique des affiliations
            HistoriqueAffiliationDAO histDAO = new HistoriqueAffiliationDAO();
            request.setAttribute("historiqueAffiliation", histDAO.getParMembre(membre.getId()));

        } catch (Exception e) {
            throw new ServletException(e);
        }

        request.getRequestDispatcher("/monProfil.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Utilisateur user    = (Utilisateur) session.getAttribute("user");

        if (user == null) { response.sendRedirect("login.jsp"); return; }

        MembreDAO dao = new MembreDAO();
        Membre m = dao.getMembreById(user.getId());

        m.setBiographie(request.getParameter("biographie"));
        m.setCentresInteret(request.getParameter("centresInteret"));
        m.setEtablissement(request.getParameter("etablissement"));
        m.setLaboratoireOrigine(request.getParameter("laboratoireOrigine"));

        dao.modifierMembre(m);
        response.sendRedirect("monProfil");
    }
}