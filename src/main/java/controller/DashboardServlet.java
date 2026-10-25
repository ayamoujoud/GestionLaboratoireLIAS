package controller;

import java.io.IOException;

import dao.MembreDAO;
import dao.PublicationDAO;
import dao.EvenementDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        MembreDAO membreDAO = new MembreDAO();
        PublicationDAO publicationDAO = new PublicationDAO();
        EvenementDAO evenementDAO = new EvenementDAO();

        request.setAttribute("nbMembres", membreDAO.countMembres());
        request.setAttribute("nbPublications", publicationDAO.countPublications());
        request.setAttribute("nbEvenements", evenementDAO.countEvenements());

        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}