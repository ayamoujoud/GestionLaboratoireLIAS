<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Equipe" %>
<%@ page import="model.Membre" %>
<%
if(session.getAttribute("user") == null){ response.sendRedirect("login.jsp"); return; }
Equipe equipe = (Equipe) request.getAttribute("equipe");
List<Membre> membres = (List<Membre>) request.getAttribute("membres");
request.setAttribute("currentPage","equipes");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Modifier l'équipe — LIAS</title>
<%@ include file="/WEB-INF/style.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/sidebar.jsp" %>

<main class="main">
  <div class="page-header">
    <h1>Modifier l'équipe</h1>
    <p>Mettre à jour le nom, la description ou le chef d'équipe</p>
  </div>

  <div class="card" style="max-width:480px;">
    <form action="modifierEquipe" method="post">
      <input type="hidden" name="id" value="<%= equipe.getId() %>">

      <div class="form-group">
        <label>Nom de l'équipe *</label>
        <input type="text" name="nom" value="<%= equipe.getNom() != null ? equipe.getNom() : "" %>" required>
      </div>

      <div class="form-group">
        <label>Description</label>
        <textarea name="description"><%= equipe.getDescription() != null ? equipe.getDescription() : "" %></textarea>
      </div>

      <div class="form-group">
        <label>Chef d'équipe</label>
        <select name="chefId">
          <option value="">— Aucun —</option>
          <% if(membres != null) { for(Membre m : membres) { %>
          <option value="<%= m.getId() %>" <%= m.getId() == equipe.getChefId() ? "selected" : "" %>>
            <%= m.getPrenom() %> <%= m.getNom() %>
          </option>
          <% } } %>
        </select>
      </div>

      <div style="display:flex;gap:10px;margin-top:10px;">
        <a href="listeEquipes" class="btn btn-ghost">Annuler</a>
        <button type="submit" class="btn btn-primary">Enregistrer</button>
      </div>
    </form>
  </div>
</main>
</body>
</html>
