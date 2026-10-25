package controller;

import java.io.IOException;

import dao.EquipeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/supprimerEquipe")
public class SupprimerEquipeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            new EquipeDAO().supprimerEquipe(id);
        } catch (Exception e) {
            throw new ServletException("Erreur suppression équipe : " + e.getMessage(), e);
        }

        response.sendRedirect("listeEquipes");
    }
}
