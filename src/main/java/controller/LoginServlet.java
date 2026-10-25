package controller;

import java.io.IOException;
import dao.UtilisateurDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Utilisateur;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Ouverture directe de /login → page de connexion
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email      = request.getParameter("email");
        String motDePasse = request.getParameter("motDePasse");

        UtilisateurDAO dao = new UtilisateurDAO();
        Utilisateur u      = dao.login(email, motDePasse);

        if (u != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", u);
            session.setAttribute("role", u.getRole());

            // Redirection selon le rôle
            switch (u.getRole().toUpperCase()) {
                case "ADMIN":
                    response.sendRedirect("adminDashboard.jsp");
                    break;
                case "DIRECTEUR":
                    response.sendRedirect("adminDashboard.jsp"); // dashboard complet
                    break;
                case "MEMBRE":
                default:
                    response.sendRedirect("membreDashboard.jsp");
                    break;
            }

        } else {
            response.sendRedirect("login.jsp?erreur=1");
        }
    }
}