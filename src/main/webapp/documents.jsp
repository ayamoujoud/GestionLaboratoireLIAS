<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>

<%!
    // Protège l'affichage contre les caractères spéciaux HTML
    private String h(Object o) {
        if (o == null) return "";
        return o.toString().replace("&", "&amp;").replace("<", "&lt;")
                .replace(">", "&gt;").replace("\"", "&quot;");
    }
%>

<%
if(session.getAttribute("user") == null){ response.sendRedirect("login.jsp"); return; }

List<Map<String,Object>> documents = (List<Map<String,Object>>) request.getAttribute("documents");
if (documents == null) documents = new ArrayList<>();

request.setAttribute("currentPage","documents");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Documents — LIAS</title>
<%@ include file="/WEB-INF/style.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/sidebar.jsp" %>

<main class="main">
  <div class="page-header page-header-row">
    <div>
      <h1>Gestion des documents</h1>
      <p>Upload, téléchargement et archivage des documents du laboratoire</p>
    </div>
    <button onclick="document.getElementById('uploadModal').style.display='flex'" class="btn btn-primary">
      + Ajouter un document
    </button>
  </div>

  <% if ("fichier".equals(request.getParameter("error"))) { %>
  <div style="background:#fef2f2;border:1px solid #fecaca;color:#DC2626;padding:12px 16px;border-radius:8px;margin-bottom:16px;">
    Veuillez choisir un fichier à envoyer.
  </div>
  <% } %>

  <!-- Types de documents -->
  <div style="display:grid;grid-template-columns:repeat(5,1fr);gap:12px;margin-bottom:24px;">
    <div class="card" style="text-align:center;padding:16px;cursor:pointer;" onclick="filterDocs('financement')">
      <div style="font-size:24px;margin-bottom:6px;">💰</div>
      <div style="font-size:12px;font-weight:500;">Financement</div>
    </div>
    <div class="card" style="text-align:center;padding:16px;cursor:pointer;" onclick="filterDocs('programme')">
      <div style="font-size:24px;margin-bottom:6px;">📅</div>
      <div style="font-size:12px;font-weight:500;">Programmes</div>
    </div>
    <div class="card" style="text-align:center;padding:16px;cursor:pointer;" onclick="filterDocs('attestation')">
      <div style="font-size:24px;margin-bottom:6px;">🏅</div>
      <div style="font-size:12px;font-weight:500;">Attestations</div>
    </div>
    <div class="card" style="text-align:center;padding:16px;cursor:pointer;" onclick="filterDocs('rapport')">
      <div style="font-size:24px;margin-bottom:6px;">📊</div>
      <div style="font-size:12px;font-weight:500;">Rapports</div>
    </div>
    <div class="card" style="text-align:center;padding:16px;cursor:pointer;" onclick="filterDocs('administratif')">
      <div style="font-size:24px;margin-bottom:6px;">🗄</div>
      <div style="font-size:12px;font-weight:500;">Administratif</div>
    </div>
  </div>

  <!-- Liste documents -->
  <div class="card">
    <div class="actions-bar">
      <div class="search-box">
        <span style="color:var(--text-muted);">🔍</span>
        <input type="text" id="searchInput" placeholder="Rechercher un document..." oninput="filterTable()">
      </div>
      <select id="filterType" onchange="filterTable()" style="border:1px solid var(--border);border-radius:8px;padding:7px 12px;font-size:13px;font-family:inherit;background:#fff;">
        <option value="">Tous les types</option>
        <option value="financement">Financement</option>
        <option value="programme">Programme</option>
        <option value="attestation">Attestation</option>
        <option value="rapport">Rapport</option>
        <option value="administratif">Administratif</option>
      </select>
    </div>
    <div class="table-wrap">
      <table id="docTable">
        <thead>
          <tr>
            <th>Document</th>
            <th>Type</th>
            <th>Événement lié</th>
            <th>Uploadé par</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
        <% if (documents.isEmpty()) { %>
          <tr><td colspan="5">
            <div class="empty-state">
              <div class="es-icon">🗂</div>
              <h3>Aucun document archivé</h3>
              <p>Uploadez votre premier document pour commencer l'archivage.</p>
            </div>
          </td></tr>
        <% } else {
             for (Map<String,Object> doc : documents) {
               String uploader = String.valueOf(doc.get("nomUploaded"));
               if (uploader == null || uploader.contains("null")) uploader = "—";
               Object evt = doc.get("evenementId");
        %>
          <tr>
            <td style="font-weight:500;"><%= h(doc.get("titre")) %></td>
            <td><span class="badge badge-blue"><%= h(doc.get("type")) %></span></td>
            <td style="color:var(--text-muted);"><%= evt != null ? "Événement n° " + h(evt) : "—" %></td>
            <td style="color:var(--text-muted);"><%= h(uploader) %></td>
            <td>
              <a href="<%= h(doc.get("cheminFichier")) %>" target="_blank" class="btn btn-primary btn-sm">⬇ Télécharger</a>
            </td>
          </tr>
        <%   }
           } %>
        </tbody>
      </table>
    </div>
  </div>
</main>

<!-- Modal upload -->
<div id="uploadModal" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,0.4);z-index:999;align-items:center;justify-content:center;">
  <div class="card" style="width:500px;max-width:90vw;position:relative;">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;">
      <h2 style="font-size:16px;font-weight:600;">Ajouter un document</h2>
      <button onclick="document.getElementById('uploadModal').style.display='none'"
              style="border:none;background:none;font-size:20px;cursor:pointer;color:var(--text-muted);">✕</button>
    </div>
    <form action="uploadDocument" method="post" enctype="multipart/form-data">
      <div class="form-group">
        <label>Titre du document <span style="color:var(--red)">*</span></label>
        <input type="text" name="titre" placeholder="Nom descriptif du document" required>
      </div>
      <div class="form-grid">
        <div class="form-group">
          <label>Type</label>
          <select name="type">
            <option value="financement">Financement</option>
            <option value="programme">Programme</option>
            <option value="attestation">Attestation</option>
            <option value="rapport">Rapport</option>
            <option value="administratif">Administratif</option>
          </select>
        </div>
        <div class="form-group">
          <label>ID Événement lié (optionnel)</label>
          <input type="number" name="evenementId" placeholder="ex: 3">
        </div>
      </div>
      <div class="form-group">
        <label>Fichier <span style="color:var(--red)">*</span></label>
        <input type="file" name="fichier" required
               style="padding:8px;border:1px dashed var(--border);border-radius:8px;width:100%;background:var(--surface);">
      </div>
      <div style="display:flex;gap:10px;margin-top:8px;">
        <button type="submit" class="btn btn-primary">Uploader</button>
        <button type="button" onclick="document.getElementById('uploadModal').style.display='none'" class="btn btn-ghost">Annuler</button>
      </div>
    </form>
  </div>
</div>

<script>
function filterTable(){
  const q=document.getElementById('searchInput').value.toLowerCase();
  const t=document.getElementById('filterType').value.toLowerCase();
  document.querySelectorAll('#docTable tbody tr').forEach(r=>{
    const txt=r.innerText.toLowerCase();
    r.style.display=(txt.includes(q)&&(!t||txt.includes(t)))?'':'none';
  });
}
function filterDocs(type){
  document.getElementById('filterType').value=type;
  filterTable();
}
</script>
</body>
</html>