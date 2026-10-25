package controller;

import dao.BesoinMaterielDAO;
import model.BesoinMateriel;
import model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/besoins")
public class BesoinMaterielServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Utilisateur user = (Utilisateur) request.getSession().getAttribute("user");

        try {
            BesoinMaterielDAO dao = new BesoinMaterielDAO();
            String role = user.getRole();

            if ("ADMIN".equalsIgnoreCase(role) || "DIRECTEUR".equalsIgnoreCase(role)) {
                // L'admin voit tous les besoins
                request.setAttribute("besoins", dao.listerTous());
                request.setAttribute("modeAdmin", true);
            } else {
                // Le membre voit ses propres besoins
                request.setAttribute("besoins", dao.listerParMembre(user.getId()));
                request.setAttribute("modeAdmin", false);
            }

            request.setAttribute("currentPage", "besoins");
            request.getRequestDispatcher("/besoins.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Utilisateur user   = (Utilisateur) request.getSession().getAttribute("user");
        String      action = request.getParameter("action");
        request.setCharacterEncoding("UTF-8");

        try {
            BesoinMaterielDAO dao = new BesoinMaterielDAO();

            if ("soumettre".equals(action)) {
                BesoinMateriel b = new BesoinMateriel();
                b.setMembreId(user.getId());
                b.setDescription(request.getParameter("description"));
                b.setQuantite(Integer.parseInt(
                    request.getParameter("quantite") != null
                    && !request.getParameter("quantite").isEmpty()
                    ? request.getParameter("quantite") : "1"));
                dao.soumettre(b);

                // Notifier l'admin
                try {
                    new dao.NotificationDAO().creer(
                        user.getId(), "MATERIEL",
                        "Nouvelle demande de matériel soumise : " + b.getDescription()
                    );
                } catch (Exception ex) { ex.printStackTrace(); }

            } else if ("valider".equals(action) || "refuser".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String decision = "valider".equals(action) ? "valide" : "refuse";
                dao.traiter(id, decision, user.getId());
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }

        response.sendRedirect("besoins");
    }
}