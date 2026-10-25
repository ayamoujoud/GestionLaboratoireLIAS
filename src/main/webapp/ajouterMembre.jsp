<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
if(session.getAttribute("user") == null){ response.sendRedirect("login.jsp"); return; }
request.setAttribute("currentPage","membres");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Ajouter un membre — LIAS</title>
<%@ include file="/WEB-INF/style.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/sidebar.jsp" %>

<main class="main">
  <div class="page-header">
    <div style="display:flex;align-items:center;gap:10px;margin-bottom:6px;">
      <a href="listeMembres" style="color:var(--text-muted);text-decoration:none;font-size:13px;">← Membres</a>
    </div>
    <h1>Ajouter un membre</h1>
    <p>Créer un nouveau profil membre dans le laboratoire</p>
  </div>

  <div class="card" style="max-width:720px;">
    <form action="ajouterMembre" method="post">
      <div style="margin-bottom:24px;padding-bottom:16px;border-bottom:1px solid var(--border);">
        <span style="font-size:13px;font-weight:600;color:var(--text);">Informations personnelles</span>
      </div>
      <div class="form-grid">
        <div class="form-group">
          <label>Prénom <span style="color:var(--red)">*</span></label>
          <input type="text" name="prenom" placeholder="ex: Fatima" required>
        </div>
        <div class="form-group">
          <label>Nom <span style="color:var(--red)">*</span></label>
          <input type="text" name="nom" placeholder="ex: Bensaid" required>
        </div>
        <div class="form-group form-full">
          <label>Email <span style="color:var(--red)">*</span></label>
          <input type="email" name="email" placeholder="prenom.nom@exemple.ma" required>
        </div>
        <div class="form-group">
          <label>Statut</label>
          <select name="statut">
            <option value="">— Choisir —</option>
            <option value="permanent">Permanent</option>
            <option value="associé">Associé</option>
            <option value="doctorant">Doctorant</option>
            <option value="retraité">Retraité</option>
            <option value="ancien">Ancien membre</option>
          </select>
        </div>
        <div class="form-group">
          <label>Équipe</label>
          <input type="text" name="equipe" placeholder="ex: Équipe Systèmes Distribués">
        </div>
      </div>

      <div style="margin:24px 0 16px;padding-bottom:16px;border-bottom:1px solid var(--border);">
        <span style="font-size:13px;font-weight:600;color:var(--text);">Affiliation</span>
      </div>
      <div class="form-grid">
        <div class="form-group">
          <label>Établissement</label>
          <input type="text" name="etablissement" placeholder="ex: Université Hassan II">
        </div>
        <div class="form-group">
          <label>Laboratoire d'origine</label>
          <input type="text" name="laboratoireOrigine" placeholder="ex: LRIT">
        </div>
      </div>

      <div style="margin:24px 0 16px;padding-bottom:16px;border-bottom:1px solid var(--border);">
        <span style="font-size:13px;font-weight:600;color:var(--text);">Profil</span>
      </div>
      <div class="form-group">
        <label>Biographie</label>
        <textarea name="biographie" placeholder="Présentation du membre, domaines de recherche..."></textarea>
      </div>
      <div class="form-group">
        <label>Centres d'intérêt</label>
        <input type="text" name="centresInteret" placeholder="ex: Machine Learning, Réseaux, Sécurité">
      </div>

      <div style="display:flex;gap:10px;margin-top:8px;">
        <button type="submit" class="btn btn-primary">Ajouter le membre</button>
        <a href="listeMembres" class="btn btn-ghost">Annuler</a>
      </div>
    </form>
  </div>
</main>
</body>
</html>
