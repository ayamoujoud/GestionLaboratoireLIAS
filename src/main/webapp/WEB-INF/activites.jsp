<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Evenement" %>

<%!
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
List<Evenement> evenements =
    (List<Evenement>) request.getAttribute("evenements");

int currentYear = java.time.Year.now().getValue();
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Activités — LIAS</title>

    <style>
        body { margin:0; font-family:'Segoe UI',Arial,sans-serif; background:#f5f7fb; color:#1f2937; }
        .public-container { max-width:1200px; margin:35px auto; padding:0 24px; }
        .retour-link { display:inline-block; margin-bottom:20px; color:#2563eb; font-weight:700; text-decoration:none; }
        .public-header { margin-bottom:25px; }
        .public-header h1 { color:#0B1F45; font-size:30px; margin-bottom:8px; }
        .public-header p { color:#64748b; }
        .public-card { background:white; padding:24px; border-radius:12px; box-shadow:0 4px 15px rgba(15,35,70,.08); }
        .search-row { display:flex; gap:12px; flex-wrap:wrap; margin-bottom:22px; }
        .search-row input, .search-row select { padding:10px 12px; border:1px solid #dbe2ea; border-radius:8px; font-size:14px; background:white; }
        .search-row input { flex:1; min-width:220px; }
        .table-wrap { overflow-x:auto; }
        .public-table { width:100%; border-collapse:collapse; }
        .public-table th { background:#f1f5f9; color:#0B1F45; text-align:left; padding:14px; white-space:nowrap; }
        .public-table td { padding:14px; border-bottom:1px solid #e8edf4; }
        .public-table tbody tr:hover { background:#f8faff; }
        .badge { display:inline-block; padding:5px 10px; border-radius:20px; background:#dbeafe; color:#1d4ed8; font-size:12px; }
        .empty-state { text-align:center; padding:45px 15px; color:#64748b; }
        .empty-state .icon { font-size:38px; margin-bottom:12px; }
    </style>
</head>

<body>

<main class="public-container">

    <a href="index.jsp" class="retour-link">← Retour à l'accueil</a>

    <div class="public-header">
        <h1>Activités scientifiques</h1>
        <p>Conférences, séminaires, workshops et événements du laboratoire LIAS.</p>
    </div>

    <div class="public-card">

        <div class="search-row">
            <input
                type="text"
                id="searchInput"
                placeholder="Rechercher par titre, type ou lieu..."
                oninput="filterTable()">

            <select id="filterAnnee" onchange="filterTable()">
                <option value="">Toutes les années</option>
                <% for (int y = currentYear + 1; y >= currentYear - 4; y--) { %>
                    <option value="<%= y %>"><%= y %></option>
                <% } %>
            </select>
        </div>

        <div class="table-wrap">
            <table class="public-table" id="actTable">
                <thead>
                    <tr>
                        <th>Titre</th>
                        <th>Type</th>
                        <th>Date</th>
                        <th>Lieu</th>
                    </tr>
                </thead>

                <tbody>
                <% if (evenements != null && !evenements.isEmpty()) {
                    for (Evenement ev : evenements) {
                        String titre = ev.getTitre() != null ? ev.getTitre() : "—";
                        String type  = ev.getType()  != null ? ev.getType()  : "";
                        String lieu  = ev.getLieu()  != null ? ev.getLieu()  : "—";

                        String debut = ev.getDateDebut() != null ? ev.getDateDebut() : "";
                        String fin   = ev.getDateFin()   != null ? ev.getDateFin()   : "";

                        // Date affichée : début, et fin si elle est différente
                        String date = debut.isEmpty() ? "—" : debut;
                        if (!debut.isEmpty() && !fin.isEmpty() && !fin.equals(debut)) {
                            date = debut + " → " + fin;
                        }

                        // année extraite de la date de début (format yyyy-MM-dd)
                        String annee = debut.length() >= 4 ? debut.substring(0, 4) : "";
                %>
                    <tr data-annee="<%= esc(annee) %>">
                        <td><%= esc(titre) %></td>
                        <td>
                            <span class="badge"><%= type.isEmpty() ? "—" : esc(type) %></span>
                        </td>
                        <td><%= esc(date) %></td>
                        <td><%= esc(lieu) %></td>
                    </tr>
                <%  }
                   } else { %>
                    <tr>
                        <td colspan="4">
                            <div class="empty-state">
                                <div class="icon">🗓</div>
                                <h3>Aucune activité disponible</h3>
                                <p>Les activités seront affichées ici lorsqu'elles seront disponibles.</p>
                            </div>
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>

</main>

<script>
function filterTable() {
    const q = document.getElementById("searchInput").value.toLowerCase();
    const annee = document.getElementById("filterAnnee").value;
    const rows = document.querySelectorAll("#actTable tbody tr");

    rows.forEach(function (row) {
        if (row.cells.length < 4) return;

        const okRecherche = row.innerText.toLowerCase().includes(q);
        const okAnnee = !annee || row.dataset.annee === annee;

        row.style.display = okRecherche && okAnnee ? "" : "none";
    });
}
</script>

</body>
</html>