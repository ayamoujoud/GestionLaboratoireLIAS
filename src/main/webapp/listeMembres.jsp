<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Membre" %>
<%
if(session.getAttribute("user") == null){ response.sendRedirect("login.jsp"); return; }
List<Membre> membres = (List<Membre>) request.getAttribute("membres");
request.setAttribute("currentPage","membres");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Membres — LIAS</title>
<%@ include file="/WEB-INF/style.jsp" %>
<style>
.member-avatar{
  width:34px;height:34px;border-radius:50%;
  background:var(--blue-pale);color:var(--blue);
  display:inline-flex;align-items:center;justify-content:center;
  font-size:12px;font-weight:600;flex-shrink:0;
}
.member-name-cell{display:flex;align-items:center;gap:10px;}
</style>
</head>
<body>
<%@ include file="/WEB-INF/sidebar.jsp" %>

<main class="main">
  <div class="page-header page-header-row">
    <div>
      <h1>Membres</h1>
      <p>Liste des membres du laboratoire LIAS</p>
    </div>
    <a href="ajouterMembre.jsp" class="btn btn-primary">+ Ajouter un membre</a>
  </div>

  <div class="card">
    <div class="actions-bar">
      <div class="search-box">
        <span style="color:var(--text-muted);">🔍</span>
        <input type="text" id="searchInput" placeholder="Rechercher un membre..." oninput="filterTable()">
      </div>
      <div style="display:flex;gap:8px;">
        <select id="filterStatut" onchange="filterTable()" style="border:1px solid var(--border);border-radius:8px;padding:7px 12px;font-size:13px;font-family:inherit;color:var(--text);background:#fff;cursor:pointer;">
          <option value="">Tous les statuts</option>
          <option value="permanent">Permanent</option>
          <option value="associé">Associé</option>
          <option value="doctorant">Doctorant</option>
          <option value="retraité">Retraité</option>
        </select>
      </div>
    </div>

    <div class="table-wrap">
      <table id="membresTable">
        <thead>
          <tr>
            <th>Membre</th>
            <th>Email</th>
            <th>Statut</th>
            <th>Établissement</th>
            <th>Équipe</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <% if(membres != null && !membres.isEmpty()) {
               for(Membre m : membres) {
                 String initials = "";
                 if(m.getNom() != null && m.getPrenom() != null && !m.getNom().isEmpty() && !m.getPrenom().isEmpty())
                   initials = m.getPrenom().substring(0,1) + m.getNom().substring(0,1);
                 else if(m.getNom() != null && m.getNom().length() >= 1)
                   initials = m.getNom().substring(0,Math.min(2,m.getNom().length()));

                 String statut = m.getStatut() != null ? m.getStatut() : "";
                 String badgeClass = "badge-gray";
                 if(statut.toLowerCase().contains("permanent")) badgeClass = "badge-blue";
                 else if(statut.toLowerCase().contains("doctorant")) badgeClass = "badge-green";
                 else if(statut.toLowerCase().contains("associé")) badgeClass = "badge-amber";
                 else if(statut.toLowerCase().contains("retraité")) badgeClass = "badge-gray";
          %>
          <tr>
            <td>
              <div class="member-name-cell">
                <div class="member-avatar"><%= initials.toUpperCase() %></div>
                <div>
                  <div style="font-weight:500;"><%= m.getPrenom() != null ? m.getPrenom() : "" %> <%= m.getNom() != null ? m.getNom() : "" %></div>
                </div>
              </div>
            </td>
            <td style="color:var(--text-muted);"><%= m.getEmail() != null ? m.getEmail() : "—" %></td>
            <td><span class="badge <%= badgeClass %>"><%= statut.isEmpty() ? "—" : statut %></span></td>
            <td style="color:var(--text-muted);font-size:13px;"><%= m.getEtablissement() != null ? m.getEtablissement() : "—" %></td>
            <td style="color:var(--text-muted);font-size:13px;"><%= m.getEquipe() != null ? m.getEquipe() : "—" %></td>
            <td>
              <div style="display:flex;gap:6px;">
                <a href="modifierMembre?id=<%= m.getId() %>" class="btn btn-ghost btn-sm">✏ Modifier</a>
                <a href="supprimerMembre?id=<%= m.getId() %>" class="btn btn-danger btn-sm"
                   onclick="return confirm('Supprimer ce membre ?')">✕</a>
              </div>
            </td>
          </tr>
          <% } } else { %>
          <tr>
            <td colspan="6">
              <div class="empty-state">
                <div class="es-icon">👥</div>
                <h3>Aucun membre enregistré</h3>
                <p>Ajoutez votre premier membre pour commencer.</p>
              </div>
            </td>
          </tr>
          <% } %>
        </tbody>
      </table>
    </div>
  </div>
</main>

<script>
function filterTable() {
  const q       = document.getElementById('searchInput').value.toLowerCase();
  const statut  = document.getElementById('filterStatut').value.toLowerCase();
  const rows    = document.querySelectorAll('#membresTable tbody tr');
  rows.forEach(r => {
    const text = r.innerText.toLowerCase();
    const matchQ = text.includes(q);
    const matchS = !statut || text.includes(statut);
    r.style.display = (matchQ && matchS) ? '' : 'none';
  });
}
</script>
</body>
</html>
