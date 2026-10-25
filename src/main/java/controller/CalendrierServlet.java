package controller;

import dao.EvenementDAO;
import model.Evenement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/calendrier")
public class CalendrierServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            EvenementDAO dao = new EvenementDAO();
            List<Evenement> evenements = dao.getAllEvenements();
            request.setAttribute("evenements", evenements);
            request.setAttribute("currentPage", "calendrier");
            request.getRequestDispatcher("/calendrier.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}