package controller;

import java.io.IOException;

import dao.EvenementDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Evenement;

@WebServlet("/modifierEvenement")
public class ModifierEvenementServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        EvenementDAO dao = new EvenementDAO();

        Evenement e = dao.getEvenementById(id);

        request.setAttribute("evenement", e);

        request.getRequestDispatcher("modifierEvenement.jsp")
               .forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Evenement e = new Evenement();

        e.setId(Integer.parseInt(request.getParameter("id")));
        e.setTitre(request.getParameter("titre"));
        e.setType(request.getParameter("type"));
        e.setLieu(request.getParameter("lieu"));
        e.setDateDebut(request.getParameter("dateDebut"));
        e.setDateFin(request.getParameter("dateFin"));

        EvenementDAO dao = new EvenementDAO();

        dao.modifierEvenement(e);

        response.sendRedirect("listeEvenements");
    }
}