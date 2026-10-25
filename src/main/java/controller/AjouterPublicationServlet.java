package controller;

import java.io.IOException;

import dao.PublicationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Publication;

@WebServlet("/ajouterPublication")
public class AjouterPublicationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Publication p = new Publication();

        p.setTitre(request.getParameter("titre"));
        p.setAuteur(request.getParameter("auteur"));
        p.setAnnee(Integer.parseInt(request.getParameter("annee")));
        p.setEquipe(request.getParameter("equipe"));
        p.setType(request.getParameter("type"));

        PublicationDAO dao = new PublicationDAO();
        dao.ajouterPublication(p);

        response.sendRedirect("listePublications");
    }
}