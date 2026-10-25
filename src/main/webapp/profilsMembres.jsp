<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, dao.MembreDAO, model.Membre" %>
<%
if (session.getAttribute("user") == null) { response.sendRedirect("login.jsp"); return; }
MembreDAO dao = new MembreDAO();
List<Membre> membres = dao.getAllMembres();
request.setAttribute("currentPage", "membres");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Profils des membres — LIAS</title>
<%@ include file="/WEB-INF/style.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/sidebar.jsp" %>

<main class="main">
  <div class="page-header">
    <h1>Membres du laboratoire</h1>
    <p>Consultez les profils de tous les membres du LIAS</p>
  </div>

  <!-- Barre de recherche -->
  <div class="card" style="padding:16px 20px;margin-bottom:20px;">
    <input type="text" id="searchInput" placeholder="🔍 Rechercher un membre..."
           onkeyup="filtrerMembres()"
           style="width:100%;padding:10px 14px;border:1px solid var(--border);border-radius:8px;font-size:14px;outline:none;">
  </div>

  <div id="membresGrid" style="display:grid;grid-template-columns:repeat(auto-fill,minmax(260px,1fr));gap:20px;">
    <% for (Membre m : membres) { %>
    <div class="card membre-card" data-nom="<%= m.getNom().toLowerCase() %> <%= m.getPrenom().toLowerCase() %>">
      <div style="display:flex;align-items:center;gap:16px;margin-bottom:16px;">
        <div style="width:56px;height:56px;border-radius:50%;background:#eff6ff;display:flex;align-items:center;justify-content:center;font-size:22px;flex-shrink:0;">👤</div>
        <div>
          <div style="font-weight:600;font-size:15px;color:var(--dark);"><%= m.getPrenom() %> <%= m.getNom() %></div>
          <div style="font-size:12px;color:var(--text-muted);">
            <span style="background:#eff6ff;color:var(--blue);padding:2px 8px;border-radius:10px;font-size:11px;font-weight:600;">
              <%= m.getStatut() != null ? m.getStatut() : "Membre" %>
            </span>
          </div>
        </div>
      </div>

      <% if (m.getEquipe() != null && !m.getEquipe().isEmpty()) { %>
      <div style="font-size:13px;color:var(--text-muted);margin-bottom:6px;">📌 <%= m.getEquipe() %></div>
      <% } %>
      <% if (m.getEtablissement() != null && !m.getEtablissement().isEmpty()) { %>
      <div style="font-size:13px;color:var(--text-muted);margin-bottom:6px;">🏛️ <%= m.getEtablissement() %></div>
      <% } %>
      <% if (m.getBiographie() != null && !m.getBiographie().isEmpty()) { %>
      <div style="font-size:13px;color:var(--text-muted);margin-top:10px;padding-top:10px;border-top:1px solid var(--border);line-height:1.5;">
        <%= m.getBiographie().length() > 100 ? m.getBiographie().substring(0, 100) + "..." : m.getBiographie() %>
      </div>
      <% } %>
    </div>
    <% } %>
  </div>
</main>

<script>
function filtrerMembres() {
  const val = document.getElementById('searchInput').value.toLowerCase();
  document.querySelectorAll('.membre-card').forEach(card => {
    const nom = card.getAttribute('data-nom');
    card.style.display = nom.includes(val) ? 'block' : 'none';
  });
}
</script>
</body>
</html>