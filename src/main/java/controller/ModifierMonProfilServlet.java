package controller;

import dao.MembreDAO;
import model.Membre;
import model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/modifierMonProfil")
public class ModifierMonProfilServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Utilisateur user = (Utilisateur) session.getAttribute("user");
        if (user == null) { response.sendRedirect("login.jsp"); return; }

        MembreDAO dao = new MembreDAO();
        Membre m = dao.getMembreById(user.getId());
        request.setAttribute("membre", m);
        request.getRequestDispatcher("/modifierMonProfil.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Utilisateur user = (Utilisateur) session.getAttribute("user");
        if (user == null) { response.sendRedirect("login.jsp"); return; }

        MembreDAO dao = new MembreDAO();
        Membre m = dao.getMembreById(user.getId());

        m.setBiographie(request.getParameter("biographie"));
        m.setCentresInteret(request.getParameter("centresInteret"));
        m.setEtablissement(request.getParameter("etablissement"));
        m.setLaboratoireOrigine(request.getParameter("laboratoireOrigine"));

        dao.modifierMembre(m);
        response.sendRedirect("monProfil");
    }
}