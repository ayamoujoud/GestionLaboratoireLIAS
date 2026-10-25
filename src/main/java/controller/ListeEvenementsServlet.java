package controller;

import java.io.IOException;
import java.util.List;

import dao.EvenementDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Evenement;

@WebServlet("/listeEvenements")
public class ListeEvenementsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EvenementDAO dao = new EvenementDAO();

        List<Evenement> evenements = dao.getAllEvenements();

        request.setAttribute("evenements", evenements);

        // Visiteur depuis la page d'accueil → page publique
        if ("public".equals(request.getParameter("mode"))) {
            request.getRequestDispatcher("/WEB-INF/activites.jsp")
                   .forward(request, response);
            return;
        }

        request.getRequestDispatcher("listEvenement.jsp")
               .forward(request, response);
    }
}