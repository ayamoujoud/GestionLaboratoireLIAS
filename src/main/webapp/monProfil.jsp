<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Membre, model.Utilisateur, model.HistoriqueAffiliation, java.util.List" %>
<%
Utilisateur user = (Utilisateur) session.getAttribute("user");
if (user == null) { response.sendRedirect("login.jsp"); return; }
Membre membre = (Membre) request.getAttribute("membre");
if (membre == null) { response.sendRedirect("monProfil"); return; }
List<HistoriqueAffiliation> historique =
    (List<HistoriqueAffiliation>) request.getAttribute("historiqueAffiliation");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Mon Profil — LIAS</title>
<%@ include file="/WEB-INF/style.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/sidebar.jsp" %>

<main class="main">
  <div class="page-header">
    <h1>Mon Profil</h1>
    <p>Vos informations personnelles au sein du laboratoire LIAS</p>
  </div>

  <!-- Carte identité -->
  <div class="card" style="max-width:800px;margin-bottom:20px;">

    <div style="display:flex;align-items:center;gap:24px;margin-bottom:32px;
                padding-bottom:24px;border-bottom:1px solid var(--border);">
      <div style="width:90px;height:90px;border-radius:50%;background:#eff6ff;
                  display:flex;align-items:center;justify-content:center;
                  font-size:36px;flex-shrink:0;">👤</div>
      <div>
        <h2 style="margin:0;font-size:22px;color:var(--dark);">
          <%= membre.getPrenom() %> <%= membre.getNom() %>
        </h2>
        <span style="display:inline-block;margin-top:6px;padding:4px 12px;
                     border-radius:20px;font-size:12px;font-weight:600;
                     background:#eff6ff;color:var(--blue);">
          <%= membre.getStatut() != null ? membre.getStatut() : "Membre" %>
        </span>
      </div>
    </div>

    <!-- Infos en grille -->
    <div style="display:grid;grid-template-columns:1fr 1fr;gap:20px;margin-bottom:24px;">

      <div class="form-group">
        <label>Email</label>
        <div style="padding:10px 14px;background:#f8fafc;border-radius:8px;
                    border:1px solid var(--border);font-size:14px;">
          <%= membre.getEmail() != null ? membre.getEmail() : "—" %>
        </div>
      </div>

      <div class="form-group">
        <label>Équipe</label>
        <div style="padding:10px 14px;background:#f8fafc;border-radius:8px;
                    border:1px solid var(--border);font-size:14px;">
          <%= membre.getEquipe() != null ? membre.getEquipe() : "—" %>
        </div>
      </div>

      <div class="form-group">
        <label>Établissement</label>
        <div style="padding:10px 14px;background:#f8fafc;border-radius:8px;
                    border:1px solid var(--border);font-size:14px;">
          <%= membre.getEtablissement() != null ? membre.getEtablissement() : "—" %>
        </div>
      </div>

      <div class="form-group">
        <label>Laboratoire d'origine</label>
        <div style="padding:10px 14px;background:#f8fafc;border-radius:8px;
                    border:1px solid var(--border);font-size:14px;">
          <%= membre.getLaboratoireOrigine() != null ? membre.getLaboratoireOrigine() : "—" %>
        </div>
      </div>
    </div>

    <div class="form-group" style="margin-bottom:20px;">
      <label>Biographie</label>
      <div style="padding:12px 14px;background:#f8fafc;border-radius:8px;
                  border:1px solid var(--border);font-size:14px;
                  min-height:60px;line-height:1.6;">
        <%= membre.getBiographie() != null ? membre.getBiographie() : "Aucune biographie renseignée." %>
      </div>
    </div>

    <div class="form-group" style="margin-bottom:28px;">
      <label>Centres d'intérêt</label>
      <div style="padding:12px 14px;background:#f8fafc;border-radius:8px;
                  border:1px solid var(--border);font-size:14px;min-height:40px;">
        <%= membre.getCentresInteret() != null ? membre.getCentresInteret() : "—" %>
      </div>
    </div>

    <a href="modifierMonProfil" class="btn btn-primary">✏️ Modifier mon profil</a>
  </div>

  <!-- Historique des affiliations -->
  <div class="card" style="max-width:800px;">
    <h2 style="font-size:16px;font-weight:600;color:var(--dark);margin-bottom:16px;">
      📅 Historique des affiliations
    </h2>

    <% if (historique == null || historique.isEmpty()) { %>
    <div style="text-align:center;padding:30px;color:var(--text-muted);font-size:14px;">
      Aucun historique d'affiliation enregistré.
    </div>
    <% } else { %>
    <div class="table-wrap">
      <table>
        <thead>
          <tr>
            <th>Date de début</th>
            <th>Date de fin</th>
            <th>Motif</th>
            <th>Statut</th>
          </tr>
        </thead>
        <tbody>
          <% for (HistoriqueAffiliation h : historique) { %>
          <tr>
            <td><%= h.getDateDebut() != null ? h.getDateDebut() : "—" %></td>
            <td><%= h.getDateFin()   != null ? h.getDateFin()   : "En cours" %></td>
            <td><%= h.getMotif()     != null ? h.getMotif()     : "—" %></td>
            <td>
              <% if (h.getDateFin() == null) { %>
              <span style="color:#16A34A;font-weight:600;font-size:12px;">● Actif</span>
              <% } else { %>
              <span style="color:var(--text-muted);font-size:12px;">● Terminé</span>
              <% } %>
            </td>
          </tr>
          <% } %>
        </tbody>
      </table>
    </div>
    <% } %>
  </div>

</main>
</body>
</html>