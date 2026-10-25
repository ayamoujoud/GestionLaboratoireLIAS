package controller;

import dao.MandatDAO;
import dao.MembreDAO;
import model.Mandat;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/mandats")
public class MandatServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            MandatDAO dao = new MandatDAO();
            request.setAttribute("mandatsActifs", dao.getMandatsActifs());
            request.setAttribute("historique", dao.getHistorique());
            request.setAttribute("membres", new MembreDAO().getAllMembres());
            request.setAttribute("currentPage", "mandats");
            request.getRequestDispatcher("/mandats.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Mandat m = new Mandat();
            m.setMembreId(Integer.parseInt(request.getParameter("membreId")));
            m.setRole(request.getParameter("role"));
            m.setEquipe(request.getParameter("equipe"));
            m.setDateDebut(request.getParameter("dateDebut"));
            new MandatDAO().ajouterMandat(m);
        } catch (Exception e) {
            throw new ServletException(e);
        }
        response.sendRedirect("mandats");
    }
}