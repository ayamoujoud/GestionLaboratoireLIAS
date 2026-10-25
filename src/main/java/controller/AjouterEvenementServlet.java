package controller;

import java.io.IOException;

import dao.EvenementDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Evenement;

@WebServlet("/ajouterEvenement")
public class AjouterEvenementServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Evenement e = new Evenement();

        e.setTitre(request.getParameter("titre"));
        e.setType(request.getParameter("type"));
        e.setLieu(request.getParameter("lieu"));
        e.setDateDebut(request.getParameter("dateDebut"));
        e.setDateFin(request.getParameter("dateFin"));

        EvenementDAO dao = new EvenementDAO();
        dao.ajouterEvenement(e);
    
        try {
            new dao.NotificationDAO().notifierTous(
                "EVENEMENT",
                "Nouvel événement ajouté : " + e.getTitre() + " (" + e.getDateDebut() + ")"
            );
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        response.sendRedirect("listeEvenements");
    }
}