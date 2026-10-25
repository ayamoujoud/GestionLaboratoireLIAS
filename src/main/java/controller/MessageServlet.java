package controller;

import dao.MessageDAO;
import dao.MembreDAO;
import dao.UtilisateurDAO;
import model.Message;
import model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/messagerie")
public class MessageServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Utilisateur user = (Utilisateur) request.getSession().getAttribute("user");
        try {
            MessageDAO dao = new MessageDAO();
            request.setAttribute("messagesRecus", dao.getMessagesRecus(user.getId()));
            request.setAttribute("messagesEnvoyes", dao.getMessagesEnvoyes(user.getId()));
            request.setAttribute("membres", new MembreDAO().getAllMembres());
            request.setAttribute("nbNonLus", dao.countNonLus(user.getId()));
            request.setAttribute("currentPage", "messagerie");
            request.getRequestDispatcher("/messagerie.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Utilisateur user = (Utilisateur) request.getSession().getAttribute("user");
        request.setCharacterEncoding("UTF-8");
        try {
            Message msg = new Message();
            msg.setExpediteurId(user.getId());
            String destId = request.getParameter("destinataireId");
            if (destId != null && !destId.isEmpty()) {
                msg.setDestinatataireId(Integer.parseInt(destId));
            }
            msg.setEquipeDest(request.getParameter("equipeDest"));
            msg.setContenu(request.getParameter("contenu"));
            new MessageDAO().envoyer(msg);
        } catch (Exception e) {
            throw new ServletException(e);
        }
        response.sendRedirect("messagerie");
    }
}