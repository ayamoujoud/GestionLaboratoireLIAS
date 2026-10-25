<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Calendar" %>

<%
if(session.getAttribute("user") == null){
    response.sendRedirect("login.jsp");
    return;
}

Integer annee = (Integer) request.getAttribute("annee");
if(annee == null) annee = Calendar.getInstance().get(Calendar.YEAR);

Integer nbM = (Integer) request.getAttribute("nbMembres");
if(nbM == null) nbM = 0;

Integer nbP = (Integer) request.getAttribute("nbPublications");
if(nbP == null) nbP = 0;

Integer nbE = (Integer) request.getAttribute("nbEvenements");
if(nbE == null) nbE = 0;

request.setAttribute("currentPage", "rapport");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Rapport annuel <%= annee %> — LIAS</title>

<%@ include file="/WEB-INF/style.jsp" %>

<style>
@media print {
    .sidebar, .no-print {
        display:none!important;
    }

    .main {
        margin-left:0!important;
        max-width:100%!important;
    }

    .card {
        box-shadow:none!important;
        border:1px solid #ccc!important;
    }
}

.rapport-header {
    background: var(--navy);
    color: #fff;
    border-radius: var(--radius);
    padding: 32px;
    margin-bottom: 24px;
}

.section-title {
    font-size:14px;
    font-weight:600;
    margin-bottom:16px;
    padding-bottom:10px;
    border-bottom:1px solid var(--border);
}
</style>
</head>

<body>

<%@ include file="/WEB-INF/sidebar.jsp" %>

<main class="main">

    <div class="page-header page-header-row no-print">
        <div>
            <h1>Rapport annuel</h1>
            <p>Rapport d'activité du Laboratoire LIAS</p>
        </div>

        <div style="display:flex;gap:10px;align-items:center;">

            <form action="rapport" method="get" style="display:flex;align-items:center;gap:8px;">
                <select name="annee" style="border:1px solid var(--border);border-radius:8px;padding:8px 12px;font-size:13px;font-family:inherit;background:#fff;">
                    <% for(int y = annee; y >= annee - 5; y--) { %>
                        <option value="<%= y %>" <%= y == annee ? "selected" : "" %>>
                            <%= y %>
                        </option>
                    <% } %>
                </select>

                <button type="submit" class="btn btn-ghost">Charger</button>
            </form>

            <button onclick="window.print()" class="btn btn-ghost">
                🖨 Imprimer
            </button>

            <a href="exportRapportPDF?annee=<%= annee %>" class="btn btn-primary">
                📥 Exporter PDF
            </a>

        </div>
    </div>

    <div class="rapport-header">
        <div style="font-size:11px;text-transform:uppercase;letter-spacing:.8px;color:rgba(255,255,255,0.5);margin-bottom:8px;">
            Rapport d'activité scientifique
        </div>

        <div style="font-size:28px;font-weight:600;margin-bottom:4px;">
            Laboratoire LIAS
        </div>

        <div style="font-size:14px;color:rgba(255,255,255,0.7);">
            Faculté des Sciences Ben M'Sik — Université Hassan II de Casablanca
        </div>

        <div style="margin-top:16px;font-size:22px;font-weight:500;color:#93c5fd;">
            Année <%= annee %>
        </div>
    </div>

    <div class="stats-row" style="margin-bottom:24px;">
        <div class="stat-card">
            <div class="stat-icon">👥</div>
            <div class="stat-num"><%= nbM %></div>
            <div class="stat-lbl">Membres actifs</div>
        </div>

        <div class="stat-card">
            <div class="stat-icon">📄</div>
            <div class="stat-num"><%= nbP %></div>
            <div class="stat-lbl">Publications <%= annee %></div>
        </div>

        <div class="stat-card">
            <div class="stat-icon">🗓</div>
            <div class="stat-num"><%= nbE %></div>
            <div class="stat-lbl">Événements <%= annee %></div>
        </div>
    </div>

    <div style="display:grid;grid-template-columns:1fr 1fr;gap:16px;">

        <div class="card">
            <div class="section-title">1. Composition du laboratoire</div>
            <p style="font-size:13.5px;color:var(--text-muted);line-height:1.7;">
                Le laboratoire LIAS compte
                <strong style="color:var(--text);"><%= nbM %> membres</strong>
                répartis en équipes de recherche thématiques.
                Les membres permanents assurent l'encadrement doctoral et la production scientifique continue.
            </p>

            <a href="listeMembres" style="font-size:13px;color:var(--blue);text-decoration:none;margin-top:12px;display:inline-block;">
                Voir la liste complète →
            </a>
        </div>

        <div class="card">
            <div class="section-title">2. Production scientifique <%= annee %></div>
            <p style="font-size:13.5px;color:var(--text-muted);line-height:1.7;">
                En <%= annee %>, le laboratoire a produit
                <strong style="color:var(--text);"><%= nbP %> publications</strong>
                incluant des articles de revues internationales, des communications en conférences
                et des chapitres d'ouvrages collectifs.
            </p>

            <a href="listePublications" style="font-size:13px;color:var(--blue);text-decoration:none;margin-top:12px;display:inline-block;">
                Voir les publications →
            </a>
        </div>

        <div class="card">
            <div class="section-title">3. Activités et événements</div>
            <p style="font-size:13.5px;color:var(--text-muted);line-height:1.7;">
                <strong style="color:var(--text);"><%= nbE %> événements scientifiques</strong>
                ont été organisés ou co-organisés par le laboratoire en <%= annee %> :
                conférences internationales, séminaires internes et workshops thématiques.
            </p>

            <a href="listeEvenements" style="font-size:13px;color:var(--blue);text-decoration:none;margin-top:12px;display:inline-block;">
                Voir les événements →
            </a>
        </div>

        <div class="card">
            <div class="section-title">4. Perspectives <%= annee + 1 %></div>
            <p style="font-size:13.5px;color:var(--text-muted);line-height:1.7;">
                Le laboratoire s'engage à poursuivre ses efforts de recherche,
                à renforcer ses partenariats internationaux et à accroître
                sa visibilité scientifique pour l'année <%= annee + 1 %>.
            </p>
        </div>

    </div>

    <div style="margin-top:24px;padding:16px;background:var(--blue-pale);border-radius:var(--radius);font-size:12px;color:var(--blue);text-align:center;" class="no-print">
        Ce rapport est généré automatiquement à partir des données enregistrées dans le système.
        Utilisez le bouton Imprimer ou Exporter PDF pour obtenir une version PDF.
    </div>

</main>

</body>
</html>