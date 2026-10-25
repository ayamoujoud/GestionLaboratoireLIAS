<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Publication" %>

<%!
    // Escape HTML to prevent XSS
    private static String esc(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
%>

<%
boolean modePublic = "public".equals(request.getParameter("mode"));

if (!modePublic && session.getAttribute("user") == null) {
    response.sendRedirect("login.jsp");
    return;
}

List<Publication> publications =
    (List<Publication>) request.getAttribute("publications");

request.setAttribute("currentPage", "publications");

int currentYear = java.time.Year.now().getValue();
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Publications — LIAS</title>

    <%-- Le style de l'espace connecté (body flex + sidebar) ne doit PAS être chargé
         en mode public, sinon il casse la mise en page de la page d'accueil --%>
    <% if (!modePublic) { %>
        <%@ include file="/WEB-INF/style.jsp" %>
    <% } %>

    <style>
        .public-container {
            max-width: 1200px;
            margin: 35px auto;
            padding: 0 24px;
        }

        .public-header {
            margin-bottom: 25px;
        }

        .public-header h1 {
            color: #0B1F45;
            font-size: 30px;
            margin-bottom: 8px;
        }

        .public-header p {
            color: #64748b;
        }

        .public-card {
            background: white;
            padding: 24px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(15, 35, 70, 0.08);
        }

        .search-row {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            margin-bottom: 22px;
        }

        .search-row input,
        .search-row select {
            padding: 10px 12px;
            border: 1px solid #dbe2ea;
            border-radius: 8px;
            font-size: 14px;
            background: white;
        }

        .search-row input {
            flex: 1;
            min-width: 220px;
        }

        .table-wrap {
            overflow-x: auto;
        }

        .public-table {
            width: 100%;
            border-collapse: collapse;
        }

        .public-table th {
            background: #f1f5f9;
            color: #0B1F45;
            text-align: left;
            padding: 14px;
            white-space: nowrap;
        }

        .public-table td {
            padding: 14px;
            border-bottom: 1px solid #e8edf4;
        }

        .public-table tbody tr:hover {
            background: #f8faff;
        }

        .badge {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            background: #dbeafe;
            color: #1d4ed8;
            font-size: 12px;
        }

        .empty-state {
            text-align: center;
            padding: 45px 15px;
            color: #64748b;
        }

        .empty-state .icon {
            font-size: 38px;
            margin-bottom: 12px;
        }

        .public-footer {
            margin-top: 35px;
            padding: 22px;
            text-align: center;
            color: #64748b;
            font-size: 13px;
        }

        @media (max-width: 600px) {
            .public-container {
                padding: 0 12px;
            }

            .public-card {
                padding: 14px;
            }

            .public-header h1 {
                font-size: 25px;
            }
        }
    </style>
</head>

<body>

<% if (!modePublic) { %>
    <%@ include file="/WEB-INF/sidebar.jsp" %>
<% } %>

<main class="<%= modePublic ? "public-container" : "main" %>">

    <div class="public-header">
        <h1>Publications scientifiques</h1>
        <p>
            Découvrez les publications et les travaux scientifiques du laboratoire LIAS.
        </p>
    </div>

    <div class="public-card">

        <div class="search-row">
            <input
                type="text"
                id="searchInput"
                placeholder="Rechercher par titre, auteur, équipe ou type..."
                oninput="filterTable()">

            <select id="filterAnnee" onchange="filterTable()">
                <option value="">Toutes les années</option>
                <% for (int y = currentYear; y >= currentYear - 4; y--) { %>
                    <option value="<%= y %>"><%= y %></option>
                <% } %>
            </select>
        </div>

        <div class="table-wrap">
            <table class="public-table" id="pubTable">
                <thead>
                    <tr>
                        <th>Titre</th>
                        <th>Auteur</th>
                        <th>Année</th>
                        <th>Équipe</th>
                        <th>Type</th>

                        <% if (!modePublic) { %>
                            <th>Actions</th>
                        <% } %>
                    </tr>
                </thead>

                <tbody>
                <% if (publications != null && !publications.isEmpty()) {
                    for (Publication p : publications) {
                        String type   = p.getType()   != null ? p.getType()   : "";
                        String titre  = p.getTitre()  != null ? p.getTitre()  : "—";
                        String auteur = p.getAuteur() != null ? p.getAuteur() : "—";
                        String equipe = p.getEquipe() != null ? p.getEquipe() : "—";
                %>
                    <tr>
                        <td><%= esc(titre) %></td>
                        <td><%= esc(auteur) %></td>
                        <td>
                            <span class="badge"><%= p.getAnnee() %></span>
                        </td>
                        <td><%= esc(equipe) %></td>
                        <td>
                            <span class="badge">
                                <%= type.isEmpty() ? "—" : esc(type) %>
                            </span>
                        </td>

                        <% if (!modePublic) { %>
                        <td>
                            <a href="modifierPublication?id=<%= p.getId() %>"
                               class="btn btn-ghost btn-sm">Modifier</a>

                            <a href="supprimerPublication?id=<%= p.getId() %>"
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('Supprimer cette publication ?')">
                               Supprimer
                            </a>
                        </td>
                        <% } %>
                    </tr>

                <%  }
                   } else { %>

                    <tr>
                        <td colspan="<%= modePublic ? 5 : 6 %>">
                            <div class="empty-state">
                                <div class="icon">📄</div>
                                <h3>Aucune publication disponible</h3>
                                <p>Les publications seront affichées ici lorsqu'elles seront disponibles.</p>
                            </div>
                        </td>
                    </tr>

                <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <% if (!modePublic) { %>
        <p style="margin-top:20px;">
            <a href="ajouterPublication.jsp" class="btn btn-primary">
                + Ajouter une publication
            </a>
        </p>
    <% } %>

</main>

<% if (modePublic) { %>
<footer class="public-footer">
    &copy; 2026 LIAS — Publications scientifiques
</footer>
<% } %>

<script>
function filterTable() {
    const q = document.getElementById("searchInput").value.toLowerCase();
    const annee = document.getElementById("filterAnnee").value;
    const rows = document.querySelectorAll("#pubTable tbody tr");

    rows.forEach(function(row) {
        // Skip the "no publication" row (single colspan cell)
        if (row.cells.length < 5) return;

        // Search only in Titre, Auteur, Équipe, Type (not the Actions column)
        const text = [0, 1, 3, 4]
            .map(function(i) { return row.cells[i].innerText; })
            .join(" ")
            .toLowerCase();

        const correspondRecherche = text.includes(q);
        const correspondAnnee = !annee ||
            row.cells[2].innerText.trim() === annee;

        row.style.display =
            correspondRecherche && correspondAnnee ? "" : "none";
    });
}
</script>

</body>
</html>