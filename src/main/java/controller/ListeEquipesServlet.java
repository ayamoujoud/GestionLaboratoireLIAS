package controller;

import java.io.IOException;
import java.util.List;

import dao.EquipeDAO;
import dao.MembreDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Equipe;

@WebServlet("/listeEquipes")
public class ListeEquipesServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            EquipeDAO dao = new EquipeDAO();
            List<Equipe> equipes = dao.getAllEquipes();
            request.setAttribute("equipes", equipes);

            // Visiteur depuis la page d'accueil → page publique (sans la liste des membres)
            if ("public".equals(request.getParameter("mode"))) {
                request.getRequestDispatcher("/WEB-INF/equipes_public.jsp")
                       .forward(request, response);
                return;
            }

            // Pour le formulaire d'ajout/modif : liste des membres pour choisir un chef
            request.setAttribute("membres", new MembreDAO().getAllMembres());

            request.getRequestDispatcher("listeEquipes.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Erreur chargement équipes : " + e.getMessage(), e);
        }
    }
}