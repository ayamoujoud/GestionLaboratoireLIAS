package controller;

import dao.MaterielDAO;
import dao.MembreDAO;
import model.Materiel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/materiel")
public class MaterielServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            MaterielDAO dao = new MaterielDAO();
            request.setAttribute("stock", dao.getStock());
            request.setAttribute("distributions", dao.getHistoriqueDistributions());
            request.setAttribute("membres", new MembreDAO().getAllMembres());
            request.setAttribute("currentPage", "materiel");
            request.getRequestDispatcher("/materiel.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        MaterielDAO dao = new MaterielDAO();
        try {
            if ("ajouter".equals(action)) {
                Materiel m = new Materiel();
                m.setDesignation(request.getParameter("designation"));
                m.setQuantiteTotale(Integer.parseInt(request.getParameter("quantite")));
                m.setDateArrivage(request.getParameter("dateArrivage"));
                m.setDescription(request.getParameter("description"));
                dao.ajouter(m);
            } else if ("distribuer".equals(action)) {
                int materielId = Integer.parseInt(request.getParameter("materielId"));
                int membreId = Integer.parseInt(request.getParameter("membreId"));
                int quantite = Integer.parseInt(request.getParameter("quantite"));
                String date = request.getParameter("dateDistribution");
                dao.distribuer(materielId, membreId, quantite, date);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
        response.sendRedirect("materiel");
    }
}