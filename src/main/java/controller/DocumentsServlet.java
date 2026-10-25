package controller;

import dao.DocumentDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/documents")
public class DocumentsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {
        try {
            req.setAttribute("documents", new DocumentDAO().listerTous());
            req.setAttribute("currentPage", "documents");
            req.getRequestDispatcher("/documents.jsp").forward(req, res);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}