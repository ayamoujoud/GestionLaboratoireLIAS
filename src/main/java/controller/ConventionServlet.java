package controller;

import dao.ConventionDAO;
import model.Convention;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/conventions")
public class ConventionServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ConventionDAO dao = new ConventionDAO();
            request.setAttribute("conventions", dao.listerToutes());
            request.setAttribute("currentPage", "conventions");
            request.getRequestDispatcher("/conventions.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            ConventionDAO dao = new ConventionDAO();
            if ("supprimer".equals(action)) {
                dao.supprimer(Integer.parseInt(request.getParameter("id")));
            } else {
                Convention c = new Convention();
                c.setTitre(request.getParameter("titre"));
                c.setPartenaire(request.getParameter("partenaire"));
                c.setTypeConvention(request.getParameter("typeConvention"));
                c.setDateSignature(request.getParameter("dateSignature"));
                c.setDateFin(request.getParameter("dateFin"));
                c.setDescription(request.getParameter("description"));
                dao.ajouter(c);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
        response.sendRedirect("conventions");
    }
}