<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Publication" %>
<%
if(session.getAttribute("user") == null){ response.sendRedirect("login.jsp"); return; }
Publication p = (Publication) request.getAttribute("publication");
request.setAttribute("currentPage","publications");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Modifier une publication — LIAS</title>
<%@ include file="/WEB-INF/style.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/sidebar.jsp" %>
<main class="main">
  <div class="page-header">
    <div style="margin-bottom:6px;"><a href="listePublications" style="color:var(--text-muted);text-decoration:none;font-size:13px;">← Publications</a></div>
    <h1>Modifier la publication</h1>
  </div>
  <div class="card" style="max-width:620px;">
    <% if(p != null) { %>
    <form action="modifierPublication" method="post">
      <input type="hidden" name="id" value="<%= p.getId() %>">
      <div class="form-group">
        <label>Titre</label>
        <input type="text" name="titre" value="<%= p.getTitre() != null ? p.getTitre() : "" %>">
      </div>
      <div class="form-grid">
        <div class="form-group">
          <label>Auteur(s)</label>
          <input type="text" name="auteur" value="<%= p.getAuteur() != null ? p.getAuteur() : "" %>">
        </div>
        <div class="form-group">
          <label>Année</label>
          <input type="number" name="annee" value="<%= p.getAnnee() %>">
        </div>
        <div class="form-group">
          <label>Équipe</label>
          <input type="text" name="equipe" value="<%= p.getEquipe() != null ? p.getEquipe() : "" %>">
        </div>
        <div class="form-group">
          <label>Type</label>
          <select name="type">
            <option value="Revue internationale"      <%= "Revue internationale".equals(p.getType())      ? "selected":"" %>>Revue internationale</option>
            <option value="Conférence internationale" <%= "Conférence internationale".equals(p.getType()) ? "selected":"" %>>Conférence internationale</option>
            <option value="Conférence nationale"      <%= "Conférence nationale".equals(p.getType())      ? "selected":"" %>>Conférence nationale</option>
            <option value="Chapitre de livre"         <%= "Chapitre de livre".equals(p.getType())         ? "selected":"" %>>Chapitre de livre</option>
            <option value="Thèse"                     <%= "Thèse".equals(p.getType())                     ? "selected":"" %>>Thèse</option>
          </select>
        </div>
      </div>
      <div style="display:flex;gap:10px;margin-top:8px;">
        <button type="submit" class="btn btn-primary">Enregistrer</button>
        <a href="listePublications" class="btn btn-ghost">Annuler</a>
      </div>
    </form>
    <% } else { %>
    <div class="empty-state">
      <div class="es-icon">⚠️</div>
      <h3>Publication introuvable</h3>
      <a href="listePublications" class="btn btn-primary" style="margin-top:16px;">Retour</a>
    </div>
    <% } %>
  </div>
</main>
</body>
</html>
