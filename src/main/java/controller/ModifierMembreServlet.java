package controller;

import java.io.IOException;

import dao.MembreDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Membre;

@WebServlet("/modifierMembre")
public class ModifierMembreServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        MembreDAO dao = new MembreDAO();
        Membre m = dao.getMembreById(id);

        request.setAttribute("membre", m);
        request.getRequestDispatcher("modifierMembre.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Membre m = new Membre();

        m.setId(Integer.parseInt(request.getParameter("id")));
        m.setNom(request.getParameter("nom"));
        m.setPrenom(request.getParameter("prenom"));
        m.setEmail(request.getParameter("email"));
        m.setStatut(request.getParameter("statut"));
        m.setEtablissement(request.getParameter("etablissement"));
        m.setLaboratoireOrigine(request.getParameter("laboratoireOrigine"));
        m.setBiographie(request.getParameter("biographie"));
        m.setCentresInteret(request.getParameter("centresInteret"));
        m.setEquipe(request.getParameter("equipe"));

        MembreDAO dao = new MembreDAO();
        dao.modifierMembre(m);

        response.sendRedirect("listeMembres");
    }
}