<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>
<%@ page import="model.Utilisateur" %>

<%!
    // Compte les lignes d'une table (renvoie -1 si la table ou la requête pose problème)
    private int compter(Connection c, String sql) {
        try (Statement st = c.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (Exception e) {
            return -1;
        }
    }

    private String afficher(int n) {
        return n < 0 ? "—" : String.valueOf(n);
    }
%>

<%
if (session.getAttribute("user") == null) { response.sendRedirect("login.jsp"); return; }

String roleSession = (String) session.getAttribute("role");
if (roleSession == null || (!"ADMIN".equalsIgnoreCase(roleSession) && !"DIRECTEUR".equalsIgnoreCase(roleSession))) {
    response.sendRedirect("membreDashboard.jsp");
    return;
}

Utilisateur utilisateur = (Utilisateur) session.getAttribute("user");

boolean baseOk = false;
int nbMembres = -1, nbUtilisateurs = -1, nbEquipes = -1, nbPublications = -1, nbEvenements = -1;
int nbDemandes = -1, nbDocuments = -1, nbMateriel = -1;
String erreurBase = "";

Connection cx = null;
try {
    cx = DBConnection.getConnection();
    if (cx != null && !cx.isClosed()) {
        baseOk = true;
        nbMembres       = compter(cx, "SELECT COUNT(*) FROM membre");
        nbUtilisateurs  = compter(cx, "SELECT COUNT(*) FROM utilisateur");
        nbEquipes       = compter(cx, "SELECT COUNT(*) FROM equipe");
        nbPublications  = compter(cx, "SELECT COUNT(*) FROM publication");
        nbEvenements    = compter(cx, "SELECT COUNT(*) FROM evenement");
        nbDemandes      = compter(cx, "SELECT COUNT(*) FROM demande_adhesion WHERE statut = 'EN_ATTENTE'");
        nbDocuments     = compter(cx, "SELECT COUNT(*) FROM document");
        nbMateriel      = compter(cx, "SELECT COUNT(*) FROM materiel");
    }
} catch (Exception e) {
    erreurBase = e.getMessage() == null ? "Erreur inconnue" : e.getMessage();
} finally {
    if (cx != null) { try { cx.close(); } catch (Exception ignore) { } }
}

request.setAttribute("currentPage", "dashboard");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Maintenance — LIAS</title>
<%@ include file="/WEB-INF/style.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/sidebar.jsp" %>

<main class="main">

  <div class="page-header page-header-row">
    <div>
      <h1>🛠 Maintenance du système</h1>
      <p>État de la plateforme LIAS et des données</p>
    </div>
    <a href="maintenance.jsp" class="btn btn-primary">↻ Actualiser</a>
  </div>

  <!-- État général -->
  <div class="card" style="margin-bottom:24px;">
    <h2 style="font-size:16px;font-weight:600;margin-bottom:14px;">État du système</h2>
    <div class="table-wrap">
      <table>
        <tbody>
          <tr>
            <td style="width:260px;font-weight:500;">Base de données MySQL</td>
            <td>
              <% if (baseOk) { %>
                <span class="badge badge-green">Connectée</span>
              <% } else { %>
                <span class="badge badge-red">Hors ligne</span>
                <span style="font-size:12px;color:var(--text-muted);"><%= erreurBase %></span>
              <% } %>
            </td>
          </tr>
          <tr>
            <td style="font-weight:500;">Serveur d'application</td>
            <td><%= application.getServerInfo() %></td>
          </tr>
          <tr>
            <td style="font-weight:500;">Version de Java</td>
            <td><%= System.getProperty("java.version") %></td>
          </tr>
          <tr>
            <td style="font-weight:500;">Date et heure du serveur</td>
            <td><%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new java.util.Date()) %></td>
          </tr>
          <tr>
            <td style="font-weight:500;">Session ouverte par</td>
            <td><%= utilisateur.getEmail() %> <span class="badge badge-blue"><%= roleSession %></span></td>
          </tr>
          <tr>
            <td style="font-weight:500;">Mémoire utilisée par l'application</td>
            <td><%= (Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory()) / (1024 * 1024) %> Mo
                sur <%= Runtime.getRuntime().maxMemory() / (1024 * 1024) %> Mo</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>

  <!-- Données -->
  <div class="stats-row" style="grid-template-columns:repeat(4,1fr);margin-bottom:24px;">
    <div class="stat-card"><div class="stat-icon">👥</div><div class="stat-num"><%= afficher(nbMembres) %></div><div class="stat-lbl">Membres</div></div>
    <div class="stat-card"><div class="stat-icon">🔑</div><div class="stat-num"><%= afficher(nbUtilisateurs) %></div><div class="stat-lbl">Comptes utilisateurs</div></div>
    <div class="stat-card"><div class="stat-icon">🧪</div><div class="stat-num"><%= afficher(nbEquipes) %></div><div class="stat-lbl">Équipes</div></div>
    <div class="stat-card"><div class="stat-icon">📄</div><div class="stat-num"><%= afficher(nbPublications) %></div><div class="stat-lbl">Publications</div></div>
  </div>
  <div class="stats-row" style="grid-template-columns:repeat(4,1fr);margin-bottom:24px;">
    <div class="stat-card"><div class="stat-icon">🗓</div><div class="stat-num"><%= afficher(nbEvenements) %></div><div class="stat-lbl">Événements</div></div>
    <div class="stat-card"><div class="stat-icon">📋</div><div class="stat-num"><%= afficher(nbDemandes) %></div><div class="stat-lbl">Demandes en attente</div></div>
    <div class="stat-card"><div class="stat-icon">🗂</div><div class="stat-num"><%= afficher(nbDocuments) %></div><div class="stat-lbl">Documents</div></div>
    <div class="stat-card"><div class="stat-icon">📦</div><div class="stat-num"><%= afficher(nbMateriel) %></div><div class="stat-lbl">Références matériel</div></div>
  </div>

  <!-- Actions rapides -->
  <div class="card">
    <h2 style="font-size:16px;font-weight:600;margin-bottom:14px;">Actions rapides</h2>
    <div style="display:flex;gap:10px;flex-wrap:wrap;">
      <a href="listeDemandes" class="btn btn-primary btn-sm">Traiter les demandes</a>
      <a href="listeMembres" class="btn btn-ghost btn-sm">Gérer les comptes</a>
      <a href="rapport" class="btn btn-ghost btn-sm">Rapport annuel</a>
      <a href="parametrage.jsp" class="btn btn-ghost btn-sm">Paramétrage</a>
      <a href="adminDashboard.jsp" class="btn btn-ghost btn-sm">← Tableau de bord</a>
    </div>
  </div>

</main>
</body>
</html>