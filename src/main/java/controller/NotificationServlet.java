package controller;

import dao.NotificationDAO;
import model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/notifications")
public class NotificationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Utilisateur user = (Utilisateur) request.getSession().getAttribute("user");

        try {
            NotificationDAO dao = new NotificationDAO();
            dao.marquerToutesLues(user.getId());
            request.setAttribute("notifications", dao.getNotifications(user.getId()));
            request.setAttribute("currentPage", "notifications");
            request.getRequestDispatcher("/notifications.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}