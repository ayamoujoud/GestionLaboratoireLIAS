<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, model.Convention" %>
<%
if (session.getAttribute("user") == null) { response.sendRedirect("login.jsp"); return; }
List<Convention> conventions = (List<Convention>) request.getAttribute("conventions");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Conventions — LIAS</title>
<%@ include file="/WEB-INF/style.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/sidebar.jsp" %>

<main class="main">
  <div class="page-header page-header-row">
    <div>
      <h1>Conventions & Collaborations</h1>
      <p>Gestion des partenariats du laboratoire LIAS</p>
    </div>
    <button onclick="document.getElementById('addModal').style.display='flex'" class="btn btn-primary">
      + Nouvelle convention
    </button>
  </div>

  <div class="card">
    <div class="table-wrap">
      <table>
        <thead>
          <tr>
            <th>Titre</th>
            <th>Partenaire</th>
            <th>Type</th>
            <th>Date signature</th>
            <th>Date fin</th>
            <th>Statut</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <% if (conventions == null || conventions.isEmpty()) { %>
          <tr><td colspan="7">
            <div class="empty-state">
              <div class="es-icon">🤝</div>
              <h3>Aucune convention enregistrée</h3>
              <p>Ajoutez votre première convention ou collaboration.</p>
            </div>
          </td></tr>
          <% } else { for (Convention c : conventions) {
               boolean active = c.getDateFin() == null || c.getDateFin().isEmpty(); %>
          <tr>
            <td><strong><%= c.getTitre() %></strong>
              <% if (c.getDescription() != null && !c.getDescription().isEmpty()) { %>
              <div style="font-size:12px;color:var(--text-muted);margin-top:2px;">
                <%= c.getDescription().length() > 60 ? c.getDescription().substring(0,60)+"..." : c.getDescription() %>
              </div>
              <% } %>
            </td>
            <td><%= c.getPartenaire() %></td>
            <td><span style="background:#eff6ff;color:var(--blue);padding:3px 8px;border-radius:6px;font-size:12px;">
              <%= c.getTypeConvention() != null ? c.getTypeConvention() : "—" %>
            </span></td>
            <td><%= c.getDateSignature() != null ? c.getDateSignature() : "—" %></td>
            <td><%= c.getDateFin() != null && !c.getDateFin().isEmpty() ? c.getDateFin() : "Indéterminée" %></td>
            <td>
              <% if (active) { %>
              <span style="color:#16A34A;font-weight:600;font-size:12px;">● Active</span>
              <% } else { %>
              <span style="color:var(--text-muted);font-size:12px;">● Expirée</span>
              <% } %>
            </td>
            <td>
              <form action="conventions" method="post" style="display:inline;"
                    onsubmit="return confirm('Supprimer cette convention ?')">
                <input type="hidden" name="action" value="supprimer">
                <input type="hidden" name="id" value="<%= c.getId() %>">
                <button type="submit" class="btn btn-ghost" style="color:var(--red);padding:6px 12px;font-size:12px;">Supprimer</button>
              </form>
            </td>
          </tr>
          <% } } %>
        </tbody>
      </table>
    </div>
  </div>
</main>

<!-- Modal ajout -->
<div id="addModal" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,0.45);z-index:999;align-items:center;justify-content:center;">
  <div class="card" style="width:520px;max-height:90vh;overflow-y:auto;position:relative;">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;">
      <h2 style="font-size:16px;font-weight:600;">Nouvelle convention</h2>
      <button onclick="document.getElementById('addModal').style.display='none'"
              style="border:none;background:none;font-size:20px;cursor:pointer;color:var(--text-muted);">✕</button>
    </div>
    <form action="conventions" method="post">
      <div class="form-group">
        <label>Titre *</label>
        <input type="text" name="titre" placeholder="Titre de la convention" required>
      </div>
      <div class="form-group">
        <label>Partenaire *</label>
        <input type="text" name="partenaire" placeholder="Nom de l'institution partenaire" required>
      </div>
      <div class="form-group">
        <label>Type de convention</label>
        <select name="typeConvention">
          <option value="Accord cadre">Accord cadre</option>
          <option value="Convention de recherche">Convention de recherche</option>
          <option value="Convention de co-tutelle">Convention de co-tutelle</option>
          <option value="Partenariat international">Partenariat international</option>
          <option value="Autre">Autre</option>
        </select>
      </div>
      <div class="form-grid">
        <div class="form-group">
          <label>Date de signature</label>
          <input type="date" name="dateSignature">
        </div>
        <div class="form-group">
          <label>Date de fin</label>
          <input type="date" name="dateFin">
        </div>
      </div>
      <div class="form-group">
        <label>Description</label>
        <textarea name="description" rows="3" placeholder="Objectifs, contexte..."></textarea>
      </div>
      <div style="display:flex;gap:10px;">
        <button type="submit" class="btn btn-primary">Enregistrer</button>
        <button type="button" onclick="document.getElementById('addModal').style.display='none'" class="btn btn-ghost">Annuler</button>
      </div>
    </form>
  </div>
</div>
</body>
</html>