<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Membre, model.Utilisateur" %>
<%
Utilisateur user = (Utilisateur) session.getAttribute("user");
if (user == null) { response.sendRedirect("login.jsp"); return; }
Membre membre = (Membre) request.getAttribute("membre");
if (membre == null) { response.sendRedirect("modifierMonProfil"); return; }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Modifier mon Profil — LIAS</title>
<%@ include file="/WEB-INF/style.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/sidebar.jsp" %>

<main class="main">
  <div class="page-header">
    <h1>Modifier mon Profil</h1>
    <p>Mettez à jour vos informations personnelles</p>
  </div>

  <div class="card" style="max-width:800px;">
    <form action="modifierMonProfil" method="post">

      <div style="display:grid;grid-template-columns:1fr 1fr;gap:20px;">

        <div class="form-group">
          <label>Établissement</label>
          <input type="text" name="etablissement"
                 value="<%= membre.getEtablissement() != null ? membre.getEtablissement() : "" %>">
        </div>

        <div class="form-group">
          <label>Laboratoire d'origine</label>
          <input type="text" name="laboratoireOrigine"
                 value="<%= membre.getLaboratoireOrigine() != null ? membre.getLaboratoireOrigine() : "" %>">
        </div>
      </div>

      <div class="form-group">
        <label>Biographie</label>
        <textarea name="biographie" rows="5" placeholder="Décrivez votre parcours..."><%= membre.getBiographie() != null ? membre.getBiographie() : "" %></textarea>
      </div>

      <div class="form-group">
        <label>Centres d'intérêt</label>
        <input type="text" name="centresInteret" placeholder="ex: Machine Learning, Vision par ordinateur..."
               value="<%= membre.getCentresInteret() != null ? membre.getCentresInteret() : "" %>">
      </div>

      <div style="display:flex;gap:12px;margin-top:8px;">
        <button type="submit" class="btn btn-primary">💾 Enregistrer</button>
        <a href="monProfil" class="btn btn-ghost">Annuler</a>
      </div>

    </form>
  </div>
</main>
</body>
</html>