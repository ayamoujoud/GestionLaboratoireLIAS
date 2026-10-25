package controller;

import dao.DBConnection;
import dao.DocumentDAO;
import model.Utilisateur;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

import java.io.*;
import java.nio.file.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/uploadDocument")
@MultipartConfig(maxFileSize = 10_000_000)
public class UploadDocumentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "uploads/documents";

    // Retrouve l'id du membre lié au compte (sinon on garde l'id utilisateur)
    private int idMembreDe(Utilisateur user) {
        String sql = "SELECT membre_id FROM utilisateur WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, user.getId());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user.getId();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        req.setCharacterEncoding("UTF-8");

        Utilisateur user = (Utilisateur) req.getSession().getAttribute("user");
        if (user == null) {
            res.sendRedirect("login.jsp");
            return;
        }

        String titre = req.getParameter("titre");
        String type = req.getParameter("type");
        String evenementIdParam = req.getParameter("evenementId");

        Part filePart = req.getPart("fichier");
        if (filePart == null || filePart.getSize() == 0
                || filePart.getSubmittedFileName() == null
                || filePart.getSubmittedFileName().isEmpty()) {
            res.sendRedirect("documents?error=fichier");
            return;
        }

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uniqueFileName = System.currentTimeMillis() + "_" + fileName.replaceAll("\\s+", "_");

        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        Files.createDirectories(Paths.get(uploadPath));
        filePart.write(uploadPath + File.separator + uniqueFileName);

        String dbPath = UPLOAD_DIR + "/" + uniqueFileName;

        Integer evenementId = null;
        if (evenementIdParam != null && !evenementIdParam.trim().isEmpty()) {
            try {
                evenementId = Integer.parseInt(evenementIdParam.trim());
            } catch (NumberFormatException e) {
                evenementId = null;
            }
        }

        try {
            new DocumentDAO().ajouter(titre, type, dbPath, evenementId, idMembreDe(user));
        } catch (Exception e) {
            throw new ServletException(e);
        }

        try {
            new dao.NotificationDAO().notifierTous("DOCUMENT", "Nouveau document uploadé : " + titre);
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        res.sendRedirect("documents");
    }
}