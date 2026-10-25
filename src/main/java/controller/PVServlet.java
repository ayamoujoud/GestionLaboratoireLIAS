package controller;

import dao.PVDAO;
import model.ProcesVerbal;
import model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.nio.file.*;

@WebServlet("/pv")
@MultipartConfig(maxFileSize = 10_000_000)
public class PVServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "uploads/pv";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("pvList", new PVDAO().listerTous());
            request.setAttribute("currentPage", "pv");
            request.getRequestDispatcher("/pv.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        Utilisateur user = (Utilisateur) request.getSession().getAttribute("user");

        try {
            PVDAO dao = new PVDAO();
            if ("supprimer".equals(action)) {
                dao.supprimer(Integer.parseInt(request.getParameter("id")));
            } else {
                // Upload fichier PV
                Part filePart = request.getPart("fichierPv");
                String pvPath = null;

                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = System.currentTimeMillis() + "_" +
                            Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                    Files.createDirectories(Paths.get(uploadPath));
                    filePart.write(uploadPath + File.separator + fileName);
                    pvPath = UPLOAD_DIR + "/" + fileName;
                }

                ProcesVerbal pv = new ProcesVerbal();
                pv.setDateReunion(request.getParameter("dateReunion"));
                pv.setOrdreDuJour(request.getParameter("ordreDuJour"));
                pv.setPvPath(pvPath);
                pv.setCreePar(user != null ? user.getId() : 1);
                dao.ajouter(pv);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
        response.sendRedirect("pv");
    }
}