<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Evenement" %>
<%
if(session.getAttribute("user") == null){ response.sendRedirect("login.jsp"); return; }
List<Evenement> evenements = (List<Evenement>) request.getAttribute("evenements");
request.setAttribute("currentPage","evenements");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Événements — LIAS</title>
<%@ include file="/WEB-INF/style.jsp" %>
<style>
.event-type-icon { font-size:18px; margin-right:4px; }
</style>
</head>
<body>
<%@ include file="/WEB-INF/sidebar.jsp" %>

<main class="main">
  <div class="page-header page-header-row">
    <div>
      <h1>Événements scientifiques</h1>
      <p>Conférences, séminaires et workshops du laboratoire</p>
    </div>
    <a href="ajouterEvenement.jsp" class="btn btn-primary">+ Ajouter un événement</a>
  </div>

  <div class="card">
    <div class="actions-bar">
      <div class="search-box">
        <span style="color:var(--text-muted);">🔍</span>
        <input type="text" id="searchInput" placeholder="Rechercher un événement..." oninput="filterTable()">
      </div>
      <select id="filterType" onchange="filterTable()" style="border:1px solid var(--border);border-radius:8px;padding:7px 12px;font-size:13px;font-family:inherit;background:#fff;cursor:pointer;">
        <option value="">Tous les types</option>
        <option value="Conférence">Conférence</option>
        <option value="Séminaire">Séminaire</option>
        <option value="Workshop">Workshop</option>
      </select>
    </div>

    <div class="table-wrap">
      <table id="evtTable">
        <thead>
          <tr>
            <th>Titre</th>
            <th>Type</th>
            <th>Lieu</th>
            <th>Date début</th>
            <th>Date fin</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <% if(evenements != null && !evenements.isEmpty()) {
               for(Evenement e : evenements) {
                 String type = e.getType() != null ? e.getType() : "";
                 String icon = "🎓";
                 String badgeC = "badge-blue";
                 if(type.toLowerCase().contains("séminaire")) { icon="💬"; badgeC="badge-green"; }
                 else if(type.toLowerCase().contains("workshop")) { icon="🔧"; badgeC="badge-amber"; }
          %>
          <tr>
            <td style="font-weight:500;"><%= e.getTitre() != null ? e.getTitre() : "—" %></td>
            <td><span class="badge <%= badgeC %>"><%= icon %> <%= type.isEmpty() ? "—" : type %></span></td>
            <td style="color:var(--text-muted);"><%= e.getLieu() != null ? e.getLieu() : "—" %></td>
            <td style="color:var(--text-muted);font-size:13px;"><%= e.getDateDebut() != null ? e.getDateDebut() : "—" %></td>
            <td style="color:var(--text-muted);font-size:13px;"><%= e.getDateFin() != null ? e.getDateFin() : "—" %></td>
            <td>
              <div style="display:flex;gap:6px;">
                <a href="modifierEvenement?id=<%= e.getId() %>" class="btn btn-ghost btn-sm">✏</a>
                <a href="supprimerEvenement?id=<%= e.getId() %>" class="btn btn-danger btn-sm"
                   onclick="return confirm('Supprimer cet événement ?')">✕</a>
              </div>
            </td>
          </tr>
          <% } } else { %>
          <tr><td colspan="6">
            <div class="empty-state">
              <div class="es-icon">🗓</div>
              <h3>Aucun événement</h3>
              <p>Créez votre premier événement scientifique.</p>
            </div>
          </td></tr>
          <% } %>
        </tbody>
      </table>
    </div>
  </div>
</main>
<script>
function filterTable(){
  const q=document.getElementById('searchInput').value.toLowerCase();
  const t=document.getElementById('filterType').value.toLowerCase();
  document.querySelectorAll('#evtTable tbody tr').forEach(r=>{
    const txt=r.innerText.toLowerCase();
    r.style.display=(txt.includes(q)&&(!t||txt.includes(t)))?'':'none';
  });
}
</script>
</body>
</html>
