<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Equipe" %>

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
List<Equipe> equipes = (List<Equipe>) request.getAttribute("equipes");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Équipes — LIAS</title>

    <style>
        .public-container { max-width:1200px; margin:35px auto; padding:0 24px; }
        .retour-link { display:inline-block; margin-bottom:20px; color:#2563eb; font-weight:700; text-decoration:none; }
        .public-header { margin-bottom:25px; }
        .public-header h1 { color:#0B1F45; font-size:30px; margin-bottom:8px; }
        .public-header p { color:#64748b; }
        .eq-grid { display:grid; grid-template-columns:repeat(auto-fill,minmax(300px,1fr)); gap:20px; }
        .eq-card { background:white; padding:24px; border-radius:12px; box-shadow:0 4px 15px rgba(15,35,70,.08); }
        .eq-card h3 { color:#0B1F45; margin:0 0 10px; font-size:18px; }
        .eq-card p { color:#64748b; line-height:1.6; margin:0 0 14px; }
        .eq-meta { display:flex; justify-content:space-between; align-items:center; gap:10px; flex-wrap:wrap;
                   font-size:13px; color:#475569; border-top:1px solid #e8edf4; padding-top:12px; }
        .eq-badge { display:inline-block; padding:5px 10px; border-radius:20px; background:#dbeafe; color:#1d4ed8; font-size:12px; }
        .eq-empty { text-align:center; padding:45px 15px; color:#64748b; background:white; border-radius:12px; }
    </style>
</head>

<body>

<main class="public-container">

    <a href="index.jsp" class="retour-link">← Retour à l'accueil</a>

    <div class="public-header">
        <h1>Équipes de recherche</h1>
        <p>Les équipes du laboratoire LIAS, leurs thématiques et leurs responsables.</p>
    </div>

    <% if (equipes != null && !equipes.isEmpty()) { %>
    <div class="eq-grid">
        <% for (Equipe eq : equipes) {
             String chef = "—";
             if (eq.getNomChef() != null || eq.getPrenomChef() != null) {
                 chef = ((eq.getPrenomChef() != null ? eq.getPrenomChef() : "") + " "
                       + (eq.getNomChef() != null ? eq.getNomChef() : "")).trim();
             }
        %>
        <div class="eq-card">
            <h3><%= esc(eq.getNom()) %></h3>
            <p><%= eq.getDescription() != null && !eq.getDescription().isEmpty()
                    ? esc(eq.getDescription()) : "Aucune description disponible." %></p>
            <div class="eq-meta">
                <span>👤 Chef d'équipe : <strong><%= esc(chef) %></strong></span>
                <span class="eq-badge"><%= eq.getNbMembres() %> membre<%= eq.getNbMembres() > 1 ? "s" : "" %></span>
            </div>
        </div>
        <% } %>
    </div>
    <% } else { %>
    <div class="eq-empty">
        <div style="font-size:38px;margin-bottom:12px;">👥</div>
        <h3>Aucune équipe disponible</h3>
        <p>Les équipes seront affichées ici lorsqu'elles seront créées.</p>
    </div>
    <% } %>

</main>

</body>
</html>