package controller;

import dao.EvenementDAO;
import model.Evenement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/api/evenements")
public class EvenementsJsonServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();

        try {
            List<Evenement> evenements = new EvenementDAO().getAllEvenements();

            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < evenements.size(); i++) {
                Evenement e = evenements.get(i);
                if (i > 0) json.append(",");

                // Couleur selon le type
                String color = "#2563EB";
                if ("Séminaire".equalsIgnoreCase(e.getType()))   color = "#16A34A";
                if ("Workshop".equalsIgnoreCase(e.getType()))    color = "#D97706";
                if ("Conférence".equalsIgnoreCase(e.getType()))  color = "#9333EA";

                json.append("{")
                    .append("\"id\":").append(e.getId()).append(",")
                    .append("\"title\":\"").append(escape(e.getTitre())).append("\",")
                    .append("\"start\":\"").append(e.getDateDebut()).append("\",")
                    .append("\"end\":\"").append(e.getDateFin() != null ? e.getDateFin() : e.getDateDebut()).append("\",")
                    .append("\"color\":\"").append(color).append("\",")
                    .append("\"extendedProps\":{")
                    .append("\"type\":\"").append(escape(e.getType())).append("\",")
                    .append("\"lieu\":\"").append(escape(e.getLieu() != null ? e.getLieu() : "")).append("\"")
                    .append("}")
                    .append("}");
            }
            json.append("]");

            out.print(json.toString());

        } catch (Exception e) {
            out.print("[]");
            e.printStackTrace();
        }
    }

    private String escape(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "");
    }
}