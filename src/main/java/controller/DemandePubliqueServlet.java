package controller;

import dao.DemandeAdhesionDAO;
import model.DemandeAdhesion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(urlPatterns = {"/soumettreDemande", "/demandeAdhesion"})
public class DemandePubliqueServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/demandeAdhesion.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        DemandeAdhesion d = new DemandeAdhesion();
        d.setNom(request.getParameter("nom"));
        d.setPrenom(request.getParameter("prenom"));
        d.setEmail(request.getParameter("email"));
        d.setEtablissement(request.getParameter("etablissement"));
        d.setMotivation(request.getParameter("motivation"));

        try {
            new DemandeAdhesionDAO().soumettre(d);
            response.sendRedirect("demandeAdhesion.jsp?status=ok");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("demandeAdhesion.jsp?status=erreur");
        }
    }
}