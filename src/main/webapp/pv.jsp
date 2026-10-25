<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, model.ProcesVerbal" %>
<%
if (session.getAttribute("user") == null) { response.sendRedirect("login.jsp"); return; }
List<ProcesVerbal> pvList = (List<ProcesVerbal>) request.getAttribute("pvList");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Procès-Verbaux — LIAS</title>
<%@ include file="/WEB-INF/style.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/sidebar.jsp" %>

<main class="main">
  <div class="page-header page-header-row">
    <div>
      <h1>Procès-Verbaux</h1>
      <p>Archivage des réunions et comptes rendus du laboratoire</p>
    </div>
    <button onclick="document.getElementById('addModal').style.display='flex'" class="btn btn-primary">
      + Nouvelle réunion
    </button>
  </div>

  <div class="card">
    <div class="table-wrap">
      <table>
        <thead>
          <tr>
            <th>Date réunion</th>
            <th>Ordre du jour</th>
            <th>Créé par</th>
            <th>Date upload</th>
            <th>Fichier PV</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <% if (pvList == null || pvList.isEmpty()) { %>
          <tr><td colspan="6">
            <div class="empty-state">
              <div class="es-icon">📋</div>
              <h3>Aucun procès-verbal enregistré</h3>
              <p>Créez votre première réunion pour commencer l'archivage.</p>
            </div>
          </td></tr>
          <% } else { for (ProcesVerbal pv : pvList) { %>
          <tr>
            <td><strong><%= pv.getDateReunion() %></strong></td>
            <td style="max-width:280px;">
              <%= pv.getOrdreDuJour() != null ?
                  (pv.getOrdreDuJour().length() > 80 ? pv.getOrdreDuJour().substring(0,80)+"..." : pv.getOrdreDuJour())
                  : "—" %>
            </td>
            <td><%= pv.getNomCreateur() != null ? pv.getNomCreateur() : "—" %></td>
            <td style="font-size:12px;color:var(--text-muted);">
              <%= pv.getDateUpload() != null ? pv.getDateUpload().substring(0,10) : "—" %>
            </td>
            <td>
              <% if (pv.getPvPath() != null && !pv.getPvPath().isEmpty()) { %>
              <a href="<%= pv.getPvPath() %>" target="_blank"
                 style="color:var(--blue);font-size:13px;text-decoration:none;">
                📄 Télécharger
              </a>
              <% } else { %>
              <span style="color:var(--text-muted);font-size:12px;">Pas encore uploadé</span>
              <% } %>
            </td>
            <td>
              <form action="pv" method="post" style="display:inline;"
                    onsubmit="return confirm('Supprimer ce PV ?')">
                <input type="hidden" name="action" value="supprimer">
                <input type="hidden" name="id" value="<%= pv.getId() %>">
                <button type="submit" class="btn btn-ghost"
                        style="color:var(--red);padding:6px 12px;font-size:12px;">Supprimer</button>
              </form>
            </td>
          </tr>
          <% } } %>
        </tbody>
      </table>
    </div>
  </div>
</main>

<!-- Modal ajout PV -->
<div id="addModal" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,0.45);z-index:999;align-items:center;justify-content:center;">
  <div class="card" style="width:520px;position:relative;">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;">
      <h2 style="font-size:16px;font-weight:600;">Nouvelle réunion / PV</h2>
      <button onclick="document.getElementById('addModal').style.display='none'"
              style="border:none;background:none;font-size:20px;cursor:pointer;color:var(--text-muted);">✕</button>
    </div>
    <form action="pv" method="post" enctype="multipart/form-data">
      <div class="form-group">
        <label>Date de la réunion *</label>
        <input type="date" name="dateReunion" required>
      </div>
      <div class="form-group">
        <label>Ordre du jour</label>
        <textarea name="ordreDuJour" rows="4"
                  placeholder="Points abordés lors de la réunion..."></textarea>
      </div>
      <div class="form-group">
        <label>Fichier PV (PDF)</label>
        <input type="file" name="fichierPv" accept=".pdf,.doc,.docx">
        <small style="color:var(--text-muted);font-size:12px;">Formats acceptés : PDF, DOC, DOCX (max 10 Mo)</small>
      </div>
      <div style="display:flex;gap:10px;">
        <button type="submit" class="btn btn-primary">Enregistrer</button>
        <button type="button"
                onclick="document.getElementById('addModal').style.display='none'"
                class="btn btn-ghost">Annuler</button>
      </div>
    </form>
  </div>
</div>
</body>
</html>