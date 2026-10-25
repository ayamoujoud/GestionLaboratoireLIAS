<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, model.Message, model.Membre, model.Utilisateur" %>
<%
Utilisateur user = (Utilisateur) session.getAttribute("user");
if (user == null) { response.sendRedirect("login.jsp"); return; }
List<Message> recus   = (List<Message>) request.getAttribute("messagesRecus");
List<Message> envoyes = (List<Message>) request.getAttribute("messagesEnvoyes");
List<Membre> membres  = (List<Membre>)  request.getAttribute("membres");
int nbNonLus = request.getAttribute("nbNonLus") != null ? (int) request.getAttribute("nbNonLus") : 0;
%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Messagerie — LIAS</title>
<%@ include file="/WEB-INF/style.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/sidebar.jsp" %>

<main class="main">
  <div class="page-header page-header-row">
    <div>
      <h1>Messagerie interne
        <% if (nbNonLus > 0) { %>
        <span style="background:#DC2626;color:white;border-radius:50%;width:22px;height:22px;
                     display:inline-flex;align-items:center;justify-content:center;
                     font-size:12px;font-weight:700;margin-left:8px;"><%= nbNonLus %></span>
        <% } %>
      </h1>
      <p>Communications entre membres du laboratoire</p>
    </div>
    <button onclick="document.getElementById('composeModal').style.display='flex'" class="btn btn-primary">
      ✉️ Nouveau message
    </button>
  </div>

  <!-- Onglets -->
  <div style="display:flex;gap:0;border-bottom:1px solid var(--border);margin-bottom:20px;">
    <button id="tab-recus" onclick="showTab('recus')"
      style="padding:10px 20px;border:none;background:none;font-size:13px;font-weight:500;
             cursor:pointer;color:var(--blue);border-bottom:2px solid var(--blue);">
      📥 Reçus <% if(nbNonLus>0){%>(<%= nbNonLus %> non lus)<%}%>
    </button>
    <button id="tab-envoyes" onclick="showTab('envoyes')"
      style="padding:10px 20px;border:none;background:none;font-size:13px;
             cursor:pointer;color:var(--text-muted);border-bottom:2px solid transparent;">
      📤 Envoyés
    </button>
  </div>

  <!-- Messages reçus -->
  <div id="panel-recus">
    <% if (recus == null || recus.isEmpty()) { %>
    <div class="card">
      <div class="empty-state">
        <div class="es-icon">📥</div>
        <h3>Aucun message reçu</h3>
        <p>Votre boîte de réception est vide.</p>
      </div>
    </div>
    <% } else { for (Message m : recus) { %>
    <div class="card" style="margin-bottom:12px;padding:18px 22px;
         border-left:4px solid <%= m.isLu() ? "var(--border)" : "var(--blue)" %>;">
      <div style="display:flex;justify-content:space-between;align-items:flex-start;">
        <div>
          <div style="font-weight:<%= m.isLu() ? "400" : "600" %>;font-size:14px;color:var(--dark);">
            De : <%= m.getNomExpediteur() %>
            <% if (!m.isLu()) { %>
            <span style="background:#eff6ff;color:var(--blue);font-size:11px;padding:2px 6px;
                         border-radius:4px;font-weight:600;margin-left:8px;">Nouveau</span>
            <% } %>
          </div>
          <div style="font-size:14px;color:var(--text-muted);margin-top:6px;line-height:1.6;">
            <%= m.getContenu() %>
          </div>
        </div>
        <div style="font-size:12px;color:var(--text-muted);white-space:nowrap;margin-left:20px;">
          <%= m.getDateEnvoi() != null ? m.getDateEnvoi().substring(0,16) : "" %>
        </div>
      </div>
    </div>
    <% } } %>
  </div>

  <!-- Messages envoyés -->
  <div id="panel-envoyes" style="display:none;">
    <% if (envoyes == null || envoyes.isEmpty()) { %>
    <div class="card">
      <div class="empty-state">
        <div class="es-icon">📤</div>
        <h3>Aucun message envoyé</h3>
      </div>
    </div>
    <% } else { for (Message m : envoyes) { %>
    <div class="card" style="margin-bottom:12px;padding:18px 22px;">
      <div style="display:flex;justify-content:space-between;align-items:flex-start;">
        <div>
          <div style="font-weight:500;font-size:14px;color:var(--dark);">
            À : <%= m.getNomDestinataire() %>
          </div>
          <div style="font-size:14px;color:var(--text-muted);margin-top:6px;line-height:1.6;">
            <%= m.getContenu() %>
          </div>
        </div>
        <div style="font-size:12px;color:var(--text-muted);white-space:nowrap;margin-left:20px;">
          <%= m.getDateEnvoi() != null ? m.getDateEnvoi().substring(0,16) : "" %>
          <% if (m.isLu()) { %>
          <div style="color:#16A34A;font-size:11px;margin-top:4px;">✓ Lu</div>
          <% } %>
        </div>
      </div>
    </div>
    <% } } %>
  </div>
</main>

<!-- Modal composer -->
<div id="composeModal" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,0.45);z-index:999;align-items:center;justify-content:center;">
  <div class="card" style="width:520px;position:relative;">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;">
      <h2 style="font-size:16px;font-weight:600;">Nouveau message</h2>
      <button onclick="document.getElementById('composeModal').style.display='none'"
              style="border:none;background:none;font-size:20px;cursor:pointer;color:var(--text-muted);">✕</button>
    </div>
    <form action="messagerie" method="post">
      <div class="form-group">
        <label>Destinataire</label>
        <select name="destinataireId">
          <option value="">-- Sélectionner un membre --</option>
          <% if (membres != null) { for (Membre mb : membres) { %>
          <option value="<%= mb.getId() %>"><%= mb.getPrenom() %> <%= mb.getNom() %></option>
          <% } } %>
        </select>
      </div>
      <div class="form-group">
        <label>Message *</label>
        <textarea name="contenu" rows="5"
                  placeholder="Écrivez votre message..." required></textarea>
      </div>
      <div style="display:flex;gap:10px;">
        <button type="submit" class="btn btn-primary">Envoyer</button>
        <button type="button"
                onclick="document.getElementById('composeModal').style.display='none'"
                class="btn btn-ghost">Annuler</button>
      </div>
    </form>
  </div>
</div>

<script>
function showTab(t) {
  ['recus','envoyes'].forEach(id => {
    document.getElementById('panel-'+id).style.display = id===t ? 'block' : 'none';
    const btn = document.getElementById('tab-'+id);
    btn.style.color        = id===t ? 'var(--blue)' : 'var(--text-muted)';
    btn.style.borderBottom = id===t ? '2px solid var(--blue)' : '2px solid transparent';
    btn.style.fontWeight   = id===t ? '500' : '400';
  });
}
</script>
</body>
</html>