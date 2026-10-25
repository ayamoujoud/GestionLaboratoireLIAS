<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, model.*" %>
<%
if (session.getAttribute("user") == null) { response.sendRedirect("login.jsp"); return; }
String q = (String) request.getAttribute("q");
if (q == null) q = "";
List<Membre>      resMembres      = (List<Membre>)           request.getAttribute("resMembres");
List<Publication> resPublications = (List<Publication>)      request.getAttribute("resPublications");
List<Evenement>   resEvenements   = (List<Evenement>)        request.getAttribute("resEvenements");
List<Map<String,String>> resDocs  = (List<Map<String,String>>) request.getAttribute("resDocuments");
Integer total = (Integer) request.getAttribute("totalResultats");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Recherche — LIAS</title>
<%@ include file="/WEB-INF/style.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/sidebar.jsp" %>

<main class="main">
  <div class="page-header">
    <h1>Recherche globale</h1>
    <p>Membres, publications, événements, documents</p>
  </div>

  <!-- Barre de recherche principale -->
  <div class="card" style="padding:24px;margin-bottom:24px;">
    <form action="recherche" method="get" style="display:flex;gap:12px;">
      <input type="text" name="q" value="<%= q %>"
             placeholder="Rechercher dans tout le laboratoire..."
             style="flex:1;padding:12px 16px;border:2px solid var(--blue);border-radius:10px;
                    font-size:15px;outline:none;font-family:inherit;"
             autofocus>
      <button type="submit" class="btn btn-primary" style="padding:12px 28px;font-size:15px;">
        🔍 Rechercher
      </button>
    </form>
  </div>

  <% if (!q.isEmpty()) { %>

  <!-- Résumé -->
  <div style="margin-bottom:20px;font-size:14px;color:var(--text-muted);">
    <% if (total != null && total > 0) { %>
    <strong style="color:var(--dark);"><%= total %> résultat(s)</strong> pour "<%= q %>"
    <% } else { %>
    <strong style="color:var(--dark);">Aucun résultat</strong> pour "<%= q %>"
    <% } %>
  </div>

  <!-- Membres -->
  <% if (resMembres != null && !resMembres.isEmpty()) { %>
  <h2 style="font-size:15px;font-weight:600;color:var(--dark);margin-bottom:12px;">
    👥 Membres (<%= resMembres.size() %>)
  </h2>
  <div class="card" style="margin-bottom:24px;">
    <div class="table-wrap">
      <table>
        <thead><tr><th>Nom</th><th>Email</th><th>Statut</th><th>Équipe</th></tr></thead>
        <tbody>
          <% for (Membre m : resMembres) { %>
          <tr>
            <td><strong><%= m.getPrenom() %> <%= m.getNom() %></strong></td>
            <td><%= m.getEmail() %></td>
            <td><span style="background:#eff6ff;color:var(--blue);padding:2px 8px;border-radius:6px;font-size:12px;">
              <%= m.getStatut() != null ? m.getStatut() : "—" %>
            </span></td>
            <td><%= m.getEquipe() != null ? m.getEquipe() : "—" %></td>
          </tr>
          <% } %>
        </tbody>
      </table>
    </div>
  </div>
  <% } %>

  <!-- Publications -->
  <% if (resPublications != null && !resPublications.isEmpty()) { %>
  <h2 style="font-size:15px;font-weight:600;color:var(--dark);margin-bottom:12px;">
    📄 Publications (<%= resPublications.size() %>)
  </h2>
  <div class="card" style="margin-bottom:24px;">
    <div class="table-wrap">
      <table>
        <thead><tr><th>Titre</th><th>Auteur</th><th>Année</th><th>Type</th></tr></thead>
        <tbody>
          <% for (Publication p : resPublications) { %>
          <tr>
            <td><strong><%= p.getTitre() %></strong></td>
            <td><%= p.getAuteur() %></td>
            <td><%= p.getAnnee() %></td>
            <td><%= p.getType() != null ? p.getType() : "—" %></td>
          </tr>
          <% } %>
        </tbody>
      </table>
    </div>
  </div>
  <% } %>

  <!-- Événements -->
  <% if (resEvenements != null && !resEvenements.isEmpty()) { %>
  <h2 style="font-size:15px;font-weight:600;color:var(--dark);margin-bottom:12px;">
    📅 Événements (<%= resEvenements.size() %>)
  </h2>
  <div class="card" style="margin-bottom:24px;">
    <div class="table-wrap">
      <table>
        <thead><tr><th>Titre</th><th>Type</th><th>Lieu</th><th>Date début</th></tr></thead>
        <tbody>
          <% for (Evenement e : resEvenements) { %>
          <tr>
            <td><strong><%= e.getTitre() %></strong></td>
            <td><%= e.getType() != null ? e.getType() : "—" %></td>
            <td><%= e.getLieu() != null ? e.getLieu() : "—" %></td>
            <td><%= e.getDateDebut() %></td>
          </tr>
          <% } %>
        </tbody>
      </table>
    </div>
  </div>
  <% } %>

  <!-- Documents -->
  <% if (resDocs != null && !resDocs.isEmpty()) { %>
  <h2 style="font-size:15px;font-weight:600;color:var(--dark);margin-bottom:12px;">
    🗂️ Documents (<%= resDocs.size() %>)
  </h2>
  <div class="card" style="margin-bottom:24px;">
    <div class="table-wrap">
      <table>
        <thead><tr><th>Titre</th><th>Type</th><th>Télécharger</th></tr></thead>
        <tbody>
          <% for (Map<String,String> doc : resDocs) { %>
          <tr>
            <td><strong><%= doc.get("titre") %></strong></td>
            <td><%= doc.get("type") != null ? doc.get("type") : "—" %></td>
            <td>
              <% if (doc.get("chemin") != null) { %>
              <a href="<%= doc.get("chemin") %>" target="_blank"
                 style="color:var(--blue);font-size:13px;">📥 Télécharger</a>
              <% } else { %>—<% } %>
            </td>
          </tr>
          <% } %>
        </tbody>
      </table>
    </div>
  </div>
  <% } %>

  <% } else { %>
  <!-- État initial -->
  <div class="card">
    <div class="empty-state">
      <div class="es-icon">🔍</div>
      <h3>Lancez une recherche</h3>
      <p>Tapez un mot-clé pour trouver des membres, publications, événements ou documents.</p>
    </div>
  </div>
  <% } %>

</main>
</body>
</html>