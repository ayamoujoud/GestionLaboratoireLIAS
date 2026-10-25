<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
if(session.getAttribute("user") == null){ response.sendRedirect("login.jsp"); return; }
request.setAttribute("currentPage","evenements");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Ajouter un événement — LIAS</title>
<%@ include file="/WEB-INF/style.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/sidebar.jsp" %>
<main class="main">
  <div class="page-header">
    <div style="margin-bottom:6px;"><a href="listeEvenements" style="color:var(--text-muted);text-decoration:none;font-size:13px;">← Événements</a></div>
    <h1>Ajouter un événement</h1>
    <p>Créer un nouvel événement scientifique</p>
  </div>
  <div class="card" style="max-width:620px;">
    <form action="ajouterEvenement" method="post">
      <div class="form-group">
        <label>Titre <span style="color:var(--red)">*</span></label>
        <input type="text" name="titre" placeholder="Titre de l'événement" required>
      </div>
      <div class="form-grid">
        <div class="form-group">
          <label>Type</label>
          <select name="type">
            <option value="Conférence">Conférence</option>
            <option value="Séminaire">Séminaire</option>
            <option value="Workshop">Workshop</option>
          </select>
        </div>
        <div class="form-group">
          <label>Lieu</label>
          <input type="text" name="lieu" placeholder="ex: Casablanca, Maroc">
        </div>
        <div class="form-group">
          <label>Date de début</label>
          <input type="date" name="dateDebut">
        </div>
        <div class="form-group">
          <label>Date de fin</label>
          <input type="date" name="dateFin">
        </div>
      </div>
      <div style="display:flex;gap:10px;margin-top:8px;">
        <button type="submit" class="btn btn-primary">Créer l'événement</button>
        <a href="listeEvenements" class="btn btn-ghost">Annuler</a>
      </div>
    </form>
  </div>
</main>
</body>
</html>
