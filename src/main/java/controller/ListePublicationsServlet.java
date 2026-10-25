package controller;

import java.io.IOException;
import java.util.List;

import dao.PublicationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Publication;

@WebServlet("/listePublications")
public class ListePublicationsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PublicationDAO dao = new PublicationDAO();

        List<Publication> publications = dao.getAllPublications();

        request.setAttribute("publications", publications);

        request.getRequestDispatcher("listePublications.jsp")
               .forward(request, response);
    }
}