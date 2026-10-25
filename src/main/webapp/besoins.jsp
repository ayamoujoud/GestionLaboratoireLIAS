<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, model.BesoinMateriel, model.Utilisateur" %>
<%
Utilisateur user = (Utilisateur) session.getAttribute("user");
if (user == null) { response.sendRedirect("login.jsp"); return; }
List<BesoinMateriel> besoins = (List<BesoinMateriel>) request.getAttribute("besoins");
boolean modeAdmin = Boolean.TRUE.equals(request.getAttribute("modeAdmin"));
%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Besoins en matériel — LIAS</title>
<%@ include file="/WEB-INF/style.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/sidebar.jsp" %>

<main class="main">
  <div class="page-header page-header-row">
    <div>
      <h1>Besoins en matériel</h1>
      <p><%= modeAdmin ? "Gestion de toutes les demandes" : "Vos demandes de matériel" %></p>
    </div>
    <button onclick="document.getElementById('addModal').style.display='flex'"
            class="btn btn-primary">
      + Nouvelle demande
    </button>
  </div>

  <!-- Tableau des besoins -->
  <div class="card">
    <div class="table-wrap">
      <table>
        <thead>
          <tr>
            <% if (modeAdmin) { %><th>Membre</th><% } %>
            <th>Description</th>
            <th>Quantité</th>
            <th>Date demande</th>
            <th>Statut</th>
            <% if (modeAdmin) { %><th>Actions</th><% } %>
          </tr>
        </thead>
        <tbody>
          <% if (besoins == null || besoins.isEmpty()) { %>
          <tr><td colspan="<%= modeAdmin ? 6 : 4 %>">
            <div class="empty-state">
              <div class="es-icon">📦</div>
              <h3>Aucune demande</h3>
              <p>Soumettez une demande de matériel en cliquant sur le bouton ci-dessus.</p>
            </div>
          </td></tr>
          <% } else { for (BesoinMateriel b : besoins) {
               String statutColor = "#6B7280";
               String statutBg    = "#F3F4F6";
               if ("en_attente".equals(b.getStatut())) { statutColor="#D97706"; statutBg="#FFFBEB"; }
               if ("valide".equals(b.getStatut()))      { statutColor="#16A34A"; statutBg="#F0FDF4"; }
               if ("refuse".equals(b.getStatut()))      { statutColor="#DC2626"; statutBg="#FEF2F2"; }
          %>
          <tr>
            <% if (modeAdmin) { %>
            <td><strong><%= b.getNomMembre() %></strong></td>
            <% } %>
            <td><%= b.getDescription() %></td>
            <td style="text-align:center;"><%= b.getQuantite() %></td>
            <td style="font-size:12px;color:var(--text-muted);">
              <%= b.getDateDemande() != null ? b.getDateDemande().substring(0,10) : "—" %>
            </td>
            <td>
              <span style="background:<%= statutBg %>;color:<%= statutColor %>;
                           padding:3px 10px;border-radius:20px;font-size:12px;font-weight:600;">
                <%= "en_attente".equals(b.getStatut()) ? "En attente"
                  : "valide".equals(b.getStatut())     ? "Validé"
                  : "Refusé" %>
              </span>
            </td>
            <% if (modeAdmin && "en_attente".equals(b.getStatut())) { %>
            <td style="display:flex;gap:6px;">
              <form action="besoins" method="post" style="display:inline;">
                <input type="hidden" name="action" value="valider">
                <input type="hidden" name="id"     value="<%= b.getId() %>">
                <button type="submit" class="btn btn-primary"
                        style="padding:5px 12px;font-size:12px;">✅ Valider</button>
              </form>
              <form action="besoins" method="post" style="display:inline;">
                <input type="hidden" name="action" value="refuser">
                <input type="hidden" name="id"     value="<%= b.getId() %>">
                <button type="submit" class="btn btn-ghost"
                        style="padding:5px 12px;font-size:12px;color:var(--red);">❌ Refuser</button>
              </form>
            </td>
            <% } else if (modeAdmin) { %>
            <td style="color:var(--text-muted);font-size:12px;">Traité</td>
            <% } %>
          </tr>
          <% } } %>
        </tbody>
      </table>
    </div>
  </div>
</main>

<!-- Modal nouvelle demande -->
<div id="addModal" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,0.45);
                           z-index:999;align-items:center;justify-content:center;">
  <div class="card" style="width:480px;position:relative;">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;">
      <h2 style="font-size:16px;font-weight:600;">Nouvelle demande de matériel</h2>
      <button onclick="document.getElementById('addModal').style.display='none'"
              style="border:none;background:none;font-size:20px;cursor:pointer;
                     color:var(--text-muted);">✕</button>
    </div>
    <form action="besoins" method="post">
      <input type="hidden" name="action" value="soumettre">
      <div class="form-group">
        <label>Description du besoin *</label>
        <textarea name="description" rows="4"
                  placeholder="Décrivez le matériel dont vous avez besoin..." required></textarea>
      </div>
      <div class="form-group">
        <label>Quantité</label>
        <input type="number" name="quantite" value="1" min="1">
      </div>
      <div style="display:flex;gap:10px;">
        <button type="submit" class="btn btn-primary">Soumettre</button>
        <button type="button"
                onclick="document.getElementById('addModal').style.display='none'"
                class="btn btn-ghost">Annuler</button>
      </div>
    </form>
  </div>
</div>
</body>
</html>