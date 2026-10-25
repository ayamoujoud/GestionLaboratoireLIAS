<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
if(session.getAttribute("user") == null){
    response.sendRedirect("login.jsp");
    return;
}
request.setAttribute("currentPage","materiel");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Matériel — LIAS</title>
<%@ include file="/WEB-INF/style.jsp" %>
</head>

<body>
<%@ include file="/WEB-INF/sidebar.jsp" %>

<main class="main">

  <div class="page-header page-header-row">
    <div>
      <h1>Gestion du matériel</h1>
      <p>Suivi des arrivages, distribution et historique</p>
    </div>

    <button onclick="document.getElementById('addModal').style.display='flex'"
            class="btn btn-primary">
      + Ajouter du matériel
    </button>
  </div>

  <div class="stats-row" style="grid-template-columns:repeat(3,1fr);margin-bottom:24px;">
    <div class="stat-card">
      <div class="stat-icon">📦</div>
      <div class="stat-num">${stock.size()}</div>
      <div class="stat-lbl">Références en stock</div>
    </div>

    <div class="stat-card">
      <div class="stat-icon">✅</div>
      <div class="stat-num">${distributions.size()}</div>
      <div class="stat-lbl">Distributions</div>
    </div>

    <div class="stat-card">
      <div class="stat-icon">⏳</div>
      <div class="stat-num">—</div>
      <div class="stat-lbl">En attente de distribution</div>
    </div>
  </div>

  <div style="display:flex;gap:0;border-bottom:1px solid var(--border);margin-bottom:20px;">
    <button id="tab-stock" onclick="showTab('stock')"
      style="padding:10px 20px;border:none;background:none;font-size:13px;font-weight:500;cursor:pointer;color:var(--blue);border-bottom:2px solid var(--blue);">
      Stock matériel
    </button>

    <button id="tab-distrib" onclick="showTab('distrib')"
      style="padding:10px 20px;border:none;background:none;font-size:13px;cursor:pointer;color:var(--text-muted);border-bottom:2px solid transparent;">
      Historique distributions
    </button>
  </div>

  <div id="panel-stock" class="card">
    <div class="table-wrap">
      <table>
        <thead>
          <tr>
            <th>Désignation</th>
            <th>Quantité totale</th>
            <th>Date d'arrivage</th>
            <th>Distribué</th>
            <th>Disponible</th>
            <th>Actions</th>
          </tr>
        </thead>

        <tbody>
          <c:choose>
            <c:when test="${empty stock}">
              <tr>
                <td colspan="6">
                  <div class="empty-state">
                    <div class="es-icon">📦</div>
                    <h3>Aucun matériel enregistré</h3>
                    <p>Ajoutez du matériel pour commencer le suivi.</p>
                  </div>
                </td>
              </tr>
            </c:when>

            <c:otherwise>
              <c:forEach var="m" items="${stock}">
                <tr>
                  <td>${m.designation}</td>
                  <td>${m.quantiteTotale}</td>
                  <td>${m.dateArrivage}</td>
                  <td>${m.quantiteDistribuee}</td>
                  <td>${m.quantiteTotale - m.quantiteDistribuee}</td>
                  <td>
                    <button class="btn btn-primary"
                      onclick="openDistribModal('${m.id}', '${m.designation}')">
                      Distribuer
                    </button>
                  </td>
                </tr>
              </c:forEach>
            </c:otherwise>
          </c:choose>
        </tbody>
      </table>
    </div>
  </div>

  <div id="panel-distrib" class="card" style="display:none;">
    <div class="table-wrap">
      <table>
        <thead>
          <tr>
            <th>Matériel</th>
            <th>Membre bénéficiaire</th>
            <th>Quantité</th>
            <th>Date de distribution</th>
          </tr>
        </thead>

        <tbody>
          <c:choose>
            <c:when test="${empty distributions}">
              <tr>
                <td colspan="4">
                  <div class="empty-state">
                    <div class="es-icon">📋</div>
                    <h3>Aucune distribution enregistrée</h3>
                  </div>
                </td>
              </tr>
            </c:when>

            <c:otherwise>
              <c:forEach var="d" items="${distributions}">
                <tr>
                  <td>${d.designation}</td>
                  <td>${d.membre}</td>
                  <td>${d.quantite}</td>
                  <td>${d.date}</td>
                </tr>
              </c:forEach>
            </c:otherwise>
          </c:choose>
        </tbody>
      </table>
    </div>
  </div>

</main>

<div id="addModal" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,0.4);z-index:999;align-items:center;justify-content:center;">
  <div class="card" style="width:460px;position:relative;">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;">
      <h2 style="font-size:16px;font-weight:600;">Ajouter du matériel</h2>
      <button type="button"
              onclick="document.getElementById('addModal').style.display='none'"
              style="border:none;background:none;font-size:20px;cursor:pointer;color:var(--text-muted);">
        ✕
      </button>
    </div>

    <form action="materiel" method="post">
      <input type="hidden" name="action" value="ajouter">

      <div class="form-group">
        <label>Désignation <span style="color:var(--red)">*</span></label>
        <input type="text" name="designation"
               placeholder="ex: Ordinateur portable HP ProBook" required>
      </div>

      <div class="form-grid">
        <div class="form-group">
          <label>Quantité</label>
          <input type="number" name="quantite" min="1" value="1" required>
        </div>

        <div class="form-group">
          <label>Date d'arrivage</label>
          <input type="date" name="dateArrivage">
        </div>
      </div>

      <div class="form-group">
        <label>Description</label>
        <textarea name="description" rows="3"
                  placeholder="Description du matériel"></textarea>
      </div>

      <div style="display:flex;gap:10px;">
        <button type="submit" class="btn btn-primary">Enregistrer</button>
        <button type="button"
                onclick="document.getElementById('addModal').style.display='none'"
                class="btn btn-ghost">
          Annuler
        </button>
      </div>
    </form>
  </div>
</div>

<div id="distribModal" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,0.4);z-index:999;align-items:center;justify-content:center;">
  <div class="card" style="width:460px;position:relative;">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;">
      <h2 style="font-size:16px;font-weight:600;">Distribuer le matériel</h2>
      <button type="button"
              onclick="document.getElementById('distribModal').style.display='none'"
              style="border:none;background:none;font-size:20px;cursor:pointer;color:var(--text-muted);">
        ✕
      </button>
    </div>

    <form action="materiel" method="post">
      <input type="hidden" name="action" value="distribuer">
      <input type="hidden" id="materielId" name="materielId">

      <div class="form-group">
        <label>Matériel</label>
        <input type="text" id="materielName" readonly>
      </div>

      <div class="form-group">
        <label>Membre bénéficiaire</label>
        <select name="membreId" required>
          <option value="">-- Choisir un membre --</option>
          <c:forEach var="mb" items="${membres}">
            <option value="${mb.id}">${mb.prenom} ${mb.nom}</option>
          </c:forEach>
        </select>
      </div>

      <div class="form-grid">
        <div class="form-group">
          <label>Quantité</label>
          <input type="number" name="quantite" min="1" value="1" required>
        </div>

        <div class="form-group">
          <label>Date de distribution</label>
          <input type="date" name="dateDistribution" required>
        </div>
      </div>

      <div style="display:flex;gap:10px;">
        <button type="submit" class="btn btn-primary">Distribuer</button>
        <button type="button"
                onclick="document.getElementById('distribModal').style.display='none'"
                class="btn btn-ghost">
          Annuler
        </button>
      </div>
    </form>
  </div>
</div>

<script>
function showTab(t) {
  ['stock','distrib'].forEach(id => {
    document.getElementById('panel-' + id).style.display = id === t ? 'block' : 'none';

    const btn = document.getElementById('tab-' + id);
    btn.style.color = id === t ? 'var(--blue)' : 'var(--text-muted)';
    btn.style.borderBottom = id === t ? '2px solid var(--blue)' : '2px solid transparent';
    btn.style.fontWeight = id === t ? '500' : '400';
  });
}

function openDistribModal(id, designation) {
  document.getElementById('materielId').value = id;
  document.getElementById('materielName').value = designation;
  document.getElementById('distribModal').style.display = 'flex';
}
</script>

</body>
</html>