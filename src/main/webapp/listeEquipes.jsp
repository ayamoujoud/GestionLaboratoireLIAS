<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Equipe" %>
<%@ page import="model.Membre" %>
<%
if(session.getAttribute("user") == null){ response.sendRedirect("login.jsp"); return; }
List<Equipe> equipes = (List<Equipe>) request.getAttribute("equipes");
List<Membre> membres = (List<Membre>) request.getAttribute("membres");
request.setAttribute("currentPage","equipes");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Équipes — LIAS</title>
<%@ include file="/WEB-INF/style.jsp" %>
<style>
.team-card{
  background:#fff;border:1px solid var(--border);border-radius:12px;
  padding:20px;display:flex;flex-direction:column;gap:10px;
}
.team-card h3{font-size:15px;font-weight:600;color:var(--text);margin:0;}
.team-card .desc{font-size:13px;color:var(--text-muted);min-height:36px;}
.team-card .chef-row{display:flex;align-items:center;gap:8px;font-size:13px;}
.team-card .chef-avatar{
  width:26px;height:26px;border-radius:50%;background:var(--blue-pale);color:var(--blue);
  display:inline-flex;align-items:center;justify-content:center;font-size:11px;font-weight:600;
}
.team-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(260px,1fr));gap:16px;}
.modal-overlay{
  display:none;position:fixed;inset:0;background:rgba(11,31,69,.45);
  align-items:center;justify-content:center;z-index:50;
}
.modal-overlay.open{display:flex;}
.modal-box{background:#fff;border-radius:14px;padding:28px;width:420px;max-width:90vw;}
.modal-box h2{font-size:18px;margin-bottom:18px;color:var(--text);}
.modal-actions{display:flex;justify-content:flex-end;gap:10px;margin-top:8px;}
</style>
</head>
<body>
<%@ include file="/WEB-INF/sidebar.jsp" %>

<main class="main">
  <div class="page-header page-header-row">
    <div>
      <h1>Équipes</h1>
      <p>Organisation du laboratoire par équipe de recherche</p>
    </div>
    <button class="btn btn-primary" onclick="document.getElementById('modalAjout').classList.add('open')">+ Nouvelle équipe</button>
  </div>

  <% if(equipes != null && !equipes.isEmpty()) { %>
  <div class="team-grid">
    <% for(Equipe eq : equipes) {
         String initials = "—";
         if(eq.getNomChef() != null && eq.getPrenomChef() != null && !eq.getNomChef().isEmpty() && !eq.getPrenomChef().isEmpty())
           initials = (eq.getPrenomChef().substring(0,1) + eq.getNomChef().substring(0,1)).toUpperCase();
    %>
    <div class="team-card">
      <h3>🏛 <%= eq.getNom() %></h3>
      <div class="desc"><%= eq.getDescription() != null && !eq.getDescription().isEmpty() ? eq.getDescription() : "Aucune description." %></div>
      <div class="chef-row">
        <span class="chef-avatar"><%= initials %></span>
        <span>
          <% if(eq.getNomChef() != null) { %>
            Chef : <%= eq.getPrenomChef() %> <%= eq.getNomChef() %>
          <% } else { %>
            Aucun chef désigné
          <% } %>
        </span>
      </div>
      <div style="font-size:13px;color:var(--text-muted);"><%= eq.getNbMembres() %> membre(s)</div>
      <div style="display:flex;gap:8px;margin-top:6px;">
        <a href="modifierEquipe?id=<%= eq.getId() %>" class="btn btn-ghost btn-sm">✏ Modifier</a>
        <a href="supprimerEquipe?id=<%= eq.getId() %>" class="btn btn-danger btn-sm"
           onclick="return confirm('Supprimer cette équipe ?')">✕</a>
      </div>
    </div>
    <% } %>
  </div>
  <% } else { %>
  <div class="card">
    <div class="empty-state">
      <div class="es-icon">🏛</div>
      <h3>Aucune équipe enregistrée</h3>
      <p>Créez votre première équipe de recherche pour commencer.</p>
    </div>
  </div>
  <% } %>
</main>

<!-- Modal ajout équipe -->
<div class="modal-overlay" id="modalAjout">
  <div class="modal-box">
    <h2>Nouvelle équipe</h2>
    <form action="ajouterEquipe" method="post">
      <div class="form-group">
        <label>Nom de l'équipe *</label>
        <input type="text" name="nom" placeholder="Ex : Intelligence Artificielle" required>
      </div>
      <div class="form-group">
        <label>Description</label>
        <textarea name="description" placeholder="Domaine de recherche, objectifs..."></textarea>
      </div>
      <div class="form-group">
        <label>Chef d'équipe</label>
        <select name="chefId">
          <option value="">— Aucun pour l'instant —</option>
          <% if(membres != null) { for(Membre m : membres) { %>
          <option value="<%= m.getId() %>"><%= m.getPrenom() %> <%= m.getNom() %></option>
          <% } } %>
        </select>
      </div>
      <div class="modal-actions">
        <button type="button" class="btn btn-ghost" onclick="document.getElementById('modalAjout').classList.remove('open')">Annuler</button>
        <button type="submit" class="btn btn-primary">Créer l'équipe</button>
      </div>
    </form>
  </div>
</div>

</body>
</html>
