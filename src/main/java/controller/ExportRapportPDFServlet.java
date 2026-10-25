package controller;

import com.itextpdf.kernel.colors.ColorConstants;
import com.itextpdf.kernel.colors.DeviceRgb;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.kernel.pdf.canvas.draw.SolidLine;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.LineSeparator;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.element.Text;
import com.itextpdf.layout.properties.TextAlignment;
import com.itextpdf.layout.properties.UnitValue;

import dao.EvenementDAO;
import dao.MembreDAO;
import dao.PublicationDAO;
import model.Evenement;
import model.Membre;
import model.Publication;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Calendar;
import java.util.List;

@WebServlet("/exportRapportPDF")
public class ExportRapportPDFServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final DeviceRgb BLEU_LIAS  = new DeviceRgb(37, 99, 235);
    private static final DeviceRgb BLEU_DARK  = new DeviceRgb(11, 31, 69);
    private static final DeviceRgb GRIS_LIGHT = new DeviceRgb(248, 250, 252);
    private static final DeviceRgb GRIS_BORD  = new DeviceRgb(229, 231, 235);
    private static final DeviceRgb BLANC      = new DeviceRgb(255, 255, 255);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int annee;

        try {
            annee = request.getParameter("annee") != null
                    ? Integer.parseInt(request.getParameter("annee"))
                    : Calendar.getInstance().get(Calendar.YEAR);
        } catch (NumberFormatException e) {
            annee = Calendar.getInstance().get(Calendar.YEAR);
        }

        response.setContentType("application/pdf");
        response.setHeader(
                "Content-Disposition",
                "attachment; filename=\"rapport-lias-" + annee + ".pdf\""
        );

        try {
            PdfWriter writer = new PdfWriter(response.getOutputStream());
            PdfDocument pdfDoc = new PdfDocument(writer);
            Document doc = new Document(pdfDoc);

            doc.setMargins(50, 50, 50, 50);

            Paragraph entete = new Paragraph()
                    .add(new Text("LABORATOIRE LIAS\n")
                            .setFontSize(26)
                            .setBold()
                            .setFontColor(BLEU_DARK))
                    .add(new Text("Rapport d'activité annuel — " + annee)
                            .setFontSize(14)
                            .setFontColor(BLEU_LIAS))
                    .setTextAlignment(TextAlignment.CENTER)
                    .setMarginBottom(8);

            doc.add(entete);

            Paragraph sousTitre = new Paragraph("Faculté des Sciences Ben M'Sik — Casablanca")
                    .setTextAlignment(TextAlignment.CENTER)
                    .setFontSize(11)
                    .setFontColor(ColorConstants.GRAY)
                    .setMarginBottom(30);

            doc.add(sousTitre);

            addLine(doc, BLEU_LIAS, 2f, 0, 30);

            MembreDAO membreDAO = new MembreDAO();
            PublicationDAO publicationDAO = new PublicationDAO();
            EvenementDAO evenementDAO = new EvenementDAO();

            List<Membre> membres = membreDAO.listerActifs();
            List<Publication> publications = publicationDAO.listerParAnnee(annee);
            List<Evenement> evenements = evenementDAO.listerParAnnee(annee);

            doc.add(sectionTitre("Résumé statistique"));

            Table statsTable = new Table(UnitValue.createPercentArray(new float[]{1, 1, 1}))
                    .useAllAvailableWidth()
                    .setMarginBottom(24);

            statsTable.addCell(statCell("Membres actifs", String.valueOf(membres.size())));
            statsTable.addCell(statCell("Publications " + annee, String.valueOf(publications.size())));
            statsTable.addCell(statCell("Événements " + annee, String.valueOf(evenements.size())));

            doc.add(statsTable);

            doc.add(sectionTitre("Membres actifs"));

            if (membres == null || membres.isEmpty()) {
                doc.add(emptyText("Aucun membre actif."));
            } else {
                Table tMembre = new Table(UnitValue.createPercentArray(new float[]{2, 2, 2, 2}))
                        .useAllAvailableWidth()
                        .setMarginBottom(24);

                addHeader(tMembre, "Prénom", "Nom", "Email", "Équipe");

                boolean pair = false;

                for (Membre m : membres) {
                    DeviceRgb bg = pair ? GRIS_LIGHT : BLANC;

                    addCell(tMembre, safe(m.getPrenom()), bg);
                    addCell(tMembre, safe(m.getNom()), bg);
                    addCell(tMembre, safe(m.getEmail()), bg);

                    // Si getEquipe() devient rouge, remplace cette ligne par le bon champ de ton modèle Membre.
                    addCell(tMembre, safe(m.getEquipe()), bg);

                    pair = !pair;
                }

                doc.add(tMembre);
            }

            doc.add(sectionTitre("Publications " + annee));

            if (publications == null || publications.isEmpty()) {
                doc.add(emptyText("Aucune publication cette année."));
            } else {
                Table tPub = new Table(UnitValue.createPercentArray(new float[]{3, 2, 1, 1}))
                        .useAllAvailableWidth()
                        .setMarginBottom(24);

                addHeader(tPub, "Titre", "Auteur(s)", "Année", "Type");

                boolean pair = false;

                for (Publication p : publications) {
                    DeviceRgb bg = pair ? GRIS_LIGHT : BLANC;

                    addCell(tPub, safe(p.getTitre()), bg);
                    addCell(tPub, safe(p.getAuteur()), bg);
                    addCell(tPub, String.valueOf(p.getAnnee()), bg);
                    addCell(tPub, safe(p.getType()), bg);

                    pair = !pair;
                }

                doc.add(tPub);
            }

            doc.add(sectionTitre("Événements " + annee));

            if (evenements == null || evenements.isEmpty()) {
                doc.add(emptyText("Aucun événement cette année."));
            } else {
                Table tEv = new Table(UnitValue.createPercentArray(new float[]{3, 1, 2, 1}))
                        .useAllAvailableWidth()
                        .setMarginBottom(24);

                addHeader(tEv, "Titre", "Type", "Lieu", "Date");

                boolean pair = false;

                for (Evenement e : evenements) {
                    DeviceRgb bg = pair ? GRIS_LIGHT : BLANC;

                    addCell(tEv, safe(e.getTitre()), bg);
                    addCell(tEv, safe(e.getType()), bg);
                    addCell(tEv, safe(e.getLieu()), bg);
                    addCell(tEv, safe(e.getDateDebut()), bg);

                    pair = !pair;
                }

                doc.add(tEv);
            }

            addLine(doc, GRIS_BORD, 1f, 20, 0);

            doc.add(new Paragraph("Rapport généré automatiquement par la plateforme LIAS — " + annee)
                    .setFontSize(9)
                    .setFontColor(ColorConstants.GRAY)
                    .setTextAlignment(TextAlignment.CENTER)
                    .setMarginTop(10));

            doc.close();

        } catch (Exception e) {
            throw new ServletException("Erreur génération PDF : " + e.getMessage(), e);
        }
    }

    private void addLine(Document doc, DeviceRgb color, float width, float marginTop, float marginBottom) {
        SolidLine solidLine = new SolidLine(width);
        solidLine.setColor(color);

        LineSeparator separator = new LineSeparator(solidLine);
        separator.setMarginTop(marginTop);
        separator.setMarginBottom(marginBottom);

        doc.add(separator);
    }

    private Paragraph sectionTitre(String texte) {
        return new Paragraph(texte)
                .setFontSize(14)
                .setBold()
                .setFontColor(BLEU_DARK)
                .setMarginTop(10)
                .setMarginBottom(10);
    }

    private Cell statCell(String label, String valeur) {
        return new Cell()
                .add(new Paragraph(valeur)
                        .setFontSize(28)
                        .setBold()
                        .setFontColor(BLEU_LIAS)
                        .setTextAlignment(TextAlignment.CENTER)
                        .setMarginBottom(4))
                .add(new Paragraph(label)
                        .setFontSize(11)
                        .setFontColor(ColorConstants.GRAY)
                        .setTextAlignment(TextAlignment.CENTER))
                .setBackgroundColor(GRIS_LIGHT)
                .setPadding(16);
    }

    private void addHeader(Table table, String... titres) {
        for (String titre : titres) {
            table.addHeaderCell(new Cell()
                    .add(new Paragraph(titre)
                            .setBold()
                            .setFontColor(ColorConstants.WHITE)
                            .setFontSize(11))
                    .setBackgroundColor(BLEU_LIAS)
                    .setPadding(8));
        }
    }

    private void addCell(Table table, String valeur, DeviceRgb bg) {
        table.addCell(new Cell()
                .add(new Paragraph(valeur)
                        .setFontSize(10))
                .setBackgroundColor(bg)
                .setPadding(6));
    }

    private Paragraph emptyText(String texte) {
        return new Paragraph(texte)
                .setFontColor(ColorConstants.GRAY)
                .setFontSize(11)
                .setMarginBottom(16);
    }

    private String safe(String value) {
        return value == null || value.trim().isEmpty() ? "—" : value;
    }
}