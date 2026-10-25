<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
if(session.getAttribute("user") == null){ response.sendRedirect("login.jsp"); return; }
request.setAttribute("currentPage","publications");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Ajouter une publication — LIAS</title>
<%@ include file="/WEB-INF/style.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/sidebar.jsp" %>
<main class="main">
  <div class="page-header">
    <div style="margin-bottom:6px;"><a href="listePublications" style="color:var(--text-muted);text-decoration:none;font-size:13px;">← Publications</a></div>
    <h1>Ajouter une publication</h1>
    <p>Enregistrer une nouvelle publication scientifique</p>
  </div>
  <div class="card" style="max-width:620px;">
    <form action="ajouterPublication" method="post">
      <div class="form-group">
        <label>Titre <span style="color:var(--red)">*</span></label>
        <input type="text" name="titre" placeholder="Titre complet de la publication" required>
      </div>
      <div class="form-grid">
        <div class="form-group">
          <label>Auteur(s) <span style="color:var(--red)">*</span></label>
          <input type="text" name="auteur" placeholder="Nom Prénom, Nom Prénom..." required>
        </div>
        <div class="form-group">
          <label>Année <span style="color:var(--red)">*</span></label>
          <input type="number" name="annee" placeholder="2026" min="1990" max="2030" required>
        </div>
        <div class="form-group">
          <label>Équipe</label>
          <input type="text" name="equipe" placeholder="ex: Équipe IA">
        </div>
        <div class="form-group">
          <label>Type de publication</label>
          <select name="type">
            <option value="">— Choisir —</option>
            <option value="Revue internationale">Revue internationale</option>
            <option value="Conférence internationale">Conférence internationale</option>
            <option value="Conférence nationale">Conférence nationale</option>
            <option value="Chapitre de livre">Chapitre de livre</option>
            <option value="Thèse">Thèse</option>
            <option value="Rapport technique">Rapport technique</option>
          </select>
        </div>
      </div>
      <div style="display:flex;gap:10px;margin-top:8px;">
        <button type="submit" class="btn btn-primary">Enregistrer</button>
        <a href="listePublications" class="btn btn-ghost">Annuler</a>
      </div>
    </form>
  </div>
</main>
</body>
</html>
