<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, model.Notification, model.Utilisateur" %>
<%
Utilisateur user = (Utilisateur) session.getAttribute("user");
if (user == null) { response.sendRedirect("login.jsp"); return; }
List<Notification> notifs = (List<Notification>) request.getAttribute("notifications");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Notifications — LIAS</title>
<%@ include file="/WEB-INF/style.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/sidebar.jsp" %>

<main class="main">
  <div class="page-header">
    <h1>Notifications</h1>
    <p>Vos alertes et informations récentes</p>
  </div>

  <div style="max-width:720px;">
    <% if (notifs == null || notifs.isEmpty()) { %>
    <div class="card">
      <div class="empty-state">
        <div class="es-icon">🔔</div>
        <h3>Aucune notification</h3>
        <p>Vous êtes à jour ! Les nouvelles activités apparaîtront ici.</p>
      </div>
    </div>
    <% } else { for (Notification n : notifs) {
         String icon = "ℹ️";
         String bgColor = "#F0F9FF";
         String borderColor = "#BAE6FD";
         if ("EVENEMENT".equals(n.getType()))    { icon = "📅"; bgColor = "#EFF6FF"; borderColor = "#BFDBFE"; }
         if ("DOCUMENT".equals(n.getType()))     { icon = "📄"; bgColor = "#F0FDF4"; borderColor = "#BBF7D0"; }
         if ("DEMANDE".equals(n.getType()))      { icon = "👤"; bgColor = "#FFFBEB"; borderColor = "#FDE68A"; }
         if ("MESSAGE".equals(n.getType()))      { icon = "✉️"; bgColor = "#F5F3FF"; borderColor = "#DDD6FE"; }
    %>
    <div style="background:<%= bgColor %>;border:1px solid <%= borderColor %>;
                border-radius:12px;padding:16px 20px;margin-bottom:12px;
                display:flex;align-items:flex-start;gap:14px;">
      <span style="font-size:22px;flex-shrink:0;margin-top:2px;"><%= icon %></span>
      <div style="flex:1;">
        <div style="font-size:14px;color:var(--dark);line-height:1.5;"><%= n.getMessage() %></div>
        <div style="font-size:12px;color:var(--text-muted);margin-top:6px;">
          <%= n.getDateCreation() != null ? n.getDateCreation().substring(0,16) : "" %>
        </div>
      </div>
    </div>
    <% } } %>
  </div>
</main>
</body>
</html>