package controller;

import dao.DemandeAdhesionDAO;
import model.Utilisateur;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/listeDemandes")
public class DemandesServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private DemandeAdhesionDAO dao = new DemandeAdhesionDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        try {
            req.setAttribute("demandes", dao.listerEnAttente());
            req.getRequestDispatcher("/demandes.jsp").forward(req, res);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect("login.jsp");
            return;
        }

        Utilisateur user = (Utilisateur) session.getAttribute("user");

        int id = Integer.parseInt(req.getParameter("id"));
        String action = req.getParameter("decision");

        String decision;

        if ("accepter".equals(action)) {
            decision = "ACCEPTE";
        } else if ("refuser".equals(action)) {
            decision = "REFUSE";
        } else {
            throw new ServletException("Action invalide : " + action);
        }

        try {
            dao.traiter(id, decision, user.getId());
            res.sendRedirect("listeDemandes");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}