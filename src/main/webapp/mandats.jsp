<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, model.Mandat, model.Membre" %>
<%
if (session.getAttribute("user") == null) { response.sendRedirect("login.jsp"); return; }
List<Mandat> mandatsActifs = (List<Mandat>) request.getAttribute("mandatsActifs");
List<Mandat> historique = (List<Mandat>) request.getAttribute("historique");
List<Membre> membres = (List<Membre>) request.getAttribute("membres");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Gouvernance — LIAS</title>
<%@ include file="/WEB-INF/style.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/sidebar.jsp" %>

<main class="main">
  <div class="page-header page-header-row">
    <div>
      <h1>Gouvernance du laboratoire</h1>
      <p>Mandats actifs et historique des responsabilités</p>
    </div>
    <button onclick="document.getElementById('addModal').style.display='flex'" class="btn btn-primary">
      + Nouveau mandat
    </button>
  </div>

  <!-- Mandats actifs -->
  <h2 style="font-size:16px;font-weight:600;color:var(--dark);margin-bottom:16px;">Mandats en cours</h2>
  <div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(280px,1fr));gap:20px;margin-bottom:32px;">
    <% if (mandatsActifs == null || mandatsActifs.isEmpty()) { %>
    <div class="card" style="color:var(--text-muted);font-size:14px;">Aucun mandat actif enregistré.</div>
    <% } else { for (Mandat m : mandatsActifs) { %>
    <div class="card">
      <div style="font-size:11px;font-weight:700;color:var(--blue);text-transform:uppercase;letter-spacing:1px;margin-bottom:8px;">
        <%= m.getRole() %>
      </div>
      <div style="font-size:18px;font-weight:700;color:var(--dark);margin-bottom:4px;">
        <%= m.getPrenomMembre() %> <%= m.getNomMembre() %>
      </div>
      <% if (m.getEquipe() != null && !m.getEquipe().isEmpty()) { %>
      <div style="font-size:13px;color:var(--text-muted);">Équipe : <%= m.getEquipe() %></div>
      <% } %>
      <div style="font-size:12px;color:var(--text-muted);margin-top:8px;">Depuis le <%= m.getDateDebut() %></div>
      <span style="display:inline-block;margin-top:8px;padding:3px 10px;background:#f0fdf4;color:#16A34A;border-radius:20px;font-size:11px;font-weight:600;">Actif</span>
    </div>
    <% } } %>
  </div>

  <!-- Historique -->
  <h2 style="font-size:16px;font-weight:600;color:var(--dark);margin-bottom:16px;">Historique complet</h2>
  <div class="card">
    <div class="table-wrap">
      <table>
        <thead>
          <tr>
            <th>Membre</th><th>Rôle</th><th>Équipe</th><th>Début</th><th>Fin</th><th>Statut</th>
          </tr>
        </thead>
        <tbody>
          <% if (historique == null || historique.isEmpty()) { %>
          <tr><td colspan="6" style="text-align:center;color:var(--text-muted);">Aucun historique</td></tr>
          <% } else { for (Mandat m : historique) { %>
          <tr>
            <td><%= m.getPrenomMembre() %> <%= m.getNomMembre() %></td>
            <td><%= m.getRole() %></td>
            <td><%= m.getEquipe() != null ? m.getEquipe() : "—" %></td>
            <td><%= m.getDateDebut() %></td>
            <td><%= m.getDateFin() != null ? m.getDateFin() : "En cours" %></td>
            <td>
              <% if (m.isActif()) { %>
              <span style="color:#16A34A;font-weight:600;font-size:12px;">Actif</span>
              <% } else { %>
              <span style="color:var(--text-muted);font-size:12px;">Terminé</span>
              <% } %>
            </td>
          </tr>
          <% } } %>
        </tbody>
      </table>
    </div>
  </div>
</main>

<!-- Modal ajout mandat -->
<div id="addModal" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,0.4);z-index:999;align-items:center;justify-content:center;">
  <div class="card" style="width:480px;position:relative;">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;">
      <h2 style="font-size:16px;font-weight:600;">Nouveau mandat</h2>
      <button onclick="document.getElementById('addModal').style.display='none'"
              style="border:none;background:none;font-size:20px;cursor:pointer;">✕</button>
    </div>
    <form action="mandats" method="post">
      <div class="form-group">
        <label>Membre *</label>
        <select name="membreId" required>
          <option value="">-- Sélectionner --</option>
          <% if (membres != null) { for (Membre m : membres) { %>
          <option value="<%= m.getId() %>"><%= m.getPrenom() %> <%= m.getNom() %></option>
          <% } } %>
        </select>
      </div>
      <div class="form-group">
        <label>Rôle *</label>
        <select name="role" required>
          <option value="DIRECTEUR">Directeur</option>
          <option value="VICE_DIRECTEUR">Vice-directeur</option>
          <option value="CHEF_EQUIPE">Chef d'équipe</option>
          <option value="MEMBRE_EQUIPE">Membre d'équipe</option>
        </select>
      </div>
      <div class="form-group">
        <label>Équipe (si chef d'équipe)</label>
        <input type="text" name="equipe" placeholder="Nom de l'équipe">
      </div>
      <div class="form-group">
        <label>Date de début *</label>
        <input type="date" name="dateDebut" required>
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