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

@WebServlet("/modifierEquipe")
public class ModifierEquipeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Equipe equipe = new EquipeDAO().getEquipeById(id);
            List<?> membres = new MembreDAO().getAllMembres();

            request.setAttribute("equipe", equipe);
            request.setAttribute("membres", membres);

            request.getRequestDispatcher("modifierEquipe.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Erreur chargement équipe : " + e.getMessage(), e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            Equipe e = new Equipe();
            e.setId(Integer.parseInt(request.getParameter("id")));
            e.setNom(request.getParameter("nom"));
            e.setDescription(request.getParameter("description"));

            String chefIdStr = request.getParameter("chefId");
            if (chefIdStr != null && !chefIdStr.isEmpty()) {
                e.setChefId(Integer.parseInt(chefIdStr));
            }

            new EquipeDAO().modifierEquipe(e);
        } catch (Exception ex) {
            throw new ServletException("Erreur modification équipe : " + ex.getMessage(), ex);
        }

        response.sendRedirect("listeEquipes");
    }
}
