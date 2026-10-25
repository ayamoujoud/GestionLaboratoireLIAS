<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Evenement" %>
<%
if(session.getAttribute("user") == null){ response.sendRedirect("login.jsp"); return; }
Evenement e = (Evenement) request.getAttribute("evenement");
request.setAttribute("currentPage","evenements");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Modifier un événement — LIAS</title>
<%@ include file="/WEB-INF/style.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/sidebar.jsp" %>
<main class="main">
  <div class="page-header">
    <div style="margin-bottom:6px;"><a href="listeEvenements" style="color:var(--text-muted);text-decoration:none;font-size:13px;">← Événements</a></div>
    <h1>Modifier l'événement</h1>
  </div>
  <div class="card" style="max-width:620px;">
    <% if(e != null) { %>
    <form action="modifierEvenement" method="post">
      <input type="hidden" name="id" value="<%= e.getId() %>">
      <div class="form-group">
        <label>Titre</label>
        <input type="text" name="titre" value="<%= e.getTitre() != null ? e.getTitre() : "" %>" required>
      </div>
      <div class="form-grid">
        <div class="form-group">
          <label>Type</label>
          <select name="type">
            <option value="Conférence"  <%= "Conférence".equals(e.getType())  ? "selected":"" %>>Conférence</option>
            <option value="Séminaire"   <%= "Séminaire".equals(e.getType())   ? "selected":"" %>>Séminaire</option>
            <option value="Workshop"    <%= "Workshop".equals(e.getType())    ? "selected":"" %>>Workshop</option>
          </select>
        </div>
        <div class="form-group">
          <label>Lieu</label>
          <input type="text" name="lieu" value="<%= e.getLieu() != null ? e.getLieu() : "" %>">
        </div>
        <div class="form-group">
          <label>Date de début</label>
          <input type="date" name="dateDebut" value="<%= e.getDateDebut() != null ? e.getDateDebut() : "" %>">
        </div>
        <div class="form-group">
          <label>Date de fin</label>
          <input type="date" name="dateFin" value="<%= e.getDateFin() != null ? e.getDateFin() : "" %>">
        </div>
      </div>
      <div style="display:flex;gap:10px;margin-top:8px;">
        <button type="submit" class="btn btn-primary">Enregistrer</button>
        <a href="listeEvenements" class="btn btn-ghost">Annuler</a>
      </div>
    </form>
    <% } else { %>
    <div class="empty-state">
      <div class="es-icon">⚠️</div>
      <h3>Événement introuvable</h3>
      <a href="listeEvenements" class="btn btn-primary" style="margin-top:16px;">Retour</a>
    </div>
    <% } %>
  </div>
</main>
</body>
</html>
