<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Membre" %>
<%
if(session.getAttribute("user") == null){ response.sendRedirect("login.jsp"); return; }
Membre m = (Membre) request.getAttribute("membre");
request.setAttribute("currentPage","membres");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Modifier un membre — LIAS</title>
<%@ include file="/WEB-INF/style.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/sidebar.jsp" %>
<main class="main">
  <div class="page-header">
    <div style="margin-bottom:6px;"><a href="listeMembres" style="color:var(--text-muted);text-decoration:none;font-size:13px;">← Membres</a></div>
    <h1>Modifier le membre</h1>
    <p><%= (m != null && m.getPrenom() != null) ? m.getPrenom() + " " + m.getNom() : "Profil" %></p>
  </div>

  <div class="card" style="max-width:720px;">
    <% if(m != null) { %>
    <form action="modifierMembre" method="post">
      <input type="hidden" name="id" value="<%= m.getId() %>">

      <div style="margin-bottom:24px;padding-bottom:16px;border-bottom:1px solid var(--border);">
        <span style="font-size:13px;font-weight:600;">Informations personnelles</span>
      </div>
      <div class="form-grid">
        <div class="form-group">
          <label>Prénom</label>
          <input type="text" name="prenom" value="<%= m.getPrenom() != null ? m.getPrenom() : "" %>">
        </div>
        <div class="form-group">
          <label>Nom</label>
          <input type="text" name="nom" value="<%= m.getNom() != null ? m.getNom() : "" %>">
        </div>
        <div class="form-group form-full">
          <label>Email</label>
          <input type="email" name="email" value="<%= m.getEmail() != null ? m.getEmail() : "" %>">
        </div>
        <div class="form-group">
          <label>Statut</label>
          <select name="statut">
            <option value="permanent"  <%= "permanent".equalsIgnoreCase(m.getStatut())  ? "selected" : "" %>>Permanent</option>
            <option value="associé"    <%= "associé".equalsIgnoreCase(m.getStatut())    ? "selected" : "" %>>Associé</option>
            <option value="doctorant"  <%= "doctorant".equalsIgnoreCase(m.getStatut())  ? "selected" : "" %>>Doctorant</option>
            <option value="retraité"   <%= "retraité".equalsIgnoreCase(m.getStatut())   ? "selected" : "" %>>Retraité</option>
            <option value="ancien"     <%= "ancien".equalsIgnoreCase(m.getStatut())     ? "selected" : "" %>>Ancien membre</option>
          </select>
        </div>
        <div class="form-group">
          <label>Équipe</label>
          <input type="text" name="equipe" value="<%= m.getEquipe() != null ? m.getEquipe() : "" %>">
        </div>
      </div>

      <div style="margin:24px 0 16px;padding-bottom:16px;border-bottom:1px solid var(--border);">
        <span style="font-size:13px;font-weight:600;">Affiliation</span>
      </div>
      <div class="form-grid">
        <div class="form-group">
          <label>Établissement</label>
          <input type="text" name="etablissement" value="<%= m.getEtablissement() != null ? m.getEtablissement() : "" %>">
        </div>
        <div class="form-group">
          <label>Laboratoire d'origine</label>
          <input type="text" name="laboratoireOrigine" value="<%= m.getLaboratoireOrigine() != null ? m.getLaboratoireOrigine() : "" %>">
        </div>
      </div>

      <div style="margin:24px 0 16px;padding-bottom:16px;border-bottom:1px solid var(--border);">
        <span style="font-size:13px;font-weight:600;">Profil</span>
      </div>
      <div class="form-group">
        <label>Biographie</label>
        <textarea name="biographie"><%= m.getBiographie() != null ? m.getBiographie() : "" %></textarea>
      </div>
      <div class="form-group">
        <label>Centres d'intérêt</label>
        <input type="text" name="centresInteret" value="<%= m.getCentresInteret() != null ? m.getCentresInteret() : "" %>">
      </div>

      <div style="display:flex;gap:10px;margin-top:8px;">
        <button type="submit" class="btn btn-primary">Enregistrer les modifications</button>
        <a href="listeMembres" class="btn btn-ghost">Annuler</a>
      </div>
    </form>
    <% } else { %>
    <div class="empty-state">
      <div class="es-icon">⚠️</div>
      <h3>Membre introuvable</h3>
      <p>Ce membre n'existe pas ou a été supprimé.</p>
      <a href="listeMembres" class="btn btn-primary" style="margin-top:16px;">Retour à la liste</a>
    </div>
    <% } %>
  </div>
</main>
</body>
</html>
