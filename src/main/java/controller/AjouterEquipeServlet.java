package controller;

import java.io.IOException;

import dao.EquipeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Equipe;

@WebServlet("/ajouterEquipe")
public class AjouterEquipeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String nom = request.getParameter("nom");
        String description = request.getParameter("description");
        String chefIdStr = request.getParameter("chefId");

        Equipe e = new Equipe();
        e.setNom(nom);
        e.setDescription(description);

        if (chefIdStr != null && !chefIdStr.isEmpty()) {
            try {
                e.setChefId(Integer.parseInt(chefIdStr));
            } catch (NumberFormatException ignored) {
            }
        }

        try {
            new EquipeDAO().ajouterEquipe(e);
        } catch (Exception ex) {
            throw new ServletException("Erreur ajout équipe : " + ex.getMessage(), ex);
        }

        response.sendRedirect("listeEquipes");
    }
}
